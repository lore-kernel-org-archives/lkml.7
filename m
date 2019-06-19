Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8CC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF2820679
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfFSOlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:41:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42348 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfFSOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:41:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so20132270qtk.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imIXxPbZ1GJrgfFyh7h0ZMPSUEh+9F/1XwIbxGydk0A=;
        b=LIqxvUiJrgsDj7w8KnvtQv6hbWpkQvLjlnUF1mTTcpExhnBZQ5auVxW/6du26/TUKp
         4X33oP2KN0uDuYXPEoq5uqPIJT08PkeE73nv1TcSdvx+o6di31NllfkU5LzRroD93qE9
         hTBT6BI0KJn2i0ka2EdwIxFI3OvqOKmIqcuyed7C16MudahN+udZa+GPBYPCGzIKLBwN
         GYCF7wEQlCnFiZc61m/xhCJMhQHt9QIQDJ9D8U9kImkNx51oaiGrUUjNab6xoP1mk78g
         ufjFi1gsKnGiIDefjtZk0o+phHQmfZANdo4kxFq8TsiBCvn2k3u8q4Ab6g2Ch/mjwiWb
         NN/A==
X-Gm-Message-State: APjAAAUVGZD6q+7DQYNArF3SgMbWjsJWifZsNr6jzE4MutxzI+FNKSxA
        6e2Cj6qZ3Noe1vz27vlQgThd6p5pTuFgMCZRJdM=
X-Google-Smtp-Source: APXvYqwiWCx3dFmr2SFdQBJcaeOaTB5zz86ZZQnqyrupWaSj/TStSxFTWZ4+gMlf89TDNvSRpZOc5Zgfu3+VWwLxJxc=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr28367056qtb.142.1560955278058;
 Wed, 19 Jun 2019 07:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142350.1985-1-Jason@zx2c4.com>
In-Reply-To: <20190619142350.1985-1-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jun 2019 16:41:00 +0200
Message-ID: <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: get_jiffies_boot_64() for jiffies that
 include sleep time
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 4:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This enables using the usual get_jiffies_64() but taking into account
> time spent sleeping, giving the high performance characteristics of
> querying jiffies without the drawback.

Can you quantify how much this gains you over ktime_get_coarse_boottime
in practice? You are effectively adding yet another abstraction for time,
which is something I'd hope to avoid unless you have a strong reason other
than it being faster in theory.

How often do you read the current time?

      Arnd
