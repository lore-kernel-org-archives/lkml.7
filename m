Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C18C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600D224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5PMBtxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfI3Umk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:42:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46433 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfI3Umj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:42:39 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so41817108ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KWTH9RQWAwgqAE8mTADMNkSdUpgrcvjdoE7K2RsU6wA=;
        b=e5PMBtxFilz/D0V//+TdmtLnY3XB7td2pd0d4/rF0mRGhMB0tLHh+PjD16jk3NlSp5
         l/CRpTZCsozkonNGNBKwcQAX9BRQss9XMK4Q3WXDWvAR9rN5Gs9aYABC7/uux289ZYgA
         ZylsWkWrSfEX9liAyQ8Nq4H2dUN8dIs/TNgwliYA7zcDfdeInaCMhIGmMcg/exkaNriG
         5IZVYXB/MKOqO/SInCtfSfHBESdZ/wI3RVgJJtvbXkMEHW/REqQYIykzofhZJaboELwN
         ZDoECHBmWZWjNIY7mvKn4hucEGpkSJmHOhX7Meiu2OIgBl01eBVwghNZXMoAGfqyCif/
         KLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KWTH9RQWAwgqAE8mTADMNkSdUpgrcvjdoE7K2RsU6wA=;
        b=j9u5oPPl9j5cVNCgxKF43gzsxniUPmXZw2XvKZJS8PdbB2T8dy54oiM9ArDWB8MBxE
         ZoQk5bwud4VfnYFSeQ/maYgU/HFQyL1LwnvKb4/X3wi6f4B1l2XE7h2qUhEgIOlh/zsc
         v+3rZlxoerV6VYwVm+AcGLi4ogcQHEBhFwmtCKYQNMf9HNbHux909Oygn4xFSHrEPHcG
         A1Cc8X+Ze+57ne6iQhUbpfgChP5ByKVBsBWr5tTfjfbuqg8eIq0srfQ8f5bbnn84p6P/
         BdynascJ8+TIzKhzUst8vHj9R0+TbTx8/KASpimO4cT+Q3RSPTyTKU7PUgvnIQXws9/p
         I2UA==
X-Gm-Message-State: APjAAAVZEjh//vnR2YP75F+31LJ0mIpnb7A49YHA0oQzfJtZkiK4Jc6B
        xGnMj11Dn8xDNHAE5sxC/30=
X-Google-Smtp-Source: APXvYqwDg0GcDXvOBELidr7GWUuBx//IQgunC73Mdby23owP5CQs0PklzLdJY58qT8lpv73O66X0Gg==
X-Received: by 2002:a05:6e02:550:: with SMTP id i16mr21456043ils.214.1569876159323;
        Mon, 30 Sep 2019 13:42:39 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s11sm5858042ioc.79.2019.09.30.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:42:38 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     hdegoede@redhat.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr
Date:   Mon, 30 Sep 2019 15:42:22 -0500
Message-Id: <20190930204223.3660-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <664aab6a-37c9-7239-a817-25dfbab00c7f@redhat.com>
References: <664aab6a-37c9-7239-a817-25dfbab00c7f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
is not released if copy_form_user fails. In order to prevent memory leak
in case of failure, the assignment to bounce_buf_ret is moved before the
error check. This way the allocated bounce_buf will be released by the
caller.

Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/virt/vboxguest/vboxguest_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 75fd140b02ff..43c391626a00 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -220,6 +220,8 @@ static int hgcm_call_preprocess_linaddr(
 	if (!bounce_buf)
 		return -ENOMEM;
 
+	*bounce_buf_ret = bounce_buf;
+
 	if (copy_in) {
 		ret = copy_from_user(bounce_buf, (void __user *)buf, len);
 		if (ret)
@@ -228,7 +230,6 @@ static int hgcm_call_preprocess_linaddr(
 		memset(bounce_buf, 0, len);
 	}
 
-	*bounce_buf_ret = bounce_buf;
 	hgcm_call_add_pagelist_size(bounce_buf, len, extra);
 	return 0;
 }
-- 
2.17.1

