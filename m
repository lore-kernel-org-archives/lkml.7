Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E44C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF0E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAnent1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfFEQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:08:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38110 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfFEQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:08:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so4300050oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xPL36afWHBy5ccdQIBqIPzU48wKIpol99WUyFOefOtw=;
        b=DAnent1HkaoqqkaCWnuWYnjKxrjcK4g8EpyFS/qrRNEOtLD/LF7a3bRpg3XY9d8Y9z
         J0mwUYQGiyypk6UiOAbMXGVW1c5Ql2yueZehY6yk6nxi6fxJ/3ZK4U4qzP2+5qEY1xXr
         cc12LH5AT4iYqJdzfs8HcGT9Wu2PJAv3fA7M+E9U2aKgT+V/5ktjW9WURXy366o9ZGoL
         p8kk9rsCXmMgxHpTglLBPJu86mEOtv22dyP8wUF5q9X9eRKfEWJwdzggRyjUAQ0nDlpK
         jp94o20iZdT7TWiuiPzNyFvc6tnLphC0T4QFSIR32YdAJ74Koo9QZdBUFZS6/3NiZfgC
         rkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xPL36afWHBy5ccdQIBqIPzU48wKIpol99WUyFOefOtw=;
        b=ZnWGfYEv5hr4zH/WWy7akpcj6rOlKoYx0/3V0OyMF5Z6ODZH3BDg5hTxLrkGjslE1L
         suZr7J2hRC7VNJN02okXk/O6AiQDv0DEq3L3XZqvrnAd8jZ9LEFJFFRRMqGoVZZY10V9
         /kpwgMKdi2VfTjxlseilQN93x8fXgnfXb2ewWr/SCZNUMJsGeYXwIRRQE6dJKUheN1yl
         oFKY5GOBoYs1JjoHzp7N8j7tHyUW1ilTpyHjmmKjechPJDvD9Oc9J7rnL8D+/XpNFWQp
         q43QlIP7+QtVL/lBDuDkqJk+u5xUbuFrvS+kDjwcyO9dj8LcnmKJrwZ/hziwyg2CBE2P
         EyAQ==
X-Gm-Message-State: APjAAAVrqdvagJTd8IzO7bJikqF80y+mme4lnZXCQlG7GYlfOZKLkRnZ
        E6m+CHAbMXXgG9yPeSOB4JBsOW0mVrUmByBEhp6vMa4iZWM=
X-Google-Smtp-Source: APXvYqwsYcBTYL6DLqDK9C7sZuUwOX2XwtAmj1aHA6qTdIE3DGZAkPBgqBOl6rlQFqpbuHyr2fHnp2u4r9LaBTtizXo=
X-Received: by 2002:aca:1308:: with SMTP id e8mr6917008oii.107.1559750904758;
 Wed, 05 Jun 2019 09:08:24 -0700 (PDT)
MIME-Version: 1.0
From:   Alec Ari <neotheuser@gmail.com>
Date:   Wed, 5 Jun 2019 11:08:13 -0500
Message-ID: <CAM5Ud7NhtKDCMnf+zbsRH1N8V6=kCpEJ5NCmJ4mOQSdVA_noMA@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
To:     linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having this problem too, build is failing:

Invalid absolute R_X86_64_32S relocation: _etext

I stayed on the 4.14 branch to help prevent these kind of breakages,
so much for that idea. Gentoo GCC 8.3.0.

Alec
