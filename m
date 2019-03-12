Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B52C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9987C2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411521;
	bh=ZtqufDUNP8i95b3gbQF+d3ingBjhTZUKjrnym/ueMlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eNAeYZpmPBM0kivB3XZ0U7+4NgQafDLjb2jDRrPKXJG/BCmkikQIswonzgymP0UKj
	 e6DyOtY7ejMBdPDhuMsAqR+dxDFMr2a9d3M+APPrIKyvsiB1Wd/4kRlbUvfojSZFuh
	 LINuoOVlxHZETjy4Wlvvum6Z4et7f4QwNtPh7PHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfCLRZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbfCLRRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:51 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A392183F;
        Tue, 12 Mar 2019 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411071;
        bh=ZtqufDUNP8i95b3gbQF+d3ingBjhTZUKjrnym/ueMlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEWtcWQboH76rm2tRVVb0yVLRBEUooDpDOAKUpb2j2ExG4mA3of8cPpFE2Yu/QuCX
         JyDybK+5ook6k4Kqt6iGT3TOSUJaR1lnPTFFkD2gmXzBY4ipeFffkGL5D8VES4P5HI
         fNJ0dpNZhDscDaqhcO0fWOAms6i1Mhxk3ctK6iWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 44/96] xtensa: smp_lx200_defconfig: fix vectors clash
Date:   Tue, 12 Mar 2019 10:10:02 -0700
Message-Id: <20190312171037.890180982@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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



