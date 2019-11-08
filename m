Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBAD20650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240376;
	bh=da0Dc3YyHtDFQHAivpF3KR1hwEg05Ph3HgY/GO0aQMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OodyfvTIsV/9pFJe0sRNDgefjTnFS1MbKrqGeC1FHpRCZJ/NKyGF3rcIgahvXYYTX
	 ujLFyrhAIB1Oq1ids5W0XFBUhs5yE8enlyZjtJw3fK1CwkqlCWj4oKkR1EfmIIpkKj
	 bUOPSPy2iHx43cWj1mV5+sXdYCrWKqUxoG5btSjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391644AbfKHTIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391624AbfKHTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:08:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AF320673;
        Fri,  8 Nov 2019 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240110;
        bh=da0Dc3YyHtDFQHAivpF3KR1hwEg05Ph3HgY/GO0aQMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRZ3nxjLOtBINJ5LeKFnOukGAvuU0JrsdlEotU6lS/uGqYpy0eKtvKwsolhMKJWTZ
         sagAhQqjwbvPRLvgJlcIN05Oezp5nPDoqvaANATb3z2CU4jUJoWuu18SE7uqBNsTBe
         cb2Mc90nz1Q5oWuX+u7/ZvQM1s7DBJE4G4zPODQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 092/140] net: rtnetlink: fix a typo fbd -> fdb
Date:   Fri,  8 Nov 2019 19:50:20 +0100
Message-Id: <20191108174910.866838205@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 8b73018fe44521c1cf59d7bac53624c87d3f10e2 ]

A simple typo fix in the nl error message (fbd -> fdb).

CC: David Ahern <dsahern@gmail.com>
Fixes: 8c6e137fbc7f ("rtnetlink: Update rtnl_fdb_dump for strict data checking")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3916,7 +3916,7 @@ static int valid_fdb_dump_strict(const s
 	ndm = nlmsg_data(nlh);
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_flags || ndm->ndm_type) {
-		NL_SET_ERR_MSG(extack, "Invalid values in header for fbd dump request");
+		NL_SET_ERR_MSG(extack, "Invalid values in header for fdb dump request");
 		return -EINVAL;
 	}
 


