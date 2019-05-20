Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F44C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAB520815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354687;
	bh=3cbeNFZjDYtiNUPJwWdnvJ2QlJeexinkSH9ggi0b/14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0attXRXch1W/HJuohzW1dZ+GQb9nA0S+zkvqghshAUoIGYAj0r9W9ywWZcVaY3f4u
	 ruUZWSCfDv0qZl20UPI/ydM+cfNSqWs4xB/c+kMoomdJVLgCBNfTcJkmVVmo67C6ti
	 DDjevymnfnu8k3kRMq22cq6wtNd755L0PxzQYTgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfETMSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbfETMSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:18:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71DD820815;
        Mon, 20 May 2019 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354681;
        bh=3cbeNFZjDYtiNUPJwWdnvJ2QlJeexinkSH9ggi0b/14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7NWRb/hV+JWwblpZ7Tm4C3DjD5RcfK5kvsD+A1vTfFdilYBy/tLUQr5emOnOiW+A
         XIo3MefUPNOTPSIwxoXbmGcKdz4Wlxso43hCHy4ynJfRYzaWrnm6F+ZH33TXbPvC5F
         XLEHoyQzfpCXrqnE39rXgc9+eEo0v2o0Bl+HIrro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Ren <renzhen@linux.alibaba.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 4.9 27/44] jbd2: check superblock mapped prior to committing
Date:   Mon, 20 May 2019 14:14:16 +0200
Message-Id: <20190520115234.268070147@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115230.720347034@linuxfoundation.org>
References: <20190520115230.720347034@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

commit 742b06b5628f2cd23cb51a034cb54dc33c6162c5 upstream.

We hit a BUG at fs/buffer.c:3057 if we detached the nbd device
before unmounting ext4 filesystem.

The typical chain of events leading to the BUG:
jbd2_write_superblock
  submit_bh
    submit_bh_wbc
      BUG_ON(!buffer_mapped(bh));

The block device is removed and all the pages are invalidated. JBD2
was trying to write journal superblock to the block device which is
no longer present.

Fix this by checking the journal superblock's buffer head prior to
submitting.

Reported-by: Eric Ren <renzhen@linux.alibaba.com>
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/journal.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1339,6 +1339,10 @@ static int jbd2_write_superblock(journal
 	journal_superblock_t *sb = journal->j_superblock;
 	int ret;
 
+	/* Buffer got discarded which means block device got invalidated */
+	if (!buffer_mapped(bh))
+		return -EIO;
+
 	trace_jbd2_write_superblock(journal, write_flags);
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);


