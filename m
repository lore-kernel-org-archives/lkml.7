Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B44217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892636;
	bh=SQhY+TpsZ2oEYPOt8K5AAC0iYYzjOFc5UyErPw4oMUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4iu2g2q7b+Wa12Sy2zp4+WzVV64/R2dq6hw0tX4NLI2EqNspp+LaSWlVanwNxkcS
	 9C5R7PO/0xCS/isEJ7BCkNsEyR+14Fvin9Dn7FJ3ccD1BowXDnaFAS//AScYEqEsnJ
	 6+GVVUJpnh9Tqnu6wjDp0CS6fCqjb0tHzWyctAHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfH0H5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfH0H5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9161E206BA;
        Tue, 27 Aug 2019 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892630;
        bh=SQhY+TpsZ2oEYPOt8K5AAC0iYYzjOFc5UyErPw4oMUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAvXCMqEbPzvJJaI9aBaqDZ67XGMajslTqa6a3sobk+iMSognSpGbkbYDnerdFuCf
         n/FCwUmZso1yiZVkhVlDxJL1aNgD+AsPwLbRb+eaSLd1KNBADWsXgw0zHlhYZDpUx5
         7Ow10a6SVzHyt1Hyttv5VOK37mYaj/tGeuuqYNvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 60/98] HID: wacom: Correct distance scale for 2nd-gen Intuos devices
Date:   Tue, 27 Aug 2019 09:50:39 +0200
Message-Id: <20190827072721.460166857@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

commit b72fb1dcd2ea9d29417711cb302cef3006fa8d5a upstream.

Distance values reported by 2nd-gen Intuos tablets are on an inverted
scale (0 == far, 63 == near). We need to change them over to a normal
scale before reporting to userspace or else userspace drivers and
applications can get confused.

Ref: https://github.com/linuxwacom/input-wacom/issues/98
Fixes: eda01dab53 ("HID: wacom: Add four new Intuos devices")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -848,6 +848,8 @@ static int wacom_intuos_general(struct w
 		y >>= 1;
 		distance >>= 1;
 	}
+	if (features->type == INTUOSHT2)
+		distance = features->distance_max - distance;
 	input_report_abs(input, ABS_X, x);
 	input_report_abs(input, ABS_Y, y);
 	input_report_abs(input, ABS_DISTANCE, distance);


