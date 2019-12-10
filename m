Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341E8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0536B20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8ZhFe8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLJPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29872 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727486AbfLJPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575991503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SBlCViivdLPWcxJR+tjSqpcELt98NYeH9PCUPU2arcI=;
        b=H8ZhFe8JaAH4njYvrwy6h/Yco80B6hTQrvD2w7EjTC9q4fp/F4PCFOy5fgGOKFv9c/QoLD
        +Jd/d74+yAxEcqmStloqLOWqBhw46Mh8OGIFzDt2rgx+3cvEJZb3lPcC+CvTsLM0J7bE9X
        QEVIJkYSw1C9JJD6aXEk7kSy4eg9yXI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-FZsgZLCYNxSI5g6JLQj-lw-1; Tue, 10 Dec 2019 10:24:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id o135so731640wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+Bh1GSR5txdzqnDGr/X1/Xu1q7+Hi2S16TKSW8j1dM=;
        b=qBbfvApHvhyiJDC42h+61PlhoVJxPIZby9jSvHLBPrfxii0JXxmEyk7NfEOCs+4zrE
         +pqovI8Ta5qIcXaMcY/4ugie5jC/VUGbB66XqsaQhOlmtHbO3LXVcWZHXUFdSZonMVcD
         8d9+feumWRds+uq2ffCBSzmCrOJ+jDDdvA8sbzDeW2HOLXV04KclcYzL+sSI8Om43FZO
         mionKFHms2iOU7Ksa1PlZpJP+0CUDgA9SKG6RUVcvB9w+obE6y3+NiScIH+Qs4iAWD/+
         i8M7FTbAArCW6mnHjHdfFx5nFsIzF9h2n8vNUHAZVKvmYV5XGmdT2yluworqEFoLXSMj
         BG0Q==
X-Gm-Message-State: APjAAAWLocMWVASV8Hj7cHS47PVT1IZYKzwJa4qJHAxg2wZMv41M2KLX
        j9oV3/CxTloIDXnUmSLoUzU06+sVeuGUo9uSZFfeMQA5wwK6MyA8/1E2hESTEB5YNGXFZt1rz+V
        KVuunRe6zcoytOYf+l2Dfcpy3
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr201646wma.138.1575991498773;
        Tue, 10 Dec 2019 07:24:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxh2uzlfHDnLNfegEN+Y5sLsGEar+YEfBdUy8Fk9L4IE5jsiI2RzFGBJdG/g7S3IdwxHLpOuA==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr201635wma.138.1575991498580;
        Tue, 10 Dec 2019 07:24:58 -0800 (PST)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id i5sm706909wml.31.2019.12.10.07.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:24:57 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] bonding: don't init workqueues on error
Date:   Tue, 10 Dec 2019 16:24:54 +0100
Message-Id: <20191210152454.86247-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: FZsgZLCYNxSI5g6JLQj-lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bond_create() initialize six workqueues used later on. In the unlikely
event that the device registration fails, these structures are initialized
unnecessarily, so move the initialization out of the error path.
Also, create an error label to remove some duplicated code.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/bonding/bond_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index fcb7c2f7f001..8756b6a023d7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4889,8 +4889,8 @@ int bond_create(struct net *net, const char *name)
 =09=09=09=09   bond_setup, tx_queues);
 =09if (!bond_dev) {
 =09=09pr_err("%s: eek! can't alloc netdev!\n", name);
-=09=09rtnl_unlock();
-=09=09return -ENOMEM;
+=09=09res =3D -ENOMEM;
+=09=09goto out_unlock;
 =09}
=20
 =09/*
@@ -4905,14 +4905,17 @@ int bond_create(struct net *net, const char *name)
 =09bond_dev->rtnl_link_ops =3D &bond_link_ops;
=20
 =09res =3D register_netdevice(bond_dev);
+=09if (res < 0) {
+=09=09free_netdev(bond_dev);
+=09=09goto out_unlock;
+=09}
=20
 =09netif_carrier_off(bond_dev);
=20
 =09bond_work_init_all(bond);
=20
+out_unlock:
 =09rtnl_unlock();
-=09if (res < 0)
-=09=09free_netdev(bond_dev);
 =09return res;
 }
=20
--=20
2.23.0

