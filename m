Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96444C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10D2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8YraHX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfCPE7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 00:59:37 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:33469 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfCPE7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 00:59:36 -0400
Received: by mail-pf1-f181.google.com with SMTP id i19so7729099pfd.0;
        Fri, 15 Mar 2019 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xZT0VQZdUPtziTV/AiaYj8BbSQ+25h1ljNukwj0CyDg=;
        b=S8YraHX8fVFL/dJ03F61c0KJnyWUZRaJ8cBQOM3WgDVqpfbyT4LOsKPPcxZpgD5DCg
         +FMAcflYRYdfSs56tWcqfmwtAFbnwe/AOAf8bRSDPvAyTb/gwdffSm4aWtvSdmllcbco
         E0TDCCMWHl+ikfciR51KfwlwJJvt081AQg1QZErlLzE59SrTYKQbxahbxnpTZkROIwmO
         snrPm6mZ9XOibL4olHfZDxy/e14ZrkvBE4fY90WkxIpoRFOnFoZxUYYw1Vd4b1HmtH0i
         dJV5bYQ53iyWvqN2J7FvmpPDoYqqNZ2A4m+Wp+OGIPyopeTLQDmddPwpsFT9FpCuAEII
         Z7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZT0VQZdUPtziTV/AiaYj8BbSQ+25h1ljNukwj0CyDg=;
        b=ciVMJtd7as9G7OgsWmQfeMLvlCBLP/a1j3peBxLXY+NqYBmyx573BxnF0tTRBIm8rx
         FS5pgf1HWaQ5keJua5FSLVLqi0VVLk3Kxh2gqagZhDz/Js8VEYKMSaz6hTbAQfagSC8/
         G5PMV3tQAIphUmqzLuQ41f9KBuQ85GKsPgWkOPcdgK+iTJfO1tmy/JrJDVx1PcVn+02C
         w7KYiuYV5G4mWcCH1+BPjEcyU8cL0xj47Q89nSOh9wUdebtUMW8qnevIktQZbsG0XeYy
         yxBW8Ey6EiGF9b3kzunngbYO8f3ShKSlrkTWfaeiZAb56TVMU4qfXgmgodcH2bvo4Ti8
         p2Ww==
X-Gm-Message-State: APjAAAWyjoQLt9JeGZKD1ffWh0JJuWELx0YEXC+4KHCan8p+Bvwu4KzM
        qZ74q9o3/tiPnibxZFLD7Ro=
X-Google-Smtp-Source: APXvYqxgdEm70Dg0Jj67gmXd7sCiy+G+edv5BSt8YdQsdmUaZu7futOJS18zhZ2ce+jzYP/Xuq8UfA==
X-Received: by 2002:a63:ef05:: with SMTP id u5mr6982354pgh.177.1552712375765;
        Fri, 15 Mar 2019 21:59:35 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j71sm7396801pfc.6.2019.03.15.21.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 21:59:34 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/4] PM / core: Introduce some helper for better Code reuse
Date:   Sat, 16 Mar 2019 00:59:24 -0400
Message-Id: <20190316045928.31934-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces some functions and macros that help reduce
code duplication.

Yangtao Li (4):
  PM / core: Introduce dpm_async_fn() helper
  PM / core: Introduce DEVICE_SUSPEND_FUNC() helper macro
  PM / core: Introduce ASYNC_RESUME_FUNC() helper macro
  PM / core: Introduce ASYNC_SUSPEND_FUNC() helper macro

 drivers/base/power/main.c | 182 ++++++++++++--------------------------
 1 file changed, 59 insertions(+), 123 deletions(-)

-- 
2.17.0

