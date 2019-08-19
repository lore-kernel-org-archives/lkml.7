Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78325C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BED422CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k65Eqeed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfHSTeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:34:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37600 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfHSTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:34:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so9906694wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UbTeYLNvE6MF9HBkLC87bPvKENg/S5WsXk7SvGnVm1s=;
        b=k65EqeedureUenJxZAcfhD7kW25D6sZTNwr5M5uuQ0rtGlS8UCPX8txs/VLhKiYksB
         9c15dnqi5VdiUmjgDsgIsaK11h0qQCXFIYDyGnfILUSF3o+25MgATRE3BSNNyDYsjGA1
         c3t/BSOWLAWd1/M4bmssf1MrnlIRdE2zwqImiumvxA0dJvRoIGtDnL6jR2K7BI1idVqn
         KaunjuQJU6I+dw9K+dtSQKu9grzFfP9VJfQP3unG+o82ABX0Yb08TBTT94Jiyzu2EPji
         fN7sA8tn4OLEsBvzKpClA/IDXJ9jdXcTflzEAAWAj0tTp0KBn2/RVCLzCTrgIxcFYs70
         67Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UbTeYLNvE6MF9HBkLC87bPvKENg/S5WsXk7SvGnVm1s=;
        b=qwCiLriPWZoUYkYeLqRENWlymkOgnEriEU4GJAJm8EFXGXeLk+e/SeuHK3C4R21Iue
         iAzoUbA1JQ0SYifY1ZXJslOG08BblsIjp8TzcKvXNFuJMhU3q9pon5/D81mBA3ykEwlr
         ghKOzJ+aDZ6VT+PVPlLAyCj/VhOBMLm//gTnMNwJNQEjatF64PjmZd/tgNt9Sn4T2D5A
         CZCMzPvKJMAK3pBDfg/XNlJg/Qj9+j/XEAV1/hicvCbmqgFgRdthxM79owqxjpC7IqcH
         A15DvQs2rAjNAdrKcfw6SuguJYSJNjWG2cjoRQ5uSjRINdvUuLFDwinhHbtx6SyIqjVX
         JBXg==
X-Gm-Message-State: APjAAAVgfNlLNR3Z/Goo5pwmJJrdAhwq+P5lpQJQWVD7LLduWOwaK8Ts
        qIVMs5tvB9CWX5l11EvcJrd0bnFq
X-Google-Smtp-Source: APXvYqxnVNyCzGYR9XNUWZ83n3OQKW8FKEDaN68NKsSAW07OFi0k5eOz+RjWMC9wXEJd5h6UoDcr0w==
X-Received: by 2002:adf:82cd:: with SMTP id 71mr25217801wrc.265.1566243244689;
        Mon, 19 Aug 2019 12:34:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f47:db00:69f9:84c:2cc6:baef? (p200300EA8F47DB0069F9084C2CC6BAEF.dip0.t-ipconnect.de. [2003:ea:8f47:db00:69f9:84c:2cc6:baef])
        by smtp.googlemail.com with ESMTPSA id f24sm11311303wmc.25.2019.08.19.12.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:34:04 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/3] x86/irq: slightly improve handle_irq
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Date:   Mon, 19 Aug 2019 21:33:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking something else I stumbled across this code.
This patch set simplifies it a little bit.

v2:
- patch 2: add "likely" to if clause and reorder it
- patch 2: For 64bit, remove handle_irq and inline call to generic_handle_irq_desc

Heiner Kallweit (3):
  x86/irq: improve definition of VECTOR_SHUTDOWN et al
  x86/irq: factor out IS_ERR_OR_NULL check from platform-specific
    handle_irq
  x86/irq: slightly improve do_IRQ

 arch/x86/include/asm/hw_irq.h |  4 ++--
 arch/x86/include/asm/irq.h    |  2 +-
 arch/x86/kernel/irq.c         | 11 ++++++++---
 arch/x86/kernel/irq_32.c      |  7 +------
 arch/x86/kernel/irq_64.c      |  9 ---------
 5 files changed, 12 insertions(+), 21 deletions(-)

-- 
2.22.1

