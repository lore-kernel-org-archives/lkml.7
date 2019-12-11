Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F03C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBD72077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079735;
	bh=TM44OjMYG7+v7HfmjBTcpsYK475VNjtqcmI10Oq1gjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bM0j4iNQAnjPDblnhL3+E/jpetVW7NzNU+nmEucmz1O4Vj03fgsSPKWKmWawCa1fl
	 OMpGOSVftRKRu1n7dtP7E57S7EjjkU6aGN5anNqdWCk6eY8oMnLeSZ+TzlotuIKoGB
	 nM//kxL4j7yzGrhJxjy3p834E0Xk0xAiByZBBrb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfLKPP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731834AbfLKPPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:15:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6212208C3;
        Wed, 11 Dec 2019 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077349;
        bh=TM44OjMYG7+v7HfmjBTcpsYK475VNjtqcmI10Oq1gjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAFHnjJPDEbkYnqB8qy8rJt/fIueb5BbEzU6n/SFbp60vV+MGozEHzBDdYUrcuyAC
         kiFPGIyEQ6XwM3/kzlOC6Ms0miE4JJ7Yo9gp+kxFgoP1IWaYMR9HZEpB4QCGJ2w/GO
         EJ7yFqgWtxg44Kybhktblyldyz7PoIXsErXucxBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.3 092/105] crypto: user - fix memory leak in crypto_reportstat
Date:   Wed, 11 Dec 2019 16:06:21 +0100
Message-Id: <20191211150301.352600702@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit c03b04dcdba1da39903e23cc4d072abf8f68f2dd upstream.

In crypto_reportstat, a new skb is created by nlmsg_new(). This skb is
leaked if crypto_reportstat_alg() fails. Required release for skb is
added.

Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
Cc: <stable@vger.kernel.org>
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/crypto_user_stat.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -326,8 +326,10 @@ int crypto_reportstat(struct sk_buff *in
 drop_alg:
 	crypto_mod_put(alg);
 
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		return err;
+	}
 
 	return nlmsg_unicast(crypto_nlsk, skb, NETLINK_CB(in_skb).portid);
 }


