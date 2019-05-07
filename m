Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA20204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvsODzdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEGIww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:52:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45695 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfEGIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:52:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so8286019pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LjOe8/uSrsnXxo1KWPfGN+bA2qnQR072UhLWqeHFo/g=;
        b=AvsODzdnuZGckkM+VoJpXhs7l0fgBRnBAAu4od2gacCID0tceKuyA+euLUfaQN3Ten
         f/gU2V8ZtAQniIRK3YBQJ28pXR+UnX8Kp6SyVEUFxqEXG15Vn47vA0xDms7+jGYxCenz
         uG/KuMw3lMwmk8O88PXI7a2zSCjFrPAbbTAgBaVgh2+phHv9agBkyKFuc696R6O2XnWO
         IU6Jztrg5HOfSySh25QCDjuqCzOW/0zeEPHgyZLwoKY5WL0iwiD/D3j/f1O8ppAEQLLB
         2zS8SYQBP5S4/rg6tBloQkcavDeI6lIIHzeaEDuS6y7iDmkwDog0nL1ykxlyV2BB/CXc
         +s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LjOe8/uSrsnXxo1KWPfGN+bA2qnQR072UhLWqeHFo/g=;
        b=bdJVvaqChuATaH9gl2aWRMjLHYmVP15DSs+BSOwrIybfdj1TBjlRSlmwEY01uJ7J3K
         7cYJveEmk1YqC3S7w9D2PzGjsjhoGGf0eKmYPhYJzlYhAJxyxTMYpaym2Sfr4O5ADT6e
         MKLLY+2xTONbv+1yzXc0ES8Urx0ttAQgp9hbwBHyqL2/7e3EuErwnVcZT1xbxAVT/SYJ
         gYfUlSxzaOSwDVF7vw0iFAWkbJVEjbMWxPhswcAGXXrSuX34uaC2bnsc4kxogPwGM0Qu
         o3SUTIWe4fnuPlcD0EPIh/SkEIE7Kv/iQYYizbZ2d9LTBiaAqs3WVzvSbVUrcsmzQ54V
         oVBg==
X-Gm-Message-State: APjAAAWM0pje9nTd3fN4GWqd0VP5ZiTnyUWSrJebqGjWa/olYq2ojegG
        M5MebBCR42xgQuhaHTDuKkge6qA=
X-Google-Smtp-Source: APXvYqxykF9oIbNCZfJdHCAdqFuOxXtRWCSKK3ahwl2KuSkkiyFlDyWifddJDyiSkuSMS6Yl8Z3Qpg==
X-Received: by 2002:a63:1316:: with SMTP id i22mr15305960pgl.274.1557219171115;
        Tue, 07 May 2019 01:52:51 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h127sm16502548pgc.31.2019.05.07.01.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 01:52:50 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Wei Huang <wei@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/boot: support to handle exception in early boot
Date:   Tue,  7 May 2019 16:52:29 +0800
Message-Id: <1557219151-32212-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot code becomes a little complicated, and hits some bugs, e.g.
Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.

There is few hint when bug happens. Catching the exception and printing
message can give a immediate help, instead of adding more debug_putstr() to
narraw down the problem.

Although no functional dependency, but in order to show message, the early
console should be ready. I have sent a separate series:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1992923.html
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1992919.html

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Wei Huang <wei@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org

Pingfan Liu (2):
  x86/idt: split out idt routines
  x86/boot: set up idt for very early boot stage

 arch/x86/boot/compressed/head_64.S | 11 +++++++
 arch/x86/boot/compressed/misc.c    | 61 ++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idt.h         | 64 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/idt.c              | 58 +---------------------------------
 4 files changed, 137 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/include/asm/idt.h

-- 
2.7.4

