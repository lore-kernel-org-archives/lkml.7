Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E37CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC7921655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498429;
	bh=fTe0sWGieUceWBrafPRzW6k4Ncx8Yx+Bp4XVbSvzTwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHyJ2LAC08eaQEs0C6uwc2s9h7a/C/6qt47efh0j9NnPJQ1pETh9syQU22EWl1yZR
	 P92SS1pEs1EA1f3vuCq++ElInGxn5kPMooVUrDOzK3NkTzpqOJULpMpBfcObZigxMX
	 MhU0e5atgoHt9EJElKnAdvdrbM0nnK9mVGTX5yLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfKKSxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfKKSxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:53:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BF3520818;
        Mon, 11 Nov 2019 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498423;
        bh=fTe0sWGieUceWBrafPRzW6k4Ncx8Yx+Bp4XVbSvzTwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XIj8hpE0yHSkqwbwCqgiujGTU0ctZoJnO4HDRI8MoDmtk1j7Ko0z8UebdFx/f0Fz
         Arv2f9eh6I+d5WrlW9to/tpNIQt4SmeFdqWYYa4MBu1rVvSH95TSxCAvmic9k/il3I
         L+6PpGLv01W2ON1vz4yOu4a5ZZNyoMNYvZyR0oxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH 5.3 065/193] netfilter: ipset: Fix an error code in ip_set_sockfn_get()
Date:   Mon, 11 Nov 2019 19:27:27 +0100
Message-Id: <20191111181505.866688112@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 30b7244d79651460ff114ba8f7987ed94c86b99a upstream.

The copy_to_user() function returns the number of bytes remaining to be
copied.  In this code, that positive return is checked at the end of the
function and we return zero/success.  What we should do instead is
return -EFAULT.

Fixes: a7b4f989a629 ("netfilter: ipset: IP set core support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/ipset/ip_set_core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -2069,8 +2069,9 @@ ip_set_sockfn_get(struct sock *sk, int o
 		}
 
 		req_version->version = IPSET_PROTOCOL;
-		ret = copy_to_user(user, req_version,
-				   sizeof(struct ip_set_req_version));
+		if (copy_to_user(user, req_version,
+				 sizeof(struct ip_set_req_version)))
+			ret = -EFAULT;
 		goto done;
 	}
 	case IP_SET_OP_GET_BYNAME: {
@@ -2129,7 +2130,8 @@ ip_set_sockfn_get(struct sock *sk, int o
 	}	/* end of switch(op) */
 
 copy:
-	ret = copy_to_user(user, data, copylen);
+	if (copy_to_user(user, data, copylen))
+		ret = -EFAULT;
 
 done:
 	vfree(data);


