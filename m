Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B60AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53E21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+DasL0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfJAQVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:21:25 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33466 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389775AbfJAQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:21:25 -0400
Received: by mail-pf1-f202.google.com with SMTP id z4so10639761pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zGjQR/sTKc3smldtiGbvkknjnXT+JplA/pSqSqfQKlI=;
        b=G+DasL0iJZ5kBOTu/zg5lhBzEt6jZOfAi1wnx0r7cOAZ7BldGdYXaJI63ngD6HwE+O
         td2ExZht8/oykOJ6vj3MIg3yGym9/ezKCc3UmfSjNgdhuBL1BlabvNzMYb2E3ZmK4lmR
         xKQSP9pNUpOfgoU/c44mv2JlOPpsdNSPsp6QouWh475Br8GI5iE0CIHgwsannd+OKyWt
         kctUWW68POaqfmJytgwPWY5G+l1LIwfEbaTs2bpLH0Umzhe8ZJmbA42UbPso+f2qtHUY
         ulHHgYlPaHHs5q5C7uw6TN6jFgZV8vOqg7CfY4xxzi79Ymw1jMuYTQHemWXww+T+xqMs
         yHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zGjQR/sTKc3smldtiGbvkknjnXT+JplA/pSqSqfQKlI=;
        b=F2ao1a3KlCiAUyWxH0zAZtz1W5wGKGsUV0Kf2roIudbE/7QziIFVPNa/eFZ2qyvLD3
         Ft39+PtOc71LbQT0hXfuLXF5JxhlAm6l31dybhVyUriwd7Myi7SvmJkOWzCDDZKxEeU3
         GQ21rxpoSMclW9PJZEComU0xCC+uJaYf6y+5oI0+PUsZiG1rsCPcXaZZFB9keqDlDvY1
         dSOUoC10q/oiQWfDoER5BliZtkEinn7OjTdDSJnEBg2AUZrHnFYY5c1bIkM4CpLKvFVT
         NHWNsyiRehEQbhNQUz2IOq4nNqua7qdVdTWbvHcSbclsp8dg71EJbfr2h2CsrbCnlBND
         JIrg==
X-Gm-Message-State: APjAAAVHgILGn0VceD8hiS5hNcLRjiX4mzPG08NsZ+gTSkbhHhwi7WcT
        1krZNbJ8Olbq6VEZAB9OZ0G54CQRQaisylK4eSw=
X-Google-Smtp-Source: APXvYqyhx8xunEJibdqSSZMbfsVIGbOyET72Al96jQRFry9WCb7OIOKmE3DHCN3SHdahPhXrl18UgoKkM5icUQv7144=
X-Received: by 2002:a63:d846:: with SMTP id k6mr31013518pgj.378.1569946884027;
 Tue, 01 Oct 2019 09:21:24 -0700 (PDT)
Date:   Tue,  1 Oct 2019 09:21:21 -0700
In-Reply-To: <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
Message-Id: <20191001162121.67109-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: Re: [PATCH] Partially revert "compiler: enable CONFIG_OPTIMIZE_INLINING
 forcibly"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     will@kernel.org
Cc:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, nsaenzjulienne@suse.de,
        torvalds@linux-foundation.org, yamada.masahiro@socionext.com,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So you'd prefer I do something like the diff below?

Yes, I find that diff preferable.  Use __always_inline only when absolutely
necessary.  Even then, it sounds like this is a workaround for one compiler,
so it should probably also have a comment. (I don't mind changing this for
all compilers).
