Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5BFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3EC20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AtuT6ONe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJGSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:43:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38315 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfJGSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:43:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id l21so13409772edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZuQdDyWsqYD2ABpjzuaYMlyNtofNUDV9L/YfiTkcKyw=;
        b=AtuT6ONerZTAjRxy0hah42Bky6hjxkP4woYIr+bGSczhAipeFOav21Z1EHHKAgOYcw
         OpYPAW/p8M/c/E152ZeiMojnVRl3VCuBWf9gipumax7CyDatkTSeIaHiukmskK10TS7e
         Wt1bS84GEhhkbBj2nZo1C7iLWFzHw7yB/IvOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZuQdDyWsqYD2ABpjzuaYMlyNtofNUDV9L/YfiTkcKyw=;
        b=KKeLX+s3pjOuPFTzr3v/dF3FYt8Z4adHpyBq61cfEgIHxIzJ2hOMdoAwBEVm8cc9sS
         o1uC1s6n2oTfLftRV72AOht0+DbGQ+wi9w4jaBwpnE/ZjKMom3hIeK297K2sQZ0uy4HO
         lxyGtdCCGu0ESU9CegtAklQWwBkNF4bsr4d10c13mV0xh9Pow5s+WGTwjdyB2uIoQ/Df
         i4sJ4wrU3f67BTZRxLuc/pLDAflv6RMlPbaUh3IOYli3ZnbL0NnVtgE8mjQxcPvnr0ym
         c/2XB6ut/fIWkcnMJjorODV6yzxXkUMRuUCyLM1i8VZBOkm5cxGjlzteBfJSOTX4dCt6
         4d5g==
X-Gm-Message-State: APjAAAUwlkBUHgYsU4KY0316OZuEAJdHxHb+pkg1PaiTF+RWJZNOg+YJ
        YqZyllv8oySHgoFPyF1N+CLiekLUroOmCPCq
X-Google-Smtp-Source: APXvYqwuixYFB2yGu5CnXRGdHc4GNLnhNp+woe0QDiSmMSCQDnzOTxXR7Ds0ueVw0FX8Mmi3l2mPZw==
X-Received: by 2002:a50:9fe5:: with SMTP id c92mr30392512edf.280.1570473813954;
        Mon, 07 Oct 2019 11:43:33 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id k10sm3487005edb.68.2019.10.07.11.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:43:33 -0700 (PDT)
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
Date:   Mon, 7 Oct 2019 20:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152800.3nhbf7h7knumriz4@holly.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 17.28, Daniel Thompson wrote:
> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
> 
> It feels like there is some rationale missing in the description here.
> 
> What is the benefit of replacing the explicit int_pow() with the
> implicit multiplications?
> 
> 
> Daniel.
> 
> 
>>
>> We could (and a following patch will) change to use a power-of-2 scale,
>> but for a fixed small exponent of 3, there's no advantage in using
>> repeated squaring.

   ^^^^^^^^^^^^^^^^^^                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Apart from the function call overhead (and resulting register pressure
etc.), using int_pow is less efficient (for an exponent of 3, it ends up
doing four 64x64 multiplications instead of just two). But feel free to
drop it, I'm not going to pursue it further - it just seemed like a
sensible thing to do while I was optimizing the code anyway.

[At the time I wrote the patch, this was also the only user of int_pow
in the tree, so it also allowed removing int_pow altogether.]

Rasmus
