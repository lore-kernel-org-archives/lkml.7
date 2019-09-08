Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BDEC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666B021920
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946664;
	bh=w2MmB0TGNdTTQo9XjSIhZEyJjp2+5TCwC5sI3zA9Jww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=egIidQ/iF5GIkjNAZJ7Cn2ciblJomsln5kIsaiJzA6Y2u4AaTM6GvjuoNy4Wp5F4g
	 0D+LeK4CgJCGQp5moNxsH/9BBZMr2UNKHdI2RenVkBdtRwl8yZKDNZPf+iOJPnq1vn
	 LI+MkpZMUiHTgFdv71ch3hWyaMliqefXwApzvyZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfIHMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbfIHMoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:15 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0CB216C8;
        Sun,  8 Sep 2019 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946654;
        bh=w2MmB0TGNdTTQo9XjSIhZEyJjp2+5TCwC5sI3zA9Jww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGfYHYXZhS48Rl6rgRou1ujGXQsokb+YjXHSnyDuNXO3EDSmsw5pJwj8yR5KvdtCv
         lqFxvGIdxZHlckoLhHyDsWJyzc0r5aF0IWqhE/5BOfpS9KuTMWNnFZ46hKlaQmBSf9
         12FrXshGctasnmvqTouhHdh47GHc836jOu0ClDsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 17/26] libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
Date:   Sun,  8 Sep 2019 13:41:56 +0100
Message-Id: <20190908121106.586997084@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5c498950f730aa17c5f8a2cdcb903524e4002ed2 ]

Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ceph/buffer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/buffer.h b/include/linux/ceph/buffer.h
index 07ca15e761001..dada47a4360ff 100644
--- a/include/linux/ceph/buffer.h
+++ b/include/linux/ceph/buffer.h
@@ -29,7 +29,8 @@ static inline struct ceph_buffer *ceph_buffer_get(struct ceph_buffer *b)
 
 static inline void ceph_buffer_put(struct ceph_buffer *b)
 {
-	kref_put(&b->kref, ceph_buffer_release);
+	if (b)
+		kref_put(&b->kref, ceph_buffer_release);
 }
 
 extern int ceph_decode_buffer(struct ceph_buffer **b, void **p, void *end);
-- 
2.20.1



