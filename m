Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80EFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4B020872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfFFSXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:23:22 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.178]:20075 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729519AbfFFSXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:23:22 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id D043088AA9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 13:23:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yx2nhYj6CYTGMYx2nhWeWH; Thu, 06 Jun 2019 13:23:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=48372 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYwyU-002JXr-Mg; Thu, 06 Jun 2019 13:23:21 -0500
Date:   Thu, 6 Jun 2019 13:18:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] kernel: module: Use struct_size() helper
Message-ID: <20190606181853.GA29960@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYwyU-002JXr-Mg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:48372
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct module_sect_attrs {
	...
        struct module_sect_attr attrs[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*sect_attrs) + nloaded * sizeof(sect_attrs->attrs[0]

with:

struct_size(sect_attrs, attrs, nloaded)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update changelog text by adding a better description for
   the motivation and usage of the struct_size() helper.

 kernel/module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 80c7c09584cf..3f3bb090fbf4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1492,8 +1492,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 	for (i = 0; i < info->hdr->e_shnum; i++)
 		if (!sect_empty(&info->sechdrs[i]))
 			nloaded++;
-	size[0] = ALIGN(sizeof(*sect_attrs)
-			+ nloaded * sizeof(sect_attrs->attrs[0]),
+	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
 			sizeof(sect_attrs->grp.attrs[0]));
 	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.attrs[0]);
 	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
-- 
2.21.0

