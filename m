Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89654C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584E82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355258;
	bh=1QUr1HOEiVC48iGBBFI3teoaKM3RtaomYix4dALh23E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nry0aDHpc/D4bhQFb1mzRTwcj5Li/W5tA9SszxAxY7QXXFrTmqPwGJohf5oGxsHfW
	 FqSh3DNZ/X5ZIBwEiNpjexz5Gku5rDB56eYbUsX6ojIxsoSipoWtqhrAmMYb57HFqv
	 u5uFKCFgwO5AlHkyw3N5wv48xGiiSJXyneJCXDYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfDOTHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbfDOTHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F7920880;
        Mon, 15 Apr 2019 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355253;
        bh=1QUr1HOEiVC48iGBBFI3teoaKM3RtaomYix4dALh23E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAaR1Q9McvqoXRUCS7fBLTjCElNWUAi7bHwM+mmhS1qf6Y1KNZ+v1DkjJyGY7zbPF
         YhjbOuS07qanjaRqaY/YXsEg32LeHi4kfm6KwLPxbILdAbTkJ4pZqa3KSN+bJhEtkb
         1JcoDpFLhJqixtoey0t6nG1wXcmYPxQ0yTkarrx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 068/101] btrfs: prop: fix zstd compression parameter validation
Date:   Mon, 15 Apr 2019 20:59:06 +0200
Message-Id: <20190415183744.077806404@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

commit 50398fde997f6be8faebdb5f38e9c9c467370f51 upstream.

We let pass zstd compression parameter even if it is not fully valid.
For example:

  $ btrfs prop set /btrfs compression zst
  $ btrfs prop get /btrfs compression
     compression=zst

zlib and lzo are fine.

Fix it by checking the correct prefix length.

Fixes: 5c1aab1dd544 ("btrfs: Add zstd support")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/props.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -396,7 +396,7 @@ static int prop_compression_apply(struct
 		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
 	} else if (!strncmp("zlib", value, 4)) {
 		type = BTRFS_COMPRESS_ZLIB;
-	} else if (!strncmp("zstd", value, len)) {
+	} else if (!strncmp("zstd", value, 4)) {
 		type = BTRFS_COMPRESS_ZSTD;
 		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
 	} else {


