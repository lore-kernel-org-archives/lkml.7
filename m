Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF02EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CBF218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254451;
	bh=91bHgM7f9f+uP/Nb4hTgZJnSDOJyTU5KYf5PW5AzEys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KzGsHxX7goTKFdUAMxmL/C8ctobHjgGq7jDK+FTAnWpjWTLbwsiCvHDSNFKO5GDEJ
	 /v+lIKavTktY04/tapZPfr4r97xwFNrybkkVkCiy8BJenYbM+aHuWQ7bvp0qe/Tp9n
	 3H5wX+6pBcICpAMwq6W2F/960iqmfpybPl18PkyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCVLeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfCVLeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806E22183E;
        Fri, 22 Mar 2019 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254444;
        bh=91bHgM7f9f+uP/Nb4hTgZJnSDOJyTU5KYf5PW5AzEys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0mWquocP1/oM4/3Nb7a/h120ea1XvYHZP9gTJsnI4cUoVz/qCpY+zOW6K45GW7CJg
         3YUYnteVvAY5GGSLmeiUIlVcmIYTQsSK1HDtoEDDFoQWRSHzUzeYpnzXG6SDNfr3TR
         jbUhovJNLZUdCiFGrbESeoC7Dc6VWC83UUc3oClU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Turnbull <phil.turnbull@oracle.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 122/230] netfilter: nfnetlink_acct: validate NFACCT_FILTER parameters
Date:   Fri, 22 Mar 2019 12:14:20 +0100
Message-Id: <20190322111245.232269013@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Turnbull <phil.turnbull@oracle.com>

commit 017b1b6d28c479f1ad9a7a41f775545a3e1cba35 upstream.

nfacct_filter_alloc doesn't validate the NFACCT_FILTER_MASK and
NFACCT_FILTER_VALUE parameters which can trigger a NULL pointer
dereference. CAP_NET_ADMIN is required to trigger the bug.

Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink_acct.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -243,6 +243,9 @@ nfacct_filter_alloc(const struct nlattr
 	if (err < 0)
 		return ERR_PTR(err);
 
+	if (!tb[NFACCT_FILTER_MASK] || !tb[NFACCT_FILTER_VALUE])
+		return ERR_PTR(-EINVAL);
+
 	filter = kzalloc(sizeof(struct nfacct_filter), GFP_KERNEL);
 	if (!filter)
 		return ERR_PTR(-ENOMEM);


