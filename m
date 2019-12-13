Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1406424658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGZm49TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLMIXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:23:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:23:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so5665100wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=82UDForXBclaXTmeibYTDaW5JlhOC14SnMnAwguOTpo=;
        b=MGZm49TSm6YR55Z4M/q8t/y0AMytdlby56dY6eoGVWh2vU00Al/RppWCcPhlnSMv7i
         5jNUBrje+r0IqzOl8/kqfJWqDsRbgYZSyA9aMJOAed5HTnCxj4BSAVpRgKrQE/yIyoPB
         Z0Fgf9puWv9aDusjm2k6ItffK/wr16PErOd19tZxtyx1Dhf1SJc63f8gVxfTaKE1aCUC
         Anqkqg8Vj09BOmJ3LjFfuH4q7pmtIEtnBcAS9bLN8OfS2dkvSbSBBYKi1qNLC9SQQM8N
         l+jf1tvRrTgeATSisYSSfEYrY/YwZgcSeGJXAHS76gnwB7R3qHWAllVe9KWCBArLyQ7L
         NDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=82UDForXBclaXTmeibYTDaW5JlhOC14SnMnAwguOTpo=;
        b=imOWyQxcqq49ECPvIQ4DhM98Wxw6BAIZZ5CN0M4BijOVhz7mOea5AHFjoOqq4zkerF
         BWTEKytZz6bgT8u1dXheSmtq2mOl4orRCnzolAqpYNKGCcNJnAk+eVRExQWRxqxxRXig
         WA8wqZTARE9iTYok6fZji716LvF4zfLqVhLaY5/KW+azLDIZydIlZFdw32ulGB3JZO9Z
         8/TrJKn/9f4j8WBuMcmdZ/krgdO1XDYjzNet4ePePk+Rr2bqbTLDKs4RDQQ9/n5sap5b
         zaURXpakxVP3vvjOAMecfNZo4eDO9dt7wImLEfao0BXcvIZsQDQv8kAEbvwDW5ZWWUoM
         cbVg==
X-Gm-Message-State: APjAAAWf8du+57wYHu49i35SofAiJ3steKH1VGmgbQZ4it1r4uN6TpVH
        1g2TBpjWdxyxZUICAIsRNTMYcQ==
X-Google-Smtp-Source: APXvYqxuukvqRUXzxZ0gSTrMqxRuIlppYpygmVYLR71C/aCAJ673bnYC+GRd2ZcLF20qehIM64I1EQ==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr10583908wrv.368.1576225426370;
        Fri, 13 Dec 2019 00:23:46 -0800 (PST)
Received: from dell ([95.149.164.71])
        by smtp.gmail.com with ESMTPSA id x18sm9172810wrr.75.2019.12.13.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:23:45 -0800 (PST)
Date:   Fri, 13 Dec 2019 08:23:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Orson Zhai <orson.zhai@spreadtrum.com>
Cc:     Rob Herring <robh@kernel.org>, Orson Zhai <orson.zhai@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        baolin.wang@unisoc.com, kevin.tang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        liangcai.fan@unisoc.com, orsonzhai@gmail.com
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20191213082336.GD3468@dell>
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
 <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
 <20191213024935.GD9271@lenovo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191213024935.GD9271@lenovo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Orson Zhai wrote:

> Hi Lee and Rob,
> 
> On Wed, Dec 11, 2019 at 02:55:39PM +0100, Arnd Bergmann wrote:
> > On Wed, Dec 11, 2019 at 5:09 AM Orson Zhai <orson.zhai@unisoc.com> wrote:
> > >
> > > There are a lot of similar global registers being used across multiple SoCs
> > > from Unisoc. But most of these registers are assigned with different offset
> > > for different SoCs. It is hard to handle all of them in an all-in-one
> > > kernel image.
> > >
> > > Add a helper function to get regmap with arguments where we could put some
> > > extra information such as the offset value.
> > >
> > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Does this patch look good to be applied?
> 
> Or if any comments please feel free to send to me.

If it looks good to Arnd, it looks good to me.

I have quite a number of reviews to get through first though, please
bear with me and resist the urge to nag.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
