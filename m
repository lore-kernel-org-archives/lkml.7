Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7601DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEFF208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfEIGM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:12:58 -0400
Received: from verein.lst.de ([213.95.11.211]:43712 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfEIGM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:12:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C038667358; Thu,  9 May 2019 08:12:37 +0200 (CEST)
Date:   Thu, 9 May 2019 08:12:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario.Limonciello@dell.com
Cc:     hch@lst.de, kai.heng.feng@canonical.com, kbusch@kernel.org,
        keith.busch@intel.com, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Message-ID: <20190509061237.GA15229@lst.de>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com> <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com> <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM> <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 08:28:30PM +0000, Mario.Limonciello@dell.com wrote:
> You might think this would be adding runtime_suspend/runtime_resume
> callbacks, but those also get called actually at runtime which is not
> the goal here.  At runtime, these types of disks should rely on APST which
> should calculate the appropriate latencies around the different power states.
> 
> This code path is only applicable in the suspend to idle state, which /does/
> call suspend/resume functions associated with dev_pm_ops.  There isn't
> a dedicated function in there for use only in suspend to idle, which is
> why pm_suspend_via_s2idle() needs to get called.

The problem is that it also gets called for others paths:

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend = suspend_fn, \
	.resume = resume_fn, \
	.freeze = suspend_fn, \
	.thaw = resume_fn, \
	.poweroff = suspend_fn, \
	.restore = resume_fn,
#else
else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif

#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
const struct dev_pm_ops name = { \
	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
}

And at least for poweroff this new code seems completely wrong, even
for freeze it looks rather borderline.

And more to the points - if these "modern MS standby" systems are
becoming common, which it looks they are, we need support in the PM core
for those instead of working around the decisions in low-level drivers.

> SIMPLE_DEV_PM_OPS normally sets the same function for suspend and
> freeze (hibernate), so to avoid any changes to the hibernate case it seems
> to me that there needs to be a new nvme_freeze() that calls into the existing
> nvme_dev_disable for the freeze pm op and nvme_thaw() that calls into the
> existing nvme_reset_ctrl for the thaw pm op.

At least, yes.

> 
> > enterprise class NVMe devices
> > that don't do APST and don't really do different power states at
> > all in many cases.
> 
> Enterprise class NVMe devices that don't do APST - do they typically
> have a non-zero value for ndev->ctrl.npss?
> 
> If not, they wouldn't enter this new codepath even if the server entered into S2I.

No, devices that do set NPSS will have at least some power states
per definition, although they might not be too useful.  I suspect checking
APSTA might be safer, but if we don't want to rely on APST we should
check for a power state supporting the condition that the MS document
quoted in the original document supports.
