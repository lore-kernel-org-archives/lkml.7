Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED188C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD509218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555033456;
	bh=ezoFhkNv2c7a2gDzE9OdwLaKZ5doSr9fSC1eIzoUfIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+qJlFDCK+IKhcF6tSPatQ2xKeKye+/hjPO/OkH8ZQD+4M087Oc6Vs91r3nzGsWWM
	 cIPdadC86Qlu5loInIpDv7wWUYoxiEMtFkvSQdPLT/A9KLEZJD+Qbn0lQ8t/3HrOCl
	 fF2pez/im/nhHWE/8oh7GvXteaAwNt3fmSU4P5Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDLBoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfDLBoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:44:13 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [52.191.113.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9593421850;
        Fri, 12 Apr 2019 01:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555033452;
        bh=ezoFhkNv2c7a2gDzE9OdwLaKZ5doSr9fSC1eIzoUfIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zk49QwQ6GRZl9d1j8ACX/XqodaXmIQxtFzJ2j1quPzGM0pRnH5u1w4gni9Z6L1BfW
         9Uez8coVEqO3rqL/DTlfQwaAbov/t63LqaWqD4juwNvSD/3uT13bgXZl8JFbS9RG4c
         5WWaUCrwM4lYUZln7aFaS7lLxopcmVBUmbFxvw4A=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH v4 3/5] mips: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
Date:   Fri, 12 Apr 2019 01:43:53 +0000
Message-Id: <20190412014355.25307-4-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412014355.25307-1-okaya@kernel.org>
References: <20190412014355.25307-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
defined CONFIG_DEBUG_MISC instead to keep the current code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8d1dc6c71173..9fc8fadb8418 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -563,7 +563,7 @@ static void __init bootmem_init(void)
 		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
 		memblock_free(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
 
-#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
+#if defined(CONFIG_DEBUG_MISC) && defined(CONFIG_DEBUG_INFO)
 		/*
 		 * This information is necessary when debugging the kernel
 		 * But is a security vulnerability otherwise!
-- 
2.21.0

