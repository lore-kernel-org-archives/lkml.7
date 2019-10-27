Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071F2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CEB21848
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210991;
	bh=LJi8viKVMKkzppmE94ulq5XiAWDEQlvE42DZARt+zVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r6wTaVY9HAtEQlmdZpuDamEJFnoOfsdYgsh4yxKfevY8xRq0jf/5E8+OfLQwRp9f/
	 8snPDINdSPvKQY5HJY7oR1t6fPq24uwL/krf5VKiQGObVTcVXk7V/o0k23G+xGT/5j
	 GLJl4X1MqItXz5GmuMaAP/1NMLqMWB1coJzQXH3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfJ0VQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbfJ0VQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:16:27 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B8B21850;
        Sun, 27 Oct 2019 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210987;
        bh=LJi8viKVMKkzppmE94ulq5XiAWDEQlvE42DZARt+zVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYsL0cssO4q+Ds4K6MFydg8ciQ76jlZcIwpI5qIwpkQ3cZ0TBWff9c70mqUWx6iM8
         aaa5GSoQ+yPOSKh93n+37XbQ05EfT3CPj1vOR+6eOy80gR5oWQLUFThNrrjAO6+anW
         78yLUE28tuRMaZVwjsKubKhaZM4pRZ2QGxFPT5SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 87/93] btrfs: tracepoints: Fix bad entry members of qgroup events
Date:   Sun, 27 Oct 2019 22:01:39 +0100
Message-Id: <20191027203315.903727534@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 1b2442b4ae0f234daeadd90e153b466332c466d8 upstream.

[BUG]
For btrfs:qgroup_meta_reserve event, the trace event can output garbage:

  qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=DATA diff=2
  qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=0x258792 diff=2

The @type can be completely garbage, as DATA type is not possible for
trace_qgroup_meta_reserve() trace event.

[CAUSE]
Ther are several problems related to qgroup trace events:
- Unassigned entry member
  Member entry::type of trace_qgroup_update_reserve() and
  trace_qgourp_meta_reserve() is not assigned

- Redundant entry member
  Member entry::type is completely useless in
  trace_qgroup_meta_convert()

Fixes: 4ee0d8832c2e ("btrfs: qgroup: Update trace events for metadata reservation")
CC: stable@vger.kernel.org # 4.10+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/btrfs.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1655,6 +1655,7 @@ TRACE_EVENT(qgroup_update_reserve,
 		__entry->qgid		= qgroup->qgroupid;
 		__entry->cur_reserved	= qgroup->rsv.values[type];
 		__entry->diff		= diff;
+		__entry->type		= type;
 	),
 
 	TP_printk_btrfs("qgid=%llu type=%s cur_reserved=%llu diff=%lld",
@@ -1677,6 +1678,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->refroot	= root->objectid;
 		__entry->diff		= diff;
+		__entry->type		= type;
 	),
 
 	TP_printk_btrfs("refroot=%llu(%s) type=%s diff=%lld",
@@ -1693,7 +1695,6 @@ TRACE_EVENT(qgroup_meta_convert,
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	refroot			)
 		__field(	s64,	diff			)
-		__field(	int,	type			)
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,


