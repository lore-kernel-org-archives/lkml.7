Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8F4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34765208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfD0Pal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:30:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60962 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-00014L-NR; Sat, 27 Apr 2019 16:15:12 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004a9-91; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jorgen Hansen" <jhansen@vmware.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Stefano Garzarella" <sgarzare@redhat.com>,
        "Xiumei Mu" <xmu@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.420898697@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 143/202] vsock: cope with memory allocation failure
 at socket creation time
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 225d9464268599a5b4d094d02ec17808e44c7553 upstream.

In the unlikely event that the kmalloc call in vmci_transport_socket_init()
fails, we end-up calling vmci_transport_destruct() with a NULL vmci_trans()
and oopsing.

This change addresses the above explicitly checking for zero vmci_trans()
at destruction time.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/vmw_vsock/vmci_transport.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1658,6 +1658,10 @@ static void vmci_transport_cleanup(struc
 
 static void vmci_transport_destruct(struct vsock_sock *vsk)
 {
+	/* transport can be NULL if we hit a failure at init() time */
+	if (!vmci_trans(vsk))
+		return;
+
 	/* Ensure that the detach callback doesn't use the sk/vsk
 	 * we are about to destruct.
 	 */

