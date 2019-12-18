Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3F0C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA488218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMHtU+Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfLRSIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:08:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727705AbfLRSIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576692484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vrd2YMHgYqCL3NryYw02VWg7A0uKKgAHx3jq/JxCp5I=;
        b=OMHtU+FgW0REp8xJ/ry8/u491+lD5SdHl3ZKnDWwAWGziAkI9KqZPczs+koiXBQ6jtyjkn
        I73lk9hFf/j8d/dHWyQ3UYP8XJDXwbVRStgF8bsPpI/u4oUnxNlNm92Fn3gBj40FjdVi4P
        R1U1Dg2KRz2CR6ePYtMN+d51VH3rG8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-8k2LkPvON3iKCuAAOxJTcQ-1; Wed, 18 Dec 2019 13:08:00 -0500
X-MC-Unique: 8k2LkPvON3iKCuAAOxJTcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13DD6800D4E;
        Wed, 18 Dec 2019 18:07:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-218.ams2.redhat.com [10.36.117.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2FBB5D9E2;
        Wed, 18 Dec 2019 18:07:56 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     davem@davemloft.net
Cc:     Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v3 11/11] vsock_test: add SOCK_STREAM MSG_PEEK test
Date:   Wed, 18 Dec 2019 19:07:08 +0100
Message-Id: <20191218180708.120337-12-sgarzare@redhat.com>
In-Reply-To: <20191218180708.120337-1-sgarzare@redhat.com>
References: <20191218180708.120337-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test if the MSG_PEEK flags of recv(2) works as expected.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock=
_test.c
index a63e05d6a0f9..1d8b93f1af31 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -178,6 +178,35 @@ static void test_stream_multiconn_server(const struc=
t test_opts *opts)
 		close(fds[i]);
 }
=20
+static void test_stream_msg_peek_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd =3D vsock_stream_connect(opts->peer_cid, 1234);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	send_byte(fd, 1, 0);
+	close(fd);
+}
+
+static void test_stream_msg_peek_server(const struct test_opts *opts)
+{
+	int fd;
+
+	fd =3D vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_byte(fd, 1, MSG_PEEK);
+	recv_byte(fd, 1, 0);
+	close(fd);
+}
+
 static struct test_case test_cases[] =3D {
 	{
 		.name =3D "SOCK_STREAM connection reset",
@@ -198,6 +227,11 @@ static struct test_case test_cases[] =3D {
 		.run_client =3D test_stream_multiconn_client,
 		.run_server =3D test_stream_multiconn_server,
 	},
+	{
+		.name =3D "SOCK_STREAM MSG_PEEK",
+		.run_client =3D test_stream_msg_peek_client,
+		.run_server =3D test_stream_msg_peek_server,
+	},
 	{},
 };
=20
--=20
2.24.1

