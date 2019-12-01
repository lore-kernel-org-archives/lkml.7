Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B7C43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 09:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903BA2073C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575193179;
	bh=uaCzlPj0HfR5lroBUOqF4z6PMJyDwmtM4pi1ceZOaNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x11oodCRmjj47jYppqSZEqtHyo1b3WjKkgb9JkGhJAAd4O/qDdlHsJrun4dwJkOlj
	 LbGLrazb6yXaUFU7aTm3HnnzZYgPOE0dyKD/XJL74pPGjGFzb87HzJi07fuOiQpoxi
	 75fqbUdFX0AJL8ww0oJU5qLagOLaFWFS5N12vOSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLAJji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 04:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfLAJjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 04:39:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DE62073C;
        Sun,  1 Dec 2019 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575193177;
        bh=uaCzlPj0HfR5lroBUOqF4z6PMJyDwmtM4pi1ceZOaNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwK3Gfjs6iC4lxglZbae8ztAAKSc8O97NfrC3H2aRCMdNmxulVOH/hz6RXew6OFQe
         MGLHeTr8qJOUCBrdG9/uwB4LBjfSIIRqRvuPtz4443NEIcLQeKwBFNAh2gU8kz/pCJ
         /IRoHyzIUPqlXhvhxt5medO/DG0PvLUVDWX9Hiyw=
Date:   Sun, 1 Dec 2019 10:39:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.205
Message-ID: <20191201093934.GB3777835@kroah.com>
References: <20191201093926.GA3777835@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201093926.GA3777835@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index c2a57420c570..9f97365b4bc6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 4
-SUBLEVEL = 204
+SUBLEVEL = 205
 EXTRAVERSION =
 NAME = Blurry Fish Butt
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 92d5f6232ec7..8aa4a5f89572 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -951,12 +951,10 @@ set_rcvbuf:
 			clear_bit(SOCK_PASSSEC, &sock->flags);
 		break;
 	case SO_MARK:
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
-		} else if (val != sk->sk_mark) {
+		else
 			sk->sk_mark = val;
-			sk_dst_reset(sk);
-		}
 		break;
 
 	case SO_RXQ_OVFL:
