Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C657C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008192087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901489;
	bh=+6+pyXTVuDkzZV0Q0wQADuekcAeHexVsRIAXln6cTn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NAeAjydNtqoNsxMZSh42tc2bJjkdMujAF7Mp595CSTl1U8DX5c1u0LA7y+e6CSsoi
	 CxLc2QGZAIGj/O2GmhYp12RzmjIRmYencST9gtslBgPJQsLjRDbOlgIdPZp/oFwPNl
	 RRd9rJYHigN6frLREKspkeZhW7OL13GahmVF+s3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCRJb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfCRJbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:31:22 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24EB2087C;
        Mon, 18 Mar 2019 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901482;
        bh=+6+pyXTVuDkzZV0Q0wQADuekcAeHexVsRIAXln6cTn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkJq17kCnWttQ/A9soMn9bkTClvNIeloKxdrq0gfQrmT02uIPGhYoiusWBM9QvzdI
         /+7OygsAiLRfyAw2mD0MCmwZZNXgNmXAw6A4qebUBs7s8FC+rObgjnsfnvfICT0AFh
         5/MNWMFMFDaQqJ0xkPmHRfN7U7oRKeFJRVPssB0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, Shengjing Zhu <i@zhsj.me>
Subject: [PATCH 4.20 52/52] vhost/vsock: fix vhost vsock cid hashing inconsistent
Date:   Mon, 18 Mar 2019 10:25:39 +0100
Message-Id: <20190318083849.999692539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zha Bin <zhabin@linux.alibaba.com>

commit 7fbe078c37aba3088359c9256c1a1d0c3e39ee81 upstream.

The vsock core only supports 32bit CID, but the Virtio-vsock spec define
CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
zero. This inconsistency causes one bug in vhost vsock driver. The
scenarios is:

  0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
  object. And hash_min() is used to compute the hash key. hash_min() is
  defined as:
  (sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits)).
  That means the hash algorithm has dependency on the size of macro
  argument 'val'.
  0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
  hash_min() to compute the hash key when inserting a vsock object into
  the hash table.
  0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
  to compute the hash key when looking up a vsock for an CID.

Because the different size of the CID, hash_min() returns different hash
key, thus fails to look up the vsock object for an CID.

To fix this bug, we keep CID as u64 in the IOCTLs and virtio message
headers, but explicitly convert u64 to u32 when deal with the hash table
and vsock core.

Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack callers")
Link: https://github.com/stefanha/virtio/blob/vsock/trunk/content.tex
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Shengjing Zhu <i@zhsj.me>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/vhost/vsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -642,7 +642,7 @@ static int vhost_vsock_set_cid(struct vh
 		hash_del_rcu(&vsock->hash);
 
 	vsock->guest_cid = guest_cid;
-	hash_add_rcu(vhost_vsock_hash, &vsock->hash, guest_cid);
+	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
 	spin_unlock_bh(&vhost_vsock_lock);
 
 	return 0;


