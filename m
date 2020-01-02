Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73820C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F50B22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003338;
	bh=P3a/ZEkweCnG571B9JxdD9lRevBt7k9vKFOiEEnafLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mT9CP1zTqAenL/Dv+qu+YT0HQtqbKD/YU9Pfh9kQ+9gxcP+c7Uk5p1yTRO9avepLd
	 xS7AYFl2CRsOvN7gjwZKFrXe9nElaUJFMHHpsl7Eur9hcHWWjr20TFtBBfrTBdyJY6
	 K6lgRe1NBW+OmYkKafOivzpNuHU4vrsIuX/Iwm/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgABWPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgABWPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:15:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A178C24649;
        Thu,  2 Jan 2020 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003323;
        bh=P3a/ZEkweCnG571B9JxdD9lRevBt7k9vKFOiEEnafLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYny6OlfeiX0VvqWuYEYiKca7ub+mtW8iCbxidyCY6bacKZjgQVYL5y79+Ekis+do
         oUN+STMaEqUfr/f3prTSAhFdR9UUDPC6lmoRz/zbewf1wdBXbyk9qYFW0B9pHqbQs3
         r60PGbDpxZe6UmWzvfSj+HkrjCHZLd6dWvlkqz84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erhard Furtner <erhard_f@mailbox.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/191] of: unittest: fix memory leak in attach_node_and_children
Date:   Thu,  2 Jan 2020 23:06:34 +0100
Message-Id: <20200102215841.878154675@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erhard Furtner <erhard_f@mailbox.org>

[ Upstream commit 2aacace6dbbb6b6ce4e177e6c7ea901f389c0472 ]

In attach_node_and_children memory is allocated for full_name via
kasprintf. If the condition of the 1st if is not met the function
returns early without freeing the memory. Add a kfree() to fix that.

This has been detected with kmemleak:
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205327

It looks like the leak was introduced by this commit:
Fixes: 5babefb7f7ab ("of: unittest: allow base devicetree to have symbol metadata")

Signed-off-by: Erhard Furtner <erhard_f@mailbox.org>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 92e895d86458..ca7823eef2b4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1146,8 +1146,10 @@ static void attach_node_and_children(struct device_node *np)
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
 
 	if (!strcmp(full_name, "/__local_fixups__") ||
-	    !strcmp(full_name, "/__fixups__"))
+	    !strcmp(full_name, "/__fixups__")) {
+		kfree(full_name);
 		return;
+	}
 
 	dup = of_find_node_by_path(full_name);
 	kfree(full_name);
-- 
2.20.1



