Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE3C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946DF207FC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOidwmBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfK3FF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 00:05:57 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:35709 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3FF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:05:56 -0500
Received: by mail-qk1-f180.google.com with SMTP id v23so19615069qkg.2;
        Fri, 29 Nov 2019 21:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Do2B9jmWha/bcrRzWjITtxu2d5yYxoA4WCpoK6RtSa8=;
        b=IOidwmBSl2SbB0Szc6pVQ1hRHfq5gYJXQCUbmKsJCmgg/F710XP8IxQdEl/NazxUlS
         r2TUjQHmjFNaME7rCTN0DPdvp1oQ8rPppICbHAg3WGC6CX8t/AtYMQYzwvjhSvH3R4jR
         uZo+n8vMuXn/1JPGywxw5kciB74Q9JtePfYxz+YqtikuYdA35qh08GWlMNh1r/yb91GH
         Uya/+/usS+jP2KRWJZVAmqel32lzZs9FyZP/Iwe2qt9XAcx53gMx/0ejl725kqykbF/u
         vjSSAyZAIzQJ6hrTDMJOcGehdNjhixEPOUTtTrHK3LJPySxJdGXblBz4itDqB3AqCZoS
         AeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Do2B9jmWha/bcrRzWjITtxu2d5yYxoA4WCpoK6RtSa8=;
        b=N0bUlc18UrR2RcU1HL4KzpCf0+aqeBpJNibnrv25JIjLbRLC6ir85ygm44/guUM7sD
         Y7lSoz60O8dbqZXypvWsA/I+AEkamJR/SJ8p9DyfXd20+beLomLYuc3HghyZMBtOQR5b
         qr2HcB52gGqgoTWIb0ksuyIIQa+05fVpCAfnWWeFpBI7WNrLsJMHx0QG7inLy7ekX3r7
         XW08qVd3se8r8ux5G1bxpqh3tFQ2twyhyxAqHbUSeqBPm49dPtsABkv1IwfE9MV7LGpI
         3f6a4xm3EeJlGAcSQ2kvwD3Xl8MQKFZDAQ9YUQ5wK3gzAoaDkxYscsYnXP0X5h0FvskA
         DBLg==
X-Gm-Message-State: APjAAAWs0vES2WB6Z9B3KT7HSAUELBFrRj5ObENvaMIpTpoFhvRRdRvL
        JaZuOdhHdmJWe4A3GQAvRkpBmgd6Tc2MdQ==
X-Google-Smtp-Source: APXvYqx82AHLwYTgOhEPpRdIU8/HQVpv/h+gzSO42GuNeCO5QGFqXtZZlHYAUxRHkYh0yc+G/qg0bQ==
X-Received: by 2002:a37:4841:: with SMTP id v62mr19841347qka.444.1575090353773;
        Fri, 29 Nov 2019 21:05:53 -0800 (PST)
Received: from ?IPv6:2804:14d:72b1:8920:a2ce:f815:f14d:bfac? ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id 62sm4814617qkm.121.2019.11.29.21.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 21:05:53 -0800 (PST)
Subject: Re: [PATCH v2] Documentation: filesystems: convert fuse to RST
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
References: <20191120192655.33709-1-dwlsalmeida@gmail.com>
 <CAJfpegsxXJN1Z5fGzcv=+sid6gSzyD=KtA2omF2Xsx8dy00tRw@mail.gmail.com>
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Message-ID: <d7bc2ab8-c1b5-85fb-6de3-c9c939d2e678@gmail.com>
Date:   Sat, 30 Nov 2019 01:58:08 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJfpegsxXJN1Z5fGzcv=+sid6gSzyD=KtA2omF2Xsx8dy00tRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miklos, thank you for taking the time to review my work!


I can send v3 and put the doc back where it was. How about the 
conversion itself, is it OK to you?


Thanks,

Daniel.



