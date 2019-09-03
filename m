Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12792053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfICHiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbfICHiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:22 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05587C04BD33
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 07:38:22 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id x11so17973018qtm.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=a2jRYEYJXw6y2ArAic1WZqLdnynYivPxAhcNn14RG7c=;
        b=XzuwH0Sdf0ZntJ99IbNNuiLlmlGwqKu6RREm08CexWJ9OJQkx1uj6ZQu6r9fuk+oQO
         SmbWJhVl6D62VQf490561bwOGmJVrIAbFWWJaa5H/C+MCN3vBL4J6KyN/Xz1q+7DSWE3
         kh2BFwsPBoP6TvK1Y9iqJkdyt3nCKZzGNp7JLxAl6BJFAOtqfiU4nxLQtvunE+tnj5SB
         sqykiGNB+swtgCi6eGMbkhRy+2+WNHjUjrWB3TjuUj5jKDPDSDFjlbeCRTwVwavTZzbL
         NeriRvQ0GOE9Rq4ktpi0uOGbxle7tmDAaDUoiShinRecrWUQOyzWRG6u2M0PbEQqd9Oi
         X5Sw==
X-Gm-Message-State: APjAAAVemH61Ks+a1JxSqQhBRPAMwkyfi/4+Vr5rkOXa+PtmeOVv7SGQ
        qz0P3HNPHr5S8Dk8qXsGOQWi5HosBuoMtKHgzG0Lw3rCLEfaLNN6cUs6qf+EiSha9s5ZJKuhXbT
        9WMbRzI9E4r6I05e//lwBUEP2
X-Received: by 2002:a37:916:: with SMTP id 22mr14382507qkj.45.1567496301058;
        Tue, 03 Sep 2019 00:38:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEnVPgjH8NbtZ+KbyL7PJmWdEblMSRWxEsCgtDKuaFkqs5CZdV4JoHPHabqe6W7wY2j8VAvw==
X-Received: by 2002:a37:916:: with SMTP id 22mr14382497qkj.45.1567496300910;
        Tue, 03 Sep 2019 00:38:20 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id 1sm8725515qko.73.2019.09.03.00.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:38:19 -0700 (PDT)
Date:   Tue, 3 Sep 2019 03:38:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH net-next] vsock/virtio: a better comment on credit update
Message-ID: <20190903073748.25214-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment we have is just repeating what the code does.
Include the *reason* for the condition instead.

Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 94cc0fa3e848..5bb70c692b1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -307,8 +307,13 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 
 	spin_unlock_bh(&vvs->rx_lock);
 
-	/* We send a credit update only when the space available seen
-	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
+	/* To reduce the number of credit update messages,
+	 * don't update credits as long as lots of space is available.
+	 * Note: the limit chosen here is arbitrary. Setting the limit
+	 * too high causes extra messages. Too low causes transmitter
+	 * stalls. As stalls are in theory more expensive than extra
+	 * messages, we set the limit to a high value. TODO: experiment
+	 * with different values.
 	 */
 	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
 		virtio_transport_send_credit_update(vsk,
-- 
MST
