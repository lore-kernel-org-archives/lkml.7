Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88290C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5221734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ALVqQgtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCLVLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:11:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35280 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfCLVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:11:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so2733710pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8FaLs0MolUkifKeut3/wUXNuJGPWfQPncZ9agSOKA0Q=;
        b=ALVqQgtXlNZVUUqHThyPjzn0W+AoLu4mN9ZK0RH3nC0IgbYhDojpCQiqwj6B2RFYIz
         hPaUFessrqXzSI3a/zKmys36xNz6X7HvCzaTN+wEMJmsVKQRywL5CrOa+eTBVQCjJ0vZ
         nx+xKpoJvUaInFhhD0GTy+hZeyo0D3w6VtbiWbGYICyAfiuDPRajCfIBT5wUvH9dlJne
         wh7uc7iF3z/0QQzcpwegxQuXSyD7TBBM2rmFnBadhqBCgUBBh1hCKccvoZ4PQoSoo0mI
         ccR+7mLP2mICl1zZAHLDoOw3zrjtPHhY6QWeKD1rzNU7m9HNHV989aQfgLdt/STdNKlw
         iBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8FaLs0MolUkifKeut3/wUXNuJGPWfQPncZ9agSOKA0Q=;
        b=snoVXlcl6PEVc7tpd+8yVnajZvfHT8lSa0T+0O+68SyNY0SQdUWmVw8/j4lmQBX3rr
         /9dmxRCJwPkcmZKB76Q7ah+0zEDvTEuvgoJz4EuzcFEox76BVRG1Z8aQmjJby3Hnexlx
         HfCKyerkRznQmpb1GTyKMtQgWqxmRl/BzyyHBWsLMDrVpWso6gXDYasPUhait0huQhM/
         9ocL31iPmTHKrqmgUKIDW/r+j09N3/+NL7L610sRDNJ/Tbbidy3OS7yf4F8+MKQ/qS2m
         9TwTQipEcWPKQa8ppkr1SNn7afhCm6VVDg8c/BL9N/itqbrLyZjpEeoeuAdnyLxutPUf
         8VPw==
X-Gm-Message-State: APjAAAUpjZJTY3Q1Len5cPEYqU4/oCkfYxrYfvLEy8uSsYqkb1nd89v5
        IGxrQHdX687twf7/d4taOU2Aow==
X-Google-Smtp-Source: APXvYqyy/Qj5qoa/rx3Pq31XNygHSUvbFNRdVg+L7X7Gvvh6Vzy+u95YbPocDPi/WjrfngE/rX/5UQ==
X-Received: by 2002:a17:902:b201:: with SMTP id t1mr5825153plr.55.1552425089579;
        Tue, 12 Mar 2019 14:11:29 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:1daf:3f96:9f7f:33ba])
        by smtp.googlemail.com with ESMTPSA id v8sm13118551pfm.174.2019.03.12.14.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 14:11:29 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
In-Reply-To: <draft-7hd0mvu7pp.fsf@baylibre.com>
References: <draft-7hd0mvu7pp.fsf@baylibre.com>
Date:   Tue, 12 Mar 2019 14:11:28 -0700
Message-ID: <7h8sxju7b3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> This patch adds the 2 UART nodes in the EE power domain with the corresponding
>> pinctrl nodes.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Similar to PATCH 4/9, are you wanting to move this to the board series?

Nevermind, I misunderstood how you were splitting up the two series.  

Kevin
