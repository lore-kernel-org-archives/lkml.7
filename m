Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="apsB5Kqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDCGuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:50:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41460 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:50:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so5411031lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNvWAUPihXUG8tk5r2OE77Ss4iGVr1lrjgN2yALMW6Y=;
        b=apsB5Kqv2C79wmC3nMkAEKQ3og2Vde9hp874tiRDUZXhpms3NOMimwlVSFw3P3U8Ex
         UaypKS/NvUz5RplwRbElxdctcuNXxlkUt56Jt0LW4Id5SASCbICwGhwCpiGmg2A98Tsx
         L6hHoD1OStyjHTtv2Bj5/G71ypbj+EtZHJAFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNvWAUPihXUG8tk5r2OE77Ss4iGVr1lrjgN2yALMW6Y=;
        b=NOZ/rNf/aRxtyRBSCTxplzEn3Z82iPFcMiIrdjfqcSJFY1PxJoF9IFJ0uCdKR/Ls60
         C+7G3qHfdJblia4QDNb9XV7gbzICRjF5GvSpa6L7n8QJljk1o2Hhmp5feSVZ/dfA4QPd
         59b6U0zPqP2+RaPuS98uz5u7NXd/ECB+PQ5S/Z6lcK2tM/pmN5EByY2qpUjztcxDPiMC
         t66//MeYnFVcGWc3MCfSqrveoYNgztuxbPet2KWfOiIk1zP70FKNBdQPRkUUD47C9QmM
         vOOlXxt8xc6qWkDmrAsqNIUn8iTuJSwlakbxzgKegbDXhcn2QeJtd0cYEA/cOM2Y+sp2
         /KFA==
X-Gm-Message-State: APjAAAVZeGQhQb3aegYQ+WMN/sV6cQzavZzaSvguZbOZYjIu9/18zMsk
        dUQfRV2R4whWO6JGfme5N9GEyyNCup0v1enY
X-Google-Smtp-Source: APXvYqy9vYnZ3VSFGpNAZM7CjNB+v8LaAla6tQrV1/CLMnWNjw36i3AjvIVxxl7eXalRBFqoliQkZQ==
X-Received: by 2002:a05:651c:114:: with SMTP id a20mr40736396ljb.53.1554274209142;
        Tue, 02 Apr 2019 23:50:09 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k21sm3064532ljk.21.2019.04.02.23.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 23:50:07 -0700 (PDT)
Subject: Re: [PATCH v2] ubsan: Avoid unnecessary 128-bit shifts
To:     George Spelvin <lkml@sdf.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <201904030545.x335jQJO015258@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1cea9e60-204a-44d5-96dc-606c0738c621@rasmusvillemoes.dk>
Date:   Wed, 3 Apr 2019 08:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201904030545.x335jQJO015258@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 07.45, George Spelvin wrote:
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index e4162f59a81c..a7eb55fbeede 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -89,8 +89,8 @@ static bool is_inline_int(struct type_descriptor *type)
>  static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
>  {
>  	if (is_inline_int(type)) {
> -		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
> -		return ((s_max)val) << extra_bits >> extra_bits;
> +		unsigned extra_bits = sizeof(val)*8 - type_bit_width(type);
> +		return (signed long)val << extra_bits >> extra_bits;
>  	}

Maybe add some #ifdef BITS_PER_LONG == 64 #define sign_extend_long
sign_extend[32/64] stuff to linux/bitops.h and write this as
sign_extend_long(val, type_bit_width(type)-1)? Or do it locally in
lib/ubsan.c so that "git grep" will tell that it's available once the
next potential user comes along.

Btw., ubsan.c is probably compiled without instrumentation, but it would
be a nice touch to avoid UB in the implementation anyway (i.e., the left
shift should be done in the unsigned type, then cast to signed and
right-shifted).

Rasmus
