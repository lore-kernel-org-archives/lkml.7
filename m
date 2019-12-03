Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D5EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE5720803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413061;
	bh=vEcNmvKCgxhstNeitHI26rx6hjGSxbZqu/hfVZccZEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fs1RWWzP/rJPFuNxDeq5pVi5KwimIPub5NPaF+wKY1vRqMpR2yGJgwJCwEJQAZ1/9
	 9d17o+Dqe8MgYfG2t6HumccBEPvWZvCF8H9Q7D5Lcvxzlj4M6jB8CQe/AcNYogvOqH
	 QZ0EOMGWmgT4x49Z12B6K7rycDP1dyRbiOFQHgZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfLCWoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbfLCWoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:44:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4722D207DD;
        Tue,  3 Dec 2019 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413058;
        bh=vEcNmvKCgxhstNeitHI26rx6hjGSxbZqu/hfVZccZEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/cUrbm0x5wIFbnQVoex0wIvNH9PG6mIZ8T4LMD+lO7nR6yE5EX85EzZW2srGq4JJ
         /LcblSOEqQpDMyVvL8uIwFceUxSBltuNGKhAeM5Byr4nNYPN+c0i2i2qWFk2q2kJS/
         1dXUI1bcxlP94trbOX1Z/hrHA0vUhGgEdkM9Uezw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 5.3 117/135] sctp: Fix memory leak in sctp_sf_do_5_2_4_dupcook
Date:   Tue,  3 Dec 2019 23:35:57 +0100
Message-Id: <20191203213043.477657216@linuxfoundation.org>
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

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit b6631c6031c746ed004c4221ec0616d7a520f441 ]

In the implementation of sctp_sf_do_5_2_4_dupcook() the allocated
new_asoc is leaked if security_sctp_assoc_request() fails. Release it
via sctp_association_free().

Fixes: 2277c7cd75e3 ("sctp: Add LSM hooks")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_statefuns.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2160,8 +2160,10 @@ enum sctp_disposition sctp_sf_do_5_2_4_d
 
 	/* Update socket peer label if first association. */
 	if (security_sctp_assoc_request((struct sctp_endpoint *)ep,
-					chunk->skb))
+					chunk->skb)) {
+		sctp_association_free(new_asoc);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+	}
 
 	/* Set temp so that it won't be added into hashtable */
 	new_asoc->temp = 1;


