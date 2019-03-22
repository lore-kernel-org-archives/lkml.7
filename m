Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE32192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254442;
	bh=zf67P746qT+QrG5tpcWPq/6pmJc/BKgTDSDlJlRjoYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/SylEKnY/6fi2AxB65Iz3/F/v/TfEyQS+g9mGL8JxntVRJui+KEs074MtEH+bqoR
	 r/H0xnvjTRLg3oRfFFL0GHGPLHfuwIVnKHlnJbXLUAx9fINwFpCpjxss2S9nCDQvu3
	 ToNwOTLeVcbTCrNh1kMqaJU+1k2T5M7fWk6fy1+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfCVLeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbfCVLd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D021721916;
        Fri, 22 Mar 2019 11:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254437;
        bh=zf67P746qT+QrG5tpcWPq/6pmJc/BKgTDSDlJlRjoYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctTgkkJAgZtWVAfEWqxN7F4uuU/Op/X0nw7nFJoro9Jo21WGq+O1ecFThrwzaC+yA
         xow8K83U5OJdzHTn/1TOpvq0mi03hKOM1SvhbCnusEtfxDIOEHPXxIqLsb8zcJXy9U
         ylFV16rOb6kQXJG21+DMiwkU08SeC+umVp3ZCgHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baozeng Ding <sploving1@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 120/230] netfilter: x_tables: enforce nul-terminated table name from getsockopt GET_ENTRIES
Date:   Fri, 22 Mar 2019 12:14:18 +0100
Message-Id: <20190322111245.086979523@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit b301f2538759933cf9ff1f7c4f968da72e3f0757 upstream.

Make sure the table names via getsockopt GET_ENTRIES is nul-terminated
in ebtables and all the x_tables variants and their respective compat
code. Uncovered by KASAN.

Reported-by: Baozeng Ding <sploving1@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |    4 ++++
 net/ipv4/netfilter/arp_tables.c |    2 ++
 net/ipv4/netfilter/ip_tables.c  |    2 ++
 net/ipv6/netfilter/ip6_tables.c |    2 ++
 4 files changed, 10 insertions(+)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1528,6 +1528,8 @@ static int do_ebt_get_ctl(struct sock *s
 	if (copy_from_user(&tmp, user, sizeof(tmp)))
 		return -EFAULT;
 
+	tmp.name[sizeof(tmp.name) - 1] = '\0';
+
 	t = find_table_lock(net, tmp.name, &ret, &ebt_mutex);
 	if (!t)
 		return ret;
@@ -2368,6 +2370,8 @@ static int compat_do_ebt_get_ctl(struct
 	if (copy_from_user(&tmp, user, sizeof(tmp)))
 		return -EFAULT;
 
+	tmp.name[sizeof(tmp.name) - 1] = '\0';
+
 	t = find_table_lock(net, tmp.name, &ret, &ebt_mutex);
 	if (!t)
 		return ret;
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -983,6 +983,7 @@ static int get_entries(struct net *net,
 			 sizeof(struct arpt_get_entries) + get.size);
 		return -EINVAL;
 	}
+	get.name[sizeof(get.name) - 1] = '\0';
 
 	t = xt_find_table_lock(net, NFPROTO_ARP, get.name);
 	if (!IS_ERR_OR_NULL(t)) {
@@ -1557,6 +1558,7 @@ static int compat_get_entries(struct net
 			 *len, sizeof(get) + get.size);
 		return -EINVAL;
 	}
+	get.name[sizeof(get.name) - 1] = '\0';
 
 	xt_compat_lock(NFPROTO_ARP);
 	t = xt_find_table_lock(net, NFPROTO_ARP, get.name);
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1171,6 +1171,7 @@ get_entries(struct net *net, struct ipt_
 			 *len, sizeof(get) + get.size);
 		return -EINVAL;
 	}
+	get.name[sizeof(get.name) - 1] = '\0';
 
 	t = xt_find_table_lock(net, AF_INET, get.name);
 	if (!IS_ERR_OR_NULL(t)) {
@@ -1799,6 +1800,7 @@ compat_get_entries(struct net *net, stru
 			 *len, sizeof(get) + get.size);
 		return -EINVAL;
 	}
+	get.name[sizeof(get.name) - 1] = '\0';
 
 	xt_compat_lock(AF_INET);
 	t = xt_find_table_lock(net, AF_INET, get.name);
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1182,6 +1182,7 @@ get_entries(struct net *net, struct ip6t
 			 *len, sizeof(get) + get.size);
 		return -EINVAL;
 	}
+	get.name[sizeof(get.name) - 1] = '\0';
 
 	t = xt_find_table_lock(net, AF_INET6, get.name);
 	if (!IS_ERR_OR_NULL(t)) {
@@ -1800,6 +1801,7 @@ compat_get_entries(struct net *net, stru
 			 *len, sizeof(get) + get.size);
 		return -EINVAL;
 	}
+	get.name[sizeof(get.name) - 1] = '\0';
 
 	xt_compat_lock(AF_INET6);
 	t = xt_find_table_lock(net, AF_INET6, get.name);


