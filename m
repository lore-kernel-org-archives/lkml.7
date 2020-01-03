Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B79AC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AFD215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578074382;
	bh=xn1Q54HWkOB4uBFT5MNOts3FC211CUhekLUk48JFLB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQ1oT6+oeC/6HZphgRo/D2GVy8vRAtt6Viu0GTXX2BTi8praM7/9l7wethmkrrWIb
	 ExTEGLR24FxPPv1Gh2GbiLYYIFxQPLRKRmsgy/tuOxyqbQL/wXIHbvwHM7N7rbLLhv
	 uengdQX3u+96gBg+LLLYRIO78QRP/37GEIUdKUSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgACR7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:59:41 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64713 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgACR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:59:39 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 003HxSJ6022724;
        Sat, 4 Jan 2020 02:59:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 003HxSJ6022724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578074371;
        bh=bJfY9P/JRKRZL7zus1oisBlsP9ihX0EmmC9HMpfIWSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTu8eM5NHXVqrx5W1k/BibTYQ0P4tMRWzZvHSbFNWXpZ6kxxVnWK1xBvz7QzgdNkj
         jDEC15QKl6bSHyX9S/qbDMKQ9ixMvaRO4yDrrLjWpATl2X3otG12gWzxnaVm13Lk5k
         8wAb0w1g7417BhkzYSbCy5Asxp81gug3naTYzYd4ssC/fIDJVQArVqxGWOXdL9hqyW
         +AT3N66EgAhgBLOgA1Hh61TVWhaULFXPwYsLg5mmktpEhjCN8WlMOKNzv8+Pv2SE17
         RHn5RY/50mGN38cVNVDeaL6gjyH4lYrrmlyhMhHgGdWYJrzIJ29mBY3GWdICteylKk
         sncjN4GY//lUw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] initramfs: make compression options not depend on INITRAMFS_SOURCE
Date:   Sat,  4 Jan 2020 02:59:08 +0900
Message-Id: <20200103175915.26663-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103175915.26663-1-masahiroy@kernel.org>
References: <20200103175915.26663-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if INITRAMFS_SOURCE is empty, usr/gen_initramfs.sh generates a
tiny default initramfs, which is embedded in vmlinux.

So, defining INITRAMFS_COMPRESSION* options should be valid irrespective
of INITRAMFS_SOURCE.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index 72f50a21c051..43934c128010 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -102,7 +102,6 @@ config RD_LZ4
 
 choice
 	prompt "Built-in initramfs compression mode"
-	depends on INITRAMFS_SOURCE!=""
 	optional
 	help
 	  This option allows you to decide by which algorithm the builtin
@@ -211,7 +210,6 @@ config INITRAMFS_COMPRESSION_LZ4
 endchoice
 
 config INITRAMFS_COMPRESSION
-	depends on INITRAMFS_SOURCE!=""
 	string
 	default ""      if INITRAMFS_COMPRESSION_NONE
 	default ".gz"   if INITRAMFS_COMPRESSION_GZIP
-- 
2.17.1

