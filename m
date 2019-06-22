Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D3C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF9020652
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561196876;
	bh=mKnQpK3j45xTKkEjOfJkKfws6XhaBAvKFokNb1Qzq3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0TLxyZWjWtxRYgRhYYgK14DGAMK2aMQOjJB7wnsypcMRfAyEgcV2/GGh1N7NcuyRd
	 RcV7qDMv3rNvnqjres4i9boyGIxA74uTOv/aIgAi4/k5Kp0K5Me04k42nKhA8apWoD
	 qQNZz2hyDYiUXFhqJzNMENF2ljcgBlE+BJ2jjjE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfFVJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfFVJrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:47:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243B120652;
        Sat, 22 Jun 2019 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561196874;
        bh=mKnQpK3j45xTKkEjOfJkKfws6XhaBAvKFokNb1Qzq3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3fviIzWrn22lkrkVM0GZy2xZessmXC9jHEeWJyyoCVt+FYlN9VZrxctUfYyn4kKx
         qKKNgkLskcz4+gEOBS1cv2gK+5+YBfo/H/1tsWjGHcedDd/GEsMv8eXNlobPb4EtnB
         uX58sccQP/UypSZvkytx8g9oECnkRAhfn2XW6xSw=
Date:   Sat, 22 Jun 2019 11:47:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.1.14
Message-ID: <20190622094751.GB12599@kroah.com>
References: <20190622094743.GA12599@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622094743.GA12599@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index dfcd51a35824..c4b1a345d3f0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 1
-SUBLEVEL = 13
+SUBLEVEL = 14
 EXTRAVERSION =
 NAME = Shy Crocodile
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2d86e1bc483c..b8b4ae555e34 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1299,7 +1299,8 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 	if (nsize < 0)
 		nsize = 0;
 
-	if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
+	if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf &&
+		     tcp_queue != TCP_FRAG_IN_WRITE_QUEUE)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
 		return -ENOMEM;
 	}
