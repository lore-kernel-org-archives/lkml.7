Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09008C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF94C21920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787716;
	bh=DCZpPlUJvO02+/84vmNnzWGmWzu8Iw6c6m/EQLN8y4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ww0F2PSJfMbYRDyiKvv4VSglN/bBjeIylXBgTUaIfIQQhrZ8jyggBUNKeQwS8h7sW
	 902he0f5idj6LcCSU0R8sMV0R9Ot0Tm6vc/R3hN2gSQ0SiMiHsitrfZ9ft1O0gCFRC
	 bscjicQ1e7H3hq0hZroz72gsF9zf7IW0444apFWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfIRGVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbfIRGVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179CB21924;
        Wed, 18 Sep 2019 06:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787712;
        bh=DCZpPlUJvO02+/84vmNnzWGmWzu8Iw6c6m/EQLN8y4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7syd94LOnt7WUx1AZNKAoHwbfV9GY4MVuYaIktdsuY0IjBpWT614n+9jZCqt0Aqq
         gvIboP2I4HBTEY6o0x57w9Xzx6Om4PWNgxclqDtViuy5VqblvTRAReFGzlJQcJNzKb
         ++2xEiCgaF5pyzWVRFH5qYin7VLb39N/3+EObc54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 44/45] nvmem: Use the same permissions for eeprom as for nvmem
Date:   Wed, 18 Sep 2019 08:19:22 +0200
Message-Id: <20190918061228.156623946@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>

commit e70d8b287301eb6d7c7761c6171c56af62110ea3 upstream.

The compatibility "eeprom" attribute is currently root-only no
matter what the configuration says. The "nvmem" attribute does
respect the setting of the root_only configuration bit, so do the
same for "eeprom".

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: b6c217ab9be6 ("nvmem: Add backwards compatibility support for older EEPROM drivers.")
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20190728184255.563332e6@endymion
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvmem/core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -407,10 +407,17 @@ static int nvmem_setup_compat(struct nvm
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (nvmem->read_only)
-		nvmem->eeprom = bin_attr_ro_root_nvmem;
-	else
-		nvmem->eeprom = bin_attr_rw_root_nvmem;
+	if (nvmem->read_only) {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_ro_root_nvmem;
+		else
+			nvmem->eeprom = bin_attr_ro_nvmem;
+	} else {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_rw_root_nvmem;
+		else
+			nvmem->eeprom = bin_attr_rw_nvmem;
+	}
 	nvmem->eeprom.attr.name = "eeprom";
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC


