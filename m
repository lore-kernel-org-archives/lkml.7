Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8536C206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381032;
	bh=RBHFNmoq0KwigmFolI7aqoLzBVjy9tx5BTawnJLct2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHxkzynTCqaqKskpZxyrtXgCa75FMRyHHlpBsAHCsQR5fv5hI+DudN4J3DzK8mdpb
	 0HnjeVj0dFolkMS5mEui4Jf+LIWCoLbBbTOi2jvGufvZ+qHB2SiPGrCdXAvQJ7btEP
	 a7N9REyzXFs98u8iHIjQe6LnwB3OVAwyTOAir25U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbfIMNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389729AbfIMNUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:20:46 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9DB206BB;
        Fri, 13 Sep 2019 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380846;
        bh=RBHFNmoq0KwigmFolI7aqoLzBVjy9tx5BTawnJLct2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeCbafoAabDdpgN0fmsaqN1EW6sVl4Uo8bqBrWqlkwzKJsF7+W8BvbCqgcyzoVD1H
         wYNbQ9Pfx9EkkYEh7eRvqvdazmZAYu3CdyAdadUtedKQcNfcqjWpWLJr/qDnrCWmZ0
         7sJsAkHu7TviEuVKUbaF+Jy70t4/6bBrFZMpSAcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lidong Chen <lidongchen@tencent.com>,
        ruippan <ruippan@tencent.com>, yongduan <yongduan@tencent.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4.19 190/190] vhost: make sure log_num < in_num
Date:   Fri, 13 Sep 2019 14:07:25 +0100
Message-Id: <20190913130615.118340191@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
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
@@ -2075,7 +2075,7 @@ static int get_indirect(struct vhost_vir
 		/* If this is an input descriptor, increment that count. */
 		if (access == VHOST_ACCESS_WO) {
 			*in_num += ret;
-			if (unlikely(log)) {
+			if (unlikely(log && ret)) {
 				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
 				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
 				++*log_num;
@@ -2218,7 +2218,7 @@ int vhost_get_vq_desc(struct vhost_virtq
 			/* If this is an input descriptor,
 			 * increment that count. */
 			*in_num += ret;
-			if (unlikely(log)) {
+			if (unlikely(log && ret)) {
 				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
 				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
 				++*log_num;


