Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A82921848
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="IWXUumZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfHYHZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 03:25:10 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25496 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYHZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 03:25:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566717904; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ldzPbGLT+phX41skMR487QM7VL1Vh995xoJxj0oo8rNNgxozgHtVpnEVlo/JGZ8qgFr2sTffSITYrVEXiupqfy4GbCKfxZSKCv9sU0IIicOKKw5TmMnX2X0zNA8uj9zQRnwOgeiDY5OAJg4rTWLrHWFqb/bvRg4T5rP8UN/bHEw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566717904; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=GBEJpVc45vEgTHzPnaWjFe1ezba09XmkZtfewSChPOA=; 
        b=CAxidBtB4ryAxSHLktB548ZFZSFKM3QkSD5o696o+ZCs9jA61gMzMNZpMmlkvtxX77PChqtbwmiW8K2wJifVn0RjFdd8xA4wcMIKvpY9urr5li5hGcM3+JaP/eDpdWbc7+4HzjpE1uB746OX2T5AACwMTBfGRCvGyX+wFTwHB9g=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=ddh0MTBebnOgvtxBq84DNzIHZ7pY1U3xkVNoXqo0GirJoqYxPwZZR5oBOFjAOqYN9sWO3lCem6w5
    +g8EXs1mHeajKUjP6kymcQvOT7zPBrmCQrTcP1a2Uo/JdKzCOU06  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566717904;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=714;
        bh=GBEJpVc45vEgTHzPnaWjFe1ezba09XmkZtfewSChPOA=;
        b=IWXUumZzwAkajLMcOI61NRT+FphXnrnMi69LG6SNO3qJYYDxIla2CaGZA7A9EsHK
        nXq9AcnW4BDylrs0QuCj/xH8A88TJStzcN+xWycLqNPKF32dCjTRToxCRGON212DQCa
        E+8QSTjOO7sRIwkrqwKbEfZfOX+Uc7M4ngBcT8hY=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.58.107 [123.120.58.107]) by mx.zohomail.com
        with SMTPS id 1566717903096668.6389464058707; Sun, 25 Aug 2019 00:25:03 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 1/3] dm writecache: remove unused member pointer in writeback_struct
Date:   Sun, 25 Aug 2019 15:24:31 +0800
Message-Id: <20190825072433.2628-2-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190825072433.2628-1-yehs2007@zoho.com>
References: <20190825072433.2628-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The stucture member pointer page in writeback_struct never has been
used actually. Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
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


