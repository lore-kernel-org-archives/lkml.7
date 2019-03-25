Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DCE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziQbKpah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfCYHxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:53:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbfCYHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:53:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so8841141wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WwxHs9gNN2oayYIsOpyLynhSLaOqx4Hgj4wWzDLjm+w=;
        b=ziQbKpahiEr27faX5KWlmjulgu+h6kB+eKxwQsgRHyye5EWKOYFrxBC2tz0GpkyIwH
         BAF0K9Eda3S80i2btCOaaEF7mLhplQhsaWKKNeooVgTnZlbOaed4NDAvqUba2q9z79Y7
         JFbl34yVxU+2ilRsg5VUf7lXinHLOqECFp0b56cT087oYVA7rukCFRFJhgBH5Zb2yo0Y
         bAM2sth2GB4xkNAS2xeqIHv3c2E5p/geNB8vG3jsiwVaUH7Eikjrf2aGIPkOdu1HnEW0
         GWF1160icl58FXnH6ReiJDo9wjc0xkpVvS+SMY1h2fwy9nNxq7xwwSCcgDS/2D81+H3m
         8gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WwxHs9gNN2oayYIsOpyLynhSLaOqx4Hgj4wWzDLjm+w=;
        b=VGVaGdUb2uzJ8n8CAYINZNJyolk49ATAVx37o3Pw4v2wYabqpBJ+9eL6dbUH2fQFoT
         qIg+UyIhkGxpssfW5mfd2JZ7ePTTwyhzdgHN175qchVHBDJRwvr8oD7nQlDdChMYY7fn
         3rOVSKBAVMWu22CZSASj7RibQuVrx1Kzgedrl0/KsxT5/iKl1LTPX2DNJiSD6XgldcxX
         6u7Ofwz1IS9cUulQ3ZtbBgLOGUcNxIt1GOSzWO5xein66+GY2jZd/YZvy/v9cCJasHbi
         VU5RM/EwX5nXw1jl5k87ElWzul3NyBxhfhf0Qk95ZrMtlz5FQZY8MiSd0XdrJuqqaIg4
         fnuQ==
X-Gm-Message-State: APjAAAWOmw+eqG6rE00b5C6CGKvc5mBgVyXsHnG2XQ1Oxl1XDOkHFhqN
        +qtjpuCcHrgXiV/1rtdV7/UbWg==
X-Google-Smtp-Source: APXvYqxnhzw0RwTGCkNmlKFbu7BLPYSX4nLK0ULvy6F+WfFsboL75U8zPiYdW1uUFmw4y70rlp81og==
X-Received: by 2002:adf:b3d1:: with SMTP id x17mr14826984wrd.15.1553500400326;
        Mon, 25 Mar 2019 00:53:20 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id y197sm24589511wmd.34.2019.03.25.00.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 00:53:19 -0700 (PDT)
Date:   Mon, 25 Mar 2019 07:53:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver
 references
Message-ID: <20190325075317.GW4731@dell>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-3-dmurphy@ti.com>
 <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019, Jacek Anaszewski wrote:

> Hi Lee,
> 
> Can we have your ack for this going via LED tree, please?

Patch looks okay.

You can take it through the LED, but if you do I will need you to send
me a pull-request to a minimised immutable branch please.

If you cannot do this, I can apply the set and provide the same to
you.

If you choose the former:

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Please let me know what you decide

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
