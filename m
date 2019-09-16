Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5501C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BC6206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568632266;
	bh=Ney3J24FYuJMp63vQJFiK7dCZ780fDYfjeEBaJ0HFaA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oGyMrHZjzW3eZklteLcVbg8ea0iyQFWvxfQut3f22huFumLIO3frGwvcwRexXiP67
	 ZjHlVhXFNXIMJBZ4R71b8ZLaRvHhL0+OwOmKRWQFmkFw0kqcy0Tm7QwypZYKD1HkQp
	 zhPVch9SPx8ccq2ZcRzQYmclMIfmiQJgk+Qfwbqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIPLLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:11:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfIPLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:11:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so9277686wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=6FJz0x5WAnwTFoZGP5ladBA6qjVpuYXxdgWUuzcvsVY=;
        b=UYg+Ug3EJWQqFyR7bTbK1jmRSS4KgydaMSjtJqx8cVgtxc8fJy5WUZmD1cOWASuzF/
         +1E1cGBYqRNRknQwIoKjHuAQuM5rnrrL4I85nSF6Tiv96Xx5w48u1EKCd+EgquGv7Ekl
         WhDWh6puEITZuSexz0wXYcQgT6F3qrx/A8f11oNxtXZjoW/x2bA46EZCNoajHLMe71by
         NaIPXmCgANU5fJoHdaS9llHZ79HOMr2qEYLBNppYJEYThgLNEFx5kMoHRR+rkAh3R+xB
         p2HxmUyEvEyhc9Wx9Ghcz3wAU4lz9o5XQiH/uuqi+028VWcK5b+IrL1cvB9aL2eygSZf
         lqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=6FJz0x5WAnwTFoZGP5ladBA6qjVpuYXxdgWUuzcvsVY=;
        b=Mecxo6K5cmcuf+/Kk76RqzGcq2Nojp+GNcL2o72XNzMQM70KepEXgUhfVQcezhaAvk
         9LoZHkM2f9XI8avFgN26ohcF6Rx1kk3Jo+NfqfzB2LYPqCtKI1Tj1eEVDcHSN2Q6elrF
         XAGXLJ9kBnBkJVdMrjvKSlVTNNhmDhrtGvgjUjQs24u6T7tFSeo7SfLyNzaB3TmFvD7Y
         UN/Zob0vuKZl15elGnWkixdoJaz9yZn1PAiopD3eJNcyxn1CdexJZqH/sH0BIAYJmZ7/
         sRsvBPott44/N0IQ0PcVpEuPDnJawfQ2mBCS41WZLunHSJlb9OOP62p/ovL+iO1UBsdY
         EzKw==
X-Gm-Message-State: APjAAAXroG+ciesVso5FGC/OxzAhfWY9C+UQ1iNjkYcJN1mkEMLER6+c
        G6o9LvWy/WPq2kRrzvjdIM2JbDY4
X-Google-Smtp-Source: APXvYqwfd9mswPj7oAaT7QspLKcUrScR6xIDV4GbTqjTvyiXKI5bd1U+ZYvFYcV4BGeZEEKMHHo5MQ==
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr13804649wmg.53.1568632263574;
        Mon, 16 Sep 2019 04:11:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v6sm24663752wma.24.2019.09.16.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:11:02 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:11:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/headers change for v5.4
Message-ID: <20190916111101.GA55216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-headers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-for-linus

   # HEAD: e8e4eb0fbeda570b16464208aebf5caccfb6eb95 asm-generic/div64: Fix documentation of do_div() parameter

Fix the parameter description <asm-generic/div64.h>.

 Thanks,

	Ingo

------------------>
Jonathan Neuschäfer (1):
      asm-generic/div64: Fix documentation of do_div() parameter


 include/asm-generic/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726fdac8f..b2a9c74efa55 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -28,12 +28,12 @@
 
 /**
  * do_div - returns 2 values: calculate remainder and update new dividend
- * @n: pointer to uint64_t dividend (will be updated)
+ * @n: uint64_t dividend (will be updated)
  * @base: uint32_t divisor
  *
  * Summary:
- * ``uint32_t remainder = *n % base;``
- * ``*n = *n / base;``
+ * ``uint32_t remainder = n % base;``
+ * ``n = n / base;``
  *
  * Return: (uint32_t)remainder
  *
