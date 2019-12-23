Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA14C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE544206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ze9JlQ/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfLWIqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:46:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45550 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfLWIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:46:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so8824141pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiv0iJZzGCkc28ztTp8qOF1V1VWNsfhmC5dV3q1Te6c=;
        b=Ze9JlQ/RyzgyMQOPYRGDFwiIEUBmtJcvRBWoEFPZyXwyP7w7fAHadXoJcLjkm8bhUH
         IIk2X8PQ7fl6hpIc8t9Ji2KXMLQSL6bk0hf5Y2h4L+rC+6rlV2RCUelriUAnLoeag8ic
         XXiEg5dUjLdXq0p6Ro0qqig87W8ig71VBwvTJw0wbGjuAcpsuKTvN4wfUIq0C8Z+2tlS
         UQYPyZNA8b+zw6b7QEl7wrOrtJ7WGXgYG1j/sfzOCJ74dw/5w/Lxwul2Qqbu2zz5pAbY
         vRalr8LpOy43j67GCFlH6/fjn/ok/YZnurf+kQONegSAUDvJK6ZvMootjqB6zO53q0ZU
         87TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiv0iJZzGCkc28ztTp8qOF1V1VWNsfhmC5dV3q1Te6c=;
        b=gdKagMWFKjS5QnQK6COkGEP6I8hGX9S3Z3SaWhauEjI7aXI+7UHgtLXzLOAMdhZxn8
         8H8BKawZ1h2/ALoyDe5Yvr2lhs5XY8jmDZmmoi2uEHnoOyuOii5gwgB9hX9ERyxV/9dS
         psQomlHzTpBG349+NMC2hujXbTAtBaCAN+ojzO+tOuL3/Qae/UcgOazrxHsvEvoiviUS
         OnzPHF2y8JTl8eUO3EjqBPOPVDDeXrXiXm7RvN7cTLkXwS4Eop8DM4vV42yDi30fHhEw
         sb/vJc7vjola71/aqav/0jUbo41KYk0OE4ak8XhiDIop1XHFppNGAuImfwAhwxNI5XCV
         A/uQ==
X-Gm-Message-State: APjAAAVVCvtudsxPEVyeLGOnDaDug21i18hdtEdJTe2e7D45rzeCcFCX
        K/Rp5oENopt81BY+eOOAN+ViDGaQkvM=
X-Google-Smtp-Source: APXvYqwtYQRnD1PE+F0K9hRtH2R1S/5XtTDwUPlezFEYsg0OKGW/HTWm3vfnSZtJ+uraXjbJB/FKPw==
X-Received: by 2002:a63:6507:: with SMTP id z7mr30920986pgb.322.1577090795638;
        Mon, 23 Dec 2019 00:46:35 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id m71sm22000516pje.0.2019.12.23.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 00:46:35 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, rostedt@goodmis.org,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] RISC-V: fixes issues of ftrace graph tracer
Date:   Mon, 23 Dec 2019 16:46:12 +0800
Message-Id: <20191223084614.67126-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace graph tracer is broken now, these patches fix the problem of ftrace graph
tracer and tested on QEMU and HiFive Unleashed board.

Zong Li (2):
  riscv: ftrace: correct the condition logic in function graph tracer
  clocksource/drivers/riscv: add notrace to riscv_sched_clock

 arch/riscv/kernel/ftrace.c        | 2 +-
 drivers/clocksource/timer-riscv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.24.1

