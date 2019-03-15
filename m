Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83672C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BBB218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tkWX5A85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCOUp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:45:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44522 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfCOUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:45:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so7120257pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MedYFqyrqJk5Y4rTqrWyFLUFe+H1yz11JYtn4iLD36Q=;
        b=tkWX5A855WjQWiLO2jJ9I3z5acBomik4gteKcmr9GDG5riUNshT4aHdFnHlZQ8yhVH
         fS73+lodLBFza7YhOXeMVJgNH3HXSAsWyOg6atSEOIAcnzBFGdluoK3VkuSEf39/vv3C
         dr+8fYm8sSPT3H8i0LboR8a8e2qEujG1kboOsq4Q1BIvTY6E7VTSF3UdXO/CzCy4/PnJ
         klRL7vQcoHKnNoMu9Fs4FRKd2PvGyyKA7J/bD3ayRg37RNRp0W5m4GJWXZYjlmxybvTa
         ggVJuFzZapW60fxfQ+DdXdAIUFpWSNyNDbFuDPEUyuTb1VJXZzgv4KZ5TNE9X405ce5V
         QR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MedYFqyrqJk5Y4rTqrWyFLUFe+H1yz11JYtn4iLD36Q=;
        b=fRm/SYusJwffHsyLCN+XK8XM5ajtfN3GHFX7I8fhKavgI7zB1pg3IXg8iuXbk3jGQ+
         KRHKCDD58X11YRqNUTLJEaaqV4xoIGkiHyGMA3F8OzWdEgf7H1vImLwLkiuU6iCwINsa
         g+mvvnLRukU5i+1uoIVNGZdpaiioOdOQ7jTU9uVEsdTQAPYdvQPQnPSZjVEiLXUzPWoG
         6VJDkhcwJ7RscvBgPeQ6z+DQYIO8T5UofUTMW8KFTX2P9VtKwi2icPA31xm2pYSr4E/r
         l7ZGWvS5TeLvYdpHtQiZP9hD1Jj0WkEpvfR2qLNBvhZE5T8ugVR4VLlcyytNo8KwFLzs
         ad9w==
X-Gm-Message-State: APjAAAVIF2qgOaDODe5jiiVpvfiA0Tjj6UzRg/y8lvQNljzLVCO5c1so
        I4SW+NufUI7LnutOC09BEBdzKQ==
X-Google-Smtp-Source: APXvYqyqTZs+fiS+XZA/nWxr6XjQuLM5+2PTQxHEUAVCclw0a9oeL73yBGy2edwtjfcKIKgRzZDhvA==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr5302316pgp.395.1552682756911;
        Fri, 15 Mar 2019 13:45:56 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a567:ae30:4f79:6ce5])
        by smtp.googlemail.com with ESMTPSA id b7sm5047566pff.136.2019.03.15.13.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:45:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-gxm-nexbox-a1: Enable USB
In-Reply-To: <20190315134909.26721-1-narmstrong@baylibre.com>
References: <20190315134909.26721-1-narmstrong@baylibre.com>
Date:   Fri, 15 Mar 2019 13:45:55 -0700
Message-ID: <7h36nnc1do.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Enable USB on the Nexbox A1 STB
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.2 (branch; v5.2/dt64)

Thanks,

Kevin
