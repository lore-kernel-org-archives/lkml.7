Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E8C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1086B208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557054036;
	bh=w/SHpRrllNxZj+LpY9Ds2dGsTQMBl30G2rqnKGez/T4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Er6ecZpXYZvSfanwB45fZO71aMhpBDGWm/2H/DaAie72AOzRTKJSr6rE2acwwd646
	 9t5bw62lPIRw8NRB6GkMKtEv/iIQnTlgXVPo/dkCz40eLZoah5jI9nlKMFIO18Era7
	 I7GGA45ww7cFCveqJz/o04DfGot4CudFfJnADPfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfEELAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 07:00:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35663 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEELAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:00:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so11731810wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z1uv87Hd85BJyOY38lyMunc2g2dXrwR3xUyDwlq8FSQ=;
        b=vBHqCx7zeF6tCDdWBlKWbfYmWgN3GQPo1pc+3953f8a6UN8QNkawsKKjmFQMeyfiw3
         VGP2nFMoDHg7K+FJGUEJwbUFnc2Asx7aWoRVb2p358AKTEKdLa+JcXFH9T3ofNbfi+JS
         3OHpvA207eyqDRFCNeJ0wPKRUY0KkzaIIJJ+5sBmAJMTw8FnCv+2w747NPOaQTqZEy/7
         7Ql9kh3T4X19iesnSm5mEvPN0dOoK8TFfgQszutfWYrDMKe7J83GBnv3sXQKKd+MTiV4
         v9aa+S+n58531Z3PF7Qn9BvIW/Gz1Fu7GnAw48N9ZW8oOGQ4SoRupH5yuiFcPV1o4BhM
         lGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Z1uv87Hd85BJyOY38lyMunc2g2dXrwR3xUyDwlq8FSQ=;
        b=HA8o8+jpNYd3gpsnhLNS1iChatHD3cuFMcZWjR/SHcs5zjSmt6tgjqo3JzBm6+mz5h
         mCDbCLZ0lfAqwyvBFBflcuPFgc8Dq0i2RPrZABRSqtt4b6LTQq9WcC1ErB1fjNSvAVT1
         vPfr7+IY5Mx9eYx7PqyTfqduiMkUYtkYy55bHyEUv5tJFZ7pZ0x2JYJAHvndB1xcxB9I
         hYWLwamBdGjhUT9BbYHtkaYP0PGRBLipaHdRUwVg0QPl5PbgbMamgME8POjVgYtEph02
         IfF6uKmhBolUUOklq5sc3/luqaTbEJf0ZuvVjRM0X7Evo83RblKofxWMdDItelBQ6fWs
         VKNg==
X-Gm-Message-State: APjAAAVz8DP3LePXhdFcSQEINzUrNOAqv7y6e4RgsvCFoMFUqkKvcP1f
        a0Xz7t4EpPH9/mabheHpeRtoN5L7
X-Google-Smtp-Source: APXvYqwrJd0hHqMStqxU+nEOCMZw7gI3A5Fw0njpSZOKS5cDTN9zIxkew3XKn2oob7aK7EoMsd8hhw==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr5479950wmm.2.1557054032630;
        Sun, 05 May 2019 04:00:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j131sm10986788wmb.9.2019.05.05.04.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 04:00:31 -0700 (PDT)
Date:   Sun, 5 May 2019 13:00:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20190505110029.GA87041@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: b51ce3744f115850166f3d6c292b9c8cb849ad4f x86/mm/mem_encrypt: Disable all instrumentation for early SME setup

Disable function tracing during early SME setup to fix a boot crash on 
SME-enabled kernels running distro kernels (some of which have function 
tracing enabled).

  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  lib/Makefile                       # b51ce3744f11: x86/mm/mem_encrypt: Disable 

 Thanks,

	Ingo

------------------>
Gary Hook (1):
      x86/mm/mem_encrypt: Disable all instrumentation for early SME setup


 arch/x86/lib/Makefile | 12 ++++++++++++
 lib/Makefile          | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 140e61843a07..3cb3af51ec89 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -6,6 +6,18 @@
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
 
+# Early boot use of cmdline; don't instrument it
+ifdef CONFIG_AMD_MEM_ENCRYPT
+KCOV_INSTRUMENT_cmdline.o := n
+KASAN_SANITIZE_cmdline.o  := n
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_cmdline.o = -pg
+endif
+
+CFLAGS_cmdline.o := $(call cc-option, -fno-stack-protector)
+endif
+
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables = GEN     $@
diff --git a/lib/Makefile b/lib/Makefile
index 3b08673e8881..18c2be516ab4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -17,6 +17,17 @@ KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 
+# Early boot use of cmdline, don't instrument it
+ifdef CONFIG_AMD_MEM_ENCRYPT
+KASAN_SANITIZE_string.o := n
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_string.o = -pg
+endif
+
+CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
+endif
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o int_sqrt.o extable.o \
