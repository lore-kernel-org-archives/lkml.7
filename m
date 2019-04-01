Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED69C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138732;
	bh=0xeruuBJBUdy3uFD0FBfyGBgD4qwEx+T8UsGvLSsGaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSH1o9+9aRNrTi0ihXFd8DQdU9/mGQVSXre8xQPVauTTtBsvKNGnyuHeH9gO3voR9
	 OIGYjKGZK21+LF5ZsXgHq5HARQ7r8Vx69ftN8qxbT3W1zVh+alAPEMg6V3s7PYYblz
	 b6UQ7shM3Y7TJXwoi+Z9enah/ZK/uNSNPy2GDEbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfDARMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbfDARME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601BE21925;
        Mon,  1 Apr 2019 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138723;
        bh=0xeruuBJBUdy3uFD0FBfyGBgD4qwEx+T8UsGvLSsGaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tW7ySA+Im+fkWj6CpaX3zuSOybPaPtMLWTuvCQAhT1uV9t1PSZhd10lD/bby67mN4
         S/cz48XBOJyJiy0OWdqbEd1gTBLiYWbrKVFCli0oVBxnJBVRqSOmz24w5bCMnxuJA2
         Pn66T74FXCk2iRr7tGZhP45sVSIDgQ6mx+o09+3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 129/146] mm/debug.c: fix __dump_page when mapping->host is not set
Date:   Mon,  1 Apr 2019 19:02:21 +0200
Message-Id: <20190401170059.158292132@linuxfoundation.org>
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

From: Oscar Salvador <osalvador@suse.de>

commit 5ae2efb1dea9f537453e841714e3ee2757595aec upstream.

While debugging something, I added a dump_page() into do_swap_page(),
and I got the splat from below.  The issue happens when dereferencing
mapping->host in __dump_page():

  ...
  else if (mapping) {
	pr_warn("%ps ", mapping->a_ops);
	if (mapping->host->i_dentry.first) {
		struct dentry *dentry;
		dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
		pr_warn("name:\"%pd\" ", dentry);
	}
  }
  ...

Swap address space does not contain an inode information, and so
mapping->host equals NULL.

Although the dump_page() call was added artificially into
do_swap_page(), I am not sure if we can hit this from any other path, so
it looks worth fixing it.  We can easily do that by checking
mapping->host first.

Link: http://lkml.kernel.org/r/20190318072931.29094-1-osalvador@suse.de
Fixes: 1c6fb1d89e73c ("mm: print more information about mapping in __dump_page")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/debug.c
+++ b/mm/debug.c
@@ -79,7 +79,7 @@ void __dump_page(struct page *page, cons
 		pr_warn("ksm ");
 	else if (mapping) {
 		pr_warn("%ps ", mapping->a_ops);
-		if (mapping->host->i_dentry.first) {
+		if (mapping->host && mapping->host->i_dentry.first) {
 			struct dentry *dentry;
 			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
 			pr_warn("name:\"%pd\" ", dentry);


