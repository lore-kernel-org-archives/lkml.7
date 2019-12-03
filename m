Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12860C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFDF20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412687;
	bh=vEcNmvKCgxhstNeitHI26rx6hjGSxbZqu/hfVZccZEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f+Ca3Z+QZ1y3npsNm5fAbDMXwLpSHU0zTBFQeVTXnwuqoAWC879W62zgXxL+8sYWt
	 tdyt7zlwzZMFy2c5ajg1NW4t9p6miU1WTwo2TYmoEht8/TUVkrsK0lT5zXAeW+v+S7
	 v1tM153sovCRvJxxtCmckbhyPC3/oHgQjshXr6ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfLCWiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfLCWiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:38:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5D6207DD;
        Tue,  3 Dec 2019 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412682;
        bh=vEcNmvKCgxhstNeitHI26rx6hjGSxbZqu/hfVZccZEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8ihQlairGhqJHNysN9Hnskvud70r9ioWuagnpTvX+r7LmtIf35/sW3kK+/c0tD2y
         7oR8YhlO2YZJoPXLzhQXwrPJjMwZCHVLqBo4pasDX+Qr8GZizjjf2TnXgll6Pp2J2+
         SULdFGZAJqmW/W6sWJx7an0KS8T+HJTFUwvh8OjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 5.4 24/46] sctp: Fix memory leak in sctp_sf_do_5_2_4_dupcook
Date:   Tue,  3 Dec 2019 23:35:44 +0100
Message-Id: <20191203212739.336309468@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
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


