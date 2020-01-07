Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE45C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D41620678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431317;
	bh=ejLZ6Gun4XVGr1aCgrOjDhyWAcIT95CLEMcKxj7Ev/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RapamiAd8BEcEc1cylqayO30Zj6MewvDOjWOc4dw7hhwB2918wy+Fs3m+cm23CVLN
	 amZPVqXy5IcA6LGHZij5Vwut/u4JzHeiUIluAyGUGu+WrMCXsFAHN13+zPO53vgjQz
	 GcJotgI89c1f5hxrX+lyWzUtmo0U/yO/8AVTrBys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgAGVIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgAGVIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7A620678;
        Tue,  7 Jan 2020 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431311;
        bh=ejLZ6Gun4XVGr1aCgrOjDhyWAcIT95CLEMcKxj7Ev/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mi0wOICSyVa1YnAL4k1QHhHiCAw6RNMXsOnrIgEzTXsZgw775PUdAj1K+nZRuuv3H
         2kYmbXTyKOgUF2t6yvXTQIsUnN+UohkZsDj1EuFpRPLikFDUuR1IfRvYf43lEJbkwF
         d50TLYeUJKTBiRiuJkH3bqzyLo+iYGJv2xhH/Juc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.19 088/115] Bluetooth: Fix memory leak in hci_connect_le_scan
Date:   Tue,  7 Jan 2020 21:54:58 +0100
Message-Id: <20200107205306.600889208@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit d088337c38a5cd8f0230fbf2d514ff7672f9d0d3 upstream.

In the implementation of hci_connect_le_scan() when conn is added via
hci_conn_add(), if hci_explicit_conn_params_set() fails the allocated
memory for conn is leaked. Use hci_conn_del() to release it.

Fixes: f75113a26008 ("Bluetooth: add hci_connect_le_scan")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_conn.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1173,8 +1173,10 @@ struct hci_conn *hci_connect_le_scan(str
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0)
+	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0) {
+		hci_conn_del(conn);
 		return ERR_PTR(-EBUSY);
+	}
 
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);


