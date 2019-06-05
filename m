Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5640C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0FA206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="bOOLOfwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFEIjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:39:12 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:50380 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbfFEIjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a1ZtZPMYFe+z3Jl//HdGBs6N7u+N8X5saYmrcSt4sM8=; b=bOOLOfwQIviyRDN9LGruObFidP
        qJH3/GhkPAWCJsiGlhb07VfVKYDW5zylgiLO1+ElKSOA8m8hsX10nTedblfcQcwVyqoPWpAm5togb
        GrAuzgyVLhUiYm7yC5WH8SZxKVUDcCLWLNGvjAfLNIGZbtZjkBJRCQGnFtqs7pduA3HAEZV82JETS
        g9TPzc4wBm9X5EzKI7veGNPwFh68xorD9vxmXrX5raEmR/qe9Qo8TmeFD8+mdQlanj7BirM5WrpAU
        taVNoynfUqH24q63A69IjunZJ0pCJqkgmUYZH5ACAUBSMBPFE06Z3OpLRW9qeKdEcyBWk/SFN63YC
        mJojbpBQ==;
Received: from [37.204.119.143] (port=55354 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hYR9S-0008s7-Li; Wed, 05 Jun 2019 11:20:08 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Date:   Wed,  5 Jun 2019 11:19:04 +0300
Message-Id: <20190605081906.28938-6-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
References: <20190605081906.28938-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 5/7] tty: Add NOKERNINFO lflag to termios
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/alpha/include/uapi/asm/termbits.h   | 1 +
 arch/ia64/include/uapi/asm/termbits.h    | 1 +
 arch/mips/include/uapi/asm/termbits.h    | 1 +
 arch/parisc/include/uapi/asm/termbits.h  | 1 +
 arch/powerpc/include/uapi/asm/termbits.h | 1 +
 arch/sparc/include/uapi/asm/termbits.h   | 1 +
 arch/xtensa/include/uapi/asm/termbits.h  | 1 +
 include/linux/tty.h                      | 1 +
 include/uapi/asm-generic/termbits.h      | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index bb895d467033..850dd8dc4c51 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -204,6 +204,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO	0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/ia64/include/uapi/asm/termbits.h b/arch/ia64/include/uapi/asm/termbits.h
index 86898e4c5905..f777b99bc5ab 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -190,6 +190,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index 3dd60924f0ef..2755cfd1497e 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -206,6 +206,7 @@ struct ktermios {
 #define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
 #define ITOSTOP TOSTOP
 #define EXTPROC 0200000		/* External processing on pty */
+#define NOKERNINFO 0400000		/* Disable kernel output from VSTATUS. */
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 #define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index ecca3b7d0c66..c7ba145adf02 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -183,6 +183,7 @@ struct ktermios {
 #define PENDIN  0040000
 #define IEXTEN  0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index c85e98d75e76..79dbcc546217 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -192,6 +192,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO	0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index a1638c9cde8b..108c039ddefb 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -225,6 +225,7 @@ struct ktermios {
 #define PENDIN	0x00004000
 #define IEXTEN	0x00008000
 #define EXTPROC	0x00010000
+#define NOKERNINFO	0x00020000
 
 /* modem lines */
 #define TIOCM_LE	0x001
diff --git a/arch/xtensa/include/uapi/asm/termbits.h b/arch/xtensa/include/uapi/asm/termbits.h
index 77969cb275b8..6155e1c81164 100644
--- a/arch/xtensa/include/uapi/asm/termbits.h
+++ b/arch/xtensa/include/uapi/asm/termbits.h
@@ -199,6 +199,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 38d8ffe7f0e3..07189f18f93d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -186,6 +186,7 @@ struct tty_bufhead {
 #define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
 #define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
 #define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
+#define L_NOKERNINFO(tty)	_L_FLAG((tty), NOKERNINFO)
 
 struct device;
 struct signal_struct;
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 11bb142ba844..6219803d6f4d 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -181,6 +181,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
-- 
2.20.1

