Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06F921473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138878;
	bh=5e7UMT3mPRevpvlJWDGqCX3mO2oHXzMPIJ1+Yx0UYu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=phxXUafyZd35A6ifpahzkfGmTK6B3YaLpuNnmXSDP/+YOSuB8B0W77t0p27NBE/hA
	 sfyIUt2VkUToD88ljCew/ug2nW40Ho3XsC4PtEc+t786Y26tTkJXxvobY5vn0cDA08
	 pAsmNF92AvsihsVqk9dc6iV99Uw2ocp3K5/Q1uX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfDAROg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbfDAROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46FC21473;
        Mon,  1 Apr 2019 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138874;
        bh=5e7UMT3mPRevpvlJWDGqCX3mO2oHXzMPIJ1+Yx0UYu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1EhowBrrbMaTkzsj4e5YLMjbAD5EnZ5ofbSmUmKlIztVpGk6BcGyfQ8GQ7RX9lxl
         FXtSbqbe9HrG3+YOD49M6aKzqYgq6aQHShErdlZ5K4RJVvMVaEsox9VU7t+/HtPXmj
         uVGN5eUGyfdA0QjAxBgJJFwDNnkwgYrHq5qU27uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, LimeTech <tomm@lime-technology.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 047/134] btrfs: dont report readahead errors and dont update statistics
Date:   Mon,  1 Apr 2019 19:01:23 +0200
Message-Id: <20190401170048.978032345@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6051,7 +6051,7 @@ static void btrfs_end_bio(struct bio *bi
 				if (bio_op(bio) == REQ_OP_WRITE)
 					btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
-				else
+				else if (!(bio->bi_opf & REQ_RAHEAD))
 					btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_READ_ERRS);
 				if (bio->bi_opf & REQ_PREFLUSH)


