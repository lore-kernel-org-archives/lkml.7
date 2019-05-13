Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9719AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691E22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557760938;
	bh=9+UsjQpwyDy1tj3CGP56pEdTyFHY73ZlBK305NAVzoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mRk3dT4u6alze1E4dEF5k+0UM+aoBOW/+VpvK6+4OTx2FiOPDGd3FXRzmZFysDjj+
	 Ee4fSqMDV8ke8JBAVgCrbtLMV3se61ke2NQSt7ipZywM2tKsTSmG3BTmY0q2vY+H/s
	 VAVtJBkbA0ZT1paN+w2ftAMelGCCsomORtlcQcX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfEMPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:22:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:7085 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfEMPWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:22:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 08:22:14 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2019 08:22:13 -0700
Date:   Mon, 13 May 2019 09:16:52 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mario.Limonciello@dell.com, keith.busch@intel.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513151652.GB15437@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513145708.GA25897@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 04:57:08PM +0200, Christoph Hellwig wrote:
> On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com wrote:
> > And NVME spec made it sound to me that while in a low power state it shouldn't
> > be available if the memory isn't available.
> > 
> > NVME spec in 8.9:
> > 
> > "Host software should request that the controller release the
> > assigned ranges prior to a shutdown event, a Runtime D3 event, or any other event
> > that requires host software to reclaim the assigned ranges."
> 
> The last part of the quoted text is the key - if the assigned range
> is reclaimed, that is the memory is going to be used for something else,
> we need to release the ranges.  But we do not release the ranges,
> as we want to keep the memory in use so that we can quickly use it
> again.

Yes, this. As far as I know, the host memory range is still accessible in
the idle suspend state. If there are states in which host memory is not
accessible, a reference explaining the requirement will be most helpful.
