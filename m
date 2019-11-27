Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091CFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D435321741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887270;
	bh=KzaYq/ZxefBgTK1mWLIBUbunCDUrWNx+9I10MwP1UNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QwYu9WDIaVneYvvyLUHE28EsX6/8xFqu9byz5ZAJ3D/8DVtrRpOmZa/iSrTIXVFxK
	 XAm35Tuq9TyNzdpsO6K+82TDgzkpcH62qyXq1p7hW0SGrnvU++w6yk+i55RfAXCgSZ
	 /2SG02TK6JpE3DdvqjnOAk539eWCW9WRhdLhRSTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfK0UlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbfK0UlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:41:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC4B21774;
        Wed, 27 Nov 2019 20:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887266;
        bh=KzaYq/ZxefBgTK1mWLIBUbunCDUrWNx+9I10MwP1UNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTegwJmCsO+9cHgsw7k4Q23TxEWJxRWOx1GMx1sJoq7exy3OolIeXANOfzCb8pdAg
         8II74UbRAS7zseznDQfJHn0fsCqxXtW8rm1AYw79NUxboVygB1nTa/y46it98+v/3c
         TmvoYsK3DnWFfGcxymdSJOR4aCTj1E/4s6TXHF/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 044/151] usbip: tools: fix atoi() on non-null terminated string
Date:   Wed, 27 Nov 2019 21:30:27 +0100
Message-Id: <20191127203027.542833130@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



