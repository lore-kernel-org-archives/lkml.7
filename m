Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BA6206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139247;
	bh=TeZUaZBXZG+0YdcaTmEjmQCzup7M9tuNSTIjWLXIaP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xll0vEzQH0z/gwYCRPFI9ZUNmjtNVDiyzqLXZTjfLuLg0tFZqe8cK/1u71PExyoMF
	 II82B+81z9FNPywxnBPO1tfduOAyqxbKhk/iAJMWJJBRRpr7Ggb3HZK8fRV6uggnyf
	 xcU35b0ePFQFnv39rt7IU2H0qOVVxVd7EiGIsQgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfDARUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731695AbfDARUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:20:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6C121473;
        Mon,  1 Apr 2019 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139241;
        bh=TeZUaZBXZG+0YdcaTmEjmQCzup7M9tuNSTIjWLXIaP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atVoy/2snG/jWb+llPTJk4nMNHwr0an8OoGmJC9mCb1gHM37YnQlQv3UqoTz3QQpy
         d68AzXGVZ7OrwcTBing3C6m4U8z5vrui5l94S0AyupVx5zu9GxP22kObsaBUiZYgIV
         KLeMmlzmD7MMnnBi+Hk7UD7Oxun9zDRbNQvSZ3qA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 019/107] sctp: get sctphdr by offset in sctp_compute_cksum
Date:   Mon,  1 Apr 2019 19:01:34 +0200
Message-Id: <20190401170047.295858155@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 273160ffc6b993c7c91627f5a84799c66dfe4dee ]

sctp_hdr(skb) only works when skb->transport_header is set properly.

But in Netfilter, skb->transport_header for ipv6 is not guaranteed
to be right value for sctphdr. It would cause to fail to check the
checksum for sctp packets.

So fix it by using offset, which is always right in all places.

v1->v2:
  - Fix the changelog.

Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/checksum.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -60,7 +60,7 @@ static inline __wsum sctp_csum_combine(_
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
-	struct sctphdr *sh = sctp_hdr(skb);
+	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
         __le32 ret, old = sh->checksum;
 	const struct skb_checksum_ops ops = {
 		.update  = sctp_csum_update,


