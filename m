Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F0DC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B862133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfEMOiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:38:03 -0400
Received: from verein.lst.de ([213.95.11.211]:39685 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfEMOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:38:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F47768AFE; Mon, 13 May 2019 16:37:41 +0200 (CEST)
Date:   Mon, 13 May 2019 16:37:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario.Limonciello@dell.com
Cc:     keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513143741.GA25500@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM> <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 02:24:41PM +0000, Mario.Limonciello@dell.com wrote:
> I've received the result that from one of my partners this patch doesn't
> work properly and the platform doesn't go into a lower power state.

Well, it sounds like your partners device does not work properly in this
case.  There is nothing in the NVMe spec that says queues should be
torn down for deep power states, and that whole idea seems rather
counter productive to low-latency suspend/resume cycles.

> This was not a disk with HMB, but with regard to the HMB I believe it
> needs to be removed during s0ix so that there isn't any mistake that SSD
> thinks it can access HMB memory in s0ix.

There is no mistake - the device is allowed to use the HMB from the
point that we give it the memory range until the point where we either
disable it, or shut the controller down.  If something else requires the
device not to use the HMB after ->suspend is called we need to disable
the HMB, and we better have a good reason for that and document it in
the code.  Note that shutting down queues or having CPU memory barriers
is not going to help with any of that.
