Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577FEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9A221582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519940;
	bh=E1eH4V28AhDSPxwzREWDAeBIRwVTvqP+aN8l9PpGcgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNqHlMSChDr5gVE5NHNH8hsO7eIB9gGR6BvMTTv/J+Hxsdzj4L1W8QerAzGyuCUX9
	 51/dHJlUHOCAOw/iMGSMZZxhu4/y8i50IkB7IzgHAeK8I2PvBkq7HuXPUCEVWHu5BV
	 VDRjNdClzhA4Katu+IN/Wg/ZuGxczPqSHCILyT5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfLPSMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730920AbfLPSMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:12:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9BE821775;
        Mon, 16 Dec 2019 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519935;
        bh=E1eH4V28AhDSPxwzREWDAeBIRwVTvqP+aN8l9PpGcgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wT8My/DgP41wa9YYMerFi4PM1HTL1nVek7FMVaVaHV/SQV/v67qI92lJz62vb/tj9
         9wxZ0PyKJ4Otm6TP7DnOkNm+tFivcI+GZOujEw7hXA135mKkQEkl9dzWYtckHggDQD
         4NP0xctKszsQ8zqtUjnbghfWOP0p7hyr6ZD0XPlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.3 130/180] ext2: check err when partial != NULL
Date:   Mon, 16 Dec 2019 18:49:30 +0100
Message-Id: <20191216174841.735294082@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@mykernel.net>

commit e705f4b8aa27a59f8933e8f384e9752f052c469c upstream.

Check err when partial == NULL is meaningless because
partial == NULL means getting branch successfully without
error.

CC: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191105045100.7104-1-cgxu519@mykernel.net
Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/inode.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -701,10 +701,13 @@ static int ext2_get_blocks(struct inode
 		if (!partial) {
 			count++;
 			mutex_unlock(&ei->truncate_mutex);
-			if (err)
-				goto cleanup;
 			goto got_it;
 		}
+
+		if (err) {
+			mutex_unlock(&ei->truncate_mutex);
+			goto cleanup;
+		}
 	}
 
 	/*


