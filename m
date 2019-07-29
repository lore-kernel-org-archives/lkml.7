Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E768C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16B9217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428714;
	bh=wplSXBTVma7MrVFbXRm589LGQUK/dpHSK1of8vGYDL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=beZ5tqsVy41ILPUKykkjpA2bRW2XHgyk063JJVq5zguZJcdSgu+EFA/d5hvhU1KJO
	 q+7oyAE5EZi0fptzKl8lZqu49bVfKMJwngEZ+VR34vdzVAuuPDdHI/wnfezCZQGwuC
	 K8GyGEcH6cQc13/dxHRZt6nSt1I/TSujNfVbEerI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfG2Tbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbfG2Tbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:31:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E5121773;
        Mon, 29 Jul 2019 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428704;
        bh=wplSXBTVma7MrVFbXRm589LGQUK/dpHSK1of8vGYDL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdGxoyoDtj0jhs5myYQ8UMiGp4iBZ/IY9Azf4lEkYDCX0WXKKioGWHOhKFINN5xS9
         H/3h3yOfxwhAidxvBvHFarWPQb0gbqsvbuaOqHn7b+xD+Q9Da0uvDF1t8I4EpTvCbY
         X2DM7CZl4O5dcHtmFDtdyxhVwRhObAtvOsL+KHBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 161/293] HID: wacom: correct touch resolution x/y typo
Date:   Mon, 29 Jul 2019 21:20:52 +0200
Message-Id: <20190729190836.885421469@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <skomra@gmail.com>

commit 68c20cc2164cc5c7c73f8012ae6491afdb1f7f72 upstream.

This affects the 2nd-gen Intuos Pro Medium and Large
when using their Bluetooth connection.

Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3550,7 +3550,7 @@ int wacom_setup_touch_input_capabilities
 					     0, 5920, 4, 0);
 		}
 		input_abs_set_res(input_dev, ABS_MT_POSITION_X, 40);
-		input_abs_set_res(input_dev, ABS_MT_POSITION_X, 40);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_Y, 40);
 
 		/* fall through */
 


