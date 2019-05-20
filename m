Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E814C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6818F20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558356114;
	bh=K54YEflfXLM4VSAwoRJKIcxe1vnu5XR84RhZ3XiT9mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8QjQZVD+Zi6ku//7P0vMniBE6YpCCnfUh1tdgz3OVqmRFc62NfvOA715SWxJW2et
	 /2mHmFofHVBkQun/yVriICFpGmnZsAiBj027zDIuBvM31KOmmTsRQL/QpDCFPLV8se
	 0oy6gQCx4T0H9pikVMl0QFA0JgFyjNO4UZh6+NXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfETMbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390192AbfETMa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:30:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D54F20645;
        Mon, 20 May 2019 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355455;
        bh=K54YEflfXLM4VSAwoRJKIcxe1vnu5XR84RhZ3XiT9mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiyGGqy8uvLVZUw2h9JFQ3gnDuKuJyAppeOxABVGP5raS5YMhsJbqRFQq33KfKmQ2
         2mStOAs2jRPAUO76uH5ig5I8i20PiBK9+NeUOapFRw6Y/+CHEvOvkmd3gk1eoKKw0B
         yVSBb0LVYnKEIdze3aj+gqnqeIvZw1AIqP5glMwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5.0 105/123] ext4: avoid panic during forced reboot due to aborted journal
Date:   Mon, 20 May 2019 14:14:45 +0200
Message-Id: <20190520115252.032767836@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 2c1d0e3631e5732dba98ef49ac0bec1388776793 upstream.

Handling of aborted journal is a special code path different from
standard ext4_error() one and it can call panic() as well. Commit
1dc1097ff60e ("ext4: avoid panic during forced reboot") forgot to update
this path so fix that omission.

Fixes: 1dc1097ff60e ("ext4: avoid panic during forced reboot")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 5.1
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -698,7 +698,7 @@ void __ext4_abort(struct super_block *sb
 			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
 		save_error_info(sb, function, line);
 	}
-	if (test_opt(sb, ERRORS_PANIC)) {
+	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
 		if (EXT4_SB(sb)->s_journal &&
 		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
 			return;


