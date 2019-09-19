Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A21C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895D421920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932495;
	bh=lQYj4NUXHSkeIRtL2lZVGzZ2tZyvwgqLTUTTjnchcWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1PlpoNYeDBtdwqmmCY6mOk/FKw9g7xofgJK+s9ElNArAGnktPeiz/vsAlzUH8lXE
	 1VYcdOdCML8Bpk7wq/ZoSGOlbZHgzbwdBBMcquHMw5UzODcxfZcqQa7EARDJF13PRK
	 w3xmV/lbbSnlVFncuPYUq4MM0yVlPWyxxwUFTP0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394415AbfISWex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405429AbfISWJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:09:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E880221928;
        Thu, 19 Sep 2019 22:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930969;
        bh=lQYj4NUXHSkeIRtL2lZVGzZ2tZyvwgqLTUTTjnchcWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c30OzBzbBzJsIbKqN1iFffRxUnmbGuOeHE3v8nUEX7IgYQzfbt3nm59v/yCxk/XKa
         ODIVHC+0G1igSqUxMTvuIjweOyYnm+NE8Whz2pb4/qnB88qiCb2ijWgfluUPXwTt4K
         DurdW+MqqU9NnQI96My+Vz5dDuDUPBu5naaVdqFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 081/124] libceph: dont call crypto_free_sync_skcipher() on a NULL tfm
Date:   Fri, 20 Sep 2019 00:02:49 +0200
Message-Id: <20190919214821.960015249@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit e8c99200b4d117c340c392ebd5e62d85dfeed027 ]

In set_secret(), key->tfm is assigned to NULL on line 55, and then
ceph_crypto_key_destroy(key) is executed.

ceph_crypto_key_destroy(key)
  crypto_free_sync_skcipher(key->tfm)
    crypto_free_skcipher(&tfm->base);

This happens to work because crypto_sync_skcipher is a trivial wrapper
around crypto_skcipher: &tfm->base is still 0 and crypto_free_skcipher()
handles that.  Let's not rely on the layout of crypto_sync_skcipher.

This bug is found by a static analysis tool STCheck written by us.

Fixes: 69d6302b65a8 ("libceph: Remove VLA usage of skcipher").
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 5d6724cee38f9..4f75df40fb121 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -136,8 +136,10 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 	if (key) {
 		kfree(key->key);
 		key->key = NULL;
-		crypto_free_sync_skcipher(key->tfm);
-		key->tfm = NULL;
+		if (key->tfm) {
+			crypto_free_sync_skcipher(key->tfm);
+			key->tfm = NULL;
+		}
 	}
 }
 
-- 
2.20.1



