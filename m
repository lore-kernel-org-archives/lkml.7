Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98877C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A1F21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254138;
	bh=X9+c5gxf7/2GeHQgPBiCZFskD4tt8pD43rSObb/q25Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O26n0ZUe18vEi/buSoA+6+D54s0oJ5/eERnaGmEwUFdUzklguM/8G8/juoUaujDjn
	 xv/VpQuULe/W4s0KdR/Zj2T9Gw5+zvKT9b+WDvB8LYqugn0/l+xCpR9ex3PK43b4zz
	 z7y5HPjUakFvk2zI7kRAcKS5hb/vrZFCWk11AAho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfCVL25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfCVL2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:28:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F89821925;
        Fri, 22 Mar 2019 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254130;
        bh=X9+c5gxf7/2GeHQgPBiCZFskD4tt8pD43rSObb/q25Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xa5iZPrg8qE+R3qA11AUQoytnuWzioIn5UA4QejKLLSqrUmZofkYFpfeKPn2/m0+O
         SpVkwN6prZEOYhh4IcPn2fQWLbdBVRhpb/YhrwtRnXCqjlG5RgFVjq7p4WfE87Eq8z
         3YD7MxYuEH2Z382xqSalsyRZ31ITeHibpGhA5yM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4d4af685432dc0e56c91@syzkaller.appspotmail.com,
        syzbot+68ee510075cf64260cc4@syzkaller.appspotmail.com,
        Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 025/230] team: avoid complex list operations in team_nl_cmd_options_set()
Date:   Fri, 22 Mar 2019 12:12:43 +0100
Message-Id: <20190322111238.468869501@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 2fdeee2549231b1f989f011bb18191f5660d3745 ]

The current opt_inst_list operations inside team_nl_cmd_options_set()
is too complex to track:

    LIST_HEAD(opt_inst_list);
    nla_for_each_nested(...) {
        list_for_each_entry(opt_inst, &team->option_inst_list, list) {
            if (__team_option_inst_tmp_find(&opt_inst_list, opt_inst))
                continue;
            list_add(&opt_inst->tmp_list, &opt_inst_list);
        }
    }
    team_nl_send_event_options_get(team, &opt_inst_list);

as while we retrieve 'opt_inst' from team->option_inst_list, it could
be added to the local 'opt_inst_list' for multiple times. The
__team_option_inst_tmp_find() doesn't work, as the setter
team_mode_option_set() still calls team->ops.exit() which uses
->tmp_list too in __team_options_change_check().

Simplify the list operations by moving the 'opt_inst_list' and
team_nl_send_event_options_get() into the nla_for_each_nested() loop so
that it can be guranteed that we won't insert a same list entry for
multiple times. Therefore, __team_option_inst_tmp_find() can be removed
too.

Fixes: 4fb0534fb7bb ("team: avoid adding twice the same option to the event list")
Fixes: 2fcdb2c9e659 ("team: allow to send multiple set events in one message")
Reported-by: syzbot+4d4af685432dc0e56c91@syzkaller.appspotmail.com
Reported-by: syzbot+68ee510075cf64260cc4@syzkaller.appspotmail.com
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -247,17 +247,6 @@ static void __team_option_inst_mark_remo
 	}
 }
 
-static bool __team_option_inst_tmp_find(const struct list_head *opts,
-					const struct team_option_inst *needle)
-{
-	struct team_option_inst *opt_inst;
-
-	list_for_each_entry(opt_inst, opts, tmp_list)
-		if (opt_inst == needle)
-			return true;
-	return false;
-}
-
 static int __team_options_register(struct team *team,
 				   const struct team_option *option,
 				   size_t option_count)
@@ -2447,7 +2436,6 @@ static int team_nl_cmd_options_set(struc
 	int err = 0;
 	int i;
 	struct nlattr *nl_option;
-	LIST_HEAD(opt_inst_list);
 
 	team = team_nl_team_get(info);
 	if (!team)
@@ -2463,6 +2451,7 @@ static int team_nl_cmd_options_set(struc
 		struct nlattr *opt_attrs[TEAM_ATTR_OPTION_MAX + 1];
 		struct nlattr *attr;
 		struct nlattr *attr_data;
+		LIST_HEAD(opt_inst_list);
 		enum team_option_type opt_type;
 		int opt_port_ifindex = 0; /* != 0 for per-port options */
 		u32 opt_array_index = 0;
@@ -2566,23 +2555,17 @@ static int team_nl_cmd_options_set(struc
 			if (err)
 				goto team_put;
 			opt_inst->changed = true;
-
-			/* dumb/evil user-space can send us duplicate opt,
-			 * keep only the last one
-			 */
-			if (__team_option_inst_tmp_find(&opt_inst_list,
-							opt_inst))
-				continue;
-
 			list_add(&opt_inst->tmp_list, &opt_inst_list);
 		}
 		if (!opt_found) {
 			err = -ENOENT;
 			goto team_put;
 		}
-	}
 
-	err = team_nl_send_event_options_get(team, &opt_inst_list);
+		err = team_nl_send_event_options_get(team, &opt_inst_list);
+		if (err)
+			break;
+	}
 
 team_put:
 	team_nl_team_put(team);


