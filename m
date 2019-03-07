Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88C220684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCGGP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:15:58 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:34434 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfCGGP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:15:56 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h1mJu-000444-I6 from Jiada_Wang@mentor.com ; Wed, 06 Mar 2019 22:15:54 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 6 Mar 2019 22:15:51 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v2 2/2] ASoC: rsnd: src: fix compiler warnings
Date:   Thu, 7 Mar 2019 15:15:54 +0900
Message-ID: <20190307061554.26486-3-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307061554.26486-1-jiada_wang@mentor.com>
References: <20190307061554.26486-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compiler complains about following declarations

sound/soc/sh/rcar/src.c:174:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 bsdsr_table_pattern1[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:183:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 bsdsr_table_pattern2[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:192:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 bsisr_table[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:201:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 chan288888[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:210:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 chan244888[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:219:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 chan222222[] = {
 ^~~~~

This patch moves the 'static' keyword to the front of the
declaration to fix the compiler warnings

Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/src.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 45096a66c074..585ffba0244b 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -134,7 +134,7 @@ unsigned int rsnd_src_get_rate(struct rsnd_priv *priv,
 	return rate;
 }
 
-const static u32 bsdsr_table_pattern1[] = {
+static const u32 bsdsr_table_pattern1[] = {
 	0x01800000, /* 6 - 1/6 */
 	0x01000000, /* 6 - 1/4 */
 	0x00c00000, /* 6 - 1/3 */
@@ -143,7 +143,7 @@ const static u32 bsdsr_table_pattern1[] = {
 	0x00400000, /* 6 - 1   */
 };
 
-const static u32 bsdsr_table_pattern2[] = {
+static const u32 bsdsr_table_pattern2[] = {
 	0x02400000, /* 6 - 1/6 */
 	0x01800000, /* 6 - 1/4 */
 	0x01200000, /* 6 - 1/3 */
@@ -152,7 +152,7 @@ const static u32 bsdsr_table_pattern2[] = {
 	0x00600000, /* 6 - 1   */
 };
 
-const static u32 bsisr_table[] = {
+static const u32 bsisr_table[] = {
 	0x00100060, /* 6 - 1/6 */
 	0x00100040, /* 6 - 1/4 */
 	0x00100030, /* 6 - 1/3 */
@@ -161,7 +161,7 @@ const static u32 bsisr_table[] = {
 	0x00100020, /* 6 - 1   */
 };
 
-const static u32 chan288888[] = {
+static const u32 chan288888[] = {
 	0x00000006, /* 1 to 2 */
 	0x000001fe, /* 1 to 8 */
 	0x000001fe, /* 1 to 8 */
@@ -170,7 +170,7 @@ const static u32 chan288888[] = {
 	0x000001fe, /* 1 to 8 */
 };
 
-const static u32 chan244888[] = {
+static const u32 chan244888[] = {
 	0x00000006, /* 1 to 2 */
 	0x0000001e, /* 1 to 4 */
 	0x0000001e, /* 1 to 4 */
@@ -179,7 +179,7 @@ const static u32 chan244888[] = {
 	0x000001fe, /* 1 to 8 */
 };
 
-const static u32 chan222222[] = {
+static const u32 chan222222[] = {
 	0x00000006, /* 1 to 2 */
 	0x00000006, /* 1 to 2 */
 	0x00000006, /* 1 to 2 */
-- 
2.19.2

