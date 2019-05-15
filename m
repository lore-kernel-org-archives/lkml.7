Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37845C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0486520862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzKBJLzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfEOGSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:18:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37024 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfEOGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:18:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so1210703wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jxbQuCq6kfxUE5RewINQp4+ByiSfCMGNEbNEcQrrPrs=;
        b=KzKBJLzxMK1qi/GNhE7XVDb5NBHzSWrYzu5UitJ5uvsO4v+mxJiGqBx9D/op31wVtZ
         JE6zeFYI/ruFAcY5lzp8Tr3iXppqV6smS3DQIMTbn7RSekkoyNgHhALoacd8OceLC9NH
         Xdkcxc13FaEOUHy7R5BE3rtmb3JnwQqTKW0ZbSxU2VdICIPy8o4XQPtufciLhuVwk33/
         Dj51IEHNBwrd0qR/yFW8a1lmO3g5yE9PHFIiijo7TQ+WNooB57R+sTqpAUfNgu1mbcbS
         aaGbEpzCj0yLYYbp62BsZ/YHdzwR1Oa01UbCgZfrb4IyczmzugjUHsa1u7FWHyD85Bvf
         RQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxbQuCq6kfxUE5RewINQp4+ByiSfCMGNEbNEcQrrPrs=;
        b=q8goJTDYrFW85l44hOJIY9thX6iT3ii5mGO8Iyr7k0ciVe+xsssPynvRjpTkyfS7CZ
         jBHNlTVODQGIXSqd7V/2kZL3EXEPTxFxJAtbTw/Wqe+ONRYYmYqkWvWBclLV/KVOR+L7
         Ov+JqiiOnrje2n258EIazdgRFCvl3QQOo8uylZNQccnGrIASIQYslBDspl1WanyH++14
         0FHaDWgfNis2jcYX10v45YBjW4GbSlYf0eJ44AMey6eA0Uc+xBTz4rc0H9n+bvCwi+WF
         bjiUdthzIUQ3e47Ird2slXXGZ1KHxyWl/o2ex1w5vutQt8wKRIYmabti8dAkVjoANrv3
         VHEw==
X-Gm-Message-State: APjAAAXavxI8LbA3OWnGoFBsLa7LhJCdMUbomoqhyktIOJf5JgadnMfn
        B7Du5tq8a43by/vmY8JwqlEarUTQ
X-Google-Smtp-Source: APXvYqwVX63RizTyf0Ly0Cwi2T4h5/V0OPVTw41psz7mqe3AnwyeW+c+scMntj/tKsnr3MbA9RESWw==
X-Received: by 2002:adf:94a5:: with SMTP id 34mr23620723wrr.275.1557901115230;
        Tue, 14 May 2019 23:18:35 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id d3sm1368862wmf.46.2019.05.14.23.18.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 23:18:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mtd: spinand: Add #define-s for page-read ops with
 three-byte addresses
To:     Jeff Kletsky <lede@allycomm.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190514215315.19228-1-lede@allycomm.com>
 <20190514215315.19228-2-lede@allycomm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <355bcf8d-bce6-1b82-0f57-539c8d9b6cac@gmail.com>
Date:   Wed, 15 May 2019 08:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514215315.19228-2-lede@allycomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 11:53 PM, Jeff Kletsky wrote:
> From: Jeff Kletsky <git-commits@allycomm.com>

That #define in $subject is called a macro.

Seems this patch adds a lot of almost duplicate code, can it be somehow
de-duplicated ?

> The GigaDevice GD5F1GQ4UFxxG SPI NAND utilizes three-byte addresses
> for its page-read ops.
> 
> http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/
> 
> Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>
> ---
>  include/linux/mtd/spinand.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index b92e2aa955b6..05fe98eebe27 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -68,30 +68,60 @@
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 1))
>  
> +#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(fast, addr, ndummy, buf, len) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
> +		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1))
> +
>  #define SPINAND_PAGE_READ_FROM_CACHE_X2_OP(addr, ndummy, buf, len)	\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 2))
>  
> +#define SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(addr, ndummy, buf, len)	\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
> +		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +
>  #define SPINAND_PAGE_READ_FROM_CACHE_X4_OP(addr, ndummy, buf, len)	\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 4))
>  
> +#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(addr, ndummy, buf, len)	\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
> +		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +
>  #define SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(addr, ndummy, buf, len)	\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 2),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 2))
>  
> +#define SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP_3A(addr, ndummy, buf, len) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
> +		   SPI_MEM_OP_ADDR(3, addr, 2),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +
>  #define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(addr, ndummy, buf, len)	\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 4),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 4))
>  
> +#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP_3A(addr, ndummy, buf, len) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
> +		   SPI_MEM_OP_ADDR(3, addr, 4),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +
>  #define SPINAND_PROG_EXEC_OP(addr)					\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> 


-- 
Best regards,
Marek Vasut
