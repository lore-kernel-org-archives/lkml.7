Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2911EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01169218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfCUWBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:53197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfCUWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357245"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6FF5430217F; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, herbert@gondor.apana.org.au
Subject: [PATCH 14/17] crypto: Don't mark AES tables const and cacheline_aligned
Date:   Thu, 21 Mar 2019 15:00:06 -0700
Message-Id: <20190321220009.29334-15-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

cacheline_aligned is a special section. It cannot be const at the same
time because it's not read-only. It doesn't give any MMU protection.

If we wanted const cacheline aligned we would need to define
a new dedicated section. But I assume it's not really needed so the const
can be dropped.

This fixes LTO complaints about conflicting section types.

Cc: herbert@gondor.apana.org.au
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 crypto/aes_generic.c | 8 ++++----
 include/crypto/aes.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 13df33aca463..851b35949737 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -64,7 +64,7 @@ static inline u8 byte(const u32 x, const unsigned n)
 static const u32 rco_tab[10] = { 1, 2, 4, 8, 16, 32, 64, 128, 27, 54 };
 
 /* cacheline-aligned to facilitate prefetching into cache */
-__visible const u32 crypto_ft_tab[4][256] __cacheline_aligned = {
+__visible u32 crypto_ft_tab[4][256] __cacheline_aligned = {
 	{
 		0xa56363c6, 0x847c7cf8, 0x997777ee, 0x8d7b7bf6,
 		0x0df2f2ff, 0xbd6b6bd6, 0xb16f6fde, 0x54c5c591,
@@ -328,7 +328,7 @@ __visible const u32 crypto_ft_tab[4][256] __cacheline_aligned = {
 	}
 };
 
-__visible const u32 crypto_fl_tab[4][256] __cacheline_aligned = {
+__visible u32 crypto_fl_tab[4][256] __cacheline_aligned = {
 	{
 		0x00000063, 0x0000007c, 0x00000077, 0x0000007b,
 		0x000000f2, 0x0000006b, 0x0000006f, 0x000000c5,
@@ -592,7 +592,7 @@ __visible const u32 crypto_fl_tab[4][256] __cacheline_aligned = {
 	}
 };
 
-__visible const u32 crypto_it_tab[4][256] __cacheline_aligned = {
+__visible u32 crypto_it_tab[4][256] __cacheline_aligned = {
 	{
 		0x50a7f451, 0x5365417e, 0xc3a4171a, 0x965e273a,
 		0xcb6bab3b, 0xf1459d1f, 0xab58faac, 0x9303e34b,
@@ -856,7 +856,7 @@ __visible const u32 crypto_it_tab[4][256] __cacheline_aligned = {
 	}
 };
 
-__visible const u32 crypto_il_tab[4][256] __cacheline_aligned = {
+__visible u32 crypto_il_tab[4][256] __cacheline_aligned = {
 	{
 		0x00000052, 0x00000009, 0x0000006a, 0x000000d5,
 		0x00000030, 0x00000036, 0x000000a5, 0x00000038,
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 852eaa9cd4db..a03139ec930f 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -28,10 +28,10 @@ struct crypto_aes_ctx {
 	u32 key_length;
 };
 
-extern const u32 crypto_ft_tab[4][256];
-extern const u32 crypto_fl_tab[4][256];
-extern const u32 crypto_it_tab[4][256];
-extern const u32 crypto_il_tab[4][256];
+extern u32 crypto_ft_tab[4][256];
+extern u32 crypto_fl_tab[4][256];
+extern u32 crypto_it_tab[4][256];
+extern u32 crypto_il_tab[4][256];
 
 int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		unsigned int key_len);
-- 
2.20.1

