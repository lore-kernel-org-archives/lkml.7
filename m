Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BC020665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521581;
	bh=qz4e+jMLzi0AUc7pzJTJEPsDGMBbCsc1pllEvhhsMdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U08EEEVWKxTuS0TGdnHxP/9LONItTz3bDBaqJRZUKMgseUj4SQBU/SeN/cNDcVANR
	 M/7PSQlXvwlU7vfaZMIHX/gRANpKgb+NxMFhUnediSluZup+5Rg/9UtbLHQ5KncNRa
	 XXeuRPGCne9FAqNWJdmUk1FzxBcOEVWEfYlJpwMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfLPSjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbfLPSD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36292072D;
        Mon, 16 Dec 2019 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519409;
        bh=qz4e+jMLzi0AUc7pzJTJEPsDGMBbCsc1pllEvhhsMdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG+JryCIzOpU+O/FcVg4tfiLWHreDY4YzeMm8fHLFIz3czjpRyI0RpzYZjl6YZkWZ
         uvsNcfh+txcTSkw7mr6jYtdQz3HXvbnl4QRcolCLKWcHr2ZxFTtLvRTDWXIwZJ3TsC
         kGqOh+EmXlCuTpNtEb+dttDL6fw2moaSLBkZ0Kac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.19 007/140] USB: documentation: flags on usb-storage versus UAS
Date:   Mon, 16 Dec 2019 18:47:55 +0100
Message-Id: <20191216174750.251932194@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 65cc8bf99349f651a0a2cee69333525fe581f306 upstream.

Document which flags work storage, UAS or both

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191114112758.32747-4-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/kernel-parameters.txt |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4941,13 +4941,13 @@
 			Flags is a set of characters, each corresponding
 			to a common usb-storage quirk flag as follows:
 				a = SANE_SENSE (collect more than 18 bytes
-					of sense data);
+					of sense data, not on uas);
 				b = BAD_SENSE (don't collect more than 18
-					bytes of sense data);
+					bytes of sense data, not on uas);
 				c = FIX_CAPACITY (decrease the reported
 					device capacity by one sector);
 				d = NO_READ_DISC_INFO (don't use
-					READ_DISC_INFO command);
+					READ_DISC_INFO command, not on uas);
 				e = NO_READ_CAPACITY_16 (don't use
 					READ_CAPACITY_16 command);
 				f = NO_REPORT_OPCODES (don't use report opcodes
@@ -4962,17 +4962,18 @@
 				j = NO_REPORT_LUNS (don't use report luns
 					command, uas only);
 				l = NOT_LOCKABLE (don't try to lock and
-					unlock ejectable media);
+					unlock ejectable media, not on uas);
 				m = MAX_SECTORS_64 (don't transfer more
-					than 64 sectors = 32 KB at a time);
+					than 64 sectors = 32 KB at a time,
+					not on uas);
 				n = INITIAL_READ10 (force a retry of the
-					initial READ(10) command);
+					initial READ(10) command, not on uas);
 				o = CAPACITY_OK (accept the capacity
-					reported by the device);
+					reported by the device, not on uas);
 				p = WRITE_CACHE (the device cache is ON
-					by default);
+					by default, not on uas);
 				r = IGNORE_RESIDUE (the device reports
-					bogus residue values);
+					bogus residue values, not on uas);
 				s = SINGLE_LUN (the device has only one
 					Logical Unit);
 				t = NO_ATA_1X (don't allow ATA(12) and ATA(16)
@@ -4981,7 +4982,8 @@
 				w = NO_WP_DETECT (don't test whether the
 					medium is write-protected).
 				y = ALWAYS_SYNC (issue a SYNCHRONIZE_CACHE
-					even if the device claims no cache)
+					even if the device claims no cache,
+					not on uas)
 			Example: quirks=0419:aaf5:rl,0421:0433:rc
 
 	user_debug=	[KNL,ARM]


