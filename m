Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79CCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F312238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sezAG8uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfGYLP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:15:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41680 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbfGYLP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:15:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so29371169lfa.8;
        Thu, 25 Jul 2019 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QstKujjss/0DVnYAF/0TqP63JHZfB86wUYC2n+CaVaw=;
        b=sezAG8uN4ojmh3KX81i1yVQrYSLC3CO86FTiakafuU/O4OR/mAhXKmyIRLIwOPSWBN
         gwfnZ9xQNuo3CdKoQEareQCWp+6CRxX5F2Dol1OY42Il+hKQMEFTY6FvDgUDqml3ODEV
         lN4rcwJklFe1PhU1o7KRt8RRc+FXrUHbNLbElhkWnTh4bcbK1SHAZuEwn4/v/ll1xjFU
         72insAs7hQt3uSKXkZJIAMcobzxMSEqc5E7I3ND6FQR9Wm398NxHKnexAzk9tWo9J0FZ
         pyDUkFVxsRWJ0l2PFXAYdIpI7dOCcC17m1Sr5XM+9UZ3+YkcMiSqtWk8mRT2ZEmfm+Fg
         tM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QstKujjss/0DVnYAF/0TqP63JHZfB86wUYC2n+CaVaw=;
        b=g2H0dZ0yGWOEgilI29rmciABP3h+O60bECRO7maE+sox2WPOibOmZSrT2NijAwIaGh
         rC/k2tmn8vmO5BWkzP7zK9yQGlU7FYs6QHN+E/bAaPfn75sVy/paU5BEfBMeY9lIoOLZ
         JUDNWt9o8dV4Cjg5yt8CXB1uzZGkFEDCm4EjRrEaD2UXJw7AsLypGUYJHc3OLgQs8VW6
         YFcvNOQp/o6N8CbQwDuPHGCgWs0pGsqEmAHKQ8F68o9Dpk60RoRAIW6+Ut1PtPwfwEUb
         nqa41TByOAbrOBbTO8blExuYw05FVV7zyahfHARnYE8djruaMVYszs8VuA3MugKw2pNs
         iYDw==
X-Gm-Message-State: APjAAAWnfk0oDTdQo6Ds2XlMQ9+vZYmz26f7aeXEu1HMSSoK01TkJDGw
        Ya5dj37AhU2IWcs7J74nXqdwwZMt
X-Google-Smtp-Source: APXvYqxBsw9k0EPJMZuZ6kkrUZKHfpWXsS5Z9fW12Fq/E9YP//RrhuxJ/z7QKwu0EOoxlkL9yqA+WA==
X-Received: by 2002:a19:2297:: with SMTP id i145mr40440899lfi.97.1564053354293;
        Thu, 25 Jul 2019 04:15:54 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id c19sm7380178lfi.39.2019.07.25.04.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 04:15:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723023511.24542-1-digetx@gmail.com>
 <20190725093644.GJ12715@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f7879942-0875-1f27-5870-3f8414c2148d@gmail.com>
Date:   Thu, 25 Jul 2019 14:15:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725093644.GJ12715@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.07.2019 12:36, Peter De Schrijver пишет:
> On Tue, Jul 23, 2019 at 05:35:10AM +0300, Dmitry Osipenko wrote:
>> The PCLK clock is running off SCLK, which is a critical clock that is
>> very unlikely to randomly change its rate. It's also a bit clumsy (and
>> apparently incorrect) to query the clock's rate with interrupts being
>> disabled because clk_get_rate() takes a mutex and that's the case during
>> suspend/cpuidle entering.
>>
> 
> SCLK and PCLK certainly can change rate at runtime, although the code to
> handle this hasn't reached upstream yet.

Okay, maybe this patch is indeed not very worthwhile then. I'm leaving
it up to you, guys, to decide.
