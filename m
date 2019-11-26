Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F21C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987242084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKZUO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:14:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:47046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727332AbfKZUO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:14:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8713B30C;
        Tue, 26 Nov 2019 20:14:24 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/35] powerpc/64s/exception: re-inline some handlers
Date:   Tue, 26 Nov 2019 21:13:31 +0100
Message-Id: <55e8df08916a56c5cd580f101626f88f2452f004.1574798487.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574798487.git.msuchanek@suse.de>
References: <cover.1574798487.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

The reduction in interrupt entry size allows some handlers to be
re-inlined.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7a234e6d7bf5..9494403b9586 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1186,7 +1186,7 @@ INT_DEFINE_BEGIN(data_access)
 INT_DEFINE_END(data_access)
 
 EXC_REAL_BEGIN(data_access, 0x300, 0x80)
-	GEN_INT_ENTRY data_access, virt=0, ool=1
+	GEN_INT_ENTRY data_access, virt=0
 EXC_REAL_END(data_access, 0x300, 0x80)
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
 	GEN_INT_ENTRY data_access, virt=1
@@ -1216,7 +1216,7 @@ INT_DEFINE_BEGIN(data_access_slb)
 INT_DEFINE_END(data_access_slb)
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-	GEN_INT_ENTRY data_access_slb, virt=0, ool=1
+	GEN_INT_ENTRY data_access_slb, virt=0
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	GEN_INT_ENTRY data_access_slb, virt=1
@@ -1472,7 +1472,7 @@ INT_DEFINE_BEGIN(decrementer)
 INT_DEFINE_END(decrementer)
 
 EXC_REAL_BEGIN(decrementer, 0x900, 0x80)
-	GEN_INT_ENTRY decrementer, virt=0, ool=1
+	GEN_INT_ENTRY decrementer, virt=0
 EXC_REAL_END(decrementer, 0x900, 0x80)
 EXC_VIRT_BEGIN(decrementer, 0x4900, 0x80)
 	GEN_INT_ENTRY decrementer, virt=1
-- 
2.23.0

