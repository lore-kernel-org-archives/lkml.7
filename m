Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8611C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A546620645
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfEMOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:54:37 -0400
Received: from verein.lst.de ([213.95.11.211]:39796 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbfEMOyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:54:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7B72E68AFE; Mon, 13 May 2019 16:54:15 +0200 (CEST)
Date:   Mon, 13 May 2019 16:54:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario.Limonciello@dell.com
Cc:     hch@lst.de, keith.busch@intel.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513145415.GA25774@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM> <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM> <20190513143741.GA25500@lst.de> <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 02:43:43PM +0000, Mario.Limonciello@dell.com wrote:
> Well I've got a thought, quoting the NVME spec:
> "After a successful completion of a Set Features command for this feature, the controller shall be in the
> Power State specified. If enabled, autonomous power state transitions continue to occur from the new state."
> 
> If APST is enabled on this disk, what is to stop an autonomous  reverse
> transition from queue activity on the way down?

Nothing.  But once the system is suspending we should not see I/O.

If we see I/O the queue freezing in the original patch Kai Heng and the
previous one from Keith is probably required, although I suspect it
just papers over problems higher up in the queue.  If we don't see I/O
the device is just behaving oddly.
