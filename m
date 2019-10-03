Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DECC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ADF21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119275;
	bh=XDx6arB34nXUENA1/0wZCm4PtDs0ly4Hms29IBe8XP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGJK15wQEyT9fSiKYe4XSIP+ONo9sNIiGZ5Netwukq1cPWNxidqLW91QLLjZ7ef46
	 Wagu5qsqYF+7j9SDF7A099/fJ3xaeTpNCs1TTybRyZdZ6TVBYUOGr4JdaRPXjyXAHS
	 LO1pXFUY3tfQGXcBiFSRybhk5GkUov4/+qqy7dMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfJCQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733212AbfJCQOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:14:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C47D92054F;
        Thu,  3 Oct 2019 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119271;
        bh=XDx6arB34nXUENA1/0wZCm4PtDs0ly4Hms29IBe8XP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgLbb3iXtJr0/z44R9RCR7ZQAFtxLRFrwGXhOWSn5PThaZy8PlruGxuYrdHtObpGT
         MUi+va4itIb5KX+KMqAviRH8eq5kJk6y8Xhus7ErEWE7npUrqK3zGta/cIgTH78X94
         lusv7qcNPfebPx+Q5aLBnUMP5i7TRnmaqyft9zSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 170/185] md/raid6: Set R5_ReadError when there is read failure on parity disk
Date:   Thu,  3 Oct 2019 17:54:08 +0200
Message-Id: <20191003154518.932468675@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Ni <xni@redhat.com>

commit 143f6e733b73051cd22dcb80951c6c929da413ce upstream.

7471fb77ce4d ("md/raid6: Fix anomily when recovering a single device in
RAID6.") avoids rereading P when it can be computed from other members.
However, this misses the chance to re-write the right data to P. This
patch sets R5_ReadError if the re-read fails.

Also, when re-read is skipped, we also missed the chance to reset
rdev->read_errors to 0. It can fail the disk when there are many read
errors on P member disk (other disks don't have read error)

V2: upper layer read request don't read parity/Q data. So there is no
need to consider such situation.

This is Reported-by: kbuild test robot <lkp@intel.com>

Fixes: 7471fb77ce4d ("md/raid6: Fix anomily when recovering a single device in RAID6.")
Cc: <stable@vger.kernel.org> #4.4+
Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid5.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2571,7 +2571,9 @@ static void raid5_end_read_request(struc
 		    && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
 			retry = 1;
 		if (retry)
-			if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
+			if (sh->qd_idx >= 0 && sh->pd_idx == i)
+				set_bit(R5_ReadError, &sh->dev[i].flags);
+			else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
 				set_bit(R5_ReadError, &sh->dev[i].flags);
 				clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
 			} else


