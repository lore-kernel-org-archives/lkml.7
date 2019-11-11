Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDEBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC19214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497160;
	bh=xyMvxFs3n+DXTMRN/z4818+BuC0ek5IfaKxMsXLPTRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCocXVbf22pybdxFhoAYnLTDZ0H/15oa4wSMjolGwXxf40eRzHkkb593YPNIrBIs9
	 xaPwXcUPpe16XKpqYQGRj87cxCZ9HXItZJE96z/nXkeeEitGwJwCAPIj4FIn0Gs0KS
	 2ezg0WthBQvgip8WuF+b0CSJGn1/EB5x0tCVrYZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfKKScj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfKKScc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:32:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85129214E0;
        Mon, 11 Nov 2019 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497152;
        bh=xyMvxFs3n+DXTMRN/z4818+BuC0ek5IfaKxMsXLPTRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyZbAPGvynZg4M8H7Bxu74yYj+37rJrG20PFvWokrL5rsWwaD25MZlMH+fhuOfuja
         jJi8nGTqr2kiRp9520KGjzqBO4amYbvi+vM13/nxuxkwrsDX2F63LisZjQlDC18Uwq
         WhqY13A3vJfqZIjOpbcJ8OdV/YWGIvl8tnBd1TYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH 4.9 21/65] netfilter: ipset: Fix an error code in ip_set_sockfn_get()
Date:   Mon, 11 Nov 2019 19:28:21 +0100
Message-Id: <20191111181344.889126080@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
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
@@ -1942,8 +1942,9 @@ ip_set_sockfn_get(struct sock *sk, int o
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
@@ -2000,7 +2001,8 @@ ip_set_sockfn_get(struct sock *sk, int o
 	}	/* end of switch(op) */
 
 copy:
-	ret = copy_to_user(user, data, copylen);
+	if (copy_to_user(user, data, copylen))
+		ret = -EFAULT;
 
 done:
 	vfree(data);


