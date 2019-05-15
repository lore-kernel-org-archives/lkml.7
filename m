Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0387AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99CA20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918133;
	bh=C/JfGwPkQp4yRLHw90qTlnjDCMKvW5g7tgWVfnlo0Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l4zwuA4wANTqdv2SSx1VJDYbLcwBwz0qOfXS0+Hhl9UUCcI5e7hMGI5afg8jej5BO
	 tpyP2mkjdJUPgCqVhs7MggU/mBlnQ8yEWF/Q1p0r2G7YJOM79iPS3h8Pz2TcVWEPSM
	 sgTIS4wOJB9ui7jB8OlFHGj+MDXGy1sE5GIH4/Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfEOLCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfEOLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:02:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C082173C;
        Wed, 15 May 2019 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918126;
        bh=C/JfGwPkQp4yRLHw90qTlnjDCMKvW5g7tgWVfnlo0Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmTDcs5AiHKwTT0VN9i9h0MN5NAE20a6TRAxYlwTbQWsUX5CDy9myM/oAG9qhZwUT
         72vM3iNnSREql7ZIP7PYWzcc2f4iwcW/Z5x+Fk9ViSuz+XhpqOQuQe9+bLVchbLstv
         BQ6SgdgyfNytawmo8c6YXdLqncdmO/UDBuyz5KPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 016/266] powerpc/powernv: Support firmware disable of RFI flush
Date:   Wed, 15 May 2019 12:52:03 +0200
Message-Id: <20190515090723.171821101@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit eb0a2d2620ae431c543963c8c7f08f597366fc60 upstream.

Some versions of firmware will have a setting that can be configured
to disable the RFI flush, add support for it.

Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush settings")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/setup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -79,6 +79,10 @@ static void pnv_setup_rfi_flush(void)
 		if (np && of_property_read_bool(np, "disabled"))
 			enable--;
 
+		np = of_get_child_by_name(fw_features, "speculation-policy-favor-security");
+		if (np && of_property_read_bool(np, "disabled"))
+			enable = 0;
+
 		of_node_put(np);
 		of_node_put(fw_features);
 	}


