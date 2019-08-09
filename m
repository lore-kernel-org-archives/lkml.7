Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C13C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811C0214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406606AbfHISys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:54:48 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:50467 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726457AbfHISys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:54:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C882918011E51;
        Fri,  9 Aug 2019 18:54:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toes84_80e899a3be108
X-Filterd-Recvd-Size: 2907
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 18:54:45 +0000 (UTC)
Message-ID: <2a72a19c81b7e57c044c583452127b453a1a455c.camel@perches.com>
Subject: [PATCH] kernel/resource.c: Convert printks to pr_<level>
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 09 Aug 2019 11:54:44 -0700
In-Reply-To: <2e93e4057d1f95680bdd6f7f7d754800b7c87ac9.camel@perches.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
         <2e93e4057d1f95680bdd6f7f7d754800b7c87ac9.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_<level> to get the output prefixed by the existing #define pr_fmt

Miscellanea:

o Convert bare printk to pr_info
o Reduce printk(KERN_WARNING to pr_info as the log level seems better

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/resource.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 7ea4306503c5..59b89e40502a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -901,7 +901,8 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 		if (conflict->end > new->end)
 			new->end = conflict->end;
 
-		printk("Expanded resource %s due to conflict with %s\n", new->name, conflict->name);
+		pr_info("Expanded resource %s due to conflict with %s\n",
+			new->name, conflict->name);
 	}
 	write_unlock(&resource_lock);
 }
@@ -1223,9 +1224,8 @@ void __release_region(struct resource *parent, resource_size_t start,
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource "
-		"<%016llx-%016llx>\n", (unsigned long long)start,
-		(unsigned long long)end);
+	pr_warn("Trying to free nonexistent resource <%016llx-%016llx>\n",
+		(unsigned long long)start, (unsigned long long)end);
 }
 EXPORT_SYMBOL(__release_region);
 
@@ -1557,10 +1557,10 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 		if (p->flags & IORESOURCE_BUSY)
 			continue;
 
-		printk(KERN_WARNING "resource sanity check: requesting [mem %#010llx-%#010llx], which spans more than %s %pR\n",
-		       (unsigned long long)addr,
-		       (unsigned long long)(addr + size - 1),
-		       p->name, p);
+		pr_info("sanity check: requesting [mem %#010llx-%#010llx], which spans more than %s %pR\n",
+			(unsigned long long)addr,
+			(unsigned long long)(addr + size - 1),
+			p->name, p);
 		err = -1;
 		break;
 	}



