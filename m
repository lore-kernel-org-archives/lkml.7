Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46B620C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cnnrX+qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfG2WBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39684 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbfG2V6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so44435998wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OW8GU+t0fVJSjUItOBj5d09rAdyjVelz1gsjEuXxZec=;
        b=cnnrX+qQPbDjALwPI2qY855GbxStpPeJEe4VSbOhOsWfQuUQnzCWREC6/j9snCQmKa
         RROusgDqPPUGhhKbvW5F8lFniaBh5s+zwA/qveINFjliT+xfLuXpI4I0xps2YbGGeHAL
         +IYMZFC7rDJmKxcMOidg5CurG+/VtroXnxhkbsje4890o4QD4ab4zX+kb28GIvnFw4et
         vflBBeqa9FFfdFH8F/fTo4HUxFWF77VZRnFDxhBpNIf59eGi9I7N/cog2/sDEZDfyKWa
         W+N9z1BsMA19ifqP9qgIHuYsSbZ/zBoBoS51YF9Fa4OzgMcUyAceyEvW0cXdj7GkdeXW
         Rqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OW8GU+t0fVJSjUItOBj5d09rAdyjVelz1gsjEuXxZec=;
        b=C8MuTQ2fl4RBxqo4tToRktFGj66Q2sQzq4b/lemtgnIWkboyYwTRblC8HIPeLnnRIl
         ehsmArSVsPke7aR0slyVObEzMynkc0AE5ge1D7jdVXgyxYDfM53mM/xMrarzpRul89lt
         5jeleLU+bKyCkUKrALKM6zUprX0cpILSk3sWH8xCHwHvRncgmv2EhQeSVaS1ba2Wbjiq
         sBGPIgtXuPezMXaL5L/dn3jaYZp24e+ykNEOd3qyYyTsXGtXxBwK+2WhqCS1EDe7tYKg
         gldCrMBR14sgEO7YTMbP2Xoi2eXn4Q/ZZruRjc2gHkAfuKBXnIm2qEzpdxSXtB3kBE41
         jOtg==
X-Gm-Message-State: APjAAAVxqVB5PHUrNXio7upplqDAWylKpCCTWYzjDbim2YXbg9fGaKsS
        CceFnIdwmnmmcSl7+3Cp/7LpKATDEc1P7PFC/rqgobbubd9v3WmHrpAPW/gUs2dZvWkhtJx2xuV
        jEwbyhVudd5/JJeVEUctMKdfWzSkaW7tjUuKvpfk8jknUKXyqECOg4gHyix9quMrqkSyZQlgLpT
        bnEBtf3xXF8/rYR18tkLZu8s3UtV69/QZAtklX2lE=
X-Google-Smtp-Source: APXvYqyczyvBs3sJHc3Xzg6CfJWOstD//re4woLcTGWNV6okiSkW8WG8Kt7KZT7qqzD3u1HHO47bNQ==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr27134664wmj.143.1564437516291;
        Mon, 29 Jul 2019 14:58:36 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:35 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 26/37] vdso: Introduce vdso_static_branch_unlikely()
Date:   Mon, 29 Jul 2019 22:57:08 +0100
Message-Id: <20190729215758.28405-27-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Introduce vdso_static_branch_unlikely(), which is similar to
static_branch_unlikely(); alias it with timens_static_branch_unlikely()
under CONFIG_TIME_NS.

The timens code in vdso will look like this:

   if (timens_static_branch_unlikely()) {
	   clk_to_ns(clk, ts);
   }

The version of vdso which is compiled from sources will never execute
clk_to_ns(). And then we can patch the 'no-op' in the straight-line
codepath with a 'jump' instruction to the out-of-line true branch and
get the timens version of the vdso library.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/include/asm/jump_label.h | 14 ++++++++++++++
 lib/vdso/gettimeofday.c           | 10 ++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 06c3cc22a058..376efb53183b 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -53,6 +53,20 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
+static __always_inline bool vdso_static_branch_unlikely(void)
+{
+	asm_volatile_goto("1:\n\t"
+		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 "2: .word 1b - 2b, %l[l_yes] - 2b\n\t"
+		 ".popsection\n\t"
+		 : :  :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 7525433f8ba4..605bdb92055d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/hrtimer_defs.h>
 #include <linux/timens_offsets.h>
+#include <linux/jump_label.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
@@ -43,6 +44,8 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 extern u8 timens_page
 	__attribute__((visibility("hidden")));
 
+#define timens_static_branch_unlikely vdso_static_branch_unlikely
+
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts)
 {
 	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
@@ -79,6 +82,7 @@ notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_tim
 }
 #else
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts) {}
+notrace static __always_inline bool timens_static_branch_unlikely(void) { return false; }
 #endif
 
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
@@ -108,7 +112,8 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	clk_to_ns(clk, ts);
+	if (timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 
 	return 0;
 }
@@ -125,7 +130,8 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
-	clk_to_ns(clk, ts);
+	if (timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 }
 
 static __maybe_unused int
-- 
2.22.0

