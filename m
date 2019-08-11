Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC7C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7DA2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 16:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="IxB+fWn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHKQ1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 12:27:55 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25507 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfHKQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 12:27:55 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 12:27:54 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1565539968; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=UMyNH7HBAABebeq9+p3mhTE8wvjaVLEKShctDus1FhQOHf2zz1+07oN3chn9PrFuivrHVqfp2wr/SeYQh6fhmFEEF5asQ/5n+jcH0pNNaZ86ljk2IKBbehUBDzea0Xtmwy2smzJ9dWphOLeLO9wPE0q01OhXNIrBcYxavZYMuv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565539968; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=RDRspd14WFFAqpEgCwVCBF5hWq4eIuUAPFRdNY1Qr5M=; 
        b=PFAgk36/7O22tqmuti54U1NZiSC9naXmJkjYlxaz8raFWPdjAmyit0e5fPEljoKKBis14RgLKv0AdZf9OnhotkTIG1zB2rTg+gFR2iZkw1ghpQIBvMMqkjLmiOtw5OMlKQRMefvs3C2YRb0dLmagkmQSRIwrCLrnz1rlHdN2PQE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=oSxardQRHbESzohqmPTbbFcstHm4my1NOgTP8u2fcI3J8lM1psGBPT1BhZK+xk42+fRaAJ8tOFpn
    NR+NhQri5IR+1+V2lUMXijBOOsYQB6AKM8YK10UEMOyplTCjM1a0  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565539968;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=665;
        bh=RDRspd14WFFAqpEgCwVCBF5hWq4eIuUAPFRdNY1Qr5M=;
        b=IxB+fWn5NilLxekR+a16wqgkvDxBgq2TgpXST78UfwdXc8jtGpgGBUjjYS9uv62i
        BNbj+a2p4P77/orqrDV3+OkmBGcfTGrCXkmVNNoOuO+fbZh3JqyxKcibFqQrzgVIBxS
        dkbclLJWAoA2DT0N+eXIWWWNNqEVxDBjXbA7GyPQ=
Received: from YEHS1XR3054QMS.lenovo.com (114.245.9.228 [114.245.9.228]) by mx.zohomail.com
        with SMTPS id 156553996745427.6067071232319; Sun, 11 Aug 2019 09:12:47 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: dm writecache: remove unused member pointer in writeback_struct
Date:   Mon, 12 Aug 2019 00:12:32 +0800
Message-Id: <20190811161233.7616-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The stucture member pointer page in writeback_struct never has been
used actually. Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 1cb137f..5c7009d 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -190,7 +190,6 @@ struct writeback_struct {
 	struct dm_writecache *wc;
 	struct wc_entry **wc_list;
 	unsigned wc_list_n;
-	struct page *page;
 	struct wc_entry *wc_list_inline[WB_LIST_INLINE];
 	struct bio bio;
 };
-- 
1.8.3.1


