Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93922190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253701;
	bh=jP94hG+MU/+ygDetenA6l7zWqPI0zcq0GIM7iv7ksmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CFgFF0qafzh5oPO/N5cLbddwRdclPqGA3cEdJJRC/N9twJYQVkOl/DbM0a4i88a7p
	 ZNw2tcTT4ZUqRYGyg3D1pt/JzFzBItN4ieOebiwx2Z6NiAxo2G9O7dq4Rm3vSuCt4S
	 oTZZchqGtuvvAPlU47KL8nbAaQgfYJfy9MJhivt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfCVLVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfCVLVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E16218A2;
        Fri, 22 Mar 2019 11:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253695;
        bh=jP94hG+MU/+ygDetenA6l7zWqPI0zcq0GIM7iv7ksmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYQ9/bXu/6qBEkPLc9M2i62GdFG3NQNTJwGAsnvwrZxkWJoqPhaRitvdus5aAlKqh
         HuBgaYmF68Mh+N+src5Am93Hx02w3EbnxJM+ggi5PWUZoGpIqGJGYkg+Mitxyi6CUr
         AUpKg2ahF2yk12n//EsmBSOA5C+I9bTAsFLaH1Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>
Subject: [PATCH 3.18 025/134] libceph: handle an empty authorize reply
Date:   Fri, 22 Mar 2019 12:13:58 +0100
Message-Id: <20190322111211.624715014@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 0fd3fd0a9bb0b02b6435bb7070e9f7b82a23f068 upstream.

The authorize reply can be empty, for example when the ticket used to
build the authorizer is too old and TAG_BADAUTHORIZER is returned from
the service.  Calling ->verify_authorizer_reply() results in an attempt
to decrypt and validate (somewhat) random data in au->buf (most likely
the signature block from calc_signature()), which fails and ends up in
con_fault_finish() with !con->auth_retry.  The ticket isn't invalidated
and the connection is retried again and again until a new ticket is
obtained from the monitor:

  libceph: osd2 192.168.122.1:6809 bad authorize reply
  libceph: osd2 192.168.122.1:6809 bad authorize reply
  libceph: osd2 192.168.122.1:6809 bad authorize reply
  libceph: osd2 192.168.122.1:6809 bad authorize reply

Let TAG_BADAUTHORIZER handler kick in and increment con->auth_retry.

Cc: stable@vger.kernel.org
Fixes: 5c056fdc5b47 ("libceph: verify authorize reply on connect")
Link: https://tracker.ceph.com/issues/20164
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
[idryomov@gmail.com: backport to 4.4: extra arg, no CEPHX_V2]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/messenger.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1980,15 +1980,19 @@ static int process_connect(struct ceph_c
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
 	if (con->auth_reply_buf) {
+		int len = le32_to_cpu(con->in_reply.authorizer_len);
+
 		/*
 		 * Any connection that defines ->get_authorizer()
 		 * should also define ->verify_authorizer_reply().
 		 * See get_connect_authorizer().
 		 */
-		ret = con->ops->verify_authorizer_reply(con, 0);
-		if (ret < 0) {
-			con->error_msg = "bad authorize reply";
-			return ret;
+		if (len) {
+			ret = con->ops->verify_authorizer_reply(con, 0);
+			if (ret < 0) {
+				con->error_msg = "bad authorize reply";
+				return ret;
+			}
 		}
 	}
 


