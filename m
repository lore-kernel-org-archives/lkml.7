Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7F4C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E9F218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555195497;
	bh=ZLW/Kxa1smBLm3T1ptMC7Z7ED7tJEJp9hYLWmENfdNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kGDKDUug50tR+pe0qT/sWsQwbPzCIYaxZfAkS/+sVkLNQgBUaFZ6hAUOA/5pOl4Ve
	 4tQ474XTJwY2Ax/2s1OHOZcqI4yQk+2rtCCxeAA1nPsk/5ox98VnLfr/19lIVpuwBQ
	 RskqzCFwpxKzyI0eJutmjFRIIs7FebfapZC+LBzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDMWox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDMWow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:44:52 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.159.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58043218C3;
        Sat, 13 Apr 2019 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555195492;
        bh=ZLW/Kxa1smBLm3T1ptMC7Z7ED7tJEJp9hYLWmENfdNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOEsYA62YgXa0/f2SFNB62xWcApGzjBCsm4n+ZmxqanSkhHpsWQZmfL9Z3iVOZFxx
         QBofqzirXFpi/xuvSrT2pHcTxUUhcj9eUfOsIMLNF4U2/doQojYUujoSVIHlfWoxu+
         6pxx0QG6H+6Fo5Le+u8xsMRd/csw+p5mfbXoUlqM=
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
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH v5 3/5] mips: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
Date:   Sat, 13 Apr 2019 22:44:36 +0000
Message-Id: <20190413224438.10802-4-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413224438.10802-1-okaya@kernel.org>
References: <20190413224438.10802-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
defined CONFIG_DEBUG_MISC instead to keep the current code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
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

