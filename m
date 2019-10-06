Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A88CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509662077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384998;
	bh=Oqfmo4XaG8wZDKY/gBAMCLXD+TvETva4MCUu/fq0kXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qGASDMXEcq59w/bhf9qjyp1wJ7/EmeR5Kj+wRUIZOtpr2ttJSpolE9vbqdcDxua6Q
	 kmiHXFegPmFqvBnseEeGh8mxq7DOIWMF1I/pAXpwvTrvIf+SWT+cTEyLWd8VRSHWiK
	 2q7dorEotwDMFo3SdaJzo+KCLKMdfq5eS55BONP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJFRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfJFRYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:24:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B2D2087E;
        Sun,  6 Oct 2019 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382675;
        bh=Oqfmo4XaG8wZDKY/gBAMCLXD+TvETva4MCUu/fq0kXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxBBRi6e6trZcQYG9Z61FvOwSnJZNPW14z+/Divnf8azgrgbH0obnpYzsYryOcRvM
         SDj643m0YlPcoXmaHFDb0ztmAP+2LrQQAXo9qxK/3JfPMES7SuDl3nDbXHmA15ySQh
         pT1z6bdu0BT/yIMYN8vzfdGWlS6P53EjlCx0NYng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 47/47] NFC: fix attrs checks in netlink interface
Date:   Sun,  6 Oct 2019 19:21:34 +0200
Message-Id: <20191006172019.364029870@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006172016.873463083@linuxfoundation.org>
References: <20191006172016.873463083@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

commit 18917d51472fe3b126a3a8f756c6b18085eb8130 upstream.

nfc_genl_deactivate_target() relies on the NFC_ATTR_TARGET_INDEX
attribute being present, but doesn't check whether it is actually
provided by the user. Same goes for nfc_genl_fw_download() and
NFC_ATTR_FIRMWARE_NAME.

This patch adds appropriate checks.

Found with syzkaller.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/nfc/netlink.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -973,7 +973,8 @@ static int nfc_genl_dep_link_down(struct
 	int rc;
 	u32 idx;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
+	    !info->attrs[NFC_ATTR_TARGET_INDEX])
 		return -EINVAL;
 
 	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
@@ -1022,7 +1023,8 @@ static int nfc_genl_llc_get_params(struc
 	struct sk_buff *msg = NULL;
 	u32 idx;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
+	    !info->attrs[NFC_ATTR_FIRMWARE_NAME])
 		return -EINVAL;
 
 	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);


