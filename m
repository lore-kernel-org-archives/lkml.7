Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18966C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3CD20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFGCjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 22:39:37 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36090 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbfFGCjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 22:39:36 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x572dZjf004420
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 22:39:35 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x572dTsn003272
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 22:39:34 -0400
Received: by mail-qk1-f199.google.com with SMTP id q17so378525qkc.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 19:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=MIgX3bW8bMehQLcxyRePAGOb6AOeg7AcYjxnuIEF0bs=;
        b=LSzlW2rg9MeVPnAfJoe6rfyS7aCuwTU9DtEATQ/TMTsTwW6sZtjJ/RwK5R49ywEwkA
         WasJqLP88XqrVkJ51OnsCJztz16YcrUnyHJiWn/OqyeEiqofhNeS7xZ9imYX+Bzu+mnD
         xRyxM+n5JiCBAN78I3kYX3xM6FSz3fla1GOw9XQdTiim0gCByPioxpVCal+sCCoX6O5g
         9f+M7XdLH3vS8AtZHiPCDRqCd95k1LDctzpdXBVEyDMDxq5eU8qF6zZDgA36DcmFasSJ
         hbCVYfSoSCKKX20nb/ZI+53yzYv1sBdX3U+ijzbloogNW5zU4y3mxuanIOA4Aa4KEwPA
         Hb9g==
X-Gm-Message-State: APjAAAVhpJcWqkbtr7KXDXogWC4yML7OST4lqSzJcil/SOhMRZyYAlc0
        Fr61a/h68ZJ0EyIo4gTlET3Wm9GsdXaqHlgVHUn2u4nX6Ne95r5t3TFr4uQbAwFkn7dBELTmT2c
        sGtUIV/FPLhT3C1mL1byTYywfeD21IbGQ3wY=
X-Received: by 2002:a0c:9305:: with SMTP id d5mr26392264qvd.83.1559875169631;
        Thu, 06 Jun 2019 19:39:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWt5rtISN5eq/35zw3oL3ccJvCnXG3axMY3hRZkTPYNYF6J0BYXWGfZsmKjzD+XmnQ6xV89g==
X-Received: by 2002:a0c:9305:: with SMTP id d5mr26392255qvd.83.1559875169441;
        Thu, 06 Jun 2019 19:39:29 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id c7sm350432qth.53.2019.06.06.19.39.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 19:39:28 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf/core.c - silence warning messages
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 06 Jun 2019 22:39:27 -0400
Message-ID: <29466.1559875167@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling kernel/bpf/core.c with W=1 causes a flood of warnings:

kernel/bpf/core.c:1198:65: warning: initialized field overwritten [-Woverride-init]
 1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
      |                                                                 ^~~~
kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
 1087 |  INSN_3(ALU, ADD,  X),   \
      |  ^~~~~~
kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
 1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
      |   ^~~~~~~~~~~~
kernel/bpf/core.c:1198:65: note: (near initialization for 'public_insntable[12]')
 1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
      |                                                                 ^~~~
kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
 1087 |  INSN_3(ALU, ADD,  X),   \
      |  ^~~~~~
kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
 1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
      |   ^~~~~~~~~~~~

98 copies of the above.

The attached patch silences the warnings, because we *know* we're overwriting
the default initializer. That leaves bpf/core.c with only 6 other warnings,
which become more visible in comparison.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4c2fa3ac56f6..2606665f2cb5 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_CGROUP_BPF) += cgroup.o
 ifeq ($(CONFIG_INET),y)
 obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
+CFLAGS_core.o          += $(call cc-disable-warning, override-init)


