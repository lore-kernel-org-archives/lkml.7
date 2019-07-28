Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD18C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13222077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfG1XTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:19:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfG1XTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:19:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so59885717wru.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfnKeVtWMsjeagN3ScOeao7K7unv51Thgt0+ZHQYeeU=;
        b=JtIAkJnZZ7whTPjajLT/WaJFe2jvKITedDvR4ya2Lq+do/l2h2WsMIXNZfBybF++G7
         m8AZOVDxtjNqwXz3rCgg87oCvpHKgn6OsLnSrUM/CtTNboFRhv/EPegi5HKTY46SiJL4
         5eDpXc1jxJNLEvxGNwnKuOzisTqNSlSEK54AYIb0s5hp6KoGll8Xh/XfGoOqBddiA6T/
         vwiNaUBdce4z/qoJmNdUdBwUVrJT6lrlg6SGPwk9sfwIfj2TtniYBgcB0viE9IE81P1V
         hgw1Hl9VP17JrtR8zEmf30BS+LlRHMcdbPV9NZtBQvFv6Sk3pZ73yTanN+Bt0FOTVoMq
         homw==
X-Gm-Message-State: APjAAAVcPlhG5qScCLsELfxmRU5xDs0x86KO4uO8ODJ1z/lXSFF1Crtu
        Tbg8FMvIGq/XeWqksblmYRC09g==
X-Google-Smtp-Source: APXvYqyY2RuYX9/y4QRYH96xA9KFUAgKSfpFPp0MxagW4oTW/Zyz4jiD35a5qHl/cJTk4SYO4cPang==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr41523394wrs.152.1564355993012;
        Sun, 28 Jul 2019 16:19:53 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id l17sm41562756wrr.94.2019.07.28.16.19.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 16:19:52 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: mark expected switch fall-through in HYP
Date:   Mon, 29 Jul 2019 01:19:49 +0200
Message-Id: <20190728231949.6874-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes a 130+ lines warning.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kvm/hyp/debug-sr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
index 26781da3ad3e..c648c243f98b 100644
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@ -18,40 +18,70 @@
 #define save_debug(ptr,reg,nr)						\
 	switch (nr) {							\
 	case 15:	ptr[15] = read_debug(reg, 15);			\
+			/* fallthrough */				\
 	case 14:	ptr[14] = read_debug(reg, 14);			\
+			/* fallthrough */				\
 	case 13:	ptr[13] = read_debug(reg, 13);			\
+			/* fallthrough */				\
 	case 12:	ptr[12] = read_debug(reg, 12);			\
+			/* fallthrough */				\
 	case 11:	ptr[11] = read_debug(reg, 11);			\
+			/* fallthrough */				\
 	case 10:	ptr[10] = read_debug(reg, 10);			\
+			/* fallthrough */				\
 	case 9:		ptr[9] = read_debug(reg, 9);			\
+			/* fallthrough */				\
 	case 8:		ptr[8] = read_debug(reg, 8);			\
+			/* fallthrough */				\
 	case 7:		ptr[7] = read_debug(reg, 7);			\
+			/* fallthrough */				\
 	case 6:		ptr[6] = read_debug(reg, 6);			\
+			/* fallthrough */				\
 	case 5:		ptr[5] = read_debug(reg, 5);			\
+			/* fallthrough */				\
 	case 4:		ptr[4] = read_debug(reg, 4);			\
+			/* fallthrough */				\
 	case 3:		ptr[3] = read_debug(reg, 3);			\
+			/* fallthrough */				\
 	case 2:		ptr[2] = read_debug(reg, 2);			\
+			/* fallthrough */				\
 	case 1:		ptr[1] = read_debug(reg, 1);			\
+			/* fallthrough */				\
 	default:	ptr[0] = read_debug(reg, 0);			\
 	}
 
 #define restore_debug(ptr,reg,nr)					\
 	switch (nr) {							\
 	case 15:	write_debug(ptr[15], reg, 15);			\
+			/* fallthrough */				\
 	case 14:	write_debug(ptr[14], reg, 14);			\
+			/* fallthrough */				\
 	case 13:	write_debug(ptr[13], reg, 13);			\
+			/* fallthrough */				\
 	case 12:	write_debug(ptr[12], reg, 12);			\
+			/* fallthrough */				\
 	case 11:	write_debug(ptr[11], reg, 11);			\
+			/* fallthrough */				\
 	case 10:	write_debug(ptr[10], reg, 10);			\
+			/* fallthrough */				\
 	case 9:		write_debug(ptr[9], reg, 9);			\
+			/* fallthrough */				\
 	case 8:		write_debug(ptr[8], reg, 8);			\
+			/* fallthrough */				\
 	case 7:		write_debug(ptr[7], reg, 7);			\
+			/* fallthrough */				\
 	case 6:		write_debug(ptr[6], reg, 6);			\
+			/* fallthrough */				\
 	case 5:		write_debug(ptr[5], reg, 5);			\
+			/* fallthrough */				\
 	case 4:		write_debug(ptr[4], reg, 4);			\
+			/* fallthrough */				\
 	case 3:		write_debug(ptr[3], reg, 3);			\
+			/* fallthrough */				\
 	case 2:		write_debug(ptr[2], reg, 2);			\
+			/* fallthrough */				\
 	case 1:		write_debug(ptr[1], reg, 1);			\
+			/* fallthrough */				\
 	default:	write_debug(ptr[0], reg, 0);			\
 	}
 
-- 
2.21.0

