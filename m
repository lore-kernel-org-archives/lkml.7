Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E1C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 08:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC5C20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 08:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpsIv5sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfHDISo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 04:18:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55075 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfHDISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 04:18:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so71926649wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KpX1VoMswGff60EXJm7f4ppyOShHzSDUT2ehky/gEA0=;
        b=MpsIv5svLr8SiKGgefFxmgjXRYnFusqmN1Y7ZxrtUwAiSeB/9T0eWfiLWtpbJE0PpO
         uBb0tW7/e5BogbYLVpmmGPsPrmEHjWJYvK+8vxb7+nxqwiEzwFiTWZlXxddrqNGvgfvv
         70G618Upp3ayXSwA338jWB34KOjIgmb6NYcpc0JAvx43GAm9JpiaCBWP0vn4C7oozTPA
         vsyGsoB8QoZfr8EyCmn5T2Mpvr+4/jH+VWmc7oGwVJ7OcngjPdH0Vsn8inCvG9h4TGxM
         YbMKKNBShGiuHwCYwV9JPSpXghzdIqtbOT0dXOc0hDh7fei3FPQwFty9w6NIyu3HPCZ7
         CWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KpX1VoMswGff60EXJm7f4ppyOShHzSDUT2ehky/gEA0=;
        b=ALSzZzA8lBN+S1pzHSvTCCgiFbZbvd3YOSUAAlStqMw6deu33CiL6wfoHW8YG+cO7X
         wCB/fy7aWPvpEDT+J1XeIVl2Rxz3X3fkQtCTfXSHXf/6VzGCBIvRDRNgB9fevKVAwUcO
         w7dbs1lgR7jPFsoaN7eDmqH+q5xZrMVpywG2pP45nCCmlAog+kk0Uvube4/cqTyXw1qM
         BdGEbKizFyM7iZXleDgOifs2484R5AUDCq1Tzhh33jvuGj4hrqFyNGouuDdHBcV3wI8B
         jErZE9Mx1ID9nxy1rrB9nTYPTadv108cWjb6QP5gviBzArKxqh1U7SktGSkQ7lZd+Rqs
         COBg==
X-Gm-Message-State: APjAAAXpJdQG27iUCf0bTzKPSLq0wNnTd26K63x/RWycqv0VCSF7gfgA
        a6uVMcJ1jfiJq3XkgS0mRMpVfAvR
X-Google-Smtp-Source: APXvYqyGYN7LWGn5rNdmj8fXVsLdEWRfqaQENgL451ZVqP2RfCkBEI7lwsuliRBIGcFYhm6w8CxahQ==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr12971070wmj.44.1564906722337;
        Sun, 04 Aug 2019 01:18:42 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f28:9900:d80f:58c5:990d:c59b? (p200300EA8F289900D80F58C5990DC59B.dip0.t-ipconnect.de. [2003:ea:8f28:9900:d80f:58c5:990d:c59b])
        by smtp.googlemail.com with ESMTPSA id r123sm79910521wme.7.2019.08.04.01.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 01:18:41 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] x86/irq: slightly improve handle_irq
Message-ID: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Date:   Sun, 4 Aug 2019 10:18:35 +0200
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

Heiner Kallweit (3):
  x86/irq: improve definition of VECTOR_SHUTDOWN et al
  x86/irq: factor out IS_ERR_OR_NULL check from platfom-specific
    handle_irq
  x86/irq: slightly improve do_IRQ

 arch/x86/include/asm/hw_irq.h | 4 ++--
 arch/x86/include/asm/irq.h    | 2 +-
 arch/x86/kernel/irq.c         | 7 ++++---
 arch/x86/kernel/irq_32.c      | 7 +------
 arch/x86/kernel/irq_64.c      | 6 +-----
 5 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.22.0

