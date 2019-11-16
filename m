Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89897C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5974B2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919321;
	bh=KzaYq/ZxefBgTK1mWLIBUbunCDUrWNx+9I10MwP1UNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MakHEzSZFeL/w9pLcyPYNuropHeZsv7qVPGpUFKmRwUkaGRGC+zBkNfqSpGF1DZ/N
	 mTv6kxvJTAxEplZvn4aXi6kLUtTI3EtgamdwB607jMHfzcdZlsKlHOPxm9Y0wob6gU
	 ucmWSsUW1G4WQkMKmIM/xguEDqI4Jwfv/hUEi97A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfKPPsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbfKPPs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:29 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F511207FA;
        Sat, 16 Nov 2019 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919308;
        bh=KzaYq/ZxefBgTK1mWLIBUbunCDUrWNx+9I10MwP1UNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSxvpbz9hBBcVpARK0ayyIqJwwhlQenSsa82/mWHkijnEwL7nG7VgFHAbruoxsu1y
         +tO4shHVp+OUSmijF3VOUcKiZYdLsgQF2Cqyn8l0uJMm7VhmOqof8nQ8klB7OUXBms
         T0TwTSBCVzAKyqzF21rsZ7FQVjhq5OChJ6jYROiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 051/150] usbip: tools: fix atoi() on non-null terminated string
Date:   Sat, 16 Nov 2019 10:45:49 -0500
Message-Id: <20191116154729.9573-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit e325808c0051b16729ffd472ff887c6cae5c6317 ]

Currently the call to atoi is being passed a single char string
that is not null terminated, so there is a potential read overrun
along the stack when parsing for an integer value.  Fix this by
instead using a 2 char string that is initialized to all zeros
to ensure that a 1 char read into the string is always terminated
with a \0.

Detected by cppcheck:
"Invalid atoi() argument nr 1. A nul-terminated string is required."

Fixes: 3391ba0e2792 ("usbip: tools: Extract generic code to be shared with vudc backend")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/usb/usbip/libsrc/usbip_host_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
index 6ff7b601f8545..f5ad219a324e8 100644
--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -43,7 +43,7 @@ static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
 	int size;
 	int fd;
 	int length;
-	char status;
+	char status[2] = { 0 };
 	int value = 0;
 
 	size = snprintf(status_attr_path, sizeof(status_attr_path),
@@ -61,14 +61,14 @@ static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
 		return -1;
 	}
 
-	length = read(fd, &status, 1);
+	length = read(fd, status, 1);
 	if (length < 0) {
 		err("error reading attribute %s", status_attr_path);
 		close(fd);
 		return -1;
 	}
 
-	value = atoi(&status);
+	value = atoi(status);
 
 	return value;
 }
-- 
2.20.1

