Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15C7C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D7B2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG5VFsWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfLRQ45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:56:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36646 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfLRQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:56:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2720102wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8jj912AzfGGR36Zyy9ypT1L40eB7VdydRDFRM+xeTvg=;
        b=NG5VFsWc8OpSQic9A+qnuy4tuyQZdBU9/nTqultIIQayP3uOueYT5vGA+8b6M1HV8h
         bxdKnjCmG+UfDHsM8noS2NBaSKlX8UL7eihej0mx97HbhLYXYKoJW254BhYko9SuLy33
         ljPy0UWL3KfqEm08I9Fd7J/fBnELrh2eBp/0uGIliwDzc/kmvW16bQSO86KgMZ77Oxc4
         7sqGqHZiqgXXKs8pBrz7C2h7PxHHGL67p3nWtaJN/ECZaGsgw7EBw5njpjDVuZ8FPbSS
         Rjj4RUZmI4aVN6NQis8G2s13S6sI8seJ9kRgafhXcBCCtsf7SDB1RN6ad4GwWfiVkZSS
         eEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jj912AzfGGR36Zyy9ypT1L40eB7VdydRDFRM+xeTvg=;
        b=ueEZUP6NgGqz65K3hErQGINGKpRNpVgUooJJ9cNzsbLgrMQ9XFaQ/BPC6+xlhbgqIK
         WPgJs16JwBTIQEg4ha7XC4T91kI/ZYrQrGkOwe7wV+pCRyrGnL07Xsz00cHmBGMBNKv6
         KA8k9XxbP9+Xo3ePFt7bWDtNVrnhohPh4wOUpQw4YZ3Yr2l5roIFXUezKjAasJXOJwCO
         DHSDIBWU/VXuqq5EMzu5kKFuOTjAdckcdMb+XGa0eTNSAiAkz54towFDWawAdgAxYlst
         PtXVB2PBYgOD+g4hjZ7sMRgxExsbRdEj0Xn2rblNkTecb6fppwnbBO0+x7oHed27DmWD
         QIWQ==
X-Gm-Message-State: APjAAAUpxRQOGXVJjkQkfsIRwnzlzpm3dbkIS4ZAv1s8MEfWweKdy2QN
        ToSUPJbLUQ4RdU9m5yFcnRG16aXP3hA=
X-Google-Smtp-Source: APXvYqznvg70lQUmBT0CE2ypcnW1H3HGNTT/+ZStxK+nd5g6Jq0zy6bdSurZTVj87HNT3pvZgPeZVQ==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr4472324wme.90.1576688214360;
        Wed, 18 Dec 2019 08:56:54 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n14sm2981137wmi.26.2019.12.18.08.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:56:53 -0800 (PST)
Subject: Re: [PATCH v5 03/11] ASoC: wcd934x: add support to wcd9340/wcd9341
 codec
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
 <20191217121642.28534-4-srinivas.kandagatla@linaro.org>
 <20191218114624.GB3219@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <80a291dd-9063-ca34-08ac-5ed194e05e79@linaro.org>
Date:   Wed, 18 Dec 2019 16:56:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191218114624.GB3219@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/12/2019 11:46, Mark Brown wrote:
> On Tue, Dec 17, 2019 at 12:16:34PM +0000, Srinivas Kandagatla wrote:
> 
>> +config SND_SOC_WCD934X
>> +	tristate "WCD9340/WCD9341 Codec"
>> +	depends on SLIMBUS
>> +	select REGMAP_SLIMBUS
>> +	select REGMAP_IRQ
>> +	help
> 
> Why does this not depend on the MFD change?
My bad, I missed this, Will fix this in next spin.

thanks,
srini
> 
