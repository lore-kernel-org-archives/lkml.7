Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B49721903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127111;
	bh=uvDQ7J1He+P4kMvTRiXCsL1gRFSKQTQJ4Sz5ob7YAug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M0tKkE5tLyvlxeJUHEKBBf59pqJqRxMAqhTeWeET4W1vOPdraCQmIrOo9nx4zd8A1
	 pN7sQJQ+jbwDrSiD4Uqdttmj9zMYwvUqo218v+4SPHB3OkjOmDnn60ODdEI20eybdK
	 uC9LShqHdgi6Q8TJlXE52hwhTtAx0jwLgtVoRIsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391277AbfDXRbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390475AbfDXRbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:46 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CFD2054F;
        Wed, 24 Apr 2019 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127106;
        bh=uvDQ7J1He+P4kMvTRiXCsL1gRFSKQTQJ4Sz5ob7YAug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwqqntwBzz4De/kUFcL98gFE08LKjWb6S89XUgKQpxbqyaeZeU55g0WOObV1CA9tw
         25Y02GGvutD5bOBR09bnMiigWwS7MUtmPMyDNVNqsYU7lTWA2fj8aQaMWSTVTzqIme
         +hK6gFKFDy7rglAjSFHinuhsUGpnK4jYaoCV22mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH 4.19 47/96] staging: most: core: use device description as name
Date:   Wed, 24 Apr 2019 19:09:52 +0200
Message-Id: <20190424170923.034658273@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gromm <christian.gromm@microchip.com>

commit 131ac62253dba79daf4a6d83ab12293d2b9863d3 upstream.

This patch uses the device description to clearly identity a device
attached to the bus. It is needed as the currently useed mdevX
notation is not sufficiant in case more than one network
interface controller is being used at the same time.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/most/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1412,7 +1412,7 @@ int most_register_interface(struct most_
 
 	INIT_LIST_HEAD(&iface->p->channel_list);
 	iface->p->dev_id = id;
-	snprintf(iface->p->name, STRING_SIZE, "mdev%d", id);
+	strcpy(iface->p->name, iface->description);
 	iface->dev.init_name = iface->p->name;
 	iface->dev.bus = &mc.bus;
 	iface->dev.parent = &mc.dev;


