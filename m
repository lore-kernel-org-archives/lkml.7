Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9828121D56
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697038;
	bh=oAxBDtac3cWfFjVWep7ONNKTlmqGnh7ooTDjepEn/WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLy6kSDdEqqdCR2CxA5e6+f8pjytLuxQmvgadmtTsu6Buc2JlLUIIyZ9CdZEYXsya
	 2GLgr0LFgvwePyN8EytoUvs3PqQ2ZQfeRMMT4cImdByJDQlmxGGrLe8LUzwl+DpiHF
	 6lZytj63KmmWUkdAL0ybCf/Z9pzhZ3Pk2r02rRFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbfJJIn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388809AbfJJInz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:43:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A02F21929;
        Thu, 10 Oct 2019 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697034;
        bh=oAxBDtac3cWfFjVWep7ONNKTlmqGnh7ooTDjepEn/WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwUreg+nEBY8TVpZgoCxxe+4LiIKanN5k9HCTwhSySD4vAwdQW2tsjpk5Li3GzE5C
         DdAfhz2BzxGBFc3MtbXwfl7TfsQ6DYP/kFfIfzbC2Fsm0dGd3nC1TjAGhpcbnqp2oU
         3sZqMzPAPgzjBA/9N7UeVqvLp2cUffADZ06WrM6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5.3 144/148] staging: erofs: some compressed cluster should be submitted for corrupted images
Date:   Thu, 10 Oct 2019 10:36:45 +0200
Message-Id: <20191010083621.018382009@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

commit ee45197c807895e156b2be0abcaebdfc116487c8 upstream.

As reported by erofs_utils fuzzer, a logical page can belong
to at most 2 compressed clusters, if one compressed cluster
is corrupted, but the other has been ready in submitting chain.

The chain needs to submit anyway in order to keep the page
working properly (page unlocked with PG_error set, PG_uptodate
not set).

Let's fix it now.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190819103426.87579-2-gaoxiang25@huawei.com
[ Gao Xiang: Manually backport to v5.3.y stable. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/unzip_vle.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1498,19 +1498,18 @@ static int z_erofs_vle_normalaccess_read
 	err = z_erofs_do_read_page(&f, page, &pagepool);
 	(void)z_erofs_vle_work_iter_end(&f.builder);
 
-	if (err) {
+	/* if some compressed cluster ready, need submit them anyway */
+	z_erofs_submit_and_unzip(&f, &pagepool, true);
+
+	if (err)
 		errln("%s, failed to read, err [%d]", __func__, err);
-		goto out;
-	}
 
-	z_erofs_submit_and_unzip(&f, &pagepool, true);
-out:
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 
 	/* clean up the remaining free pages */
 	put_pages_list(&pagepool);
-	return 0;
+	return err;
 }
 
 static int z_erofs_vle_normalaccess_readpages(struct file *filp,


