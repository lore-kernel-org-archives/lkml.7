Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2130C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E14218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLlaQXLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfB1VLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:11:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51534 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfB1VLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:11:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id n19so10540760wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 13:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYNT8yNC1QCFZVsGXmcN5/MbVYhdcu05EJEh0Fd5Glo=;
        b=BLlaQXLvUXZEjlxQJbpqE47SeFCdFaTZbaJYaBJPCkG8Hu/e7rgHGchKUHpz3zGA9m
         8ecIKTyX8jf+gyDvVEyp/WnrVYF3vcgcgcxzS7BPB9uYO2WHmhmsZCu7bCCxkEJOKGdN
         v+yPNr/up9Oslh1xZPl0pVwULJjcOsHA34MXaKhVpXpPgUgmjuu6PoCBExEp/1960s4i
         ehwyt6IA5dTCcTXVnp0/gFE/ieUo6Gq6PBKE53iauA9aAPVKWwdcvIXRmjwVAzquFwn7
         2M/kgkwKBVyE6iG0xT4xVOAPOw9JdfqpScGaomoOOVEMBU6TVySxHugkEcOcq4tJ+13G
         ar1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYNT8yNC1QCFZVsGXmcN5/MbVYhdcu05EJEh0Fd5Glo=;
        b=PcJszSwKprTpEE/GISVBd/yZR+RgiFdWjmrGos3ViXweIpS8vFihqRUXhyGUCxvLGg
         UheBkt1aPBPvCTVNpGsLboQIp9f9gHT2PUPdRrofqWaCxwf9Mip4JZq3efQlGPFe4X7H
         YuuZDflpapt2ZChINSl0mv/2hy+Dqi8BVs3E9k7vyxlJ01mnckuAN3bgTH60UO+FkXz+
         S2i18zR/dLsXD3iWa6X5jyT2YNlixG9Xxwq6YjycWWdf1xfT3eQERZ0Te3vG2/mJwZPi
         0jnfcuJ+WoPpUkvziHP67xVhJW6U/zh0bA5injUYTqHEEhlc2nByzQnojtssT5yJDboM
         rTiw==
X-Gm-Message-State: AHQUAuYgr2/LY1934QyarJQ2+mK9HljwzU+rnQx7lA4QMDdZDtLEdzEH
        JDCyVKvhK9KX9jp8eW+ECRSFonI=
X-Google-Smtp-Source: AHgI3IZQgKyBvM7aRNS6RcB9rkR0rbk4Ew18FcdDcwOj9756rynbuUMMdmAp9gJBsIUhVaeqPfOehA==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr1128856wmj.100.1551388289355;
        Thu, 28 Feb 2019 13:11:29 -0800 (PST)
Received: from avx2 ([46.53.245.171])
        by smtp.gmail.com with ESMTPSA id i16sm15827230wru.16.2019.02.28.13.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:11:28 -0800 (PST)
Date:   Fri, 1 Mar 2019 00:11:26 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        wang.bo116@zte.com.cn, wdjjwb@163.com
Subject: Re: +
 include-linux-typesh-use-unsigned-int-instead-of-unsigned.patch added to -mm
 tree
Message-ID: <20190228211126.GA28901@avx2>
References: <20190228174109.MrWZN%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190228174109.MrWZN%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:41:09AM -0800, akpm@linux-foundation.org wrote:
> --- a/include/linux/types.h~include-linux-typesh-use-unsigned-int-instead-of-unsigned
> +++ a/include/linux/types.h
> @@ -155,9 +155,9 @@ typedef u64 dma_addr_t;
>  typedef u32 dma_addr_t;
>  #endif
>  
> -typedef unsigned __bitwise gfp_t;
> -typedef unsigned __bitwise slab_flags_t;
> -typedef unsigned __bitwise fmode_t;
> +typedef unsigned int __bitwise gfp_t;
> +typedef unsigned int __bitwise slab_flags_t;
> +typedef unsigned int __bitwise fmode_t;

I don't know if this is desireable. Switching to "unsigned" is better:
1 less token and less 80 column pressure.
