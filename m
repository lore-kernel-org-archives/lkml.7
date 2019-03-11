Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815C82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334430;
	bh=NDW14k+WaO8haX/CP+qnrw7K4z0Sj5X55grZIP0vMI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfgumgQ9hiltJ1QZ/bNomIRn5ZyLY7SKkime1Hc1qbxvxcWovPGB6uG9l8dIN4St1
	 /LRN5lq/sVr9MdkS+5MAQ22QnM4UY2R9xomdJrJCBtBFpL+2lezKizfONaHyZqGG3/
	 HZ1FqUWX0VvKbs2OGEiIAk8NHxA4Z77JYIu49fB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfCKUA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbfCKT75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B870214AF;
        Mon, 11 Mar 2019 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334397;
        bh=NDW14k+WaO8haX/CP+qnrw7K4z0Sj5X55grZIP0vMI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsH1//c/E8lIw11s5mziffB2l11gygr/EofwkzM7QxqBXj9WvbaaeIYHcrC/QKvlU
         wlD1mxkKoutp7nV9r0QlqnyIfKIy3Z8Jx4RIE054FS3PFgOy1LW/aCVowEpvf5uFkO
         bmLWIUwS8dQffFaYeqXzzGKK6THKl4KJinQaqWTo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 3/6] team: avoid complex list operations in team_nl_cmd_options_set()
Date:   Mon, 11 Mar 2019 15:59:48 -0400
Message-Id: <20190311195951.139741-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195951.139741-1-sashal@kernel.org>
References: <20190311195951.139741-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 3e0f7116380d..eb04b348edf3 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -253,17 +253,6 @@ static void __team_option_inst_mark_removed_port(struct team *team,
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
@@ -2435,7 +2424,6 @@ static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
 	int err = 0;
 	int i;
 	struct nlattr *nl_option;
-	LIST_HEAD(opt_inst_list);
 
 	team = team_nl_team_get(info);
 	if (!team)
@@ -2451,6 +2439,7 @@ static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
 		struct nlattr *opt_attrs[TEAM_ATTR_OPTION_MAX + 1];
 		struct nlattr *attr;
 		struct nlattr *attr_data;
+		LIST_HEAD(opt_inst_list);
 		enum team_option_type opt_type;
 		int opt_port_ifindex = 0; /* != 0 for per-port options */
 		u32 opt_array_index = 0;
@@ -2554,23 +2543,17 @@ static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
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
-- 
2.19.1

