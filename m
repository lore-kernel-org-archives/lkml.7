Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E523C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCE2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="j6/h1F6I";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="hqsx7tqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfC0KpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:45:19 -0400
Received: from mail128-16.atl41.mandrillapp.com ([198.2.128.16]:18183 "EHLO
        mail128-16.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731668AbfC0KpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:45:19 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 06:45:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=qZZSsnfZjwS1Mn9CA2yZlrd+GTax9gGW7CsTVUXwZqM=;
 b=j6/h1F6I628yHjiRDhJmjZ3RXah6ZyeDHJzsLkaLshYAC8ohSGmEj/3h9v3HIw16JblHwOHHonb4
   nuE7PeB3LQckIjsWQs0Zi2iuOF4EKi99MgfyImNBe1pGic/QlZAs2nsa8qHf6VvpjpjVwaoH24ln
   IEcaFu4i0nWWeMjeWLo=
Received: from pmta01.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail128-16.atl41.mandrillapp.com id hjda3s1mqukt for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:15:18 +0000 (envelope-from <bounce-md_31050260.5c9b4d36.v1-724e808b8ada4d2a9f13fe3df0362240@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553681718; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=qZZSsnfZjwS1Mn9CA2yZlrd+GTax9gGW7CsTVUXwZqM=; 
 b=hqsx7tqfMjrBaH7sDXqPOAz8qnVbhttufWAXFSt+bhNQFQ7X1DWk1Ucr+q1ismVn/sR1/p
 FX/fIziK1bpXpAdwAao9+KdMy9JWKTN+P3w5uJK6yH0p6bu0D6Gnuxf7PrT1gNBi6FnKjFyt
 qe7JIdptPVlYSCNh0DEOAqFKazbVI=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to negotiated max_write
Received: from [87.98.221.171] by mandrillapp.com id 724e808b8ada4d2a9f13fe3df0362240; Wed, 27 Mar 2019 10:15:18 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>,
        Kirill Smelkov <kirr@nexedi.com>, <stable@vger.kernel.org>
Message-Id: <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com>
In-Reply-To: <cover.1553680185.git.kirr@nexedi.com>
References: <cover.1553680185.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.724e808b8ada4d2a9f13fe3df0362240
X-Mandrill-User: md_31050260
Date:   Wed, 27 Mar 2019 10:15:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE filesystem server and kernel client negotiate during initialization
phase, what should be the maximum write size the client will ever issue.
Correspondingly the filesystem server then queues sys_read calls to read
requests with buffer capacity large enough to carry request header
+ that max_write bytes. A filesystem server is free to set its max_write
in anywhere in the range between [1=C2=B7page, fc->max_pages=C2=B7page]. In
particular go-fuse[2] sets max_write by default as 64K, wheres default
fc->max_pages corresponds to 128K. Libfuse also allows users to
configure max_write, but by default presets it to possible maximum.

If max_write is < fc->max_pages=C2=B7page, and in NOTIFY_RETRIEVE handler w=
e
allow to retrieve more than max_write bytes, corresponding prepared
NOTIFY_REPLY will be thrown away by fuse_dev_do_read, because the
filesystem server, in full correspondence with server/client contract,
will be only queuing sys_read with ~max_write buffer capacity, and
fuse_dev_do_read throws away requests that cannot fit into server
request buffer. In turn the filesystem server could get stuck waiting
indefinitely for NOTIFY_REPLY since NOTIFY_RETRIEVE handler returned OK
which is understood by clients as that NOTIFY_REPLY was queued and will
be sent back.

-> Cap requested size to negotiate max_write to avoid the problem.
This aligns with the way NOTIFY_RETRIEVE handler works, which already
unconditionally caps requested retrieve size to fuse_conn->max_pages.
This way it should not hurt NOTIFY_RETRIEVE semantic if we return less
data than was originally requested.

Please see [1] for context where the problem of stuck filesystem was hit
for real, how the situation was traced and for more involving patch that
did not make it into the tree.

[1] https://marc.info/?l=3Dlinux-fsdevel&m=3D155057023600853&w=3D2
[2] https://github.com/hanwen/go-fuse

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8a63e52785e9..38e94bc43053 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1749,7 +1749,7 @@ static int fuse_retrieve(struct fuse_conn *fc, struct=
 inode *inode,
 =09offset =3D outarg->offset & ~PAGE_MASK;
 =09file_size =3D i_size_read(inode);
 
-=09num =3D outarg->size;
+=09num =3D min(outarg->size, fc->max_write);
 =09if (outarg->offset > file_size)
 =09=09num =3D 0;
 =09else if (outarg->offset + num > file_size)
-- 
2.21.0.392.gf8f6787159

