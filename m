Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39734C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F7F218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254141;
	bh=SlG/z3BEnV6VrO2KRAgQiva44bi4mVlzaL3uuAVhsM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sM0/ooHykGFtn1ANVJ2iHsToDGMiV97NGWZ5KvGaOtv4Z7xA8DpKvVKYnZQZa/glb
	 9v23RI81VfABvW2ywxFItNbSibU2vwGaYwXNVAgdAVRXtUHnh8twGSGvmvBT+s9vs1
	 ObfTA3yhbdJNPWF3bw5cKkUzXWDNyLc3ka+hk1Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfCVL27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbfCVL2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:28:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC34E21916;
        Fri, 22 Mar 2019 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254134;
        bh=SlG/z3BEnV6VrO2KRAgQiva44bi4mVlzaL3uuAVhsM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1F41TJBSiE7WGkZJrIMgb9WduslM6cBo1qaO2hrGwAFlbXOTOs3auyfCq3WKRqT2P
         hXCtCFffaQOhOZrKrN50mI6IzwiirtkS07eLRZXz4Re0gIT8GhfIRA3CHXhl6Xzx3h
         lPYAT75TBDIHyzCrtpgvVwb4ksGxX333ybrVXx5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Oussama Ghorbel <ghorbel@pivasoftware.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 026/230] sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
Date:   Fri, 22 Mar 2019 12:12:44 +0100
Message-Id: <20190322111238.535953958@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 173656accaf583698bac3f9e269884ba60d51ef4 ]

If we disabled IPv6 from the kernel command line (ipv6.disable=1), we should
not call ip6_err_gen_icmpv6_unreach(). This:

  ip link add sit1 type sit local 192.0.2.1 remote 192.0.2.2 ttl 1
  ip link set sit1 up
  ip addr add 198.51.100.1/24 dev sit1
  ping 198.51.100.2

if IPv6 is disabled at boot time, will crash the kernel.

v2: there's no need to use in6_dev_get(), use __in6_dev_get() instead,
    as we only need to check that idev exists and we are under
    rcu_read_lock() (from netif_receive_skb_internal()).

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: ca15a078bd90 ("sit: generate icmpv6 error when receiving icmpv4 error")
Cc: Oussama Ghorbel <ghorbel@pivasoftware.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -577,7 +577,7 @@ static int ipip6_err(struct sk_buff *skb
 		goto out;
 
 	err = 0;
-	if (!ipip6_err_gen_icmpv6_unreach(skb))
+	if (__in6_dev_get(skb->dev) && !ipip6_err_gen_icmpv6_unreach(skb))
 		goto out;
 
 	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)


