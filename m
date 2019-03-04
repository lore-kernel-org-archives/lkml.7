Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815C120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689049;
	bh=fLYtDXGL8OLSblBdUyXRB/DTlVc22VHgCAhdr22tG3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DWz9QvHyv4LDtFAgs/e5WMdX91Rh5d4khD7eKrVwErwl3siiLEIVwrkW0UxBV1QCc
	 KyilketcQQlGLMtWgckCVH2Tjphdv6BnGcLNLVQHAkSNkUWNCW0TGu6anz93DbfJE+
	 6tkP4eXJl68KNWSwqqk7vW1Cqkcl7gO7BnJFCNlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCDI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfCDI3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD5C20836;
        Mon,  4 Mar 2019 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688150;
        bh=fLYtDXGL8OLSblBdUyXRB/DTlVc22VHgCAhdr22tG3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRix7UB9AqCUFefnzkbq4BNzLx/UcsdLUsYxwaTdANobzwCUYXiMgeUFKSLCwPZZX
         U3PdNVcu2fJx86Ht99ewxfOmpV9odE4wXQse6cz2o1BlC2RTtiTe3WZj/3dF2j03wD
         8T7uxrUwJ9q53S1CH+Sl/vhVe4H5isMhDLsDYCfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/78] staging: rtl8723bs: Fix build error with Clang when inlining is disabled
Date:   Mon,  4 Mar 2019 09:22:16 +0100
Message-Id: <20190304081626.984668042@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 97715058b70da1262fd07798c8b2e3e894f759dd ]

When CONFIG_NO_AUTO_INLINE was present in linux-next (which added
'-fno-inline-functions' to KBUILD_CFLAGS), an allyesconfig build with
Clang failed at the modpost stage:

ERROR: "is_broadcast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: "is_zero_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: "is_multicast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!

These functions were marked as extern inline, meaning that if inlining
doesn't happen, the function will be undefined, as it is above.

This happens to work with GCC because the '-fno-inline-functions' option
respects the __inline attribute so all instances of these functions are
inlined as expected and the definition doesn't actually matter. However,
with Clang and '-fno-inline-functions', a function has to be marked with
the __always_inline attribute to be considered for inlining, which none
of these functions are. Clang tries to find the symbol definition
elsewhere as it was told and fails, which trickles down to modpost.

To make sure that this code compiles regardless of compiler and make the
intention of the code clearer, use 'static' to ensure these functions
are always defined, regardless of inlining. Additionally, silence a
checkpatch warning by switching from '__inline' to 'inline'.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index bcc8dfa8e6728..9efb4dcb9d3a8 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -850,18 +850,18 @@ enum ieee80211_state {
 #define IP_FMT "%pI4"
 #define IP_ARG(x) (x)
 
-extern __inline int is_multicast_mac_addr(const u8 *addr)
+static inline int is_multicast_mac_addr(const u8 *addr)
 {
         return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
-extern __inline int is_broadcast_mac_addr(const u8 *addr)
+static inline int is_broadcast_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
 }
 
-extern __inline int is_zero_mac_addr(const u8 *addr)
+static inline int is_zero_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
-- 
2.19.1



