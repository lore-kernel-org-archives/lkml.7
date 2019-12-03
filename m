Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD0120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414578;
	bh=CIzuTMe1UuwbUJ8PlKeH7iu0kZG2TL47IyRUbFUmx8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DVyOpeUfiTgDbI9n1tNGs9qInNvwtsT4JYpjr3xPBE52Ur5W012MwPdS+xmHu5Lcv
	 dhy4PxlYfkSkNjhHgHqmUAQQ3K38G9h4rTg4sDxS5ELpJTck/jPb3D3769LXH7WRR8
	 YW6/aLaxj5ndzbpraaLLiAEFXfbOY6Z9BNgA0IUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfLCWnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbfLCWnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:43:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B4C2073C;
        Tue,  3 Dec 2019 22:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413025;
        bh=CIzuTMe1UuwbUJ8PlKeH7iu0kZG2TL47IyRUbFUmx8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNEIt4EBrLriFFei2slKWsJw7aMJLb6m7R/kl1Bj2JJv66kFagddfex60Ebgo+UQJ
         ZZujsrRqaTk8fQp6qaavlECLqaU5jOsEisZs012DjRN7pTqfwKOz+4HJs4a+pNvLtP
         jXbGhaGopYSf+H4bEiYjv3Z7j3/088PnOFuNPFr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, JD <jdtxs00@gmail.com>,
        Paul Wouters <paul@nohats.ca>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.3 107/135] xfrm: Fix memleak on xfrm state destroy
Date:   Tue,  3 Dec 2019 23:35:47 +0100
Message-Id: <20191203213040.775685454@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 86c6739eda7d2a03f2db30cbee67a5fb81afa8ba upstream.

We leak the page that we use to create skb page fragments
when destroying the xfrm_state. Fix this by dropping a
page reference if a page was assigned to the xfrm_state.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Reported-by: JD <jdtxs00@gmail.com>
Reported-by: Paul Wouters <paul@nohats.ca>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -495,6 +495,8 @@ static void ___xfrm_state_destroy(struct
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
 	}
+	if (x->xfrag.page)
+		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
 	xfrm_state_free(x);


