Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE92077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079747;
	bh=XjHufn7v/xHJflkm4hdu11S4TsZSTicj+Ib/sir+U2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QlxFt/usNYgmbNMBy9xvotTx2yjcxTPN3FKOnn0RY1XBegjxiJXNIIPQU9LJyRZf/
	 zOsJblvFdXT/LToPzgnNOUl7t6/Vo1W1QijpnSQ7UTMaWjv3Vr33WJS8ncP+6j49UZ
	 hH4td31+F6Fjw2tstvN2J0MiLmmjdYrY/3/86BZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfLKPzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731823AbfLKPPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:15:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B562208C3;
        Wed, 11 Dec 2019 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077346;
        bh=XjHufn7v/xHJflkm4hdu11S4TsZSTicj+Ib/sir+U2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvLt5Nzuv9cNMtG2qGQATjEO49DnOWLeu9xrfMnlNNLbP8ZJlpRwr2Jpvi0XKHZ8a
         ysr2THqoGvUx4nH23OMBjHa6JxpRWmyvHpUomK7KzzH9nkYEG/o4PMmQPVnFDeaiC+
         cixR4LpdrKm9wf4Hi9GoVFhTBBS31MCHinaXKDHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.3 091/105] crypto: user - fix memory leak in crypto_report
Date:   Wed, 11 Dec 2019 16:06:20 +0100
Message-Id: <20191211150301.178958821@linuxfoundation.org>
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

commit ffdde5932042600c6807d46c1550b28b0db6a3bc upstream.

In crypto_report, a new skb is created via nlmsg_new(). This skb should
be released if crypto_report_alg() fails.

Fixes: a38f7907b926 ("crypto: Add userspace configuration API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/crypto_user_base.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/crypto_user_base.c
+++ b/crypto/crypto_user_base.c
@@ -214,8 +214,10 @@ static int crypto_report(struct sk_buff
 drop_alg:
 	crypto_mod_put(alg);
 
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		return err;
+	}
 
 	return nlmsg_unicast(crypto_nlsk, skb, NETLINK_CB(in_skb).portid);
 }


