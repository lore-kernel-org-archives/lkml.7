Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7022C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C31218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253891;
	bh=wJsqrR+Fnf/guWQC9P1hCKCSmHUzyMa7RY5iNzqk+RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZghiAL2kyC5rp40NkTIZ4Ax1yHohSTe2jIqhyCD1fHgHL287Aw1Bx39jB2BSgXSg
	 cK2u7HX0XNJ9/IrulsRmwBLiiW4e8yfdwXHbBrkIfU/p+de+CDBoS0uloFnKvG4n/L
	 0f0Qvaw87B+1EFSsTAsAn6HGO+WlrBZytv69igxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfCVLYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbfCVLYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:24:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A716820657;
        Fri, 22 Mar 2019 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253888;
        bh=wJsqrR+Fnf/guWQC9P1hCKCSmHUzyMa7RY5iNzqk+RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkLku4MQSZ6pvmVtoobELiog6+7xlSsghnrA76jDPNb7Iad2EVqP6tv55/DBPjFUP
         S813DFXanwS0DVTttg8wO8jXGENr3gmyp6yu/jNzw1R5ea6kRHE5AOQfxV2H/6lYaW
         Zi6ioLMjGZ/u8McopdyabZIaxe6NfQxetr4619v0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 3.18 094/134] Its wrong to add len to sector_nr in raid10 reshape twice
Date:   Fri, 22 Mar 2019 12:15:07 +0100
Message-Id: <20190322111216.957712563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4528,7 +4528,6 @@ bio_full:
 	atomic_inc(&r10_bio->remaining);
 	read_bio->bi_next = NULL;
 	generic_make_request(read_bio);
-	sector_nr += nr_sectors;
 	sectors_done += nr_sectors;
 	if (sector_nr <= last)
 		goto read_more;


