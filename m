Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8930C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4920833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct/15mBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDHBLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:11:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40929 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHBLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:11:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so1767298pgl.7;
        Sun, 07 Apr 2019 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oxL+R3MKlPW/mufkeMOUHjfImsEah75MIkDtVYlHeYQ=;
        b=ct/15mBOWELJ5D7xr9EFbCYq79LU6v9keLe+DsfcoFAE9sVeKoLuckHKvJBuf86ryb
         uTylNQhGJCXzCZ/ofk2f9f9/cNsjvH31q9Oz/6c0N92iUUB0N0/dUdEO883i1If41S60
         mH/ynvLtkFyZ7dDbGYyvaMcHbpznJx65H5GsmJGauItZ9pE3pPGYawlNeNa5PL577mKE
         Ltt3dB8GJK2/oxLA3fyai9ACpPAgO8r4us+S/Vmy+KNOWWzhJu4kmPl4uhAAKTgMLq3b
         Tid0qmuX1q8wIANzJNwQSnCi70RUEKvSOaWEl3L/5zxXWq9YKk7oB/ImBZvZOWHBbLPj
         bNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oxL+R3MKlPW/mufkeMOUHjfImsEah75MIkDtVYlHeYQ=;
        b=flqV4JJAtWJqnXy8vUpvGr7s567NcMBIbZyAlyh3WMlzxw4Q0sW130i+nuYL5iUqi0
         6p87aHK4abdhc1GsNvqJqhUHMreaakqVZlRpC0tQFEDXIBjb2fYG3+NijSzc+krVzZlp
         RZ/JCFB4G6lP1Tp1VwewE/or/0frHZjHQRN065h/ky2oyRLR93bHLkI3SK0D3BZR50Rk
         kebhCXY//SXeafnPG2Da7WHpUO5DSx9+mQhKa8euk3I+xUDRfLy6kHbxZSxleORza8QG
         Ebce7mNVE1VNBC3XYvsCTc9N3O+Qjcy6NljW3bNomV2cS5oBVla596nso2wHZuR6F5dg
         nVqg==
X-Gm-Message-State: APjAAAWCgHldGkZOe1zlqYOPtQa4zmMr552hFLLTd4VDJTjT+S+N/eR7
        7kQVLNJbspDEpsxo5Y/Hh9U=
X-Google-Smtp-Source: APXvYqwRkJzLf4Mka8z7iOP+iUbRmmP52L9gvtrwKOReLiRBtNa5k5ouv5N5RBe9REUvIxexUjQ9fg==
X-Received: by 2002:a63:1043:: with SMTP id 3mr25363487pgq.283.1554685874186;
        Sun, 07 Apr 2019 18:11:14 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g10sm9818552pgq.54.2019.04.07.18.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 18:11:13 -0700 (PDT)
Subject: Re: [PATCH] of: Documentation: Correct return value from
 of_overlay_fdt_apply
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        pantelis.antoniou@konsulko.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404022555.29382-1-chris.packham@alliedtelesis.co.nz>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9bb707be-9cb3-dffc-303f-ee7025090ba9@gmail.com>
Date:   Sun, 7 Apr 2019 18:11:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404022555.29382-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 7:25 PM, Chris Packham wrote:
> The return from of_overlay_fdt_apply() just indicates success or fail.
> The cookie is returned via reference.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/devicetree/overlay-notes.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
> index 725fb8d255c1..62f2003d6205 100644
> --- a/Documentation/devicetree/overlay-notes.txt
> +++ b/Documentation/devicetree/overlay-notes.txt
> @@ -88,7 +88,8 @@ Overlay in-kernel API
>  The API is quite easy to use.
>  
>  1. Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
> -return value is an error or a cookie identifying this overlay.
> +return indicates success or failure. A a cookie identifying this overlay is
> +returned via reference on success.
>  
>  2. Call of_overlay_remove() to remove and cleanup the overlay changeset
>  previously created via the call to of_overlay_fdt_apply(). Removal of an
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
