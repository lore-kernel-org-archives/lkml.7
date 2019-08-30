Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3487CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A8723779
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MvXWFH6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfH3XPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:15:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38232 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfH3XPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:15:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so9739271edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/Zs3M8U4xSGbreIPfz9YMDfpqs2smNfuk85ROC+apU=;
        b=MvXWFH6ftQzG8wWiBOpbSjKuTH4p25AU6oyHSkugbesKwVToHwqjPWARvv4qzk6ky3
         NHRmgqltPXivqanNUfLAufvxTcIPXh6edYpWOLItncjHzLJ7uhdWVIeq8hwrq6zKou12
         JHESRNTz9fQfjhmk7rGJtglpOeOwWZM61cMXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/Zs3M8U4xSGbreIPfz9YMDfpqs2smNfuk85ROC+apU=;
        b=PGKAvQcdocVUjVg2YrNiyTCYVKiyFYJDTuqGih3XdR209CcA0Uz8DJflKlLZTArT+l
         91MwZqC8zNPMrjneW1fHB2exAA1DXiNvSswwF57OLZeRzzRBphwVW3PLE+mS3spkPkUa
         ddenIV26g2kZXEfhql/kwyL1qF/JHObtU8zY9gQpJY7Oorq2PhDtf8+z2HH9Qi2yampO
         dCcB5TVcQJNLs6JASxwfNPYikLv8jR2QFao499Vwr1pdBccuwaDJ075LEJI3ScVvMvep
         aBjgjQsL9qj7i0wvXpd2CnHc1zoNPi/cDjNRnGmLv2gpuSDqCCCAHZNe77tHFg15CpkV
         nk+A==
X-Gm-Message-State: APjAAAW1FmOPga3LoRHOFxqpyXTHy4JkgpebyLY1D58S8SN3V1OK+yBP
        Agn6Fjy61nbrEFGONQ5mVFr1Bg==
X-Google-Smtp-Source: APXvYqyjP+IlOiO60QitHnJhC7VKtCSpvE/0viEv6q7xwARYRrE+IuIxfNjvGAgdpnE62JdcVRRO8g==
X-Received: by 2002:a50:d48b:: with SMTP id s11mr10309799edi.253.1567206936269;
        Fri, 30 Aug 2019 16:15:36 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s4sm875457ejx.33.2019.08.30.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:15:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 3/6] compiler_types.h: don't #define __inline
Date:   Sat, 31 Aug 2019 01:15:24 +0200
Message-Id: <20190830231527.22304-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spellings __inline and __inline__ should be reserved for uses
where one really wants to refer to the inline keyword, regardless of
whether or not the spelling "inline" has been #defined to something
else. Due to use of __inline__ in uapi headers, we can't easily get
rid of the definition of __inline__. However, almost all users of
__inline has been converted to inline, so we can get rid of that
#define.

The exception is include/acpi/platform/acintel.h. However, that header
is only included when using the intel compiler (does anybody actually
build the kernel with that?), and the ACPI_INLINE macro is only used
in the definition of utterly trivial stub functions, where I doubt a
small change of semantics (lack of __gnu_inline) changes anything.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler_types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 599c27b56c29..ee49be6d6088 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -150,8 +150,17 @@ struct ftrace_likely_data {
 	__maybe_unused notrace
 #endif
 
+/*
+ * gcc provides both __inline__ and __inline as alternate spellings of
+ * the inline keyword, though the latter is undocumented. New kernel
+ * code should only use the inline spelling, but some existing code
+ * uses __inline__. Since we #define inline above, to ensure
+ * __inline__ has the same semantics, we need this #define.
+ *
+ * However, the spelling __inline is strictly reserved for referring
+ * to the bare keyword.
+ */
 #define __inline__ inline
-#define __inline   inline
 
 /*
  * Rather then using noinline to prevent stack consumption, use
-- 
2.20.1

