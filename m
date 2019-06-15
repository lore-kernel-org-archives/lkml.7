Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C780C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 06:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649EC2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 06:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SmfdGKEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfFOGml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 02:42:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfFOGml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 02:42:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so2720560pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hNHWrhfyzsV2n/wRn65uyM6GtYs6ZW3csZvNGHrW1M=;
        b=SmfdGKEs9uPX16YgUrEx8uxW6d74F8JSAWtvzcoD+gYAubt5m7kLbAo3yn13CuIbXC
         LcmpVrD/YFGRQ2uPnZ8E7HdD1vyh7X+TsUnB8/8s0kEQvA+Uy6XhVghwux+/uDWQMx6t
         CA0eE1B4NKJOQWPT4O7Z+fdXwYC/6Ykz2Z89A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hNHWrhfyzsV2n/wRn65uyM6GtYs6ZW3csZvNGHrW1M=;
        b=bwAw3UTsPJx1xkZDhmOskFCUit4Zbiv4NNF7EljTT7NkRga0Fj+qdYWOsmVrqkTuOO
         OkXWgftI/8PTWar7oa4//y0D4E1u0/x9kJcCmgCdHlRj5malhw3oTWEodyEpGtzhMEui
         QGddCMo6ftd3qCdAJxcjcCY82oUFPHyBruSkS1yU3/bavjBnUuCW08/b78JzKEagCQJY
         m+T+UmDv37FW8V95P63hJLNx+ApOPFjBTDI5JOtGixM8cAbZv3O5mpcA4ZWa0cZ/KZ0f
         bTEk8wteIUF9WPdTL/pxah2hl2ktPaW4aBnftWrnSoPB7S6IVWPlMbXop6kcHQLtS+qP
         91fQ==
X-Gm-Message-State: APjAAAW4kU3kKlYYUDfSIoJ4F2E2wX5UI64hthOrClmJW2igWTur3JyQ
        5QJO9cpySvy7FR/jZyrjJQbAiw==
X-Google-Smtp-Source: APXvYqztVvlek2ciZ+0if+6HLcVw/2Jr58oCThu5McVtMseOVbl4zFUyuLV/sAQA79bZsV+yqr0xQg==
X-Received: by 2002:a63:eb55:: with SMTP id b21mr38365372pgk.67.1560580960622;
        Fri, 14 Jun 2019 23:42:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:942a:df4a:2beb:7e97])
        by smtp.gmail.com with ESMTPSA id z126sm7025201pfb.100.2019.06.14.23.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 23:42:40 -0700 (PDT)
From:   Stephen Barber <smbarber@chromium.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Barber <smbarber@chromium.org>
Subject: [PATCH] vsock/virtio: set SOCK_DONE on peer shutdown
Date:   Fri, 14 Jun 2019 23:42:37 -0700
Message-Id: <20190615064237.73586-1-smbarber@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the SOCK_DONE flag to match the TCP_CLOSING state when a peer has
shut down and there is nothing left to read.

This fixes the following bug:
1) Peer sends SHUTDOWN(RDWR).
2) Socket enters TCP_CLOSING but SOCK_DONE is not set.
3) read() returns -ENOTCONN until close() is called, then returns 0.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f3f3d06cb6d8..e30f53728725 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -871,8 +871,10 @@ virtio_transport_recv_connected(struct sock *sk,
 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
 			vsk->peer_shutdown |= SEND_SHUTDOWN;
 		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
-		    vsock_stream_has_data(vsk) <= 0)
+		    vsock_stream_has_data(vsk) <= 0) {
+			sock_set_flag(sk, SOCK_DONE);
 			sk->sk_state = TCP_CLOSING;
+		}
 		if (le32_to_cpu(pkt->hdr.flags))
 			sk->sk_state_change(sk);
 		break;
-- 
2.22.0.410.gd8fdbe21b5-goog

