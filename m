Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9543C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C5422C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033457;
	bh=l3KunXrgj1/1PR7Nhw1HPBgQkLWACq+ht0INIonY6F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rA31cuaPVhMpEeCFmqGF4wXQbOcmJ1E7n/r3TZKMStvGDA08BjNtSIGdR+j9XcV/o
	 PBehktCtwsmzKyyt/X8RQpjhPwl2fHTaZ/b63Pt7kN7mwg9H896PvPEZI/4+nhl3a/
	 CkmAyxHpToh6q+tzL8br4+C7T1EPPT4KhAXKdjjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbfGYFoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391199AbfGYFoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5DF22BF5;
        Thu, 25 Jul 2019 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033452;
        bh=l3KunXrgj1/1PR7Nhw1HPBgQkLWACq+ht0INIonY6F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT2HRVvDXUb0N/OyxYrWlhEXzIJsDJM1rwBemUmQBsL2zN99cu9Q3J8CfwrLsBp6M
         G9VK/0bH6CslDdRJEOevMFxm+pHyIjhNm33OttyS44dS+9GWvcgT0Gh/7ah1+SRAfI
         PfAokhc/8OY0kzs2TH3tmflOfzJroXd+p+J6TTDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 173/271] crypto: ccp - Validate the the error value used to index error messages
Date:   Wed, 24 Jul 2019 21:20:42 +0200
Message-Id: <20190724191710.010320380@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hook, Gary <Gary.Hook@amd.com>

commit 52393d617af7b554f03531e6756facf2ea687d2e upstream.

The error code read from the queue status register is only 6 bits wide,
but we need to verify its value is within range before indexing the error
messages.

Fixes: 81422badb3907 ("crypto: ccp - Make syslog errors human-readable")
Cc: <stable@vger.kernel.org>
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-dev.c |   96 ++++++++++++++++++++++---------------------
 drivers/crypto/ccp/ccp-dev.h |    2 
 2 files changed, 52 insertions(+), 46 deletions(-)

--- a/drivers/crypto/ccp/ccp-dev.c
+++ b/drivers/crypto/ccp/ccp-dev.c
@@ -35,56 +35,62 @@ struct ccp_tasklet_data {
 };
 
 /* Human-readable error strings */
+#define CCP_MAX_ERROR_CODE	64
 static char *ccp_error_codes[] = {
 	"",
-	"ERR 01: ILLEGAL_ENGINE",
-	"ERR 02: ILLEGAL_KEY_ID",
-	"ERR 03: ILLEGAL_FUNCTION_TYPE",
-	"ERR 04: ILLEGAL_FUNCTION_MODE",
-	"ERR 05: ILLEGAL_FUNCTION_ENCRYPT",
-	"ERR 06: ILLEGAL_FUNCTION_SIZE",
-	"ERR 07: Zlib_MISSING_INIT_EOM",
-	"ERR 08: ILLEGAL_FUNCTION_RSVD",
-	"ERR 09: ILLEGAL_BUFFER_LENGTH",
-	"ERR 10: VLSB_FAULT",
-	"ERR 11: ILLEGAL_MEM_ADDR",
-	"ERR 12: ILLEGAL_MEM_SEL",
-	"ERR 13: ILLEGAL_CONTEXT_ID",
-	"ERR 14: ILLEGAL_KEY_ADDR",
-	"ERR 15: 0xF Reserved",
-	"ERR 16: Zlib_ILLEGAL_MULTI_QUEUE",
-	"ERR 17: Zlib_ILLEGAL_JOBID_CHANGE",
-	"ERR 18: CMD_TIMEOUT",
-	"ERR 19: IDMA0_AXI_SLVERR",
-	"ERR 20: IDMA0_AXI_DECERR",
-	"ERR 21: 0x15 Reserved",
-	"ERR 22: IDMA1_AXI_SLAVE_FAULT",
-	"ERR 23: IDMA1_AIXI_DECERR",
-	"ERR 24: 0x18 Reserved",
-	"ERR 25: ZLIBVHB_AXI_SLVERR",
-	"ERR 26: ZLIBVHB_AXI_DECERR",
-	"ERR 27: 0x1B Reserved",
-	"ERR 27: ZLIB_UNEXPECTED_EOM",
-	"ERR 27: ZLIB_EXTRA_DATA",
-	"ERR 30: ZLIB_BTYPE",
-	"ERR 31: ZLIB_UNDEFINED_SYMBOL",
-	"ERR 32: ZLIB_UNDEFINED_DISTANCE_S",
-	"ERR 33: ZLIB_CODE_LENGTH_SYMBOL",
-	"ERR 34: ZLIB _VHB_ILLEGAL_FETCH",
-	"ERR 35: ZLIB_UNCOMPRESSED_LEN",
-	"ERR 36: ZLIB_LIMIT_REACHED",
-	"ERR 37: ZLIB_CHECKSUM_MISMATCH0",
-	"ERR 38: ODMA0_AXI_SLVERR",
-	"ERR 39: ODMA0_AXI_DECERR",
-	"ERR 40: 0x28 Reserved",
-	"ERR 41: ODMA1_AXI_SLVERR",
-	"ERR 42: ODMA1_AXI_DECERR",
-	"ERR 43: LSB_PARITY_ERR",
+	"ILLEGAL_ENGINE",
+	"ILLEGAL_KEY_ID",
+	"ILLEGAL_FUNCTION_TYPE",
+	"ILLEGAL_FUNCTION_MODE",
+	"ILLEGAL_FUNCTION_ENCRYPT",
+	"ILLEGAL_FUNCTION_SIZE",
+	"Zlib_MISSING_INIT_EOM",
+	"ILLEGAL_FUNCTION_RSVD",
+	"ILLEGAL_BUFFER_LENGTH",
+	"VLSB_FAULT",
+	"ILLEGAL_MEM_ADDR",
+	"ILLEGAL_MEM_SEL",
+	"ILLEGAL_CONTEXT_ID",
+	"ILLEGAL_KEY_ADDR",
+	"0xF Reserved",
+	"Zlib_ILLEGAL_MULTI_QUEUE",
+	"Zlib_ILLEGAL_JOBID_CHANGE",
+	"CMD_TIMEOUT",
+	"IDMA0_AXI_SLVERR",
+	"IDMA0_AXI_DECERR",
+	"0x15 Reserved",
+	"IDMA1_AXI_SLAVE_FAULT",
+	"IDMA1_AIXI_DECERR",
+	"0x18 Reserved",
+	"ZLIBVHB_AXI_SLVERR",
+	"ZLIBVHB_AXI_DECERR",
+	"0x1B Reserved",
+	"ZLIB_UNEXPECTED_EOM",
+	"ZLIB_EXTRA_DATA",
+	"ZLIB_BTYPE",
+	"ZLIB_UNDEFINED_SYMBOL",
+	"ZLIB_UNDEFINED_DISTANCE_S",
+	"ZLIB_CODE_LENGTH_SYMBOL",
+	"ZLIB _VHB_ILLEGAL_FETCH",
+	"ZLIB_UNCOMPRESSED_LEN",
+	"ZLIB_LIMIT_REACHED",
+	"ZLIB_CHECKSUM_MISMATCH0",
+	"ODMA0_AXI_SLVERR",
+	"ODMA0_AXI_DECERR",
+	"0x28 Reserved",
+	"ODMA1_AXI_SLVERR",
+	"ODMA1_AXI_DECERR",
 };
 
-void ccp_log_error(struct ccp_device *d, int e)
+void ccp_log_error(struct ccp_device *d, unsigned int e)
 {
-	dev_err(d->dev, "CCP error: %s (0x%x)\n", ccp_error_codes[e], e);
+	if (WARN_ON(e >= CCP_MAX_ERROR_CODE))
+		return;
+
+	if (e < ARRAY_SIZE(ccp_error_codes))
+		dev_err(d->dev, "CCP error %d: %s\n", e, ccp_error_codes[e]);
+	else
+		dev_err(d->dev, "CCP error %d: Unknown Error\n", e);
 }
 
 /* List of CCPs, CCP count, read-write access lock, and access functions
--- a/drivers/crypto/ccp/ccp-dev.h
+++ b/drivers/crypto/ccp/ccp-dev.h
@@ -632,7 +632,7 @@ struct ccp5_desc {
 void ccp_add_device(struct ccp_device *ccp);
 void ccp_del_device(struct ccp_device *ccp);
 
-extern void ccp_log_error(struct ccp_device *, int);
+extern void ccp_log_error(struct ccp_device *, unsigned int);
 
 struct ccp_device *ccp_alloc_struct(struct sp_device *sp);
 bool ccp_queues_suspended(struct ccp_device *ccp);


