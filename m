Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BBDC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A127233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566466012;
	bh=RGSrS75/dAlh69//rvSZNs4nKX4vmwiqC91h7KEWT40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uKw/qpPy5bmkDsaN/dmDsrGUA6067booBECKlUr0XGele5vNZB556rL9l5MretJq5
	 9GcO3z/NTRW5OpCPEhfrRk4P3/nl6M31/RfI+siHkVwBjXPslQbBPezPAoTP/izTyU
	 v6eCmpCYS3iSVtImx+v3ivaijDzNkF9eULqaESm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbfHVJ0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:26:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731829AbfHVJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SuSy3FwC9g7e9MP38jQoeaQqj9wgxK6akeFEVXSHI7g=; b=E6Ep03hTc/OMURZQI/pHby/R6
        pxiJiDd67Z9IDPoYy40qNjMPWkiH676qsZMJ1ysetis3sCMaeQHsIIT4Iz9iwRFQCfcvWvjFP2tua
        FXNvggeVhwnQ7sZXem0k3PddENIa2emGPjK3b014mZdMxMKWUNIzELPSSePytlJno4POwd+0FhXD3
        hWLS3qoujLBIFyCujBMPvUork5w6KgS6LwET+F5WhlU59XvKB1KNDjj68V4ip8H8/VrkQbEb3Kvn4
        IW3AmPqovk+4moN0HRkz82iRH21MK6v5US68H4Nr+r53XNKH1gckfvYugZFj+hZkNtkis/To2+EwK
        6Zm3edLvg==;
Received: from [177.133.63.56] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0jMf-00037g-FT; Thu, 22 Aug 2019 09:26:41 +0000
Date:   Thu, 22 Aug 2019 06:26:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Borislav Petkov <bp@alien8.de>, paul.walmsley@sifive.com,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190822062635.00f6e507@coco.lan>
In-Reply-To: <20190819062619.GA20211@lst.de>
References: <20190818082935.14869-1-hch@lst.de>
        <20190819060904.GA4841@zn.tnic>
        <20190819062619.GA20211@lst.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 19 Aug 2019 08:26:19 +0200
Christoph Hellwig <hch@lst.de> escreveu:

> On Mon, Aug 19, 2019 at 08:09:04AM +0200, Borislav Petkov wrote:
> > On Sun, Aug 18, 2019 at 10:29:35AM +0200, Christoph Hellwig wrote:  
> > > The sifive_l2_cache.c is in no way related to RISC-V architecture
> > > memory management.  It is a little stub driver working around the fact
> > > that the EDAC maintainers prefer their drivers to be structured in a
> > > certain way  
> > 
> > That changed recently so I guess we can do the per-IP block driver after
> > all, if people would still prefer it.  
> 
> That would seem like the best idea.  But I don't really know this code
> well enough myself, and I really need to get this code out of the
> forced on RISC-V codebase as some SOCs I'm working with simply don't
> have the memory for it..
> 
> So unless someone signs up to do a per-IP block edac drivers instead
> very quickly I'd still like to see something like this go into 5.4
> for now.

I'm wandering if we should at least add an entry for this one at
MAINTAINERS, pointing it to the EDAC mailing list. Something like:

diff --git a/MAINTAINERS b/MAINTAINERS
index 7dfe381c8b43..1c3bc5aa3af0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5906,6 +5906,7 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
+F:	drivers/soc/sifive/
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>


Thanks,
Mauro
