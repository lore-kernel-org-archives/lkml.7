Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A39FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDC7207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264481;
	bh=v7jPuxTaNfvQo0RFwf9rffYtA8ruCixICaVy6ahYeyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QObI1JjGvzuPdNRB4pMvPGPZEBR/FkDZI8QUCv+omQJRpAhaSD3YcB3MU8MUfCeR2
	 76apHt6EFnarrsnO1XqdOhLfq8lHp/369UcvYirvE1LSG0o16px7+gzhopSdzWSAg/
	 x6H5H4x3pSZahu88oXA+7tz2miM18VclTvFtxLrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407577AbfJPWVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437553AbfJPVxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:37 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C892421928;
        Wed, 16 Oct 2019 21:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262816;
        bh=v7jPuxTaNfvQo0RFwf9rffYtA8ruCixICaVy6ahYeyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YChsu2yjM9HQQBGt+azCFzIccNov5O4W6HqtEyAluPtr+gA9pvE9zDWhmpamTki70
         OOTx0n/asr6Cvf6OLL+qcrkY50jrm4j5bhjObh5yKtz4rX9yDAo6S53AU7bue14Jmm
         yCYCtN8ym5iJN7aZS9BbpJSEvBXi3focg3fx8UuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 59/79] USB: legousbtower: fix slab info leak at probe
Date:   Wed, 16 Oct 2019 14:50:34 -0700
Message-Id: <20191016214822.137161555@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 1d427be4a39defadda6dd8f4659bc17f7591740f upstream.

Make sure to check for short transfers when retrieving the version
information at probe to avoid leaking uninitialised slab data when
logging it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20190919083039.30898-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/legousbtower.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -923,8 +923,10 @@ static int tower_probe (struct usb_inter
 				  get_version_reply,
 				  sizeof(*get_version_reply),
 				  1000);
-	if (result < 0) {
-		dev_err(idev, "LEGO USB Tower get version control request failed\n");
+	if (result < sizeof(*get_version_reply)) {
+		if (result >= 0)
+			result = -EIO;
+		dev_err(idev, "get version request failed: %d\n", result);
 		retval = result;
 		goto error;
 	}


