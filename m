Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD43C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44C520656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354787;
	bh=IJn2Q8/2OgYDh2rtnnN4OFRWjHb9UQYcpcJuI7OuYJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9JtPqVfMEaIsqRdqJjUy0Ww1++XrBLAkjDrcGXOuJ1g19lGM0+ulSg5S1/AZgcGl
	 rzdhs1/Zh0kgkDSt5Z/k/Iuynz9F11UChvW9SdYcV08Qf8roLT0FGwVBAk8pGMW6se
	 vEl7kzys1yF1Bvr+R4lGi/Lh7qwwojkvKCOjrHhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbfETMTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732236AbfETMTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:19:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEF220656;
        Mon, 20 May 2019 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354782;
        bh=IJn2Q8/2OgYDh2rtnnN4OFRWjHb9UQYcpcJuI7OuYJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JY8asboYCRVRPhJs0TRN2nTl3pxcs3bKz+jQ98mWs6kBHkK6DyI78P7mZIPovT0xu
         zCQlV5S8VE3R8dtkM3N6zSYA5LMsU4tt7besEb6eARjaBupiSjXStjZtH4yadRc4E2
         QKzar95ReYi6JF90RGrKji+ob3qLbLEyEIR3PXSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Ren <renzhen@linux.alibaba.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: [PATCH 4.14 40/63] jbd2: check superblock mapped prior to committing
Date:   Mon, 20 May 2019 14:14:19 +0200
Message-Id: <20190520115235.504908336@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
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
@@ -1353,6 +1353,10 @@ static int jbd2_write_superblock(journal
 	journal_superblock_t *sb = journal->j_superblock;
 	int ret;
 
+	/* Buffer got discarded which means block device got invalidated */
+	if (!buffer_mapped(bh))
+		return -EIO;
+
 	trace_jbd2_write_superblock(journal, write_flags);
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);


