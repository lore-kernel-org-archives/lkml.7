Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97775C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA64207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf4EapN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLJO0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:26:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53127 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727178AbfLJO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575987966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNvyL4Y9eRzqtb2H2E84LxRf2YADQJydGhMMLpn/rvY=;
        b=Tf4EapN/ON+Cq8bjHWP6JxY9ovR4U91WGQ+NuP4XyXKwACRP2BQA6gvujCILzZhbpjsufE
        KqBo+UH5hDSMIsEuvRH/cbpmO68Fy3OMmQICLU4ZzMWZu3O0Qb8IfYRwF5Qkfi1LQf2Ymc
        bu2tQTnjEkJXVENDZxzKqjO7UAxgKEE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-ydGpg9_FNoawwIHZXns7iA-1; Tue, 10 Dec 2019 09:26:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id j13so8988107wrr.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQxMVxgAtK5y0CyKs1BCEj6d5vwE3qN67Xvd5FZmfgk=;
        b=omfNI2UufX1KGJkBXL7AIO5r6fXad2qh7qAj5kkEh6L3LAtWlqbWcU0fR+xKT9YswX
         mXWeblKib8pEl2suxKvxbP78LTaan1uU2BNZ54V9IkSuLUJBr67rwagVCWBkecwOYiQp
         lv8HewRazyaGMGIWw38zY7OP/M0mVhUiEAFTn7Z++bhCd5Da1soyN90p1QT6EIT/oU/s
         L625LSfEmFr847b/Qh712YkyZWvPsNAlaV9AwQ3hsabLod4LHTQfBketOTg3tyumnb3K
         9J9/uWTdNLrs51Q6HGWaa8cxVF1TssklXdb4kHNvDUuwZLHuWQNoZCENvJrr1agjDAx1
         o7YQ==
X-Gm-Message-State: APjAAAX0ZJLUiviBOYKeMvScuTmvqadIDuX6v0VjvN2im7xWKDzLErs9
        PnXpX9Eu8G5Ysyk7dAzBlDaHuctupvnDaPl3IsYDIH594eg7C/IDe3hZbzauZ1Bj1p/F+obhVLm
        uF1SPdcLr2bVr79kdZBIzqZ8z
X-Received: by 2002:a1c:9e0d:: with SMTP id h13mr5613200wme.110.1575987963557;
        Tue, 10 Dec 2019 06:26:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwf8mLK3UiBgavRy2zL8nuLvXVh2JCTOm4jCctkF/rAHV0Vm9bzgDEuAXksgE6XBUivzcDsTA==
X-Received: by 2002:a1c:9e0d:: with SMTP id h13mr5613179wme.110.1575987963411;
        Tue, 10 Dec 2019 06:26:03 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id u8sm3290027wmm.15.2019.12.10.06.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:26:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:26:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net-next v12 3/3] netronome: use the new txqueue timeout
 argument
Message-ID: <20191210142305.52171-4-mst@redhat.com>
References: <20191210142305.52171-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210142305.52171-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: ydGpg9_FNoawwIHZXns7iA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

