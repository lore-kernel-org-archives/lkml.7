Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF26C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894E4216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599306;
	bh=+erWMCoHTiSsklg2eI6FKFJT38mbys5O4ZaxKE9Ogkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RtCl3e+AWK2SzaByYhs/nAvcFLml77w7UuvGtcJOYwt6Hv9O5k9bPm87GTahAGL+J
	 J1msCO/NMXNzNVZjD2uX5oE00NBtBZEXLG4iPBOIV0dZwvOFW4DJQghyHHxyD85EZU
	 w0QkPQf94TtcPh3/eM759+Wa/Stm44sg6DGlA6Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfGHPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387757AbfGHPVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:21:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F08214C6;
        Mon,  8 Jul 2019 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599302;
        bh=+erWMCoHTiSsklg2eI6FKFJT38mbys5O4ZaxKE9Ogkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q75EdKaXJnAWQlELDLaZEvoICU1KGCtXW2BgOQMbyYKBYCe60f5Sktg4F50NZkjqm
         3H6l/edJd3bhMXly34fMDavQ7ybFlbJE+GXMKRgGPypmnGt2HpUE0/CFeN0KDhbs3L
         LnwlLt1LlR58vFOiytuydZzp6AVAQxd5ToJNiF2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 044/102] net/9p: include trans_common.h to fix missing prototype warning.
Date:   Mon,  8 Jul 2019 17:12:37 +0200
Message-Id: <20190708150528.713266530@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 52ad259eaac0454c1ac7123e7148cf8d6e6f5301 ]

This silences -Wmissing-prototypes when defining p9_release_pages.

Link: http://lkml.kernel.org/r/b1c4df8f21689b10d451c28fe38e860722d20e71.1542089696.git.dato@net.com.org.es
Signed-off-by: Adeodato Simó <dato@net.com.org.es>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_common.c b/net/9p/trans_common.c
index 38aa6345bdfa..9c0c894b56f8 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -14,6 +14,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
+#include "trans_common.h"
 
 /**
  *  p9_release_req_pages - Release pages after the transaction.
-- 
2.20.1



