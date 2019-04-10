Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F11C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46347206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc4pt87P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfDJQ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42516 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfDJQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so1853676pgh.9;
        Wed, 10 Apr 2019 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SCRoPbtosM1WAc1OWsOBc3b3uYjt4rYcPlO+7y22AmU=;
        b=uc4pt87PXEuMmA/OkxmrFbXIuhyh4MFCTqT09mqjL67iN6ASZi/OIT7O0BoPNhDD60
         9IBBcbrC5iQoeaAqwv/HqiYbrLp6IyX+E73CGZTqHAlRJewxMpes1fkm1uvqDmm0oUcG
         S9y96LrtJvQ55HgFsu1uI1U/7xEQjEe4sxcgz9PQ5daqwPy81M0TewIseeDhJI7XfmXG
         leW9ZpPzM7mEo3eMRrqjDSd/C3tKU4zx+12yNF72SB0mrSyIp2NxYiA/N5ww8hTc+G6k
         ANQasiHnGOtx3tJKomezitXJXog8uGGNSAh2t22Aamka98P+a3vSKRjKeSRlJ+kTyV3N
         4XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SCRoPbtosM1WAc1OWsOBc3b3uYjt4rYcPlO+7y22AmU=;
        b=Eu+lciDY2l6vEWsgAFSKIJ+JYlnIm4Undli7cRlWicV6CM4KtP9kS05MGW5S1fOtZ9
         elbJqtJBZ4QvfmZtK8RVdCaHOGW79fbz2umUUeikRPlW36++H//Ti0l9bEQNzLbV6uyE
         dHwCoTpgvqQsr8VX1r1zMw8G+Q85imSml0KbH7O+gNgu2aWcl/5Dwnh160QqsUaPVfRe
         V4Y+bN7Q3T2NLxGtKrPcRUCU1PmeSjiUQ4Qa2D571wA1hhBOpC12WVTlXlk1JXY3Hkmh
         keLtfW5nf7EzAPxIq3U2uVTmgeYoCLwXhT+NBfFJkaWjjKV/vnP1wo/lhZ8vDFuNkVPj
         YyXQ==
X-Gm-Message-State: APjAAAXUs9EBRMCsrYPvFjkpcNQ43VVl6t73l646Rltubivt+841RbKh
        QW9MzHr/Td8KzyFuPkhAfck6t19j
X-Google-Smtp-Source: APXvYqzN2LkKH54Ftdcn0Y/tUHlxCfHjINh3cyvFxykWYLoppRuMWOs1NbpZ7z+rNZ2i5//ogmzmUA==
X-Received: by 2002:a63:1d4f:: with SMTP id d15mr14944477pgm.347.1554913687994;
        Wed, 10 Apr 2019 09:28:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q11sm50968208pgs.94.2019.04.10.09.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:07 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/22] watchdog: Expand use of device managed functions (series 3 of 3)
Date:   Wed, 10 Apr 2019 09:27:41 -0700
Message-Id: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
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
- Drop empty remove functions
- Replace shutdown function with call to watchdog_stop_on_reboot()
- Replace stop on remove with call to watchdog_stop_on_unregister()
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'ret = e; return ret;' with 'return e;'.
- Use local variable 'struct device *dev' consistently
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Drop unnecessary calls to platform_set_drvdata()

Conversions were performed automatically with coccinelle using a number
of semantic patches. The semantic patches and the scripts used to generate
commit logs are available at https://github.com/groeck/coccinelle-patches.
All patches were compile tested and manually reviewed.

This is the third of three series of similar patches for watchdog drivers.
More patches may follow over time.
