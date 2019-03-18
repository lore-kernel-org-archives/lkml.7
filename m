Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7197B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901994;
	bh=PTkR6rjIKZyOydKnpO3uAJsIsZgyYpz3EDbKqOVVfR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTQ1q5R552FZDzz1dOJrSNS9qE3ujUuIUPB5xqUpvUEBCoFgCcZKsLuLUIM0+eFag
	 k4biudtZ/q33GF4fKJIGNP5VuHLZb4ueO4sd1R3W4qa+9BBay8jJgm3pCdw3nprB6a
	 wehM+InnS58MmKF0EDUfO8jUe3N5CHNH8bIcHHOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfCRJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387491AbfCRJfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:35:40 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C065E2083D;
        Mon, 18 Mar 2019 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901740;
        bh=PTkR6rjIKZyOydKnpO3uAJsIsZgyYpz3EDbKqOVVfR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7mb/fIMJ4sXManHI9hLpPTX5PLyj+XDDYGnHWvJR/qrplYneTSnUBc33jM2sVzQZ
         bD9kiGF8QYCHVjdGZ26f8KdIKNbo8J5JA3kjsmsuYicq4CpLSdz7prndZf7Z9PhHba
         xr8rdPrIZsBA0C6R2iQHHOhf0yKV8IvU84s+lBxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 33/34] Its wrong to add len to sector_nr in raid10 reshape twice
Date:   Mon, 18 Mar 2019 10:25:57 +0100
Message-Id: <20190318084149.634296540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

commit b761dcf1217760a42f7897c31dcb649f59b2333e upstream.

In reshape_request it already adds len to sector_nr already. It's wrong to add len to
sector_nr again after adding pages to bio. If there is bad block it can't copy one chunk
at a time, it needs to goto read_more. Now the sector_nr is wrong. It can cause data
corruption.

Cc: stable@vger.kernel.org # v3.16+
Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid10.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4495,7 +4495,6 @@ read_more:
 	atomic_inc(&r10_bio->remaining);
 	read_bio->bi_next = NULL;
 	generic_make_request(read_bio);
-	sector_nr += nr_sectors;
 	sectors_done += nr_sectors;
 	if (sector_nr <= last)
 		goto read_more;


