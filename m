Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A8C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140223;
	bh=Jx2R8CtTMQ8QtFpruMhzVFakK/a9HUJyQ9ElEgwOy8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZIGxqcXqZ9p9DCEh7BPW3LI0OALOxxfAhlxHsa0kuBkOFp8r8V94x+L0gZBsQp42
	 wZNNTDOyPFEDFPfNHPn2HqNeUXXzCqsZhFa1pLE5acOGR/pDmaSl3Bw5u5rLZ3YJly
	 df7SSx9gIjcAk8q6Qn/pulhJrmnfmuicjksAOHT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfDARhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387572AbfDARg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392E320830;
        Mon,  1 Apr 2019 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140218;
        bh=Jx2R8CtTMQ8QtFpruMhzVFakK/a9HUJyQ9ElEgwOy8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXL+HF4s0bR6dmDq26oYmyE/X7I1qK7+PU3ykNlFUMWuD5K7nY85ed6Z2Nzk8PS8l
         i6PCZYyVB2m7A//amrhLU719bSBtCK0+ZFU3j61inpVubH4gfjm4MSje9Ofj5nZvKp
         RtUYXY4VVIPMJrbQZLpQZQohOYuqcJ/7HPYJ5/5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3.18 01/50] udf: Fix crash on IO error during truncate
Date:   Mon,  1 Apr 2019 19:02:44 +0200
Message-Id: <20190401170041.400924310@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit d3ca4651d05c0ff7259d087d8c949bcf3e14fb46 upstream.

When truncate(2) hits IO error when reading indirect extent block the
code just bugs with:

kernel BUG at linux-4.15.0/fs/udf/truncate.c:249!
...

Fix the problem by bailing out cleanly in case of IO error.

CC: stable@vger.kernel.org
Reported-by: jean-luc malet <jeanluc.malet@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/udf/truncate.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -261,6 +261,9 @@ void udf_truncate_extents(struct inode *
 			epos.block = eloc;
 			epos.bh = udf_tread(sb,
 					udf_get_lb_pblock(sb, &eloc, 0));
+			/* Error reading indirect block? */
+			if (!epos.bh)
+				return;
 			if (elen)
 				indirect_ext_len =
 					(elen + sb->s_blocksize - 1) >>


