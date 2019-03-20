Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E0E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mEu4IlVr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrmZFG30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCTRqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:46:36 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56859 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfCTRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:46:35 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 13:46:35 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4EBC8231E7;
        Wed, 20 Mar 2019 13:39:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 20 Mar 2019 13:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=D
        /oXc+713++ecBotR94dhoqyhOY4U6rININ+Cpib0mw=; b=mEu4IlVr+CIFcmcRm
        wD2qDqbp0o3XXxfsJHHlWAtf4Us+CF6fadvAVMb3ommz7jmVMcyHMsqVQbvgUoIx
        9phbm6yXkLL0ZVpNFP6rwbD0onRCyhA22A15GuFQe6sh70ZL++b5Nrhv/b9YKxon
        btlsIuxk8ULf9wCiLBd7s0ClyZnz/U38cawy78kYXPZnEComY+k9IEzIsDL/8cIT
        Et8icpr3nBJtEL1CzlvZ6Yp6ucbUx3gaWGigmZO2XFYXu0G3XWmyJbzelIteGmIn
        YhQL3bQ/wOATZaepM2sQoAJCQcK2AtJlg6CMLL/tpXl1OZSIPBJWKzv6Re23t1/u
        I4ojQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=D/oXc+713++ecBotR94dhoqyhOY4U6rININ+Cpib0
        mw=; b=WrmZFG30VSr24+qCfvL88T7H5q/H+9a2aPbU5Snrpw6bCRk8au8hpou1H
        htoyhXX21z0qRPCrp+4ovNBdioN9vgfNT7s9+COjAMkGp0kTfxWKnpeAf884KSpS
        Jha0f5bdq7o1rDRHPO8/f6xLyUkh2KIRcROPHHzoAHKXzfnfuC8HbgtJdy35FAu1
        q1KUyC+TXHcAZwbyI7dXGpgXP7SXmtUvzBhiZTHOOm7EvWBM6BYSVAgq0jUJ0XJT
        cx5cc1AKo4uD+flvILllN9Crunytm8itWMpAliowosL6pjeYdfVfPCDy1PyTxD0r
        Ca/05ep6eDgEbZ9bae8RUUHnjKYcg==
X-ME-Sender: <xms:6XqSXJCk_E_KrU5xR7hrbFbAcFup7z0w6MUwIPxRgCqLP9p5ZifW7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrieeigddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtredunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:6XqSXLxmUECWsnpFinB_c7G2CMyzSphgZ3P8keWAlBwpSSpa6JFXIg>
    <xmx:6XqSXPmSgx1u4AzCSV3bvtocse3Qwc5AWNIqQBKzsErahnzC98nJfg>
    <xmx:6XqSXIFTnEHYlyfYdjKh-oW14JY45oZcncQsfBCkJt0DwGiR_4P0ZA>
    <xmx:6nqSXGzHB-xOz41hs4J3x0y5ZCopyqiBDJe5MwJ58ETnPVyCyQpuHA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC8D81031A;
        Wed, 20 Mar 2019 13:39:52 -0400 (EDT)
Date:   Wed, 20 Mar 2019 18:39:51 +0100
From:   Greg KH <greg@kroah.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 5/8] scsi: lpfc: change snprintf to scnprintf for
 possible overflow
Message-ID: <20190320173951.GA27003@kroah.com>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-5-w@1wt.eu>
 <CAGXu5jKu5br-pB3U+3PDtgcgq_nmt0C7gHLYQXV4tz3pN=S11Q@mail.gmail.com>
 <de134f7c-7516-cfb4-7cd2-6d96b45bdb48@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de134f7c-7516-cfb4-7cd2-6d96b45bdb48@broadcom.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:41:17PM -0800, James Smart wrote:
> 
> On 1/14/2019 5:15 PM, Kees Cook wrote:
> > On Sat, Jan 12, 2019 at 7:29 AM Willy Tarreau<w@1wt.eu>  wrote:
> > > From: Silvio Cesare<silvio.cesare@gmail.com>
> > > 
> > > Change snprintf to scnprintf. There are generally two cases where using
> > > snprintf causes problems.
> > > 
> > > 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> > > In this case, if snprintf would have written more characters than what the
> > > buffer size (SIZE) is, then size will end up larger than SIZE. In later
> > > uses of snprintf, SIZE - size will result in a negative number, leading
> > > to problems. Note that size might already be too large by using
> > > size = snprintf before the code reaches a case of size += snprintf.
> > > 
> > > 2) If size is ultimately used as a length parameter for a copy back to user
> > > space, then it will potentially allow for a buffer overflow and information
> > > disclosure when size is greater than SIZE. When the size is used to index
> > > the buffer directly, we can have memory corruption. This also means when
> > > size = snprintf... is used, it may also cause problems since size may become
> > > large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> > > configuration.
> > > 
> > > The solution to these issues is to use scnprintf which returns the number of
> > > characters actually written to the buffer, so the size variable will never
> > > exceed SIZE.
> > > 
> > > Signed-off-by: Silvio Cesare<silvio.cesare@gmail.com>
> > > Cc: James Smart<james.smart@broadcom.com>
> > > Cc: Dick Kennedy<dick.kennedy@broadcom.com>
> > > Cc: Dan Carpenter<dan.carpenter@oracle.com>
> > > Cc: Kees Cook<keescook@chromium.org>
> > > Cc: Will Deacon<will.deacon@arm.com>
> > > Cc: Greg KH<greg@kroah.com>
> > > Signed-off-by: Willy Tarreau<w@1wt.eu>
> > I think this needs Cc: stable.
> > 
> > Reviewed-by: Kees Cook<keescook@chromium.org>
> > 
> > -Kees
> > 
> 
> 
> Reviewed-by:  James Smart <james.smart@broadcom.com>

What ever happened to this patch?  Did it get dropped somehow?

thanks,

greg k-h
