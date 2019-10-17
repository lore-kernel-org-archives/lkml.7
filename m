Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B98ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65B620854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571317084;
	bh=5PvDqYIkD25UHCLqVbbqeGHt67Vbvi9W1p1aLs9NggU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vJ7n7yki1BAPN3ZqLg9T3zzmDz2dcdwoDqsF5l/Yg+L3K81WQv9PLBVhzs90HM+LP
	 R4QAatA0IhvnRR3n7bVyUGhTys1MDPLe3z/1ZAtFz5hgJRyJ4+SZZXkcFNDCuUD2bw
	 CXi8agItlWL34dkvSPndNimNAGS+gyCIoC6COCYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390796AbfJQM6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:58:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJQM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fqfvJwGghxY/zvJczuG3/Ld93T9mcoCDDrIkbXWs7Sk=; b=po5ekprxuyc4XbZj/GiSZZOxK
        XnmJuBTsnFVusvf8RHqb32e2q+BmM2FLOphxhDvtk100NFpDBCIJDmALheko0WV94K640qpsZBEf6
        VDmAMk6fwXdR4STE0QPGHixD/qfmg5dirQ/+mR47pm+PwKrf69zIVmSnmJXN7wI3UzGAwQAfug5CB
        NOQ2eO28le2sE8uQlLKcBeyvLXrRj4vbfixTaHuis7SrNbS+txcPtnMBawip8mC3BO8RKfnRsop4U
        hGzu2L34yC0b1u++srYXLiy3fHJkhIsZro05OdLPxkzL4gBWXseVaW2TzTPGxfVYsTT75hKwlPOq3
        XhVZZjgvw==;
Received: from [179.95.49.118] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL5Lp-0006o4-7D; Thu, 17 Oct 2019 12:57:57 +0000
Date:   Thu, 17 Oct 2019 09:57:51 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 3/3] media: cedrus: Add HEVC/H.265 decoding support
Message-ID: <20191017095751.5a229051@coco.lan>
In-Reply-To: <20190927143411.141526-4-paul.kocialkowski@bootlin.com>
References: <20190927143411.141526-1-paul.kocialkowski@bootlin.com>
        <20190927143411.141526-4-paul.kocialkowski@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 27 Sep 2019 16:34:11 +0200
Paul Kocialkowski <paul.kocialkowski@bootlin.com> escreveu:

> This introduces support for HEVC/H.265 to the Cedrus VPU driver, with
> both uni-directional and bi-directional prediction modes supported.
> 
> Field-coded (interlaced) pictures, custom quantization matrices and
> 10-bit output are not supported at this point.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---

...

> +		unsigned int ctb_size_luma =
> +			1 << log2_max_luma_coding_block_size;

Shifts like this is a little scary. "1" constant is signed. So, if
log2_max_luma_coding_block_size is 31, the above logic has undefined
behavior. Different archs and C compilers may handle it on different
ways.

> +#define VE_DEC_H265_LOW_ADDR_PRIMARY_CHROMA(a) \
> +	(((a) << 24) & GENMASK(31, 24))

Same applies here and on other similar macros. You need to enforce
(a) to be unsigned, as otherwise the behavior is undefined.

Btw, this is a recurrent pattern on this file. I would define a
macro, e. g. something like:

	#define MASK_BITS_AND_SHIFT(v, high, low) \
		((UL(v) << low) & GENMASK(high, low))

And use it for all similar patterns here.

The best would be to include such macro at linux/bits.h, although some
upstream discussion is required.

So, for now, let's add it at this header file, but work upstream
to have it merged there.


Thanks,
Mauro
