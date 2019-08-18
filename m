Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD623C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 08:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9470B2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 08:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gRpAqOSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfHRIWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 04:22:00 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33925 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 04:21:59 -0400
Received: by mail-wr1-f42.google.com with SMTP id s18so5556611wrn.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=erBhroXvZphX/a/9Bqn63XJ5sUdSuQJdtIuRbnYV/zY=;
        b=gRpAqOSXfvyxIeANEB04s8FrqzOc7XOQs9CfIRJ0OZRvxwLvG6uzbYrYSjJhySc5MS
         MzF5cUUEGX4RKRP74MYoCbrcP4ng67ED5FjWql0z2fv9qiqPUFauEQ9b1P6W5dfCp81l
         lsM0f4zZYqIDqt2R35AAPc2BRH2cTvY0aBuqQu7pn5IXor2mH0aXM6rpNou5ptDTgVMU
         FFTptEhVE4pxa8LU27yJdFnnL+85MILdsVDgmZssnVZhlljGSRZ/hIl6aUhVrt7Qw+4O
         EFs/JCX8DTrG88cjPU1AaKSGKbUUaFKIHs+vUnYsm2TwJXv3yFvNs1YZdGwj/3umC1HJ
         SZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=erBhroXvZphX/a/9Bqn63XJ5sUdSuQJdtIuRbnYV/zY=;
        b=Y3Qc4Qh8lixYl1gFsY9vf3b/OPvKbHMLFnKeaWycrOPWyQzJ2UCgqIvGG/g3v+f1kh
         BvyAYf5aG4blegxwlsb5tZsUgWVQ1+YRJjgfvYYixLPVZPls3zU8iIlhmCmdWTDbABuH
         GtBITqyEdihmF9lRiOmZQ9gXnr1la4Dp1fBg68WNGx9um8qWQKNJqMcYOBYhDEi7cWbo
         5lxbkeA1YxwbujxMu9K64+hkQhc6GeJz720Vt0pC0d3NccnH2eBdM9DBGZFVFkVdOiQ1
         +kf0+o+SPKrmONbRwr+jW2PdJr/4wNnkGMQFy2xVLa4rG6ROTlNZCu2FkxY3kpEgbtCC
         N4eQ==
X-Gm-Message-State: APjAAAUYbD+EBLYI6UdbXt9t7EYxxuqMoJWzQ8Bgv3NXvwX1D9EP16kb
        l9eak7A1+VpkPfQAmuNVkrdI6LPL
X-Google-Smtp-Source: APXvYqycS2KuEihbBJaQ075irl12NU3pE+2hxKqWnCo68mtljACF93tGwaC5q6JzicwkftM0GEK2Cw==
X-Received: by 2002:a5d:6392:: with SMTP id p18mr20938037wru.330.1566116517605;
        Sun, 18 Aug 2019 01:21:57 -0700 (PDT)
Received: from [192.168.1.20] (host86-151-115-73.range86-151.btcentralplus.com. [86.151.115.73])
        by smtp.googlemail.com with ESMTPSA id a19sm36368038wra.2.2019.08.18.01.21.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 01:21:56 -0700 (PDT)
Subject: Re: iwlwifi: microcode SW error detected
From:   Chris Clayton <chris2553@googlemail.com>
To:     LKML <linux-kernel@vger.kernel.org>
References: <42e782e0-78be-b3d4-d222-1a75df35b078@googlemail.com>
Message-ID: <cdf38da2-def1-cf0d-2d35-f31cc8fe122a@googlemail.com>
Date:   Sun, 18 Aug 2019 09:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42e782e0-78be-b3d4-d222-1a75df35b078@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2019 08:19, Chris Clayton wrote:
> Hi.
> 
> I just found the following error in the output from dmesg.
> 
> [ 4023.460058] iwlwifi 0000:02:00.0: Microcode SW error detected. Restarting 0x0.

Since reporting, I've found that this problem is being explored in the thread that starts at
https://marc.info/?l=linux-kernel&m=156601519111113.

Chris
