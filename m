Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E765C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F476214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430863;
	bh=hd7RXUo3KFS17hUD5oANRx8RcmKobByz/Ye13+kEITE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaS7yP/NPDQosUwxzLw75JioaTWisyFkW0cCn//QpCPNgWEA1IDayvOeq9noKFNMq
	 H0/CsfIVlmuUZiTZUbbwp3OKisxxL8lCki9yWGi/n5x4S5z+hRyfejRBdm3Q2gU1BB
	 p88cKIOBYVNgebbMlDE2uMfChlrT98yyySPAYMP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgAGVBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgAGVAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADE524682;
        Tue,  7 Jan 2020 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430850;
        bh=hd7RXUo3KFS17hUD5oANRx8RcmKobByz/Ye13+kEITE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJTGatEGefoiNySYDHUzdT3T9wh2D9Z8lDYd36NZ9AJnQ5aBmOSC/6l2UiE4FIGVf
         hAXuqex+B8NwlBeu6tPdLRQhuEgQIsOJwistGKaN2+/uvRiJT79bEb27fAwugCXw79
         1YPgILA2TLV6IVOYsbKIu6v+tj1EvcbSFNsVGNhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 121/191] mm/gup: fix memory leak in __gup_benchmark_ioctl
Date:   Tue,  7 Jan 2020 21:54:01 +0100
Message-Id: <20200107205339.457715526@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit a7c46c0c0e3d62f2764cd08b90934cd2aaaf8545 upstream.

In the implementation of __gup_benchmark_ioctl() the allocated pages
should be released before returning in case of an invalid cmd.  Release
pages via kvfree().

[akpm@linux-foundation.org: rework code flow, return -EINVAL rather than -1]
Link: http://lkml.kernel.org/r/20191211174653.4102-1-navid.emamdoost@gmail.com
Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/gup_benchmark.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -26,6 +26,7 @@ static int __gup_benchmark_ioctl(unsigne
 	unsigned long i, nr_pages, addr, next;
 	int nr;
 	struct page **pages;
+	int ret = 0;
 
 	if (gup->size > ULONG_MAX)
 		return -EINVAL;
@@ -63,7 +64,9 @@ static int __gup_benchmark_ioctl(unsigne
 					    NULL);
 			break;
 		default:
-			return -1;
+			kvfree(pages);
+			ret = -EINVAL;
+			goto out;
 		}
 
 		if (nr <= 0)
@@ -85,7 +88,8 @@ static int __gup_benchmark_ioctl(unsigne
 	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
 
 	kvfree(pages);
-	return 0;
+out:
+	return ret;
 }
 
 static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,


