Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBFDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B22207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118421;
	bh=dAwhzUaKbLdSeqMT5ZJ1TQUKNfFgFh1FT2Ze30/BIdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUOmwbPjy4R1FBUk/HjKOYJ8fl18nbxJfLzOBcEHnKg7ur/LxDQeZnfK7LxwnALsP
	 35oJgocT78DAlf4qKa14siSMAsl+6nN0MSN4h7jMEhvh1hqD4P7ZvsuqYSmfJorpDJ
	 +RB5rMCVVasE6onKRE5ZVGCdiFlW17UN/SV4E93Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfJCQAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfJCQAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:00:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9541F20830;
        Thu,  3 Oct 2019 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118416;
        bh=dAwhzUaKbLdSeqMT5ZJ1TQUKNfFgFh1FT2Ze30/BIdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTdZ13qkPM/amZbL9miQvvbpDTqXjZZxDxN9sTSWzfjU9mSIAG2A0KsJyMulvi6b9
         ooTuNUjsaMDouARHxswq31BUB8mkQ1qI96lJ2SvnnQATyMr5Y8QzSzoW0eT+5H2xAB
         E5TTM0aikiRw5Qnc7bSumjuNqQarpQ6IkH2WXorU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.4 88/99] md/raid6: Set R5_ReadError when there is read failure on parity disk
Date:   Thu,  3 Oct 2019 17:53:51 +0200
Message-Id: <20191003154338.656585846@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
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
@@ -2394,7 +2394,9 @@ static void raid5_end_read_request(struc
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


