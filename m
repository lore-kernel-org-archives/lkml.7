Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E872C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB062068F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tfZz/hUh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WU8WB3In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKZB4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:56:10 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:38904 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfKZB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:56:10 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 20:56:09 EST
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 47MRcx4JGHzQlC4;
        Tue, 26 Nov 2019 02:48:17 +0100 (CET)
Authentication-Results: gerste.heinlein-support.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1574732895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3vGTyx4hrjcs+n5a2EyZnoDC1MYkgE9tWQx/rXiB5Jg=;
        b=tfZz/hUhECWi98Ur/t45TDfhcHtd8n7kweUxvyoG2Hxe3iuq497B9zDKgr9yZ8tVD612U6
        c3e9gO4VrJ9fo+NcjBEKMajYlRKbpLS0l6QCs9Wu15ZFkAMSQTf22UpziRbfhaBI72nyEx
        bVMOykVbdveeIRkiJIwYMGb3aWQHDFtXSg8TzyCGCjQXYCqE//+chroTwyufwWR+fhD1HO
        6+F+a7GdqRNWuwQKFVgKreWxYCYH11vZ+e+PyE+AJy4ounzlS+/jD1x+FhSOIyBOJMw5Gu
        FHFOfpLDdjS2EO++HqpfoyYSjWXkJ2KTqLrHEOSfH8Of84LfTQqawP2oCf+jYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received; s=mail20150812; t=
        1574732893; bh=PWOAFg4hdwumD5Wgmmm4vIukmBf1tHCRGCyJGHCyzX0=; b=W
        U8WB3InnQZTnesO09wYOBTq74yclueWZR2ykRstZ+ZFCI8FX5d/NIV+cdZMxA+sU
        BM67mm2e9fXfYMbTYPyYLp6KEqTI7SRnLzDZ0YNjG/8DCQVnpKwYTU+mecJk5OSk
        vxEiOzmORXnym1Wxj/OI8NehWUjv9eVHU3A+oYRnIJo3EACTWS+S4J4OY8U2HH/u
        hq3MaNTwXvVT4PYAypu6ZjzDATFK929epNUX1+AeA515Mj5rin9lokPcjdDpUvxD
        czLTNYcOGKi9uYLStwNKKaZvJFYe5xH8+esXXAXsDW+sj0/VxEYKH1EOzKpuLqsi
        wQfAZOHzSoqBWLqaR1GUg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id EnMWbBeg9YEO; Tue, 26 Nov 2019 02:48:13 +0100 (CET)
From:   Erhard Furtner <erhard_f@mailbox.org>
To:     linuxppc-dev@ozlabs.org
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2] of: unittest: fix memory leak in attach_node_and_children
Date:   Tue, 26 Nov 2019 02:48:04 +0100
Message-Id: <20191126014804.28267-1-erhard_f@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes in v2:
  - Make the commit message more clearer.

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
2.23.0

