Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB11521929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138356;
	bh=58+fWRjX5jAoPvjEzDoD6LrfbrLnLHQ2LO3pw2wieJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmLD+sBrrVucBNuQXbzr60K42olztfLLA2two0qTa9Z9xOiJyktUWY8PUeIuQnksK
	 jW/rNfkynvkCbkaFNJZTjicU2L3Ui4ZnmSOlvCNfE0eg22fl5uC2sgkGl+8CByCFqb
	 fkJpKBxM+RoUaCaopdc7rBiiC+5qFkFXKQ19P+WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfDARFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfDARFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1B021924;
        Mon,  1 Apr 2019 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138352;
        bh=58+fWRjX5jAoPvjEzDoD6LrfbrLnLHQ2LO3pw2wieJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXIxmNKFLePNQ5MXumpnmQuKgkCAL47kt53kE09XFXrLPuEbXLZsabhSh4vwAAGB4
         Zvp+USRzccKU+tdkY/bnm3b9LCcYk1R31ez+/4OuU4VZvBpKedVNL4eiaHk9075kqT
         fb+sDXt0UTb7bJX8ktP/gY0vA+qMMF1fOu4vCqz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, LimeTech <tomm@lime-technology.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 040/146] btrfs: dont report readahead errors and dont update statistics
Date:   Mon,  1 Apr 2019 19:00:52 +0200
Message-Id: <20190401170051.882717171@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

commit 0cc068e6ee59c1fffbfa977d8bf868b7551d80ac upstream.

As readahead is an optimization, all errors are usually filtered out,
but still properly handled when the real read call is done. The commit
5e9d398240b2 ("btrfs: readpages() should submit IO as read-ahead") added
REQ_RAHEAD to readpages() because that's only used for readahead
(despite what one would expect from the callback name).

This causes a flood of messages and inflated read error stats, so skip
reporting in case it's readahead.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202403
Reported-by: LimeTech <tomm@lime-technology.com>
Fixes: 5e9d398240b2 ("btrfs: readpages() should submit IO as read-ahead")
CC: stable@vger.kernel.org # 4.19+
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6413,7 +6413,7 @@ static void btrfs_end_bio(struct bio *bi
 				if (bio_op(bio) == REQ_OP_WRITE)
 					btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
-				else
+				else if (!(bio->bi_opf & REQ_RAHEAD))
 					btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_READ_ERRS);
 				if (bio->bi_opf & REQ_PREFLUSH)


