Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D390C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D4B20693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUOsc7nE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfIHNT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:19:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50504 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfIHNT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:19:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id c10so10923231wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rfaHrbONJalqk5Rglnc/sSZrvOVVtEVDgToC07/vRfw=;
        b=YUOsc7nEEG6/3I5boErH3RGSSQO0fyI5oD3arLtc/ndNOma9V4dZ1kW3FiMkfF4gcG
         Bx6uV2uWNKd3l6HPlZj1znXxvpNNbaDzAyoLcsw12/2pa1mqYDIuw8l5Lu9imuveCDLh
         lQQSj/rFqf7AKyAJ6d+Kl+mSsjN7sQ/7NUlLLuhQAVddUVs5THTj8dU8+8LgQCZwUiqX
         no0rNCYjhz72fLZ3I1A9/tRYIqR2ybFDwmLkO8ha50ZWhFxqlSLkbu3zYDGgk/YPOFOn
         JW3DFQybfBNtFPzKXBUu2bUSzlMYgnOWaZ4ca2G79N7EbRcyAfQD5dr+SUnOOEBUZPR0
         eAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rfaHrbONJalqk5Rglnc/sSZrvOVVtEVDgToC07/vRfw=;
        b=MfwfJkeB+6YdtvJQzfaopjfBPc7x85A6KY2V8SJeDz3F02VQMVVGsFhoD0i01dZwts
         sCv+6NHJVA5gCUXJEi/X4yJdzoJTFhbnQZITl7sp0akt6hjCB2BNZEmQNd2+9B3rMxsA
         64RGf4zVP7ciLqzZQYLx3ybta2G1YbJRaDEb4XuEd8XT8KrlKFnVg/gu997PJXwudSCj
         Eqc7bqGdYPuW5WsDWi9q/kk0wv2LgYZvX48k/Kjc1hVs4Z32NoQh2fiIzGcp6n6ZV2g+
         wi3sQLSYmRx5wdVvhqyhX6A9jFKToyw4GhZrfYDVWphL2Kp7n8PiJE4SwVxNkXLI5L5L
         oqjQ==
X-Gm-Message-State: APjAAAXrUodbW6kGhr6DdxS0cR0xL+lr8wfN+QRg0Kd4kfPZqqEn6F45
        hflLr8gYXYIg7cdJqjFR3Xc=
X-Google-Smtp-Source: APXvYqwC1sKtwnFtDzrrTs9o23o7zhCpoCqyAFr8nmlOTsxFB9FrHLZis4ZF8N4gcyhgqvNvShsZgw==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr14393484wmk.129.1567948765033;
        Sun, 08 Sep 2019 06:19:25 -0700 (PDT)
Received: from gmail.com ([134.209.253.200])
        by smtp.gmail.com with ESMTPSA id l10sm12630675wrh.20.2019.09.08.06.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Sep 2019 06:19:24 -0700 (PDT)
Date:   Sun, 8 Sep 2019 15:19:02 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] compiler-attributes for v5.3-rc8
Message-ID: <20190908131902.GA21291@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here it is the Oops-fixing cherry-picked commit for -rc8 from the __section
cleanup series.

Cheers,
Miguel

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8

for you to fetch changes up to bfafddd8de426d894fcf3e062370b1efaa195ebc:

  include/linux/compiler.h: fix Oops for Clang-compiled kernels (2019-09-08 14:53:58 +0200)

----------------------------------------------------------------
Fix Oops in Clang-compiled kernels (Nick Desaulniers)

----------------------------------------------------------------
Nick Desaulniers (1):
      include/linux/compiler.h: fix Oops for Clang-compiled kernels

 include/linux/compiler.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
