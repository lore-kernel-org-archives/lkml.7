Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24040C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E424B218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355157;
	bh=YgJP8LPJWE1fttp1UkK4cPW97RAhni5HTj/ZTvGpHBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pq5/WT46hyKPH+3r6Y5az7G4u1LhgVMZhOVXOmxhHjrrpmnz/Du+0lqa116EBL91r
	 vgeMDErxXYl9OVC/KlvYDFympAu/4MkfgS0DlB0OUxisVHekRYsUNrT2+cIGxz9S7v
	 dor8mtfwAzdvI46x8evreF/AoWbNp193opDUopjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfDOTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbfDOTFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EA62087C;
        Mon, 15 Apr 2019 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355151;
        bh=YgJP8LPJWE1fttp1UkK4cPW97RAhni5HTj/ZTvGpHBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eckoPQoISjjEyGWIN3uY1GNzBgFF3EMk2wb9vdUP9E3vjpGY+bEPMHzJVVeYdsuqr
         5Fmiyul5rZLAtrcgwswqMD01WNVqG3JRar6RIEOEFTSpc54rnTeU/AqGtStZrTPyZ/
         ZPoZstHYgEYpPPWSbrCsUt7Dl3GN5q94NjctJ29I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Yotam Gigi <yotam.gi@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/101] net/sched: act_sample: fix divide by zero in the traffic path
Date:   Mon, 15 Apr 2019 20:58:13 +0200
Message-Id: <20190415183741.183975442@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fae2708174ae95d98d19f194e03d6e8f688ae195 ]

the control path of 'sample' action does not validate the value of 'rate'
provided by the user, but then it uses it as divisor in the traffic path.
Validate it in tcf_sample_init(), and return -EINVAL with a proper extack
message in case that value is zero, to fix a splat with the script below:

 # tc f a dev test0 egress matchall action sample rate 0 group 1 index 2
 # tc -s a s action sample
 total acts 1

         action order 0: sample rate 1/0 group 1 pipe
          index 2 ref 1 bind 1 installed 19 sec used 19 sec
         Action statistics:
         Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
         backlog 0b 0p requeues 0
 # ping 192.0.2.1 -I test0 -c1 -q

 divide error: 0000 [#1] SMP PTI
 CPU: 1 PID: 6192 Comm: ping Not tainted 5.1.0-rc2.diag2+ #591
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:tcf_sample_act+0x9e/0x1e0 [act_sample]
 Code: 6a f1 85 c0 74 0d 80 3d 83 1a 00 00 00 0f 84 9c 00 00 00 4d 85 e4 0f 84 85 00 00 00 e8 9b d7 9c f1 44 8b 8b e0 00 00 00 31 d2 <41> f7 f1 85 d2 75 70 f6 85 83 00 00 00 10 48 8b 45 10 8b 88 08 01
 RSP: 0018:ffffae320190ba30 EFLAGS: 00010246
 RAX: 00000000b0677d21 RBX: ffff8af1ed9ec000 RCX: 0000000059a9fe49
 RDX: 0000000000000000 RSI: 000000000c7e33b7 RDI: ffff8af23daa0af0
 RBP: ffff8af1ee11b200 R08: 0000000074fcaf7e R09: 0000000000000000
 R10: 0000000000000050 R11: ffffffffb3088680 R12: ffff8af232307f80
 R13: 0000000000000003 R14: ffff8af1ed9ec000 R15: 0000000000000000
 FS:  00007fe9c6d2f740(0000) GS:ffff8af23da80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fff6772f000 CR3: 00000000746a2004 CR4: 00000000001606e0
 Call Trace:
  tcf_action_exec+0x7c/0x1c0
  tcf_classify+0x57/0x160
  __dev_queue_xmit+0x3dc/0xd10
  ip_finish_output2+0x257/0x6d0
  ip_output+0x75/0x280
  ip_send_skb+0x15/0x40
  raw_sendmsg+0xae3/0x1410
  sock_sendmsg+0x36/0x40
  __sys_sendto+0x10e/0x140
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x60/0x210
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [...]
  Kernel panic - not syncing: Fatal exception in interrupt

Add a TDC selftest to document that 'rate' is now being validated.

Reported-by: Matteo Croce <mcroce@redhat.com>
Fixes: 5c5670fae430 ("net/sched: Introduce sample tc action")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Yotam Gigi <yotam.gi@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_sample.c                        | 10 ++++++--
 .../tc-testing/tc-tests/actions/sample.json   | 24 +++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 6b67aa13d2dd..c7f5d630d97c 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -43,8 +43,8 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 	struct tc_action_net *tn = net_generic(net, sample_net_id);
 	struct nlattr *tb[TCA_SAMPLE_MAX + 1];
 	struct psample_group *psample_group;
+	u32 psample_group_num, rate;
 	struct tc_sample *parm;
-	u32 psample_group_num;
 	struct tcf_sample *s;
 	bool exists = false;
 	int ret, err;
@@ -80,6 +80,12 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 		return -EEXIST;
 	}
 
+	rate = nla_get_u32(tb[TCA_SAMPLE_RATE]);
+	if (!rate) {
+		NL_SET_ERR_MSG(extack, "invalid sample rate");
+		tcf_idr_release(*a, bind);
+		return -EINVAL;
+	}
 	psample_group_num = nla_get_u32(tb[TCA_SAMPLE_PSAMPLE_GROUP]);
 	psample_group = psample_group_get(net, psample_group_num);
 	if (!psample_group) {
@@ -91,7 +97,7 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&s->tcf_lock);
 	s->tcf_action = parm->action;
-	s->rate = nla_get_u32(tb[TCA_SAMPLE_RATE]);
+	s->rate = rate;
 	s->psample_group_num = psample_group_num;
 	RCU_INIT_POINTER(s->psample_group, psample_group);
 
diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/sample.json b/tools/testing/selftests/tc-testing/tc-tests/actions/sample.json
index 3aca33c00039..618def9bdf0e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/sample.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/sample.json
@@ -143,6 +143,30 @@
             "$TC actions flush action sample"
         ]
     },
+    {
+        "id": "7571",
+        "name": "Add sample action with invalid rate",
+        "category": [
+            "actions",
+            "sample"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action sample",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action sample rate 0 group 1 index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC actions get action sample index 2",
+        "matchPattern": "action order [0-9]+: sample rate 1/0 group 1.*index 2 ref",
+        "matchCount": "0",
+        "teardown": [
+            "$TC actions flush action sample"
+        ]
+    },
     {
         "id": "b6d4",
         "name": "Add sample action with mandatory arguments and invalid control action",
-- 
2.19.1



