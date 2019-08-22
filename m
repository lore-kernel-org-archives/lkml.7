Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1920856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495342;
	bh=npgjU07bkp5BW/wFuSeJjCowJMBsgE0HDJNJfYeAeyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mvjh7lj1AbOx8q2Qr7EVbt3BXOkWLygwmWOQCXENkG9UhZHFeAMtyOHj3RgT7q+lq
	 C1zQOw1fbomiqFDfZINhVFfrkQBJ1fdlFkROYYxZxBE2tCrEgI6fq8XqQMraVFW+nM
	 fw4VE2lcm8iGHucLXUgwZ1hDOmZ8REkc/tAfPSnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392446AbfHVRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391812AbfHVRZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:04 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09992341E;
        Thu, 22 Aug 2019 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494704;
        bh=npgjU07bkp5BW/wFuSeJjCowJMBsgE0HDJNJfYeAeyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWRz881uooDbIXD+HjxwkMY7vbuq1eXBxZQXgbpsOpUbSB+ZwVcytoCpRYyAOy/t1
         Ixl27tsYu6DdQ9Ik6knRvo/fkKlVmg5bZOl647KMZbLwevvmtfsE12QblsC6G2Hi2C
         YLgfLLsMzHbADXHRqYgq0bgwDlMFpvvRhH8b1+3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Morris <dmorris@metaloft.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 58/71] netfilter: conntrack: Use consistent ct id hash calculation
Date:   Thu, 22 Aug 2019 10:19:33 -0700
Message-Id: <20190822171730.292363869@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
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
@@ -307,13 +307,12 @@ EXPORT_SYMBOL_GPL(nf_ct_invert_tuple);
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
@@ -323,9 +322,10 @@ u32 nf_ct_get_id(const struct nf_conn *c
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


