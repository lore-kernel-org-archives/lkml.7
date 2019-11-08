Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B71C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB7F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="E1wEJh8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbfKHUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:07:51 -0500
Received: from alln-iport-2.cisco.com ([173.37.142.89]:4873 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbfKHUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:07:48 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 15:07:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1046; q=dns/txt; s=iport;
  t=1573243668; x=1574453268;
  h=from:to:cc:subject:date:message-id;
  bh=X1lPDJ2u683UXe+m/XoPk0zEHMn31p9nWWtfEQdDTlg=;
  b=E1wEJh8Gm0pSSYS8eDxmTNOlv4JWWQfel7sfmApGnsiaJgk0bl9nZpwi
   6QRQXRMEFJTpaU/axkSrXZ7x70nSP1cF1eUOUmDxUzWHOFcf77xKfQHYU
   Zsr2eMF89H8Mc6tqwxr4giCyQLOw67WfxJ2omOGZekHj2b91NkHxtWq1T
   k=;
X-IronPort-AV: E=Sophos;i="5.68,283,1569283200"; 
   d="scan'208";a="368687251"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Nov 2019 20:00:42 +0000
Received: from zorba.cisco.com ([10.24.83.59])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id xA8K0eEd022208;
        Fri, 8 Nov 2019 20:00:41 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Yu Sun <yusun2@cisco.com>,
        xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/xz: Fix XZ_DYNALLOC to avoid useless memory reallocations.
Date:   Fri,  8 Nov 2019 12:00:40 -0800
Message-Id: <20191108200040.20259-2-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.83.59, [10.24.83.59]
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lasse Collin <lasse.collin@tukaani.org>

s->dict.allocated was initialized to 0 but never set after
a successful allocation, thus the code always thought that
the dictionary buffer has to be reallocated.

For the original commit to xz-embedded.git, please refer to:
https://git.tukaani.org/?p=xz-embedded.git;a=commit;h=40d291b

Signed-off-by: Yu Sun <yusun2@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 lib/xz/xz_dec_lzma2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 08c3c8049998..156f26fdc4c9 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -1146,6 +1146,7 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_reset(struct xz_dec_lzma2 *s, uint8_t props)
 
 		if (DEC_IS_DYNALLOC(s->dict.mode)) {
 			if (s->dict.allocated < s->dict.size) {
+				s->dict.allocated = s->dict.size;
 				vfree(s->dict.buf);
 				s->dict.buf = vmalloc(s->dict.size);
 				if (s->dict.buf == NULL) {
-- 
2.17.1

