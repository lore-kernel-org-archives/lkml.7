Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE81C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfC0XlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:41:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0XlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F3AC30BC666;
        Wed, 27 Mar 2019 23:41:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0EB960FDE;
        Wed, 27 Mar 2019 23:41:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 04/68] vfs: Provide sb->s_iflags settings in fs_context
 struct
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:41:06 +0000
Message-ID: <155373006604.7602.11874595648703180211.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Mar 2019 23:41:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a field in the fs_context struct through which bits in the
sb->s_iflags superblock field can be set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/super.c                 |    1 +
 include/linux/fs_context.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 583a0124bc39..6c3acd633cca 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -543,6 +543,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	}
 	fc->s_fs_info = NULL;
 	s->s_type = fc->fs_type;
+	s->s_iflags |= fc->s_iflags;
 	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index eaca452088fa..98b44ad89378 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -86,6 +86,7 @@ struct fs_context {
 	void			*s_fs_info;	/* Proposed s_fs_info */
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
+	unsigned int		s_iflags;	/* OR'd with sb->s_iflags */
 	unsigned int		lsm_flags;	/* Information flags from the fs to the LSM */
 	enum fs_context_purpose	purpose:8;
 	bool			need_free:1;	/* Need to call ops->free() */

