Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C93C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF57204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LjiH2Aic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfFYMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:16:07 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:40949 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfFYMQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:16:07 -0400
Received: by mail-qk1-f177.google.com with SMTP id c70so12345297qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=Jo5ZxbVSIdMopp53XA/lWdARqu1Vh5aO08tEM8lSAB8=;
        b=LjiH2Aick5W1S4iX94IADv/8ufjngFU9SFx5pPZBTdlYAgz3IaLZyyQeSySCmi7D6L
         fBewD81X8OLiO72k7nK37Dr3+KDLT59keFgdwZ1mAvzTtmF4f5W/5Atw2fhBp0HATKBV
         Hee48t8z5OQ1g+x0KQzKSp4AwQsQiTp3n4Xka8baYKA48t0gcHBhNB+wvmLF+1XMeLo8
         DNT9x97d9WjttYql91ZVtuXPfUClWnxTOMgTN1aaPevoao4Eyufm7PFS0pGV6NzuH4Zv
         psinx69lSDpo3IgJ4LbZ9T6bQcszpGB6f2X5/IK+KtSfMYRAxjvb/v7wPTADzCVZIlov
         cLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=Jo5ZxbVSIdMopp53XA/lWdARqu1Vh5aO08tEM8lSAB8=;
        b=S86rNFjf/Bg5eKLDey0jf1/LcH8hHfPdyGl33onvV+s13bGIX1LYbcBDG8IO42YjXd
         O+U4m236629NW7Gqx33V+INofybuL+80P9ECrGufLgMoY+DF1EEwimIYPpr49G1QvyZy
         KKgHQlqdUoRQ7thJNOB3yag1Gy7NiNTVYvXNYQdA2wyhaPsDUrlkENpbFO4CC253iS0j
         4HrILyKtBvyThlRpLdIh/UCixfHMFZnfJNWXy0YSg9nBisT/LkJPt3/qI5prwUSvv07G
         KwXh3vMidyurZydYgc6mcPkfCcoRECnoh8R6/Wb9iHuD+pEyCUFkccGVGFmiGy6dQMXb
         8fsg==
X-Gm-Message-State: APjAAAXAihMtSjLqwImYFAZol/d0VfWoQ1wCLswC2ybW8vSmaSAl8fbX
        GLd52g2KhAr5Z9UJtfNzZSuKag==
X-Google-Smtp-Source: APXvYqwMrlhcyFatGCBkoDD6VKM1BCFRs76z953BDEboVbbhRtdY/MlybjpRLQJs/+vq5eIMwFiuLA==
X-Received: by 2002:a37:4a04:: with SMTP id x4mr22458625qka.408.1561464965994;
        Tue, 25 Jun 2019 05:16:05 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s127sm6765096qkd.107.2019.06.25.05.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 05:16:05 -0700 (PDT)
Message-ID: <1561464964.5154.63.camel@lca.pw>
Subject: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
From:   Qian Cai <cai@lca.pw>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Jun 2019 08:16:04 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "arm64: vdso: Substitute gettimeofday() with C
implementation" [1] breaks clang build.

error: invalid value 'tiny' in '-mcode-model tiny'
make[1]: *** [scripts/Makefile.build:279:
arch/arm64/kernel/vdso/vgettimeofday.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2

[1] https://patchwork.kernel.org/patch/11009663/
