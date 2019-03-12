Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17C7206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412382;
	bh=iWi2w7VW4hB/d5xNEVxt82Ixlq/EKh+clDXewtt+jZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6W9WWoT53NKz4bhrqna3Io+lryuGpj0NOx3pTQ0XQP2OEhMbZndAP55opDWo4t/Q
	 9Cqk6hZxx8UEobrPIvH2Qh6DiRLNxScBzwMko+YWLRnyv1Bxe5fzn5xJukyDfJSwOZ
	 AmJGCabpNRQ4+ssjnZm387E993TmjJwwnk9yAmhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfCLRjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfCLRQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:19 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2490C2184E;
        Tue, 12 Mar 2019 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410979;
        bh=iWi2w7VW4hB/d5xNEVxt82Ixlq/EKh+clDXewtt+jZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0ncgLpScOrPLULSYZt6IHz3HXAqxzTcVkAzjnw+3JsgsAPbsI3DNpxQKOmUncMcw
         q5WjTG0C2m4QWL7tG0ZaTSHpk/qerYzD0u6SAIqKdU7QZxV8DHcYZbuJWp2iFBjGIP
         3besXoJmQnqOnv/Cs0jEsp40EV/S3k1EO+EeXsc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/135] xtensa: smp_lx200_defconfig: fix vectors clash
Date:   Tue, 12 Mar 2019 10:08:22 -0700
Message-Id: <20190312170346.263482627@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 306b38305c0f86de7f17c5b091a95451dcc93d7d ]

Secondary CPU reset vector overlaps part of the double exception handler
code, resulting in weird crashes and hangups when running user code.
Move exception vectors one page up so that they don't clash with the
secondary CPU reset vector.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/configs/smp_lx200_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 14e3ca353ac8..5035b86a2e49 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -34,6 +34,7 @@ CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 # CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX is not set
 # CONFIG_PCI is not set
+CONFIG_VECTORS_OFFSET=0x00002000
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=96M@0"
-- 
2.19.1



