Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957CDC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F62C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMaQ4W4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfFJTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:11:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbfFJTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:11:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id b17so10301832wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxGrZIk0ilyARGeNNCgKhGQZa7EH/uMSHTcMGHhDQ9M=;
        b=QMaQ4W4XXGQx0RuwZjmX5oQJYDawi3cbL6qNm1PK0Wyej+cgQNfVpDdaq7fey/MKcb
         zOCdXr371bMnJRfUQTXs+tdQueXm/uqqzB9J/0KXwg8tlN2X+5nGePhB13smhK+2cw8C
         JcRLFcqhAQlp4Jz5y4+0ULVZIjm7fGB/cfCFhNYCI4oMHzK/j/IxxZLYIvhEXRRoVC/8
         uvocrR09DFwzwPzqRcNGkR1cPFPHqvMEBGObCisxro16CUwjov61326mO9IO0nizld2H
         1V0uEl5ImOgXLQmSvZPoVDR50OE0azQpoVbPtbFy3vV53WLz2jBtb89I4BR0ek7vZfoK
         vGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxGrZIk0ilyARGeNNCgKhGQZa7EH/uMSHTcMGHhDQ9M=;
        b=psKIXkCfUErt4vJdCzOU+jdQQzMMN01s24UpAOdnxAubc2s0RZ/4p5AP9USIbgxTrQ
         zDkHXF5Xg6jEalBTcsmEjTlJX7J57/ORKqVwXzlrQZN+T4/Jvj8HKrwwUO4He+mGnyQd
         1v2PLH0Wf0F6+M7cGzRIgNY7KB/OCqnnOOHWF2X4l2P12mHUpyj3L4VTRXLxdYU2XnwD
         JhLn1kRKHtVi82L6unnC8Kqt2nefpzleGlFsZAh4U4Z9z7tAAY12uqfZ0YFgQP8hSzFf
         ypqsbyr5bEuvfBcvqi6YAflTAoMKXsU0bEWIcVR3TTJgSEnqNoKPeRYiMELYb/ViJCpc
         sCFA==
X-Gm-Message-State: APjAAAXjqxcUGX6OQERyjtWiGX02rTHunAel5ydXVKV+MsJocNDZFSbl
        Vvhcx9Xgn4x+ZVuQZMXvlaw8pw==
X-Google-Smtp-Source: APXvYqy5gdI/Dzp9A6lc41i4FU3NFeqmkX4ph+neuoWpmKseNBvFiu579ofTaiIrZ1zsU+GqKySYbw==
X-Received: by 2002:a5d:6343:: with SMTP id b3mr13243554wrw.317.1560193883338;
        Mon, 10 Jun 2019 12:11:23 -0700 (PDT)
Received: from [192.168.1.6] (233.red-79-146-84.dynamicip.rima-tde.net. [79.146.84.233])
        by smtp.gmail.com with ESMTPSA id b136sm670675wme.30.2019.06.10.12.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 12:11:22 -0700 (PDT)
Subject: Re: [PATCH v3] tty: serial: msm_serial: avoid system lockup condition
To:     Rob Clark <robdclark@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, agross@kernel.org,
        David Brown <david.brown@linaro.org>, jslaby@suse.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        khasim.mohammed@linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
 <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <e656ddd3-f327-818d-3688-f24fddcb52c5@linaro.org>
Date:   Mon, 10 Jun 2019 21:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 19:53, Rob Clark wrote:
> On Mon, Jun 10, 2019 at 10:23 AM Jorge Ramirez-Ortiz
> <jorge.ramirez-ortiz@linaro.org> wrote:
>> The function msm_wait_for_xmitr can be taken with interrupts
>> disabled. In order to avoid a potential system lockup - demonstrated
>> under stress testing conditions on SoC QCS404/5 - make sure we wait
>> for a bounded amount of time.
>>
>> Tested on SoC QCS404.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 
> I had observed that heavy UART traffic would lockup the system (on
> sdm845, but I guess same serial driver)?
> 
> But a comment from the peanut gallary:  wouldn't this fix lead to TX
> corruption, ie. writing more into TX fifo before hw is ready?  I
> haven't looked closely at the driver, but a way to wait without irqs
> disabled would seem nicer..
> 
> BR,
> -R
> 

I think sdm845 uses a different driver (qcom_geni_serial.c) but yes in
any case we need to determine the sequence leading to the lockup. In our
internal releases we are adding additional debug information to try to
capture this info.

But also I dont think this means that the safety net should not be used

btw, do you think that perhaps we should add a WARN_ONCE() on timeout?.
