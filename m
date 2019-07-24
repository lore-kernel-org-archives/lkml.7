Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB51322ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998156;
	bh=OgzOyEycRsQ5tZXTbgiVPzNADZxiQiXmkuy7t8sX45E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E71b5llm/XEQXNYLnH9xnYWyGmdbFm9JyIOAVZTdRvLbWYdLZfqk2uTPE2BjW9UZQ
	 Aks1/qqxSXFUEiKGcWAYlYja7Qwsoq9fRh7KiRbB+9/AF894XWsqBbMvcmyj+J88Ce
	 wyCEHdfnRB+lfxOZZ3zVftXHs2l4tpvXqa0sh830=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391782AbfGXTzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391743AbfGXTzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5421205C9;
        Wed, 24 Jul 2019 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998143;
        bh=OgzOyEycRsQ5tZXTbgiVPzNADZxiQiXmkuy7t8sX45E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgge97N5DnfMrzcxoPrLPXH5FvrB17Q6P1mTN/ZFsLcWhI+Tok5qojbrBmFA4Y+Il
         obbwEl/QXT2CPAsic7Cq5FCBBMF4FThVrcnyZNdrMJRf8vgu1UBbuSvywjLmhrUXhA
         63PWofvwHCxJeB2vq9fv9QMrMrs/FSIIdPyOYLSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grant Hernandez <granthernandez@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.1 262/371] Input: gtco - bounds check collection indent level
Date:   Wed, 24 Jul 2019 21:20:14 +0200
Message-Id: <20190724191744.165701375@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Hernandez <granthernandez@google.com>

commit 2a017fd82c5402b3c8df5e3d6e5165d9e6147dc1 upstream.

The GTCO tablet input driver configures itself from an HID report sent
via USB during the initial enumeration process. Some debugging messages
are generated during the parsing. A debugging message indentation
counter is not bounds checked, leading to the ability for a specially
crafted HID report to cause '-' and null bytes be written past the end
of the indentation array. As long as the kernel has CONFIG_DYNAMIC_DEBUG
enabled, this code will not be optimized out.  This was discovered
during code review after a previous syzkaller bug was found in this
driver.

Signed-off-by: Grant Hernandez <granthernandez@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/tablet/gtco.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -78,6 +78,7 @@ Scott Hill shill@gtcocalcomp.com
 
 /* Max size of a single report */
 #define REPORT_MAX_SIZE       10
+#define MAX_COLLECTION_LEVELS  10
 
 
 /* Bitmask whether pen is in range */
@@ -223,8 +224,7 @@ static void parse_hid_report_descriptor(
 	char  maintype = 'x';
 	char  globtype[12];
 	int   indent = 0;
-	char  indentstr[10] = "";
-
+	char  indentstr[MAX_COLLECTION_LEVELS + 1] = { 0 };
 
 	dev_dbg(ddev, "======>>>>>>PARSE<<<<<<======\n");
 
@@ -350,6 +350,13 @@ static void parse_hid_report_descriptor(
 			case TAG_MAIN_COL_START:
 				maintype = 'S';
 
+				if (indent == MAX_COLLECTION_LEVELS) {
+					dev_err(ddev, "Collection level %d would exceed limit of %d\n",
+						indent + 1,
+						MAX_COLLECTION_LEVELS);
+					break;
+				}
+
 				if (data == 0) {
 					dev_dbg(ddev, "======>>>>>> Physical\n");
 					strcpy(globtype, "Physical");
@@ -369,8 +376,15 @@ static void parse_hid_report_descriptor(
 				break;
 
 			case TAG_MAIN_COL_END:
-				dev_dbg(ddev, "<<<<<<======\n");
 				maintype = 'E';
+
+				if (indent == 0) {
+					dev_err(ddev, "Collection level already at zero\n");
+					break;
+				}
+
+				dev_dbg(ddev, "<<<<<<======\n");
+
 				indent--;
 				for (x = 0; x < indent; x++)
 					indentstr[x] = '-';


