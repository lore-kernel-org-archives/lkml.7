Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897B9206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098987;
	bh=ywlPNhe9q6s7xmSEoV4kIeU8IFY4qdBlUrpk7UcgrWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ux8FzeWpt6P56mSAUudbkUNAlNCalO3hC7XxCRGNuJVIG2i5AazCYe+GnehpRkhKb
	 v0ioN/TxLPq1zSjaSdtCn2auBJ7EstkxKhG9lDiIu1w2TtxKiLvQHi6bQNGxamtq6F
	 IygbLO0j6ryUY2A5vwU+LGGtNW+Gjo1KlNQruKAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfFIQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731562AbfFIQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:49:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833922070B;
        Sun,  9 Jun 2019 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098985;
        bh=ywlPNhe9q6s7xmSEoV4kIeU8IFY4qdBlUrpk7UcgrWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oo3gHVpeN9E58Ffe4iH8ueGzAoMlFDV4HgQ1ng7+7wxKuFMVfp3GKk3Utv8DrJsro
         TLcZ6NuIvbjmtTgZrfHLruhy8H7C6+gRnP61sTZW6w7vSRob2OcPu+w5njpc0/9Bed
         HI0Mo2OAdMVYoK3Grc1/PJAZEDplZbrzdBdZ14QM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.19 36/51] test_firmware: Use correct snprintf() limit
Date:   Sun,  9 Jun 2019 18:42:17 +0200
Message-Id: <20190609164129.496329390@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit bd17cc5a20ae9aaa3ed775f360b75ff93cd66a1d upstream.

The limit here is supposed to be how much of the page is left, but it's
just using PAGE_SIZE as the limit.

The other thing to remember is that snprintf() returns the number of
bytes which would have been copied if we had had enough room.  So that
means that if we run out of space then this code would end up passing a
negative value as the limit and the kernel would print an error message.
I have change the code to use scnprintf() which returns the number of
bytes that were successfully printed (not counting the NUL terminator).

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_firmware.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -223,30 +223,30 @@ static ssize_t config_show(struct device
 
 	mutex_lock(&test_fw_mutex);
 
-	len += snprintf(buf, PAGE_SIZE,
+	len += scnprintf(buf, PAGE_SIZE - len,
 			"Custom trigger configuration for: %s\n",
 			dev_name(dev));
 
 	if (test_fw_config->name)
-		len += snprintf(buf+len, PAGE_SIZE,
+		len += scnprintf(buf+len, PAGE_SIZE - len,
 				"name:\t%s\n",
 				test_fw_config->name);
 	else
-		len += snprintf(buf+len, PAGE_SIZE,
+		len += scnprintf(buf+len, PAGE_SIZE - len,
 				"name:\tEMTPY\n");
 
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"num_requests:\t%u\n", test_fw_config->num_requests);
 
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"send_uevent:\t\t%s\n",
 			test_fw_config->send_uevent ?
 			"FW_ACTION_HOTPLUG" :
 			"FW_ACTION_NOHOTPLUG");
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 
 	mutex_unlock(&test_fw_mutex);


