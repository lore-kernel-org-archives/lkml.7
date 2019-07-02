Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583E9C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284F42064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054941;
	bh=7+KiisQO44b+0B8ltKPR+aTQjmKfAoUAKi7Tw5GLKvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gv9tWomM8R8FoTF+H8tXuRj8Xef8pss3FCPnvCP2NkZbHD0TAe9mJt6jAZoq3yt5W
	 3EJJ9VyVTxQSSo1/xaIxsfIKAbW/LwBOyJ4g2F1hneYWWTrafti45yw95rQHiuCvng
	 HDwgxaVwZG89eC04l7n1pA9K2wxRDR94+TN+B89g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGBIJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfGBII6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C69E21841;
        Tue,  2 Jul 2019 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054937;
        bh=7+KiisQO44b+0B8ltKPR+aTQjmKfAoUAKi7Tw5GLKvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlqcGE3RbyhQPUqLQ51WP4icD+QumADN1k7L+rCIvom7YmSI3AfmpcnWvlUuEzIGa
         lmHI+vwEN9mH4hoxoK3bJZ56dK/GMAFPO6GCVs2kRRFxFwl6lmgqbKSaxrXQtnuo2t
         bQoUff10e7rgI84DGh6UmiiHsfqt3lpfzuwOBxLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/43] 9p: p9dirent_read: check network-provided name length
Date:   Tue,  2 Jul 2019 10:01:52 +0200
Message-Id: <20190702080124.447367850@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ef5305f1f72eb1cfcda25c382bb0368509c0385b ]

strcpy to dirent->d_name could overflow the buffer, use strscpy to check
the provided string length and error out if the size was too big.

While we are here, make the function return an error when the pdu
parsing failed, instead of returning the pdu offset as if it had been a
success...

Link: http://lkml.kernel.org/r/1536339057-21974-4-git-send-email-asmadeus@codewreck.org
Addresses-Coverity-ID: 139133 ("Copy into fixed size buffer")
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 766d1ef4640a..1885403c9a3e 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -622,13 +622,19 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 	if (ret) {
 		p9_debug(P9_DEBUG_9P, "<<< p9dirent_read failed: %d\n", ret);
 		trace_9p_protocol_dump(clnt, &fake_pdu);
-		goto out;
+		return ret;
 	}
 
-	strcpy(dirent->d_name, nameptr);
+	ret = strscpy(dirent->d_name, nameptr, sizeof(dirent->d_name));
+	if (ret < 0) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "On the wire dirent name too long: %s\n",
+			 nameptr);
+		kfree(nameptr);
+		return ret;
+	}
 	kfree(nameptr);
 
-out:
 	return fake_pdu.offset;
 }
 EXPORT_SYMBOL(p9dirent_read);
-- 
2.20.1



