Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CF42064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4YUwzGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGQ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:57:59 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38576 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCGQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:57:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id h58so14066448edb.5;
        Thu, 07 Mar 2019 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NpQjR7YIc0TU364fqOl5eewsZhUQFvSsNWi6Lt8cpao=;
        b=U4YUwzGJ4l9PdJK9K2320/2lVWPFPiBzeQfbImX6PiiDrw6eqhRNITSZW46Lwsbg1b
         fI6KRTUZFOZw7zAF7tfXM1mm+oLnht0iYlkiLWESWaWCOr6FjlLbi6X2udivzh3mn9zW
         YFBZ5hGLk1kBQRx8o7BHZv8vd+12Ia/o5CgMYNVco82cfEPs6S9oL2lHKme4Lu1aTDim
         cLvs+2TzPEYOvWrkWALjIHRhHIWpKz1wxzoC2pRMs/ECBGPjRPDcel198XtGD7nTSTzj
         5sK8SNBqqvjly+9C51X4ss7Vm7ScCDk3WqV72aH3wS+5w6W1WDfr0fpTsD5dqL2667Ga
         CMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NpQjR7YIc0TU364fqOl5eewsZhUQFvSsNWi6Lt8cpao=;
        b=f5D5Ul5c+eJKWzfqyRBduPBRMpTTCHfwpO4fOxuJnXFl/W4INRJEmPz0EKQvx4FUq2
         mRFbvp5pt0WFV/PJuEP2vIm3GQzVhcuqMp0HZyNnrcg4pVKT8lLGQkcLQ76VmFH6nKbd
         aLcPvf9jfjP0hsU0WCNDrOpVb1CWRBSWurqmVU4in8IKa2wGZxHetWST7ZJAJuzKknC4
         BMDzF0GEcrmysk161pwIEtWI4v+P+jGHWgFz+goaUJue6TM3wHW12wXICegffiy1su+N
         1g4UBjeeBoiLsduuGNoQVU3xpBHKlyM7Xfdhd+LCueyywiMkEtVPZtdCUu9vqlDmDuWY
         Zt+A==
X-Gm-Message-State: APjAAAXx6a1yO3PL6EfAEZY0yOwnSER46512IT0JR4SWZmLNoAaWO/tc
        brqDFZyb4TxbKXTLqRZ0+wk=
X-Google-Smtp-Source: APXvYqwA3hDfWJwEek/o+IOMnpLpL4g/qABJlftAxfTERzaw2OFSOXfs1vhp33Hxmm0ANWErO93dEg==
X-Received: by 2002:a50:9125:: with SMTP id e34mr28328340eda.183.1551977876983;
        Thu, 07 Mar 2019 08:57:56 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id y17sm987695ejj.10.2019.03.07.08.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:57:55 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: atm: Use IS_ENABLED in atm_dev_ioctl
Date:   Thu,  7 Mar 2019 09:57:42 -0700
Message-Id: <20190307165741.19870-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

net/atm/resources.c:256:6: warning: variable 'number' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
net/atm/resources.c:212:7: warning: variable 'iobuf_len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]

Clang won't realize that compat is 0 when CONFIG_COMPAT is not set until
the constant folding stage, which happens after this semantic analysis.
Use IS_ENABLED instead so that the zero is present at the semantic
analysis stage, which eliminates this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/386
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I don't think this looks the greatest because of the IS_ENABLED + #ifdef
but the only other solution I could think of looks way uglier to me:

https://gist.github.com/74650e9139f704a5435f82fc80d59969

 net/atm/resources.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index bada395ecdb1..3e9f6391319e 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -203,13 +203,9 @@ int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat)
 	int __user *sioc_len;
 	int __user *iobuf_len;
 
-#ifndef CONFIG_COMPAT
-	compat = 0; /* Just so the compiler _knows_ */
-#endif
-
 	switch (cmd) {
 	case ATM_GETNAMES:
-		if (compat) {
+		if (IS_ENABLED(CONFIG_COMPAT) && compat) {
 #ifdef CONFIG_COMPAT
 			struct compat_atm_iobuf __user *ciobuf = arg;
 			compat_uptr_t cbuf;
@@ -253,7 +249,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat)
 		break;
 	}
 
-	if (compat) {
+	if (IS_ENABLED(CONFIG_COMPAT) && compat) {
 #ifdef CONFIG_COMPAT
 		struct compat_atmif_sioc __user *csioc = arg;
 		compat_uptr_t carg;
-- 
2.21.0

