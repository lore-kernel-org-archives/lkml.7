Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B25DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1732183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260228;
	bh=JOWNQszS5ulCNgvrClVHzhkcQxXuTyw8zYNo0FJHzBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VVLbJoj5bhY+oI+oPgz8v+g6Sbl2vfUE7ApdDu5BBKTUE5inJTXByTTEVzXFjNPPv
	 D3GaryBtoKTQrIFTPKN1i4QAjtmtXMGr/CRlATouoqMdeGy4RWVN/x9ryReiBYA5E/
	 LdhHB4iVDTwlX3j7koyLvxj+BX2SKJK33E725th8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfCVNK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbfCVLeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5BA2183E;
        Fri, 22 Mar 2019 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254448;
        bh=JOWNQszS5ulCNgvrClVHzhkcQxXuTyw8zYNo0FJHzBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/KS1jCi//5s+56ajKnbATu7o5gcyY77MFPlQMKJhoo9tQJagf51RQnVTsDhesILC
         9Dz09LUNl0J+c+iZDx3RtF3d3iJUnyaGKcAvAEOq5RwxbeDD6ohU/GJbXXz1rZArcx
         GUAeRSWeXVTKzxpCgfY6xJfuQpt7CkFZMXbwd+qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baozeng Ding <sploving1@gmail.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 123/230] netfilter: nf_conntrack_tcp: Fix stack out of bounds when parsing TCP options
Date:   Fri, 22 Mar 2019 12:14:21 +0100
Message-Id: <20190322111245.302225293@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>

commit 644c7e48cb59cfc6988ddc7bf3d3b1ba5fe7fa9d upstream.

Baozeng Ding reported a KASAN stack out of bounds issue - it uncovered that
the TCP option parsing routines in netfilter TCP connection tracking could
read one byte out of the buffer of the TCP options.  Therefore in the patch
we check that the available data length is large enough to parse both TCP
option code and size.

Reported-by: Baozeng Ding <sploving1@gmail.com>
Tested-by: Baozeng Ding <sploving1@gmail.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_proto_tcp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -410,6 +410,8 @@ static void tcp_options(const struct sk_
 			length--;
 			continue;
 		default:
+			if (length < 2)
+				return;
 			opsize=*ptr++;
 			if (opsize < 2) /* "silly options" */
 				return;
@@ -470,6 +472,8 @@ static void tcp_sack(const struct sk_buf
 			length--;
 			continue;
 		default:
+			if (length < 2)
+				return;
 			opsize = *ptr++;
 			if (opsize < 2) /* "silly options" */
 				return;


