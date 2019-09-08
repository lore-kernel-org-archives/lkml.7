Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A67C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE821927
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946614;
	bh=w2MmB0TGNdTTQo9XjSIhZEyJjp2+5TCwC5sI3zA9Jww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QP0UddwDzpIONXiIkeWgms8lQEcYroIrEaR6mpgx3JZJoFdaIeuZljKy1dGDL2TJQ
	 z8nzT9tnl3+VeP8NP5DuHrrw1vCvpgbXpinDVQ0GAa75pWg3MK1YkABPC+3dUhNtmk
	 LU0nU6ev3CwXXFpII3teO4yyAG77T+ltS+ySteQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfIHMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbfIHMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:43:31 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F170218AE;
        Sun,  8 Sep 2019 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946610;
        bh=w2MmB0TGNdTTQo9XjSIhZEyJjp2+5TCwC5sI3zA9Jww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPMm0kaerSC95CqJeFOKC2vjEDfGSicc2RrtRMTGetU/g77ZiEGmxCrtwJd2ZMcj1
         /FI4Cwp/S+V6NFTIKqAiOKHfoeEh8U6IHYDxzIYphvmKB32PXl2lPxhCOEYhbMQbak
         2A+ZUOnB3XEdrb3MA8l247RFumwTfG6059qoaPHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 16/23] libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
Date:   Sun,  8 Sep 2019 13:41:51 +0100
Message-Id: <20190908121100.477137033@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121052.898169328@linuxfoundation.org>
References: <20190908121052.898169328@linuxfoundation.org>
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



