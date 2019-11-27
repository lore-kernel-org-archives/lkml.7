Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E97520862
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886990;
	bh=XGeaBPaoTRyL12hk8l8n/RDBwwRN4upaOnS/zIqnn14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sr7463Ld3OKbz5ZV87m8QkVYAVLhf9kXmP0m6XxEzJ55zfOumhjuP80MRxLH/+Sbb
	 TxapLhn9gY8uXfVzZFXYs+gfHNdWEAbrNEe0BdipjMzXyojAH/gpOCIRwlvOemm8ws
	 yadAylesUmktsZUNtlOobtwhk1DDRW4kbY4bmGas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfK0Ug3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfK0Ug0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:36:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204862158A;
        Wed, 27 Nov 2019 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886986;
        bh=XGeaBPaoTRyL12hk8l8n/RDBwwRN4upaOnS/zIqnn14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPFcS1W5cY0Y2ta3xMUuZkpPCWAvL3d695pCz803mGTdzz6yTHsq9855E16OB8MND
         03jSIApXRHG6DJ7c/mKe7LDw8K7mdzyfz97J3cUl5t80uGI0LP7fhb+d4l6Qw/20U+
         P/mxSD+xgJ/ThKsOQurvSbceOeiwAKyGC4sjbq+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 067/132] hfs: fix BUG on bnode parent update
Date:   Wed, 27 Nov 2019 21:30:58 +0100
Message-Id: <20191127203003.459389906@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit ef75bcc5763d130451a99825f247d301088b790b ]

hfs_brec_update_parent() may hit BUG_ON() if the first record of both a
leaf node and its parent are changed, and if this forces the parent to
be split.  It is not possible for this to happen on a valid hfs
filesystem because the index nodes have fixed length keys.

For reasons I ignore, the hfs module does have support for a number of
hfsplus features.  A corrupt btree header may report variable length
keys and trigger this BUG, so it's better to fix it.

Link: http://lkml.kernel.org/r/cf9b02d57f806217a2b1bf5db8c3e39730d8f603.1535682463.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/brec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 2e713673df42f..85dab71bee74f 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -444,6 +444,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			/* restore search_key */
 			hfs_bnode_read_key(node, fd->search_key, 14);
 		}
+		new_node = NULL;
 	}
 
 	if (!rec && node->parent)
-- 
2.20.1



