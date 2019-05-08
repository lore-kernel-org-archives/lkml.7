Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B37AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45502204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfEHTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:52:19 -0400
Received: from verein.lst.de ([213.95.11.211]:41592 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfEHTwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:52:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 465E167358; Wed,  8 May 2019 21:51:59 +0200 (CEST)
Date:   Wed, 8 May 2019 21:51:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario.Limonciello@dell.com
Cc:     kai.heng.feng@canonical.com, kbusch@kernel.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Message-ID: <20190508195159.GA1530@lst.de>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com> <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com> <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 07:38:50PM +0000, Mario.Limonciello@dell.com wrote:
> The existing routines have an implied assumption that firmware will come swinging
> with a hammer to control the rails the SSD sits on.
> With S2I everything needs to come from the driver side and it really is a
> different paradigm.

And that is why is this patch is fundamentally broken.

When using the simple pm ops suspend the pm core expects the device
to be powered off.  If fancy suspend doesn't want that we need to
communicate what to do to the device in another way, as the whole
thing is a platform decision.  There probabl is one (or five) methods
in dev_pm_ops that do the right thing, but please coordinate this
with the PM maintainers to make sure it does the right thing and
doesn't for example break either hibernate where we really don't
expect just a lower power state, or enterprise class NVMe devices
that don't do APST and don't really do different power states at
all in many cases.
