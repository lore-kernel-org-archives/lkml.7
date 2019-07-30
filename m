Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BD1C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB32087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRkCSNBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfG3KuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:50:09 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:33590 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbfG3KuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:50:09 -0400
Received: by mail-lf1-f41.google.com with SMTP id x3so44470119lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=F31cQ0ne3p3xFuaSlxROjZYeTvKp+9tCo1IZnDyB5kc=;
        b=HRkCSNByu31f39s+lOU22nTucb6QbcbWxwwj2ZbJu2tlOmUkF6O1+iJIl6/diz7cjg
         VJ144Pqm1gbPTn1+ZPtAKLEjE7uhacH6kI7XZaj5nsEooGsiyEsFUT2qdQqLNRMurpZA
         NGSIC3XDmnQdAJOWMInyzabVKWoeGcS/K3+4nJ7RcucAwhGOpxPVD2pZfD4+1slua4f4
         ZwN9ay3V3Jgh6yIYHl+k6FMe66BVMzDCRsvS7wpUqsXSaswZbsSls5E28EfPSZEO6wcN
         LfzadRc9jB/AVts4r+OUvrgBhohfoKa+tsEuimsamKkhxylbovNJwMwJmdclpDIuTMj0
         lMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F31cQ0ne3p3xFuaSlxROjZYeTvKp+9tCo1IZnDyB5kc=;
        b=XOrdzzSRie6kl9EhKM/3qst4r5q6dQcjsCmTNpP5+wEP2Hylp7rpKMKin6hbW3jghb
         koelaazqFHgPz/159ErYceuLRUAcaIVLNDQqqOaunZzbrU+9WkZctmSs0hHcOMKxzEEL
         jWN7K6qEscTxmKp7Fo8OI7OmOGxl1JRXH9tTZDlK3X61N+ayuv49PBvuNG9uMW67C/V6
         FSqfL1Xg0CUBzMfksm7dDS4C3hn+neLtpS2UKabDyiP0cdXDHTcl8qUw0vwSYkDFLRlE
         AMtwF2efDtPZLHsNkUPhQ4onzeZ+1GT1/Mg52BvSrlkCJFLRXDYZ93HjU9RtHp5EcjCX
         GGyw==
X-Gm-Message-State: APjAAAUKo5JgOYokWRH55afzjXvFtv0lX3CfBKjcH0j58VUkWMhyaGVJ
        owniGIpdB74vDrdLCU449BmsDABwfGyXFcbzmYrfOA==
X-Google-Smtp-Source: APXvYqy3j01W1DiK77paO5P6wAyETN2Q1v+EqaF8qkc9KhP+lBvg1oeHOI1YhDj6KVh1ScwmIbAm5j/jergMRP5DZrE=
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr246679lfy.191.1564483806778;
 Tue, 30 Jul 2019 03:50:06 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jul 2019 16:19:55 +0530
Message-ID: <CA+G9fYtWFhak1_N1sAJk=HGo+yzYvrU9DDfZRV_3a8C9JUMT0Q@mail.gmail.com>
Subject: linux-next 20190730: undefined reference to `gpiod_get_from_of_node'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today's linux next 20190730 build broken for x86_64 and i386.

drivers/gpio/gpiolib-devres.o: In function `devm_gpiod_get_from_of_node':
gpiolib-devres.c:(.text+0x203): undefined reference to `gpiod_get_from_of_node'
Makefile:1063: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1

Full build log link,
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/574/consoleText

Best regards
Naresh Kamboju
