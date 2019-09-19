Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C881FC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADA920678
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931484;
	bh=XoWVh8zkxqQBH7vyK96N6HQzgw676k1kvoxSzDKHeGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggEfaRQYn2URwBhOGIplUlTFkIdGomrhmrhGvDin8TwhA3dX3/Y4f+qmdm/YayfUi
	 Fno0lGwZN1z+wdsyWIg0iPyixmGcgxC7Scc9fhOiYIMP//JcTDVdcjeqOeGdH1IzbJ
	 1vqpFjUz0JMDfHlEaj6oV9e8xsARI0F5fcFxamKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406560AbfISWSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404681AbfISWSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:18:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA3E21924;
        Thu, 19 Sep 2019 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931479;
        bh=XoWVh8zkxqQBH7vyK96N6HQzgw676k1kvoxSzDKHeGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ik+2BtCYHFsjS9srJRcR/5qMdnb/MSNG9Tt6DZ2vvvfj6O7Uxu7ZaKjJxHIi0kE4g
         351V0jy7C/cCroMm/CoOu14efRsv7PVDb4qbUP6KnawX1LOC1ZLu3gSduXjt25Q0lP
         FKdGjLFv2ElDyFbJGFC9POHJ5WNeqJPhm26Dj+80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/59] cifs: Use kzfree() to zero out the password
Date:   Fri, 20 Sep 2019 00:03:51 +0200
Message-Id: <20190919214806.407908148@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 478228e57f81f6cb60798d54fc02a74ea7dd267e ]

It's safer to zero out the password so that it can never be disclosed.

Fixes: 0c219f5799c7 ("cifs: set domainName when a domain-key is used in multiuser")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 699e763ea671a..f523a9ca9574f 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2662,7 +2662,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 			rc = -ENOMEM;
 			kfree(vol->username);
 			vol->username = NULL;
-			kfree(vol->password);
+			kzfree(vol->password);
 			vol->password = NULL;
 			goto out_key_put;
 		}
-- 
2.20.1



