Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF27120854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfCFRwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:52:41 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfCFRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:52:41 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MN5W9-1hKdfe0lhV-00J3Pd; Wed, 06 Mar 2019 18:52:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: binfmt: mark aout as broken
Date:   Wed,  6 Mar 2019 18:52:38 +0100
Message-Id: <1551894758-4554-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e0502efe-39b3-b488-793d-6536687b24d7@metux.net>
References: <e0502efe-39b3-b488-793d-6536687b24d7@metux.net>
X-Provags-ID: V03:K1:sUAEDbyLcjFae4BRsh6WBGIJadt8dSkjCeLplI4moA2BeSUG/39
 R3uM3r+Yytxtxu8Iqg2X7RIFcdpkbiGdRP/tdIbYJOAYJG4IEg+1LMOGZMXyTZ/0h2xx/4j
 qfwuHyWutBN5E2L4IWMhmQj7QBSJrXOdSBnnKZCKPYfUO09TGpnkeyN3WHN2bM8aLHX/zNB
 lYEBvZFJlaKAxdO0JuLzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tlPNDlnMe8Y=:Ulz4oGBEdtjDNsrNz7q+Ej
 +75yWIkJYmkFFpIBU+Yf+E9XAicgl+zTZOBBnINF/HreDkG76NJriAWe1a3n0pCJX0plopAVy
 PJJlM/L517v+rgYxrK0RZjQj1baYyLw3/KgvyqTI+YtM5oaPiMBOGF7dNAircImy4IjMI6QP0
 BHWNjtYQqxEkGw6QsIvkJiEXXU0dDf3/Z3n/9f/PqBOV4/VHqhrb5IYdNnaUsD98FGSCfUGJ1
 Z2aUjSSbLJ0FIx1VnaMOcl60q/9uKCIDBSdKKrOJyLneJy+Cv6ogDi5ZK1gWCd7A8Jm+Of08W
 niuzSdH8kx+wBSnqV9Di8mQ/yxlqCs6lk7msQsflBnhrZxx00OB3tLf6519EtHCWv2fZmsnDv
 WgscPcAxwQIfFBG7RFuLMaynEEqpNiLThudcGsd43JSj5OXeTzuksvKnYXph8rtTsFvnO8ZcO
 3H3NPPLlxPPFkQI4ZHJVjJxuGtauUoP9XXxalrlQksAhNptg9xN1Q+DXFK2Uf95Y5VVzGMOl4
 9i4Nv9qkPsiSfrkIfAPrGy67HJW786aQWlxODvdHkfeQuCl8G4LfAPrzdY9uS5alSC+8lypgI
 OWSARvbh2GQc2sgXNlIDbNwK/WK2DidBBBT3IA+s9Z44PH00jI2DPKR5OlEqQRwVP6iQGzoHu
 zOeh61DwAfeH4VQsC8Di5u2GX3xzVpJWqx8gSxOn1TuJh4nUZwSOX3nInOE20OTHWxR+d+N8k
 1NJ/aaLGiDsbd7n1x7jd+MjddPKwA6AXHpQjKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core dumping is pretty broken, and nobody seriously seems to use
that ancient binfmt anymore.

In the longer run, it probably will be removed. But once that's
done, it'll take some time to propagate through the distros and
hit somebody who really needs it, and reverting will be difficult.

Therefore, markt it BROKEN right now, sit back and just wait for
somebody complaining :p

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 fs/Kconfig.binfmt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index b795f8d..05074f4 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -115,6 +115,7 @@ config HAVE_AOUT
 config BINFMT_AOUT
 	tristate "Kernel support for a.out and ECOFF binaries"
 	depends on HAVE_AOUT
+	depends on BROKEN
 	---help---
 	  A.out (Assembler.OUTput) is a set of formats for libraries and
 	  executables used in the earliest versions of UNIX.  Linux used
-- 
1.9.1

