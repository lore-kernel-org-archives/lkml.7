Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5338C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8823400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495575;
	bh=YLSDIMuCDp/pQ8b1bLsyZv4ffLewgbv3UcvNqC6fHM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqDYtkIEXuVhkz+gwbSKm+wyjq6/xk93qxgdP06GL0IE7wCVI312/yRGMrNW3fHrg
	 6YLqc0UUW9nk6mCuR0hE3Eft3FibFKFoaXNXqYCXtpAXWqM/PPI+B2HIp+ufrjO1RF
	 nPZMiybFxMNQY64fmtMjtAHcM+7x0177pzPxyYUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405048AbfHVRje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404122AbfHVRYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:13 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED0B23400;
        Thu, 22 Aug 2019 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494652;
        bh=YLSDIMuCDp/pQ8b1bLsyZv4ffLewgbv3UcvNqC6fHM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0GocdUvDnxbzA8eX9W1Iq8O7X/8fpQdWFfG7m0tbkFLjic2v35acQ5avaj9efaVq
         HJog6QNp2GVmJUtA3RQhVJLD9CV7F9qKxr04I2ZhkHuhJilWv7qNgClT6ecluS2g8R
         363u5BRPy0+7FGGa+Fy/wmTaNwoapdxkzPC8ftC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Morris <dmorris@metaloft.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 093/103] netfilter: conntrack: Use consistent ct id hash calculation
Date:   Thu, 22 Aug 2019 10:19:21 -0700
Message-Id: <20190822171732.933803946@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Morris <dmorris@metaloft.com>

commit 656c8e9cc1badbc18eefe6ba01d33ebbcae61b9a upstream.

Change ct id hash calculation to only use invariants.

Currently the ct id hash calculation is based on some fields that can
change in the lifetime on a conntrack entry in some corner cases. The
current hash uses the whole tuple which contains an hlist pointer which
will change when the conntrack is placed on the dying list resulting in
a ct id change.

This patch also removes the reply-side tuple and extension pointer from
the hash calculation so that the ct id will will not change from
initialization until confirmation.

Fixes: 3c79107631db1f7 ("netfilter: ctnetlink: don't use conntrack/expect object addresses as id")
Signed-off-by: Dirk Morris <dmorris@metaloft.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -308,13 +308,12 @@ EXPORT_SYMBOL_GPL(nf_ct_invert_tuple);
  * table location, we assume id gets exposed to userspace.
  *
  * Following nf_conn items do not change throughout lifetime
- * of the nf_conn after it has been committed to main hash table:
+ * of the nf_conn:
  *
  * 1. nf_conn address
- * 2. nf_conn->ext address
- * 3. nf_conn->master address (normally NULL)
- * 4. tuple
- * 5. the associated net namespace
+ * 2. nf_conn->master address (normally NULL)
+ * 3. the associated net namespace
+ * 4. the original direction tuple
  */
 u32 nf_ct_get_id(const struct nf_conn *ct)
 {
@@ -324,9 +323,10 @@ u32 nf_ct_get_id(const struct nf_conn *c
 	net_get_random_once(&ct_id_seed, sizeof(ct_id_seed));
 
 	a = (unsigned long)ct;
-	b = (unsigned long)ct->master ^ net_hash_mix(nf_ct_net(ct));
-	c = (unsigned long)ct->ext;
-	d = (unsigned long)siphash(&ct->tuplehash, sizeof(ct->tuplehash),
+	b = (unsigned long)ct->master;
+	c = (unsigned long)nf_ct_net(ct);
+	d = (unsigned long)siphash(&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple,
+				   sizeof(ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple),
 				   &ct_id_seed);
 #ifdef CONFIG_64BIT
 	return siphash_4u64((u64)a, (u64)b, (u64)c, (u64)d, &ct_id_seed);


