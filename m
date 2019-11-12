Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F389E2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573546562;
	bh=J/OThn6iLck1PKQEzgYOrdrJIO3+vZLAM21GL3dDj7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jMuZfhhvlJDQTGve97D9KXDs2mYyqlpJ1egMQo2NrElflMYUmt8h7xyCtAeoITjGw
	 YAjHqYF0rYt9/2oSisYo2MVWo/p2eofKpFCM1qJ4QCiDTwosQ69ol7KjHwNYhVn9AQ
	 /1XhEdQZiHU40lgJroBrSDWkUH9rdCNMQvvwlZhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKLIQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:16:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36824 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:16:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id d13so13703604qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iSiNV5scpDBuaeOgWdkNzYJXOXgt273IMaBQBvWkFxg=;
        b=ubFk442k6Qo+4DCHOghiwUojCKSiwtYqodWzLLYmlxFwYP00iJKgZ1PotFrZBQSXmN
         nvbp0ZZxZ+j7wtmCsM1LxKZAL4akAwAOS09yvfgsK8wcyszclv8b61aeuQSSAePxkmbX
         B+OgEDhi8GtlORT057O8I4FL4QiUoI3ggyrQ+Slok6FVWwR+k0yUhZ67fLRkGKzxtc1Y
         cUntcvc6r9ilypwEkEnDXQI1IEjeiVJY6iuyFohkZhLa70ravNQVzqUkdoKLFBWV2AkB
         /K88503KPwwokzbzT8/T6KRZvSs/krVVeK5fqfegNPhokXSDVMNnicGVB+6sLFQDktUV
         V9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSiNV5scpDBuaeOgWdkNzYJXOXgt273IMaBQBvWkFxg=;
        b=Tg2W+22PRVp/Rdc2Mw/bLI74vwFLMSfbdXGjqA28kuDZl10hWG4o3nXRm/Cw8aoT9C
         8ENh9MHVEwVC/MFupC86GNYYmUFcw8hFjl4AdZy+Doe8Tfxh50Qg0wW1w54hNuTYnyg1
         ql1/6Xv7BOCrWX3YCDermPlpb7kPDrXwlDqPIEEdL5Lbw+Mh0Tq4FTtMHgOtWhBSh/zT
         x+qH18uXPRX+ySIZb/EE+IztuFqfmST1M/zQVqSrOdz2CSHKXVKcYHpRyMdVYhtKrGRr
         Y7ngW4ZuE0rSohc+yudtMpTiSc/r/tkFIWOgHGEonDUVAqUIOgygnT5oglRPoQGw2Sbc
         CdJA==
X-Gm-Message-State: APjAAAXreCpaEeAGCsaZq8ZLQFVh16ElvISQv7LsoKWUD/M9+uayT3UT
        kttPOsvV//D7JHFUdnW1EO31kujW
X-Google-Smtp-Source: APXvYqz+MCuPdzMn3Gq6vuN/M97IR0ATc7nfvv3FhRs70RzJyGGIOlNP9KbdksudvWScx5mCeegApg==
X-Received: by 2002:a05:620a:9dc:: with SMTP id y28mr14426574qky.297.1573546559542;
        Tue, 12 Nov 2019 00:15:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 130sm8711498qkd.33.2019.11.12.00.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 00:15:59 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:15:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/iopl: Rename <asm/iobitmap.h> to <asm/io_bitmap.h>
Message-ID: <20191112081555.GH100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
 <20191112074052.GD100264@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112074052.GD100264@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rename <asm/iobitmap.h> to <asm/io_bitmap.h>, because IMHO the header 
that defines 'struct io_bitmap' should be called io_bitmap.h. :-)

Build tested.

Thanks,

	Ingo

---
 arch/x86/entry/common.c                          | 2 +-
 arch/x86/include/asm/{iobitmap.h => io_bitmap.h} | 0
 arch/x86/kernel/ioport.c                         | 2 +-
 arch/x86/kernel/process.c                        | 2 +-
 arch/x86/kernel/ptrace.c                         | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 85e8a8d7b380..9747876980b5 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -33,7 +33,7 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 #include <asm/nospec-branch.h>
-#include <asm/iobitmap.h>
+#include <asm/io_bitmap.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
diff --git a/arch/x86/include/asm/iobitmap.h b/arch/x86/include/asm/io_bitmap.h
similarity index 100%
rename from arch/x86/include/asm/iobitmap.h
rename to arch/x86/include/asm/io_bitmap.h
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 203f82383bf6..d1a3a9f5314b 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -11,7 +11,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-#include <asm/iobitmap.h>
+#include <asm/io_bitmap.h>
 #include <asm/desc.h>
 
 static atomic64_t io_bitmap_sequence;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ecf97855ed68..7bf60741e80a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -41,7 +41,7 @@
 #include <asm/desc.h>
 #include <asm/prctl.h>
 #include <asm/spec-ctrl.h>
-#include <asm/iobitmap.h>
+#include <asm/io_bitmap.h>
 #include <asm/proto.h>
 
 #include "process.h"
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index f27c322f1c93..72bf005c8208 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -42,7 +42,7 @@
 #include <asm/traps.h>
 #include <asm/syscall.h>
 #include <asm/fsgsbase.h>
-#include <asm/iobitmap.h>
+#include <asm/io_bitmap.h>
 
 #include "tls.h"
 

