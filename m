Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF01C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D483A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfEBOPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:15:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:51402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfEBOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82947AD9F;
        Thu,  2 May 2019 14:15:11 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id CF641E0156; Thu,  2 May 2019 16:15:10 +0200 (CEST)
Message-Id: <b10cbb009c6ea4acf02df7cac4972870b1c89eb8.1556806084.git.mkubecek@suse.cz>
In-Reply-To: <cover.1556806084.git.mkubecek@suse.cz>
References: <cover.1556806084.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v2 2/3] netlink: set bad attribute also on maxtype check
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
Date:   Thu,  2 May 2019 16:15:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check that attribute type is within 0...maxtype range in
__nla_validate_parse() sets only error message but not bad_attr in extack.
Set also bad_attr to tell userspace which attribute failed validation.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: David Ahern <dsahern@gmail.com>
---
 lib/nlattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/nlattr.c b/lib/nlattr.c
index 29f6336e2422..adc919b32bf9 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -356,7 +356,8 @@ static int __nla_validate_parse(const struct nlattr *head, int len, int maxtype,
 
 		if (type == 0 || type > maxtype) {
 			if (validate & NL_VALIDATE_MAXTYPE) {
-				NL_SET_ERR_MSG(extack, "Unknown attribute type");
+				NL_SET_ERR_MSG_ATTR(extack, nla,
+						    "Unknown attribute type");
 				return -EINVAL;
 			}
 			continue;
-- 
2.21.0

