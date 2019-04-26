Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D8C20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAsfTCig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDZTbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:31:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46586 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfDZTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:31:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so2166956pff.13;
        Fri, 26 Apr 2019 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=twUoIHgKe4Zz4Xc+lzK5VUvxsu8bPvTpQjzTcyQyQXg=;
        b=kAsfTCigJDynNwEw8pwUta7VBRYILyfZUo/TcV6IqM8TSnosyZd+z+2TDHecO2qK8y
         uezPtTIcOT07F0b+k1FuITpxSCid0TrrDraek54V9jlgckG5zQgXojTg+NRjyOhXJnN7
         k5xpgH9a43PmWsYNbqNj86YTBEZ50aybReSsvYIhYhW/1a+vmqAYnu4xxVyj4fh6aSQ6
         5OmO1+j1x53iLMBPPFdaW0ZEOWGuneMsHN1guTHrQoolKwLMg++lYP/ZpSzVBMY4OenM
         Xmgou9vcCTMKsx9ioQT1+0eTn5OdVDsY8JMgEJhXw1jNuQD9t04X23TqkXEAEOwjTkFJ
         hqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=twUoIHgKe4Zz4Xc+lzK5VUvxsu8bPvTpQjzTcyQyQXg=;
        b=E3h4doZg/9i/MUF93fh+2YNgG2BMrLXR08vZrM5vw7r2Sa9Ehpb9nMkH1QAsPUFdGp
         VujNcN1Qz1LZSLAjDNq/OcBnT4ye9p2qfKJ3B+PR4k+HSP3p6KHeBI3/Gs3SMZyJ5nmK
         vt4lbU3cEKsHJtlbBD4lPAYoif/lfiWK2yxEset61Ilq4pyzLJqWx3/djthmJpHkGbXp
         yn0ZIV6OUc5G4xlUCkE4iQk2TyWZqUHDb9mtxEib72AatoM+ta/Ft77z8Ey6KiR0RT7k
         kVv6eTEjNRMRWBvjAsuNisQ6jYDUTxEHDGKPKUY2lLZMyzVsCGiFn/aOC0Ck4PzrabED
         1atQ==
X-Gm-Message-State: APjAAAVuTXL2hqzOWuPNCdaEaiU15rbfEvIXXryx+2Uk98+XyBXrjNAz
        aN2joVCi+1d2Va8OqPJQkQk=
X-Google-Smtp-Source: APXvYqwsO0Xr3NQqc8OTsDIXo0Bjnj37QzqyEnKHEpWEomO1f94DmBdwIDLd5Gr/qtTr0TiJHWTlYA==
X-Received: by 2002:a62:1d83:: with SMTP id d125mr12315543pfd.74.1556307083304;
        Fri, 26 Apr 2019 12:31:23 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id q128sm41052091pga.60.2019.04.26.12.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:31:22 -0700 (PDT)
Subject: Re: [PATCH] of/device.c: fix the wrong comments
To:     jojo_zeng@126.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1556156754-18993-1-git-send-email-jojo_zeng@126.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d28a199c-eba3-7f10-0430-c3da58522a41@gmail.com>
Date:   Fri, 26 Apr 2019 12:31:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556156754-18993-1-git-send-email-jojo_zeng@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 6:45 PM, jojo_zeng@126.com wrote:
> From: Jojo Zeng <jojo_zeng@126.com>
> 
> the comments which discribed the input parameters of of_match_device(). 
> the name is changed, so fix it.
> 
> Signed-off-by: Jojo Zeng <jojo_zeng@126.com>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 3717f2a..da81583 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -17,7 +17,7 @@
>  
>  /**
>   * of_match_device - Tell if a struct device matches an of_device_id list
> - * @ids: array of of device match structures to search in
> + * @matches: array of of device match structures to search in
>   * @dev: the of device structure to match against
>   *
>   * Used by a driver to check whether an platform_device present in the
> 


Reviewed-by: Frank Rowand <frank.rowand@sony.com>
