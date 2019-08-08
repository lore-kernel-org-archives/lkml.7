Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681EBC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0FA2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291346;
	bh=QR/+RiJBu5Vz2MvmCgi2zdsjQkqaeIi+8tB8wySTYGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nwAxM53/ZylHbOK3SLRhC2nXX71iqHYalG9obvJHPU3Tur+KMKDU5QaO00/EOVUTk
	 ac4SWfbuq1Hm0QWXQSgiv6pSZsZw4EEDbVePlhx4mWbY8mzvC4Ha0Mg47sSZaziY95
	 snT/644830t791PYrI65cer7rnkgd2MbomG4PECY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405041AbfHHTJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405026AbfHHTJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:09:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4921021874;
        Thu,  8 Aug 2019 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291341;
        bh=QR/+RiJBu5Vz2MvmCgi2zdsjQkqaeIi+8tB8wySTYGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR4YxRrHwS1Pq4jktr/ZoW++qu2vU/PcElliuChecxxWMrgGW608jrHJENbehsySi
         Y2VJ01+x/YpuhhqY8aqoPuEm5meTBvprZiuyImZWql6i7RNJLcPM89K0qEeDwDJCOA
         6nuMmZOS72tyXBdGwsUa0B7oKB5ui9HW++upPgX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 09/45] HID: wacom: fix bit shift for Cintiq Companion 2
Date:   Thu,  8 Aug 2019 21:04:55 +0200
Message-Id: <20190808190454.290553805@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <skomra@gmail.com>

commit 693c3dab4e50403f91bca4b52fc6d8562a3180f6 upstream.

The bit indicating BTN_6 on this device is overshifted
by 2 bits, resulting in the incorrect button being
reported.

Also fix copy-paste mistake in comments.

Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Link: https://github.com/linuxwacom/xf86-input-wacom/issues/71
Fixes: c7f0522a1ad1 ("HID: wacom: Slim down wacom_intuos_pad processing")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -537,14 +537,14 @@ static int wacom_intuos_pad(struct wacom
 		 */
 		buttons = (data[4] << 1) | (data[3] & 0x01);
 	} else if (features->type == CINTIQ_COMPANION_2) {
-		/* d-pad right  -> data[4] & 0x10
-		 * d-pad up     -> data[4] & 0x20
-		 * d-pad left   -> data[4] & 0x40
-		 * d-pad down   -> data[4] & 0x80
-		 * d-pad center -> data[3] & 0x01
+		/* d-pad right  -> data[2] & 0x10
+		 * d-pad up     -> data[2] & 0x20
+		 * d-pad left   -> data[2] & 0x40
+		 * d-pad down   -> data[2] & 0x80
+		 * d-pad center -> data[1] & 0x01
 		 */
 		buttons = ((data[2] >> 4) << 7) |
-		          ((data[1] & 0x04) << 6) |
+		          ((data[1] & 0x04) << 4) |
 		          ((data[2] & 0x0F) << 2) |
 		          (data[1] & 0x03);
 	} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {


