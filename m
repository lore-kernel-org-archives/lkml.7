Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C74C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3922313
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvkhe0Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKSAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:23:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37365 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKSAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:23:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so15434456lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 16:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4llU1F6LnwHCj5QCkkDFR2utRYRS39lSfGOyGIyfVHo=;
        b=hvkhe0HyZsyEUxKasN7CBPhArMPIxYuemst7zJgC6mwFDHbojiQUgTIES3kmaCgK7H
         wzEpToDBrdS32NzPxH55/yoFLKYB+TYZkHGZgbBwMSgnki3v21XSkhc5LYUanlkIKLy6
         4+y75ud2n1Iv24PNKkuKgy1+Bkac1xakcVGnUm06kDcreZO+YT+BbPVVQ3yNOfH4T7Qh
         BScxdSlLv8rDbQYBtqSVom7DP3EZHr3Oc3aRXHI7cyCoVNOuX+5YaT+KGKJVsjIN8hkl
         MSOsM3+L4aDwy11MnhjP9KbgrEKTBCTVY/U4k+FWEQ2axXFPiLjFwwyf9F880YnT1iFR
         7yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4llU1F6LnwHCj5QCkkDFR2utRYRS39lSfGOyGIyfVHo=;
        b=Vs7smdGZdP7SckJpmwxMUuvSECwno9ZwSDCmPpv6M5r+th5KoL3FMM/wDTSFes4owf
         Eq5ht+sVRqnDoM8G4+5WhqAfYmw1FO6n6fXDK01awbG3/ZsexJzPj+nNckJBB6DqbSBW
         fh39eEJGt8nPFUcGxQ9i7wFPgjOvhsCqIcuCgaoSmlUpjxKtllniimaZY0lSqjD/DhI8
         kRjLbq6uG9XlQDHcJhxB3FzXfGbq8iM1Xk0dTcIy+/QTvLxzIVDVNOYad3NObK+n0bot
         EZNRzoo007573CyTEny3Hv8use98YYp+uJJSimrWr4BbwpNZlfTcesKbfdH3NEcQuqv4
         OCCA==
X-Gm-Message-State: APjAAAWcg/qLGA0nC3FhlO5ZQHOX5tdpud6r5PTektsgjcx/73udi9Bd
        Qo7sX+EtBH1kcF05taNna57VyA==
X-Google-Smtp-Source: APXvYqxzCBXE23ht+1iaif+rlqHGf5YhEfM5ZZzaeubaq3PrsNd7qh/NH8WgFa5bgfBk/VQDkNwpRw==
X-Received: by 2002:a19:6e06:: with SMTP id j6mr1468098lfc.6.1574122996442;
        Mon, 18 Nov 2019 16:23:16 -0800 (PST)
Received: from localhost.localdomain (57-201-94-178.pool.ukrtel.net. [178.94.201.57])
        by smtp.gmail.com with ESMTPSA id i6sm2633167lfo.12.2019.11.18.16.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:23:15 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     netdev@vger.kernel.org, davem@davemloft.net,
        vinicius.gomes@intel.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [net PATCH v2] taprio: don't reject same mqprio settings
Date:   Tue, 19 Nov 2019 02:23:12 +0200
Message-Id: <20191119002312.23811-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The taprio qdisc allows to set mqprio setting but only once. In case
if mqprio settings are provided next time the error is returned as
it's not allowed to change traffic class mapping in-flignt and that
is normal. But if configuration is absolutely the same - no need to
return error. It allows to provide same command couple times,
changing only base time for instance, or changing only scheds maps,
but leaving mqprio setting w/o modification. It more corresponds the
message: "Changing the traffic mapping of a running schedule is not
supported", so reject mqprio if it's really changed.

Also corrected TC_BITMASK + 1 for consistency, as proposed.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

v2..v1:
- rebased on net/master instead of net-next/master
- added fixes tag
- corrected TC_BITMASK + 1 and used <=

 net/sched/sch_taprio.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 7cd68628c637..c609373c8661 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -922,7 +922,7 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
 	}
 
 	/* Verify priority mapping uses valid tcs */
-	for (i = 0; i < TC_BITMASK + 1; i++) {
+	for (i = 0; i <= TC_BITMASK; i++) {
 		if (qopt->prio_tc_map[i] >= qopt->num_tc) {
 			NL_SET_ERR_MSG(extack, "Invalid traffic class in priority to traffic class mapping");
 			return -EINVAL;
@@ -1347,6 +1347,26 @@ static int taprio_parse_clockid(struct Qdisc *sch, struct nlattr **tb,
 	return err;
 }
 
+static int taprio_mqprio_cmp(const struct net_device *dev,
+			     const struct tc_mqprio_qopt *mqprio)
+{
+	int i;
+
+	if (!mqprio || mqprio->num_tc != dev->num_tc)
+		return -1;
+
+	for (i = 0; i < mqprio->num_tc; i++)
+		if (dev->tc_to_txq[i].count != mqprio->count[i] ||
+		    dev->tc_to_txq[i].offset != mqprio->offset[i])
+			return -1;
+
+	for (i = 0; i <= TC_BITMASK; i++)
+		if (dev->prio_tc_map[i] != mqprio->prio_tc_map[i])
+			return -1;
+
+	return 0;
+}
+
 static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
@@ -1398,6 +1418,10 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	admin = rcu_dereference(q->admin_sched);
 	rcu_read_unlock();
 
+	/* no changes - no new mqprio settings */
+	if (!taprio_mqprio_cmp(dev, mqprio))
+		mqprio = NULL;
+
 	if (mqprio && (oper || admin)) {
 		NL_SET_ERR_MSG(extack, "Changing the traffic mapping of a running schedule is not supported");
 		err = -ENOTSUPP;
@@ -1455,7 +1479,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 					    mqprio->offset[i]);
 
 		/* Always use supplied priority mappings */
-		for (i = 0; i < TC_BITMASK + 1; i++)
+		for (i = 0; i <= TC_BITMASK; i++)
 			netdev_set_prio_tc_map(dev, i,
 					       mqprio->prio_tc_map[i]);
 	}
-- 
2.20.1

