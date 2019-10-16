Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D9FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E4120640
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smKnNLAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392064AbfJPPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:01:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36429 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388424AbfJPPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:01:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so3150872wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=gBIzGINd7SQ7oBpqM/NJJHdjeRpwfDkX8l55pEp/DuE=;
        b=smKnNLAdHYOllIrDVEixkFAORjdfr8hXbLNqEQ4Y86ccXGJ2haZwseq5xHkD53KgX6
         Z+paZ18i1xxzkCj+/+SuQ3+Jjdbmv9/+mRGYwpHesZlawlcZJqPN9fyireiqrD1gpTIG
         QswcolaJdFVRJfqKmY7IznmClaEJ3kItGuPWH142RbnLnpI5oRhLmXiQLmU1mr7iWcTn
         JyYsoeUy+14SuALGRgCiTbh6UE6PYB739bMFf49vjTkIi4H2w8pTT7vv3yi9WJUtLXOd
         UwlmEo+oRjsr/6Oc6ZW/8+lAEvnVlPOte7ZZMsVHErGzv7ahW68fqIi3yAgy6hX26A1H
         8jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=gBIzGINd7SQ7oBpqM/NJJHdjeRpwfDkX8l55pEp/DuE=;
        b=ou+yeTyOdnhm7RQH2jpIgtpjuNxthou+6N/9m+oPO4SGWpmFY6fOQjDXzr55prhyDI
         yaDZ3SFaRg9E3Ryb5zGRBnMspQznFAK47hKGXXl1t7tc3LFwURNZ7Jdf04Rxcs6GK/b+
         LVJV8BnuVssN5NLkeMeatpxenx6SGc9hXSs+B4/swhXDg1cY5xEvz8VXdN1qj1kNxChC
         ETSPR2aQJpbOxGXEfvM5vqeZ3kXjk4RQ62v87WAm+50MlKqK0CGqf+nS0bpvqP0L9PUw
         spmFdZKgcdCOwOKRTkia8Fy98qM9u/3WNVCjg4J9lqjRDGNnOkfPBK7fu6lj2OrlKbX2
         ZqHg==
X-Gm-Message-State: APjAAAXQbIOz2CJf12FHrg6bMTm+Ex/caROfW4unyNT6NicKzOgVvcWV
        KIU4SrFXTG3SWW/B+4BOX5K94hMD
X-Google-Smtp-Source: APXvYqy5c+iODVvlN/NaNMiUViYa/0uPuY6zL9LTYzJyhEB55wAcb/XR7G5uWTK7JhQ5XCN5gulJWg==
X-Received: by 2002:a1c:4986:: with SMTP id w128mr3666689wma.69.1571238085613;
        Wed, 16 Oct 2019 08:01:25 -0700 (PDT)
Received: from [109.186.90.35] (109-186-90-35.bb.netvision.net.il. [109.186.90.35])
        by smtp.gmail.com with ESMTPSA id z125sm3358100wme.37.2019.10.16.08.01.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 08:01:24 -0700 (PDT)
Message-ID: <5DA730B2.2@gmail.com>
Date:   Wed, 16 Oct 2019 18:01:06 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     YueHaibing <yuehaibing@huawei.com>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] char: xillybus: use devm_platform_ioremap_resource()
 to simplify code
References: <20191016092546.26332-1-yuehaibing@huawei.com>
In-Reply-To: <20191016092546.26332-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the patch.

I have to admit that this goes slightly against my instinct not to touch 
code that works. But I'll leave the tradeoff to people who know better 
than me.

Anyhow, I've verified that it compiles well, and the functional 
equivalence is quite obvious.

Regards,
    Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 16/10/19 12:25, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing<yuehaibing@huawei.com>
> ---
>   drivers/char/xillybus/xillybus_of.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/char/xillybus/xillybus_of.c b/drivers/char/xillybus/xillybus_of.c
> index bfafd8f..96b6de8 100644
> --- a/drivers/char/xillybus/xillybus_of.c
> +++ b/drivers/char/xillybus/xillybus_of.c
> @@ -116,7 +116,6 @@ static int xilly_drv_probe(struct platform_device *op)
>   	struct xilly_endpoint *endpoint;
>   	int rc;
>   	int irq;
> -	struct resource *res;
>   	struct xilly_endpoint_hardware *ephw =&of_hw;
>
>   	if (of_property_read_bool(dev->of_node, "dma-coherent"))
> @@ -129,9 +128,7 @@ static int xilly_drv_probe(struct platform_device *op)
>
>   	dev_set_drvdata(dev, endpoint);
>
> -	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> -	endpoint->registers = devm_ioremap_resource(dev, res);
> -
> +	endpoint->registers = devm_platform_ioremap_resource(op, 0);
>   	if (IS_ERR(endpoint->registers))
>   		return PTR_ERR(endpoint->registers);
>
>    

