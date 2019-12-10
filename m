Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD179C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74366207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlD9lK0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfLJNJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:09:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727541AbfLJNJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575983380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNvyL4Y9eRzqtb2H2E84LxRf2YADQJydGhMMLpn/rvY=;
        b=AlD9lK0lcRsDsXFvNQYzjqN8VPz1SiM8s3OBwIm9Ok0zggn7BmR7jMvd2vdQWyVfuPUK44
        59ccR13uXYDFEPpiJqjeQiXHauO1oFZ2RYf6gW8p+edtr3DE0DvT8M17EE6a7j7nFDUJTr
        PFpLqmrhyxiSr0Fr9vVn89Y3D2+4E0s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-XLLSf6ixNPOe9lLYmkHxaA-1; Tue, 10 Dec 2019 08:09:39 -0500
Received: by mail-qk1-f197.google.com with SMTP id x71so7179129qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQxMVxgAtK5y0CyKs1BCEj6d5vwE3qN67Xvd5FZmfgk=;
        b=p295HFEDK4Mpbj5OgyNxzujR1usLInxqml7pYccGFdxkK+wnxdDuTygvP/9MfWfI3W
         TLbHnoLeotuvtA7FXO+oPgRgCaWN0seiNVLrTtokwq5mAMSGScn658LGAEEj0SV4NzR2
         VnHOZteTDXVZm0xpu58AoDnMPsCuESG7vtzWXES4G8oS46IU2yVz5jHf/D91MYSqhbC3
         WBFY+/T+SHpmTaSHhcaVMNlULjqQUjLW5kRvXamBsOAzSeqRVQiPtHvwNvg/G+u/G/GN
         ylqculJ3e9w4BnneRcqxDYRxMHe9VsV4Ts8MgV2fsHGWmIP3TsNt4BktGHz0Q8bFlFq4
         dnxg==
X-Gm-Message-State: APjAAAVDXxfzthZ+DZi+VWZkKP99CA5TIko3p3mMqvK6uNrcj8dPfURB
        DxLyJ1BwTz35f6c6tt7VHvhexoxwPEMHgqJVSK75Fn4jkZnrD3HXivFAA8h+qXMzWl5dw0i2VTR
        INB9Cgw0GZc3nx49Nrc4SKV1I
X-Received: by 2002:ac8:1348:: with SMTP id f8mr30477645qtj.159.1575983378430;
        Tue, 10 Dec 2019 05:09:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzCxpfTPGAXiCVPIWJAs4HLWH6sVbFeBsTubfL0QW4kVTGuGgosmmYsXqgQxz0BbX7tFuG7A==
X-Received: by 2002:ac8:1348:: with SMTP id f8mr30477630qtj.159.1575983378295;
        Tue, 10 Dec 2019 05:09:38 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id o187sm903287qkf.26.2019.12.10.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:09:37 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:09:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net-next v11 3/3] netronome: use the new txqueue timeout
 argument
Message-ID: <20191210130837.47913-4-mst@redhat.com>
References: <20191210130837.47913-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210130837.47913-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: XLLSf6ixNPOe9lLYmkHxaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20191210130932.73jGn20lkYH3sfjjacnkjQFUuYRqVfboi5DELgb1LC0@z>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/=
net/ethernet/netronome/nfp/nfp_net_common.c
index bd305fc6ed5a..d4eeb3b3cf35 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1324,14 +1324,8 @@ nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct =
nfp_net_tx_ring *tx_ring)
 static void nfp_net_tx_timeout(struct net_device *netdev, unsigned int txq=
ueue)
 {
 =09struct nfp_net *nn =3D netdev_priv(netdev);
-=09int i;
=20
-=09for (i =3D 0; i < nn->dp.netdev->real_num_tx_queues; i++) {
-=09=09if (!netif_tx_queue_stopped(netdev_get_tx_queue(netdev, i)))
-=09=09=09continue;
-=09=09nn_warn(nn, "TX timeout on ring: %d\n", i);
-=09}
-=09nn_warn(nn, "TX watchdog timeout\n");
+=09nn_warn(nn, "TX watchdog timeout on ring: %u\n", txqueue);
 }
=20
 /* Receive processing
--=20
MST

