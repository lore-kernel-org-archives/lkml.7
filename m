Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659FAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1AE20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380921;
	bh=W91+UdTzEWWfVfME9CPqZRP/B4xux4w9QJ+y6UvKR9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zid5ASDLX9MbHoXGqt6Se5GjSiCu07RuzSbwmbBZC7VgvE6WEEx1iw3+fvLt/0gfS
	 HU1On33IP6MgM+D+zL+Xjlr6pZ0MyzVm83R13j84CTamOFK+jwT3q8M1Z8CZSe+R9K
	 x2Ft/3XyQ60lkVKJ9Omuiv66JkwP9HOadjkTrT8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbfIMNV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390935AbfIMNV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:21:57 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFDA206BB;
        Fri, 13 Sep 2019 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380916;
        bh=W91+UdTzEWWfVfME9CPqZRP/B4xux4w9QJ+y6UvKR9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLX2PsRlqLT7AUn3lrzqX82MwAWTU96XE/aHXzDw9KEwgbvlN9IPmmNnNS3sY2dJF
         JCd6KOnHIhla2weeHmfsa1qpAMmnKGPv0ODMu+xLnHqHVqOL13NGnWhl5Fn9prtjCr
         SmzfyNwoUvKc2dMeuBJsnw2y30JpK3K91bS1BruY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lidong Chen <lidongchen@tencent.com>,
        ruippan <ruippan@tencent.com>, yongduan <yongduan@tencent.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 5.2 37/37] vhost: make sure log_num < in_num
Date:   Fri, 13 Sep 2019 14:07:42 +0100
Message-Id: <20190913130522.220388907@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yongduan <yongduan@tencent.com>

commit 060423bfdee3f8bc6e2c1bac97de24d5415e2bc4 upstream.

The code assumes log_num < in_num everywhere, and that is true as long as
in_num is incremented by descriptor iov count, and log_num by 1. However
this breaks if there's a zero sized descriptor.

As a result, if a malicious guest creates a vring desc with desc.len = 0,
it may cause the host kernel to crash by overflowing the log array. This
bug can be triggered during the VM migration.

There's no need to log when desc.len = 0, so just don't increment log_num
in this case.

Fixes: 3a4d5c94e959 ("vhost_net: a kernel-level virtio server")
Cc: stable@vger.kernel.org
Reviewed-by: Lidong Chen <lidongchen@tencent.com>
Signed-off-by: ruippan <ruippan@tencent.com>
Signed-off-by: yongduan <yongduan@tencent.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/vhost.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2074,7 +2074,7 @@ static int get_indirect(struct vhost_vir
 		/* If this is an input descriptor, increment that count. */
 		if (access == VHOST_ACCESS_WO) {
 			*in_num += ret;
-			if (unlikely(log)) {
+			if (unlikely(log && ret)) {
 				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
 				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
 				++*log_num;
@@ -2217,7 +2217,7 @@ int vhost_get_vq_desc(struct vhost_virtq
 			/* If this is an input descriptor,
 			 * increment that count. */
 			*in_num += ret;
-			if (unlikely(log)) {
+			if (unlikely(log && ret)) {
 				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
 				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
 				++*log_num;


