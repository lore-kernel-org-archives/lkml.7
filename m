Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5483C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7617021670
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806410;
	bh=QKdJ5JSiilDuojvUedJrJMd7Km5HZo8Bo7krkXaevPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jxkNnl7ndtn1hdxC/CFeCUAZPE7L8qnHVM+0ZK2azKEZyR+eWDnY18VwSpFs/e9uI
	 15G0sWPa4FYUo+XqIUUI8y1a+9K6g4FAir4F++3fyhnrD4l1tu5unn40ianttzwCXP
	 DYlVu+tFmVi+/B9dU7S+qvKa2D/usaleUJDs+l4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfFQVUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfFQVUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:20:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D532089E;
        Mon, 17 Jun 2019 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806406;
        bh=QKdJ5JSiilDuojvUedJrJMd7Km5HZo8Bo7krkXaevPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZN/IxO3M5Om7/B2c60l54gFDoSF2QkSQWB/qgfxVVjS5dTzCDkK/1jHQ950ryntL
         yC5zwZL+LjqyhoB3EhA9/N/Fir3P0iRMOo+eyLdRJZGc4XzISnkwO9Phxy0YCpPb9O
         h8kjwM8wYgGJWstrP9c8aTe4HixmEtup8zAWlzys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5.1 004/115] HID: input: fix assignment of .value
Date:   Mon, 17 Jun 2019 23:08:24 +0200
Message-Id: <20190617210800.141354191@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 39b3c3a5fbc5d744114e497d35bf0c12f798c134 upstream.

The value field is actually an array of .maxfield. We should assign the
correct number to the correct usage.

Not that we never encounter a device that requires this ATM, but better
have the proper code path.

Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for
       high-resolution scrolling")
Cc: stable@vger.kernel.org  # v5.0+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1595,7 +1595,7 @@ static bool __hidinput_change_resolution
 			if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
 				continue;
 
-			*report->field[i]->value = value;
+			report->field[i]->value[j] = value;
 			update_needed = true;
 		}
 	}


