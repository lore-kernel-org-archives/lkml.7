Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A173C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F6A243D7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTCRRX0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfE3BFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:05:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45335 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfE3BFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:05:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id x7so819483plr.12;
        Wed, 29 May 2019 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pyl/L4lftqre86x4sDXFC//cXdVYSHdszkBDIq0F9kA=;
        b=GTCRRX0FPev8NT+YGJsHGcCdJCxG92nkcB8v64iqMk23Rjub8TZ98noOEp9km4gkGo
         uuf3oW7XL5QFgCpU531dAHkFlDOhFqNf6uyTY/wFPbLVyX+BoNZV98xnQ3oARRBdLgxO
         DrneOgK9Ld1Nsvma+2iTIDqo8cn7onzbJUYHy9XbL/6mN9u0z4n069XW/NMqp+rLNwr2
         b21QtQPGxN9KswIMpKnidvm+Itg2ATLUeteHrgu3NVqJhDyS6CKD31kfzXbmf4oj6Sf+
         QHaTnU5LaVEZhqIjQEnr9vHQGdvbGYIPrcSf0SEPqv/L6fR26G/wCgzXp7TS3HxkfTVG
         mA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pyl/L4lftqre86x4sDXFC//cXdVYSHdszkBDIq0F9kA=;
        b=GSBZY5KMm4AHbkM2s/xFmD2KfgIUq+weIabNafW26CnfCPFAZ7rAlsPZI9mS/Hkcha
         npj0QpH5MhAwGcg1ch9Yjz/bGKo0kJAYpj68bzvMlchGEQK5ssYWrlylqLuJ4TCF+Tx1
         kZFosP1AXyaqoFZNtSEdSxMy40Yd5Le6EEWK35mpFe5uwsLUQlvVHV7pHpJL8h7EgoI3
         I1DwPN7w0kwTdtxWWQVEDC9l6LjLcnU8Su0ZKjB7cUs3oPfddp0hjmSy5zrQGQ5TkMdS
         uWNZ1IB9kqYNNT5BxZHHZL4mUyV4HWEWbCdPVevnd0yI7c6pCu8UW2lnsXcUknpery6I
         NNoQ==
X-Gm-Message-State: APjAAAXyKQsmFmhHUnKnz7MDE1U10dBk4qO6XXRV4gOQWKGEphj0Rz2g
        OJvgezFXFYaoQaKj5Yy16b/BG3ZR
X-Google-Smtp-Source: APXvYqxkxvXL66NaVgVxd4ZMCG5XUs4T06D1NIsaC6C41tKJWj7CHQ0CoEFgnNnaykwmwlGCS4evUg==
X-Received: by 2002:a17:902:15c5:: with SMTP id a5mr974456plh.39.1559178318967;
        Wed, 29 May 2019 18:05:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id c76sm861965pfc.43.2019.05.29.18.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 18:05:18 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 0/3] KVM: Yield to IPI target if necessary
Date:   Thu, 30 May 2019 09:05:04 +0800
Message-Id: <1559178307-6835-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is from Xen, when sending a call-function IPI-many to vCPUs, 
yield if any of the IPI target vCPUs was preempted. 17% performance 
increasement of ebizzy benchmark can be observed in an over-subscribe 
environment. (w/ kvm-pv-tlb disabled, testing TLB flush call-function 
IPI-many since call-function is not easy to be trigged by userspace 
workload).

v2 -> v3:
 * add bounds-check on dest_id

v1 -> v2:
 * check map is not NULL
 * check map->phys_map[dest_id] is not NULL
 * make kvm_sched_yield static
 * change dest_id to unsinged long

Wanpeng Li (3):
  KVM: X86: Yield to IPI target if necessary
  KVM: X86: Implement PV sched yield hypercall
  KVM: X86: Expose PV_SCHED_YIELD CPUID feature bit to guest

 Documentation/virtual/kvm/cpuid.txt      |  4 ++++
 Documentation/virtual/kvm/hypercalls.txt | 11 +++++++++++
 arch/x86/include/uapi/asm/kvm_para.h     |  1 +
 arch/x86/kernel/kvm.c                    | 21 +++++++++++++++++++++
 arch/x86/kvm/cpuid.c                     |  3 ++-
 arch/x86/kvm/x86.c                       | 26 ++++++++++++++++++++++++++
 include/uapi/linux/kvm_para.h            |  1 +
 7 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.7.4

