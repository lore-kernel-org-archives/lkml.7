Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17766206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtjgQa8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfDDK7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:59:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35303 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfDDK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:59:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so1066629pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C2n7auR9XrmVNuGRtjtTiE7lCR/G7AjBp8rceLUifX4=;
        b=FtjgQa8QBtP8156KCcRWnTJIsouy7GvP2tTbQdVSHsnYIvzAGHH2q65jSZ9eAAOCVV
         Aeb7Y6OguOWRG3YUzAlEklyL9osSM4RYr4JeIofKKpr4m4ipmZsWrg3s/YddT53nOPui
         U3PRD6xZCp74KwYNJly03PZ03cgEvG6nJq4p7RhO9eN6q2A8F7zxbSxjlx8L2bbLCAVb
         5GLJvo5h5E4FCNZrpD84VZ59IcfpeZp59NPlz8+ng418sdiFlsUYUt3MEXk0MRUZ02vy
         bgGI4hL6u3p3TrvkVHQcSLXwoPEp5g8bey17JnTseIyr62moiJeNGDrbUcbpfI1BuPaB
         ZRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C2n7auR9XrmVNuGRtjtTiE7lCR/G7AjBp8rceLUifX4=;
        b=o5kWxqO0rzeL3Clwers1awM/JrGXswNSk3+knT2mNF3kUuouhXuR53JQ2aQ6G/ndUg
         zzfBLu7MvoENqX6YqMSrlpJDc/7zq1pjZXHP23EQuK+L7hveC8TcF9TWhBHZsccwP98r
         s0W/G6Q4co/Q6GykaoT00lZUod0hcFHvSNDYO9McU6BQkskFda8r87CyMxr2ne424vOQ
         mqketSAzn289K23ZVkywY/ftgsdkAHN50Z65OMaYooVE3Lxzua0K0Rf5FLWQrxDE1xZc
         ayTMYxV6zSZc4oLaJmcgHAo/o6nRDrEboX38eVDqLYqXxCunYG1W/Xt4hntbyPyrGDRQ
         TOsA==
X-Gm-Message-State: APjAAAV2QbkGUTe/dYRKE9LKrQsjq2FriG6oktfHU6hxKG/o25tnxi9+
        BFrg8/I71ny4SCU6IASYwF6WXzcv+6c=
X-Google-Smtp-Source: APXvYqz2ul2rSae9gOSMV4gw1hDC9j7OcPciN6R8z1jOODR9E6BgMS741fvu0u0CGUwfoRUZiapJYA==
X-Received: by 2002:aa7:9211:: with SMTP id 17mr5184092pfo.220.1554375589314;
        Thu, 04 Apr 2019 03:59:49 -0700 (PDT)
Received: from [10.71.9.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id i1sm40543613pgc.63.2019.04.04.03.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 03:59:48 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] nvmem: sunxi-sid: add new reg_read func
To:     Yangtao Li <tiny.windzz@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
 <20190402154514.11284-5-tiny.windzz@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7dc60dd9-3bbb-f215-4554-a0051c0cfbfd@linaro.org>
Date:   Thu, 4 Apr 2019 11:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402154514.11284-5-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2019 16:45, Yangtao Li wrote:
> Because there was an endianness issue. It seems that reg_read
> function which the nvmem the driver currently exposes is wrong.
> So add the new read function, the new function is used when the
> native_endian flag is set.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

This patch and 5/5 does not apply cleanly on nvmem-next.
Also I would need an ack from Maxime to be able to apply it.

thanks,
srini
