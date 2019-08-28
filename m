Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9918DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775D822CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfH1Kas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:30:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbfH1Kao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:30:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19769AFF2;
        Wed, 28 Aug 2019 10:30:43 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/4] powerpc/64: Disable COMPAT if littleendian.
Date:   Wed, 28 Aug 2019 12:30:29 +0200
Message-Id: <b61dba35d1b255d9eb2c503127b015a5cf479150.1566987936.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566987936.git.msuchanek@suse.de>
References: <cover.1566987936.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc32le was never really a thing. Endian swap is already disabled by
default so this 32bit support is kind of useless on ppc64le.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5bab0bb6b833..67cd1c4d1bae 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -265,7 +265,7 @@ config PANIC_TIMEOUT
 
 config COMPAT
 	bool
-	default y if PPC64
+	default y if PPC64 && !CPU_LITTLE_ENDIAN
 	select COMPAT_BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
-- 
2.22.0

