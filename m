Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9292080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431791;
	bh=yVSMHHClpJzlndkHCGKLUUq2inE9hgWKi9DMbgYa214=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBCIuiYK2oTqu92iGalKCL4S5YAQazFtcdSp2R75uOO8WMTehJpjlJ6Nx/R41gzBA
	 Mt0XhPFOHcOp8BvWfgw7OCyrIT78s3SDVzfNH/I7Ax13G5kmZtZPwrtJ52Lz2rEbUJ
	 JtC+KfDNVHh9m+48HhlLG9IlAcowiShZBo5Baevw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgAGVQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgAGVHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83192072A;
        Tue,  7 Jan 2020 21:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431231;
        bh=yVSMHHClpJzlndkHCGKLUUq2inE9hgWKi9DMbgYa214=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dL7Asim48SLqw/Vb3Er6jAheQXp0lfHg1cbck8VsnSAxlI+ectj6qsdgOyHSCPzJt
         260VHUerX6vlbHFvEouUUg34ti89PovYJeIoTaC98u8+cwpbBqJ4SB9bwRNVxWoTKq
         jbFrBnsIQs9BEDQkaH6/aIvU0cg5lRQVMKHyCvNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
        Jinsuk Choi <jjinsuk.choi@lge.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 052/115] mm/zsmalloc.c: fix the migrated zspage statistics.
Date:   Tue,  7 Jan 2020 21:54:22 +0100
Message-Id: <20200107205302.628401027@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chanho Min <chanho.min@lge.com>

commit ac8f05da5174c560de122c499ce5dfb5d0dfbee5 upstream.

When zspage is migrated to the other zone, the zone page state should be
updated as well, otherwise the NR_ZSPAGE for each zone shows wrong
counts including proc/zoneinfo in practice.

Link: http://lkml.kernel.org/r/1575434841-48009-1-git-send-email-chanho.min@lge.com
Fixes: 91537fee0013 ("mm: add NR_ZSMALLOC to vmstat")
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Jinsuk Choi <jjinsuk.choi@lge.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>        [4.9+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/zsmalloc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2092,6 +2092,11 @@ static int zs_page_migrate(struct addres
 		zs_pool_dec_isolated(pool);
 	}
 
+	if (page_zone(newpage) != page_zone(page)) {
+		dec_zone_page_state(page, NR_ZSPAGES);
+		inc_zone_page_state(newpage, NR_ZSPAGES);
+	}
+
 	reset_page(page);
 	put_page(page);
 	page = newpage;


