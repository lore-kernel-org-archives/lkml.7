Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95E20715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4LAk4oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfKTP4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:56:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729198AbfKTP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574265402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yaTkqQdIWgZMRM72EEX7JTxyVtAAHvFqpyGvxqamTPE=;
        b=O4LAk4oeXv68JPMDGdwR8to+89Rfu9qzTIH+Hvt30EsHC2iuZskezT7XeDjuGMNn0Pyls2
        cg0dV9Oq6fyj+E8yRGPDYc1UZBn+IV0r2gh1cO3RtYQWoEpQoRf9k9L4mFyFjWklL6ZF4k
        aCxi0hSZVFbCjOo5tpwXdqIYH30H81Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-45eM74xEO-qOGdKgyphmHA-1; Wed, 20 Nov 2019 10:56:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461DB18B9FEE;
        Wed, 20 Nov 2019 15:56:37 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 672BC67278;
        Wed, 20 Nov 2019 15:56:35 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mao Wenan <maowenan@huawei.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net-next] vsock/vmci: make vmci_vsock_cb_host_called static
Date:   Wed, 20 Nov 2019 16:56:34 +0100
Message-Id: <20191120155634.43936-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 45eM74xEO-qOGdKgyphmHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

When using make C=3D2 drivers/misc/vmw_vmci/vmci_driver.o
to compile, below warning can be seen:
drivers/misc/vmw_vmci/vmci_driver.c:33:6: warning:
symbol 'vmci_vsock_cb_host_called' was not declared. Should it be static?

This patch make symbol vmci_vsock_cb_host_called static.

Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI gu=
est/host are active")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Hi Dave,
do you think it could go through net-next since it solves a problem
introduced by "vsock: add multi-transports support" series?

Adding R-b from "kbuild test robot" that found the same issue.

Thanks,
Stefano
---
 drivers/misc/vmw_vmci/vmci_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vm=
ci_driver.c
index 95fed4664a2d..cbb706dabede 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -30,7 +30,7 @@ static bool vmci_host_personality_initialized;
=20
 static DEFINE_MUTEX(vmci_vsock_mutex); /* protects vmci_vsock_transport_cb=
 */
 static vmci_vsock_cb vmci_vsock_transport_cb;
-bool vmci_vsock_cb_host_called;
+static bool vmci_vsock_cb_host_called;
=20
 /*
  * vmci_get_context_id() - Gets the current context ID.
--=20
2.21.0

