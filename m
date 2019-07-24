Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588BAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D60320665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999270;
	bh=eWLE12TI9q55kDE2CbptexNcBXzWn/WZQmLU0F6g4Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y4d+P6qdRtmhr6XC3jMYXiZJpGD2sXt7nnFyEnX98dc4YjMLaZM0zAeiNMuyTHlNX
	 TLkR9gjCuw8ymYtGqWaF9EB5wnFURL1A62JmC1v8YdeQTB/RH6Nqo0uv6m+JYKCFeQ
	 K7SxtC+IeftUHJ/zeBGFQEFnC+viI22+ECX4013c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392457AbfGXUO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391900AbfGXTzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39ADF22AED;
        Wed, 24 Jul 2019 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998119;
        bh=eWLE12TI9q55kDE2CbptexNcBXzWn/WZQmLU0F6g4Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2idDu3Jt6B9Iin66vr3TKl8QYtcl7dLoLyQdzi0v/OlzCGHGJk7guKjlBdb3Trq4U
         wMXMgsSz/TZC+3hfobfUQsmYq855SIt0ksobfxPjCqWXT4GykGn9GdjbbjwrY+/HS2
         cjOPooxvY0ccaGvMsHsNE2y52ACEjxQ32KtG9DlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 211/371] Bluetooth: hidp: NUL terminate a string in the compat ioctl
Date:   Wed, 24 Jul 2019 21:19:23 +0200
Message-Id: <20190724191740.447525236@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dcae9052ebb0c5b2614de620323d615fcbfda7f8 ]

This change is similar to commit a1616a5ac99e ("Bluetooth: hidp: fix
buffer overflow") but for the compat ioctl.  We take a string from the
user and forgot to ensure that it's NUL terminated.

I have also changed the strncpy() in to strscpy() in hidp_setup_hid().
The difference is the strncpy() doesn't necessarily NUL terminate the
destination string.  Either change would fix the problem but it's nice
to take a belt and suspenders approach and do both.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hidp/core.c | 2 +-
 net/bluetooth/hidp/sock.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a442e21f3894..5abd423b55fa 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -775,7 +775,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->version = req->version;
 	hid->country = req->country;
 
-	strncpy(hid->name, req->name, sizeof(hid->name));
+	strscpy(hid->name, req->name, sizeof(hid->name));
 
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->src);
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 2151913892ce..03be6a4baef3 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -192,6 +192,7 @@ static int hidp_sock_compat_ioctl(struct socket *sock, unsigned int cmd, unsigne
 		ca.version = ca32.version;
 		ca.flags = ca32.flags;
 		ca.idle_to = ca32.idle_to;
+		ca32.name[sizeof(ca32.name) - 1] = '\0';
 		memcpy(ca.name, ca32.name, 128);
 
 		csock = sockfd_lookup(ca.ctrl_sock, &err);
-- 
2.20.1



