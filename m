Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8549CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AD121929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138735;
	bh=Dj7nbLfnVf2kgzOfFsbQ1sfR9+9TPzkzWMayEfTtw90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CgWx8oHEQK7o4MuoRCnsj2AV2nr321q2GN4U4W27922n95VJ0yUGhi2VcJTtYYpdu
	 wHkuzKNUJSTdO7OOPH8Vk54viwxVv8lEEk3j0u3ZBW9KxAw8Q7nM4NQWMk75Gj+Apf
	 IhgeThPztepXq21didxeUJ8c3hs/TlUa8FI32a8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfDARMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbfDARML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE5A21924;
        Mon,  1 Apr 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138730;
        bh=Dj7nbLfnVf2kgzOfFsbQ1sfR9+9TPzkzWMayEfTtw90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJYC3dl/X1OSM63tFkkKyjpuoybYhfg/50qvbwRjf45X66B7QKu5DVww4L00Zo5Km
         T9ydNhIVGpkuz6Q6Dc5kXbVLEBI6x/iQmb6sHYwCe53VdOk1fpQU1+imwnq2TwJ8Mj
         uHvy8XrXC4edS/Cj29MIf7UYTFqGbiZPGwj/RAoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 131/146] mm/page_isolation.c: fix a wrong flag in set_migratetype_isolate()
Date:   Mon,  1 Apr 2019 19:02:23 +0200
Message-Id: <20190401170059.296051562@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qian Cai <cai@lca.pw>

commit f5777bc2d9cf0712554228b1a7927b6f13f5c1f0 upstream.

Due to has_unmovable_pages() taking an incorrect irqsave flag instead of
the isolation flag in set_migratetype_isolate(), there are issues with
HWPOSION and error reporting where dump_page() is not called when there
is an unmovable page.

Link: http://lkml.kernel.org/r/20190320204941.53731-1-cai@lca.pw
Fixes: d381c54760dc ("mm: only report isolation failures when offlining memory")
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Qian Cai <cai@lca.pw>
Cc: <stable@vger.kernel.org>	[5.0.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_isolation.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -59,7 +59,8 @@ static int set_migratetype_isolate(struc
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
+	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
+				 isol_flags))
 		ret = 0;
 
 	/*


