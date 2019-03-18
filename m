Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A7A2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901842;
	bh=re1gM1oROJpQdQCnHivcKfT9tXK2tXUZkrG1ACvUqC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClVOkilYfblYJbgxcKtbchVkgkGfJl8+HiMlw9iomj0sIt2vymyARDP21SbLCtiT4
	 NocNfvAZZQ6MASxN7fiX0i4DDL2h5NAsfIw2NiGaeTKLzHN/Kg13DqVFqhvSVWcdZS
	 gUWO+I4AsC8v/v6XMmfDTmNC5BxmX7WiHW24sUJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfCRJhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387824AbfCRJhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:37:16 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D002621773;
        Mon, 18 Mar 2019 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901836;
        bh=re1gM1oROJpQdQCnHivcKfT9tXK2tXUZkrG1ACvUqC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQ7bSZ9pk4h3Q0gfFefk01v38amobTEAEWZOJkGnP20RqXRlnEq3b/Ve4JnoLnzLs
         KFQkCKgQeEpqAyvzyTGwLFE7IL8MStgNr+noNc1j9d+WmrFxl9a9eEyGBwOa8h+Dnd
         Ju8aLQI4Q105y6ltNN9vf1IxWVrnan8uDHVnUyoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.9 28/31] Its wrong to add len to sector_nr in raid10 reshape twice
Date:   Mon, 18 Mar 2019 10:26:03 +0100
Message-Id: <20190318084211.557757574@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4489,7 +4489,6 @@ bio_full:
 	atomic_inc(&r10_bio->remaining);
 	read_bio->bi_next = NULL;
 	generic_make_request(read_bio);
-	sector_nr += nr_sectors;
 	sectors_done += nr_sectors;
 	if (sector_nr <= last)
 		goto read_more;


