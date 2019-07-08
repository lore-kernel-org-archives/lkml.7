Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78883C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506B72166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599283;
	bh=aSmWjpJ16O8U2JtLY5LrHCNx1acy5VZ7PDfAG+fXiIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vA/RersUoAz+UjRxNAyatkJaQnoCY3DJYul1XLDLGjqIqCLycZ6vd5giObxFI41Vk
	 NIGh69kmqpbClZUpP/WP33tMTVWs/GgpaGQrshkmNfdfleLKna0SJQpU8b6cZww8m+
	 hPsy7DFoW4TLMqJV0ldbmhShzuiQqO2+9Thren0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfGHPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbfGHPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:21:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B2821734;
        Mon,  8 Jul 2019 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599278;
        bh=aSmWjpJ16O8U2JtLY5LrHCNx1acy5VZ7PDfAG+fXiIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgTErJ3mWjEhh8RbxR4LojbwtltXvyyOYYoSinBMnYxcKn34NayDqjWPlwrSZrI4V
         DY2roAVMVpLFgvI1xt21f8lqMzTTEr2iII3MGfoeZwIPSVVfo+RSTTG8KOQui+JkJj
         lh9ktaZnaznGzqW7kyhFAKPY61dGaSSdCUcmiMjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Craig Gallek <kraig@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.9 063/102] bpf: udp: ipv6: Avoid running reuseports bpf_prog from __udp6_lib_err
Date:   Mon,  8 Jul 2019 17:12:56 +0200
Message-Id: <20190708150529.714551171@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

commit 4ac30c4b3659efac031818c418beb51e630d512d upstream.

__udp6_lib_err() may be called when handling icmpv6 message. For example,
the icmpv6 toobig(type=2).  __udp6_lib_lookup() is then called
which may call reuseport_select_sock().  reuseport_select_sock() will
call into a bpf_prog (if there is one).

reuseport_select_sock() is expecting the skb->data pointing to the
transport header (udphdr in this case).  For example, run_bpf_filter()
is pulling the transport header.

However, in the __udp6_lib_err() path, the skb->data is pointing to the
ipv6hdr instead of the udphdr.

One option is to pull and push the ipv6hdr in __udp6_lib_err().
Instead of doing this, this patch follows how the original
commit 538950a1b752 ("soreuseport: setsockopt SO_ATTACH_REUSEPORT_[CE]BPF")
was done in IPv4, which has passed a NULL skb pointer to
reuseport_select_sock().

Fixes: 538950a1b752 ("soreuseport: setsockopt SO_ATTACH_REUSEPORT_[CE]BPF")
Cc: Craig Gallek <kraig@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Craig Gallek <kraig@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/udp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -479,7 +479,7 @@ void __udp6_lib_err(struct sk_buff *skb,
 	struct net *net = dev_net(skb->dev);
 
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
-			       inet6_iif(skb), udptable, skb);
+			       inet6_iif(skb), udptable, NULL);
 	if (!sk) {
 		__ICMP6_INC_STATS(net, __in6_dev_get(skb->dev),
 				  ICMP6_MIB_INERRORS);


