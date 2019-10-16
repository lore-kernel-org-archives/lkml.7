Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272E7ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E638421D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262878;
	bh=8osOiuLEA4bTqyQk3oWduH2334I6xYBmy+/krY4WAf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H8F6Qv6QHGPwBeWoKITETSEhmsUMqynvH+08gXwJhA4bEP9LJp4HacXE1nBHdkrJp
	 ggvQs3rDJI6IwMdlxnLXbHjjED/5Qd4P/QZ9CAKHS44Ny9nsRQzyw2rouQM3p3kDTV
	 /+4/c/N0NJr2jTp1O7hdzSh7jt3CCBghRpJXrqd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437712AbfJPVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437703AbfJPVyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:19 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1968222C9;
        Wed, 16 Oct 2019 21:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262859;
        bh=8osOiuLEA4bTqyQk3oWduH2334I6xYBmy+/krY4WAf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iThn3MpLeP8J8OQNbwX4dJ+gX0kiE96rNIeuiJMsRWzN75Sd8XJt27Vy6A6ANyDiL
         pMD9iEL6WSpyWC3zbrAyV0MTNU+cjx5hquFLZ3ooxXZY+C7BWW7kbsN5K0ozmmbHfm
         BDqB/BBEkHcqD06rngx+RybwPr8PtB1P6l0KCwf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH 4.9 07/92] powerpc/powernv: Restrict OPAL symbol map to only be readable by root
Date:   Wed, 16 Oct 2019 14:49:40 -0700
Message-Id: <20191016214804.493683777@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Donnellan <ajd@linux.ibm.com>

commit e7de4f7b64c23e503a8c42af98d56f2a7462bd6d upstream.

Currently the OPAL symbol map is globally readable, which seems bad as
it contains physical addresses.

Restrict it to root.

Fixes: c8742f85125d ("powerpc/powernv: Expose OPAL firmware symbol map")
Cc: stable@vger.kernel.org # v3.19+
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190503075253.22798-1-ajd@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -579,7 +579,10 @@ static ssize_t symbol_map_read(struct fi
 				       bin_attr->size);
 }
 
-static BIN_ATTR_RO(symbol_map, 0);
+static struct bin_attribute symbol_map_attr = {
+	.attr = {.name = "symbol_map", .mode = 0400},
+	.read = symbol_map_read
+};
 
 static void opal_export_symmap(void)
 {
@@ -596,10 +599,10 @@ static void opal_export_symmap(void)
 		return;
 
 	/* Setup attributes */
-	bin_attr_symbol_map.private = __va(be64_to_cpu(syms[0]));
-	bin_attr_symbol_map.size = be64_to_cpu(syms[1]);
+	symbol_map_attr.private = __va(be64_to_cpu(syms[0]));
+	symbol_map_attr.size = be64_to_cpu(syms[1]);
 
-	rc = sysfs_create_bin_file(opal_kobj, &bin_attr_symbol_map);
+	rc = sysfs_create_bin_file(opal_kobj, &symbol_map_attr);
 	if (rc)
 		pr_warn("Error %d creating OPAL symbols file\n", rc);
 }


