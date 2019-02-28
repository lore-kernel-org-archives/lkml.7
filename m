Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A665C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204932075B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551396014;
	bh=XB3UiBzB3HqFLT6vnRpMzyXAIPdB2LC8DyZLwc/27ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=whefQ0WGCexrIEwdH0q1vp9LSExIrzepw5pIyvhsPxrKVNVCKX9OIfAevViy7htam
	 bmrnIc2SuanqxNigXV1dNWQYQ0UbJo6xwVhQJPkljp5VsJ6kMLGw9eppY4zmE8W0mr
	 SAGBRys3l4Da5zyCZrlLQPto8liT8VHt4zQWSCK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfB1XUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:20:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:4373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfB1XUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:20:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 15:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="138087648"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2019 15:20:06 -0800
Date:   Thu, 28 Feb 2019 16:20:22 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     hch@infradead.org, Alex_Gagniuc@Dellteam.com,
        torvalds@linux-foundation.org, keith.busch@intel.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@fb.com, mr.nuke.me@gmail.com,
        hch@lst.de, jonathan.derrick@intel.com
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Message-ID: <20190228232020.GB22003@localhost.localdomain>
References: <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
 <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:10:11PM +0000, Austin.Bolen@dell.com wrote:
> I'd also note that in PCIe, things that intentionally take the link down 
> like SBR or Link Disable suppress surprise down error reporting.  But 
> NSSR doesn't have this requirement to suppress surprise down reporting. 
> I think that's a gap on the part of the NVMe spec.

SBR and Link Disable are done from the down stream port, though, so the
host can still communicate with the function that took the link down.
That's entirely different than taking the link down from the end device,
so I'm not sure how NVMe can fix that.

But I can't even recall why NVMe defined NSSR to require PCIe LTSSM
Detect. That seems entirely unnecessary and is just asking for trouble.
