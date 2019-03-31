Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B2DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A32183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvLMNUcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfCaR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:26:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44087 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbfCaR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:26:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so8815880wrn.11;
        Sun, 31 Mar 2019 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Y47egCouj6CwboGuzaojNr2NiGMo7cFRPCKBF1IBqo=;
        b=EvLMNUcf95TM4CGVe9OtSpWS8fkjxqHgDacnziGWz6camkyeUyEpWoVL0NTCTPbf0q
         AE/nksGmLDOGy9KvSpSWCjm0fBI/R+IROiw+kDd96KSeu8FmavufEC/B+cHJZM9/UIfP
         E1khh/EHOiU//QL6vZ0QCMUe2fipVX5CtJ/AISppul6AQ4aq6oWsNhu2QCnliK4fxean
         ilNDNKudye9UjlUt1yyk+TRfXkhXFfujvHcnTBwtSDAVpCjxzZIPZjI+qo+5lHh9vPX1
         eWKl2v/J0cWiR+x9rxLrNxrkk+/Ta8YdEqa3fOsOgEuLn87ogUZlAWyeKBguyRdYhtM0
         Yz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Y47egCouj6CwboGuzaojNr2NiGMo7cFRPCKBF1IBqo=;
        b=MXJ06qfVeduguQDJwxqhgcyO8cEWY58C4Q5Qu63vuvOZeSv7G//U+2aQGGcJRX19n1
         2EINALEdt0uUeTXBKdb3tlM0/M/Tgzl9W78izp/7XWN4DKlmFtBHQsSQT/ZMCE/dpvBm
         TcLBuQ/0c2wJxYU+EsGO+/RB4IBKXW5+WfVVA+AxUBkyntE1haFG4ojPv3olNY0b6F6H
         /RyMK83jlb6fncILsUBqTPlPTAcTZPBN2FK46N9lm48pUtyhKA8XBLPpP9ucSKsR/M+S
         mrTuR5SaNDqEmit7UjEYErlQo7KqYaki4GK0VKgwVxtkjI+ZAydcHSTOjOoxOXEYjejC
         00hQ==
X-Gm-Message-State: APjAAAXhytg5EviZ48Kn3MJeKEOrN03BT+4x+PPx8OPaY2jDTTLhvA/h
        1ucGJZ6z0F/B3sd/smEzlTg=
X-Google-Smtp-Source: APXvYqxFDouWYdyeoRvQ6dia4mfIurc0vStDNGw5xyScu8zQgwt//rO/RnmmZvt7fB0mdTIcTFcFuA==
X-Received: by 2002:a5d:6b43:: with SMTP id x3mr41032647wrw.76.1554053160808;
        Sun, 31 Mar 2019 10:26:00 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id c126sm8650224wma.0.2019.03.31.10.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 10:26:00 -0700 (PDT)
Date:   Sun, 31 Mar 2019 18:25:58 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/7] fbdev: sm712fb: add 2D-related I/O headers and
 functions.
Message-ID: <20190331172558.ndvtilm7c2cy6xa4@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-3-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:54PM +0800, Yifeng Li wrote:
> This commit adds I/O macros and functions related to 2D opeartions.
> A hunk of hardware register definitions are taken verbatim from
> OpenBSD.
> 
> In addition, a utility function pad_to_dword() is added to help
> padding data for the 2D engine. It  accepts 3, 2, or 1 byte(s) of
> data, and pads it to a 32-bit word suitable for 2D Drawing Engine.
> 
> Yes, we can set info->pixmap.scan_align/buf_align = 4 and forget
> about padding, but it's incompatible with cfb_imageblit() w/
> depth == 1. In case we need to fallback (e.g. debugging), it would
> be inconvenient, so we pad it manually.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  drivers/video/fbdev/sm712.h | 96 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
> index 89e446db2ac7..4892fd485f08 100644
> --- a/drivers/video/fbdev/sm712.h
> +++ b/drivers/video/fbdev/sm712.h
> @@ -91,6 +91,102 @@ static inline u8 smtc_seqr(u8 reg)
>  	return smtc_mmiorb(0x3c5);
>  }
>  
> +/*
> + * DPR (2D drawing engine)
> + */
> +#define DPR_COORDS(x, y)		(((x) << 16) | (y))
> +
<snip>
> +#define DPR_SRC_WINDOW			0x3c
> +#define DPR_SRC_BASE			0x40
> +#define DPR_DST_BASE			0x44
> +
> +#define DE_CTRL_START			0x80000000
> +#define DE_CTRL_RTOL			0x08000000
> +#define DE_CTRL_COMMAND_MASK		0x001f0000
> +#define DE_CTRL_COMMAND_SHIFT			16
> +#define DE_CTRL_COMMAND_BITBLT			0x00
> +#define DE_CTRL_COMMAND_SOLIDFILL		0x01
> +#define DE_CTRL_COMMAND_HOSTWRITE		0x08
> +#define DE_CTRL_ROP2_SELECT		0x00008000
> +#define DE_CTRL_ROP2_SRC_IS_PATTERN	0x00004000
> +#define DE_CTRL_ROP2_SHIFT			0
> +#define DE_CTRL_ROP2_COPY			0x0c
> +#define DE_CTRL_HOST_SHIFT			22
> +#define DE_CTRL_HOST_SRC_IS_MONO		0x01
> +#define DE_CTRL_FORMAT_XY			0x00
> +#define DE_CTRL_FORMAT_24BIT			0x30

Please fix the alignment. Some of them are right aligned and some are left.

--
Regards
Sudip
