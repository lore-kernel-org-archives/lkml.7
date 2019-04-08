Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D67C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DAC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGodJ5Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfDHTji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32961 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so3600718pfo.0;
        Mon, 08 Apr 2019 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=NvIQQiGUUqMq2n4rD+U/QDSFSbC0cU9WmZgqSLRuhSU=;
        b=QGodJ5DpLvDXR+YRurVP3T5OVo/DZox3K83UfNn9ugcYTvYVnsqlErSnU/6bC05mCB
         aOZJEzfjk1DWy72KHY3b2OwSKvxVqYsAWKJPIhP7riHqCTo38bTycFnXPBgsjXkzTT8O
         sn9YVwZFwbqbNiD/FbHPIBu9+0srzqa/PJMb8Gba2DO1eGU2OSzA96DFe8DAgQRbOLYo
         vJB/UuODg1wqmYskqGTsW6VmcXHKpeLTU72kzsK4Rk44EEGKZer8zB6u0uP5qYO/bDvq
         Nkw12H12CEaKa1R2pGrHSepd5qC5nHw7ZKtRHkvfjp+TIewgalwShBnAZTmrop3BVwLb
         au7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=NvIQQiGUUqMq2n4rD+U/QDSFSbC0cU9WmZgqSLRuhSU=;
        b=kfo1MVg2/VyhJ6phop7vJxBw11xiDRGTQ/JxANTsETe6LLqrnX6kiH1wR9ES8xv1A7
         yDk/vtpZfoWDYsEppPgIZaV68kMh6FIFpGrvDguP1WbT3ngSSBRlHig6eL/VRUnY0hYX
         OLKCsZU4T0H369XA25bRxq/I9q9Llc7VaMJy3zoJtyT5iXjdXduK/jYMu5I5hjYFc10S
         Vp99PcG+7YRhmnfunLcYE0ENXrlczZkCN9qU1U9tsw8RiAE1gIiBg1EoT4tFudYxzDXv
         OHDSolYsztfMxtSEEMFAnLF7AUMsb/V4rqwuqbkjkeUbXaGBc2MS0SZ8Sw5/O0lmDkHd
         K6Jg==
X-Gm-Message-State: APjAAAUiPWzzi6Gj2pMhjpxxE5cHOPxhHFL6Uo01jg7NOVi5C3QSyowU
        82CP2qRDYB/E56OZeCQvxxzhClMx
X-Google-Smtp-Source: APXvYqzvtOH5OtOSw54J4KmmjizX0AXH/HadPoLS6SfOBjxBau1ydp4yUV6mOY41IXMys/BYBHK/SA==
X-Received: by 2002:a65:51c5:: with SMTP id i5mr29429658pgq.189.1554752377332;
        Mon, 08 Apr 2019 12:39:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm29184342pfb.80.2019.04.08.12.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:36 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/22] watchdog: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:24 -0700
Message-Id: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions and other changes to simplify error handling,
reduce source code size, improve readability, and reduce the likelyhood
of bugs.

The changes made in this series can be summarized to

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_watchdog_register_driver() to register watchdog device
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Drop assignments to otherwise unused variables
- Drop unnecessary braces around conditional return statements
- Drop empty remove function
- Replace shutdown function with call to watchdog_stop_on_reboot()
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'ret = e; return ret;' with 'return e;'.
- Use local variable 'struct device *dev' consistently
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Drop unnecessary calls to platform_set_drvdata()

Conversions were performed automatically with coccinelle using a number
of semantic patches. The semantic patches and the scripts used to generate
commit logs are available at https://github.com/groeck/coccinelle-patches.

This is the first of (at least) three series of similar patches for watchdog
drivers.
