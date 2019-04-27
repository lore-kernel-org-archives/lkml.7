Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B0C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CE206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfD0P3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:29:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32936 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727291AbfD0PPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:19 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2q-0000zL-4r; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004c9-Qo; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Phil Sutter" <phil@nwl.cc>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.556690474@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 161/202] netfilter: nf_tables: fix flush after rule
 deletion in the same batch
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 23b7ca4f745f21c2b9cfcb67fdd33733b3ae7e66 upstream.

Flush after rule deletion bogusly hits -ENOENT. Skip rules that have
been already from nft_delrule_by_chain() which is always called from the
flush path.

Fixes: cf9dc09d0949 ("netfilter: nf_tables: fix missing rules flushing per table")
Reported-by: Phil Sutter <phil@nwl.cc>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16:
 - Use nft_rule_is_active_next() instead of nft_is_active_next()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1897,6 +1897,9 @@ static int nf_table_delrule_by_chain(str
 	int err;
 
 	list_for_each_entry(rule, &ctx->chain->rules, list) {
+		if (!nft_rule_is_active_next(ctx->net, rule))
+			continue;
+
 		err = nf_tables_delrule_one(ctx, rule);
 		if (err < 0)
 			return err;

