Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5891421917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254481;
	bh=gJ7W2T8ZuWW+MM+4MTgiGpHBqRTW6UkN4YqAM1H3FRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LE47PHk7A1R1Z4Fr+4BELnGXh79S8H5m5HQ0kPzI3Dyq3spYhXdlahpd0splsHusX
	 VLEV7fIDhenU1hp03sZ2Lo8VoxucudLSNCT5SfvCJnlKbmQYqU+KpaiOLHz3a0yzZh
	 wvnQ3u+bX1frFzprOJCfhn0SMBDCWk0b263qDG6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfCVLek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730447AbfCVLei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A2421929;
        Fri, 22 Mar 2019 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254477;
        bh=gJ7W2T8ZuWW+MM+4MTgiGpHBqRTW6UkN4YqAM1H3FRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH2Ujph3VjUKoc+vxfcGa2x6cJTewrKkuBynLLPciFczjypvRVu2zwT0lZB2JFCgL
         glgJBMX1kNyPnTJYn8R2dfKyxVnahzVzl6uhGT1dzE5EN/iA4L9Il+w/scueHFJcf1
         sglo26KE92QmXnApJ/cgjfuXXKrNHiK7TW1aUDRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.4 148/230] Its wrong to add len to sector_nr in raid10 reshape twice
Date:   Fri, 22 Mar 2019 12:14:46 +0100
Message-Id: <20190322111247.061986500@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4442,7 +4442,6 @@ bio_full:
 	atomic_inc(&r10_bio->remaining);
 	read_bio->bi_next = NULL;
 	generic_make_request(read_bio);
-	sector_nr += nr_sectors;
 	sectors_done += nr_sectors;
 	if (sector_nr <= last)
 		goto read_more;


