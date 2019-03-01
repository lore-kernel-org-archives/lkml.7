Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE936C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972212087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551400215;
	bh=luCTbSmawhSdnFbAJtXA9GGBlXlyIXKPu/7OPefZcFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x3A+mdKwpmfAHGzv2Lv0548TmJlb4KVkIF/PTEW8aovCVtpxoG++8x8aLEwVj43k+
	 jSd3rFANBgm9OL7G5dNZejnEH5C5Np1mHIYw6+7o7GFbi7To6F9XYQj54Oha9g/oLX
	 ovmVyxPPfDR39uPP/mG9fAiqUGAoghhAb8/oKZiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfCAAaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:30:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:7400 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfCAAaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:30:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 16:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="148235200"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2019 16:30:10 -0800
Date:   Thu, 28 Feb 2019 17:30:26 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     hch@infradead.org, Alex_Gagniuc@Dellteam.com,
        torvalds@linux-foundation.org, keith.busch@intel.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@fb.com, mr.nuke.me@gmail.com,
        hch@lst.de, jonathan.derrick@intel.com
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Message-ID: <20190301003026.GA22712@localhost.localdomain>
References: <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
 <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
 <20190228232020.GB22003@localhost.localdomain>
 <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:43:46PM +0000, Austin.Bolen@dell.com wrote:
> On 2/28/2019 5:20 PM, Keith Busch wrote:
> > SBR and Link Disable are done from the down stream port, though, so the
> > host can still communicate with the function that took the link down.
> > That's entirely different than taking the link down from the end device,
> > so I'm not sure how NVMe can fix that.
> > 
> 
> Agreed it is different.  Here is one way they could have solved it: host 
> writes magic value to NSSRC but device latches this instead of 
> resetting.  Then require host to do SBR.  When device sees SBR with 
> magic value in NSSRC it does an NSSR.

For single port drives, yes, but that wouldn't work so well for multi-port
devices connected to different busses, maybe even across multiple hosts.
The equivalent of an FLR across all ports should have been sufficient,
IMO.
