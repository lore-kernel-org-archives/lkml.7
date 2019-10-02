Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8755D222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfJBTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:08:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35314 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729076AbfJBTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:09 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyo-00035y-Gh; Wed, 02 Oct 2019 20:08:06 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyn-0003cB-Rb; Wed, 02 Oct 2019 20:08:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Catalina Mocanu" <catalina.mocanu@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Wed, 02 Oct 2019 20:06:51 +0100
Message-ID: <lsq.1570043211.136218297@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 29/87] staging: iio: cdc: Don't put an else right
 after a return
In-Reply-To: <lsq.1570043210.379046399@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Catalina Mocanu <catalina.mocanu@gmail.com>

commit 288903f6b91e759b0a813219acd376426cbb8f14 upstream.

This fixes the following checkpatch.pl warning:
WARNING: else is not generally useful after a break or return.

While at it, remove new line for symmetry with the rest of the code.

Signed-off-by: Catalina Mocanu <catalina.mocanu@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/iio/cdc/ad7150.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -143,19 +143,15 @@ static int ad7150_read_event_config(stru
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
 			return adaptive && (threshtype == 0x1);
-		else
-			return adaptive && (threshtype == 0x0);
+		return adaptive && (threshtype == 0x0);
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
 			return adaptive && (threshtype == 0x3);
-		else
-			return adaptive && (threshtype == 0x2);
-
+		return adaptive && (threshtype == 0x2);
 	case IIO_EV_TYPE_THRESH:
 		if (dir == IIO_EV_DIR_RISING)
 			return !adaptive && (threshtype == 0x1);
-		else
-			return !adaptive && (threshtype == 0x0);
+		return !adaptive && (threshtype == 0x0);
 	default:
 		break;
 	}

