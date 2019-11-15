Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79258C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D5820706
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+QjIhLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKOB52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:57:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44477 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfKOB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:57:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id z188so6671505lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 17:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhwfCvUXZdHcPjd/8gnXz63IRCXwmj0cc9MwMWk9XXQ=;
        b=e+QjIhLz/WsEJAN12AxLkTNiXTZIBr5lqC50IVP0v3sj3Dv4Vght57Kv79N+t2D0uf
         U+mTHNdA3WbMGdb9k6sJoOovSavYzNoubzdH8/k9oiMusB8TRlv5I8W07vZMh+xP4SNn
         66YT/YbdoWng9ye34W9IfWIPnEeHVWKymthBeju9oAksBfbIcCppd3oKuMK5KzpzAWK9
         gYOUlRqvPBWPnSEtGjNvz2c2Gvgsw/aSfn9s+yPjqNsGBMu6TDE2zdKdJk+awScoOZGn
         He2vsQHPpfNKqMPSrFqqwuUWbNuD/zy/vh7AhQmMdOECtXu/kiIeXELfwO+pIPVp/1Up
         peIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhwfCvUXZdHcPjd/8gnXz63IRCXwmj0cc9MwMWk9XXQ=;
        b=YAFml4s7B/WwiNrlpBiJu/4UL/hnsx2PKL2zkjddKgCaqIpjkcKkdLOzkONp9G+4OR
         QJxx2cJLe7dlfBQknh9sa7TLGvYRe7gtudPsv6i87siDeNJSO8lJk3evBs/mqdoLFqZ5
         uBwMBVP38ZaI8mnQgHxhITC8gQY15e7q7c1OdN7pquYcPOXE26gxVsdXW7Rh5MPS3UCy
         2iv+ofYmkj6qn8uUTjXTLtFALg0BlgwJEvTq+WGj54Cgp0ghY4W4VHK2h1puDS67wWyU
         H3rVjsHPYErGW4yRUftNH7u7WP1heTq2zmBwMpvO5FXKmzOdUvh2Cth5+E+qslHKTyKf
         o0rA==
X-Gm-Message-State: APjAAAXzKVvuucecJ/VTzAjJ03kSMa/t0aJy2cvEorjyRF/Zcpc5Zgfv
        mFrRC0lrId5rFbbWORb50aOJlkWyNY4=
X-Google-Smtp-Source: APXvYqz1qOY1cWE8Vi59QvBvRmmDiO65qvpBAwJtShWlFCb8fPUP7tPVw8M2P1uoObYofhL+pdmBGA==
X-Received: by 2002:a19:3f07:: with SMTP id m7mr9468163lfa.136.1573783043837;
        Thu, 14 Nov 2019 17:57:23 -0800 (PST)
Received: from localhost.localdomain (57-201-94-178.pool.ukrtel.net. [178.94.201.57])
        by smtp.gmail.com with ESMTPSA id v22sm4376394lfg.63.2019.11.14.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:57:22 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     netdev@vger.kernel.org, davem@davemloft.net,
        vinicius.gomes@intel.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [net-next PATCH] taprio: don't reject same mqprio settings
Date:   Fri, 15 Nov 2019 03:56:07 +0200
Message-Id: <20191115015607.11291-1-ivan.khoronzhuk@linaro.org>
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

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 7cd68628c637..bd844f2cbf7a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1347,6 +1347,26 @@ static int taprio_parse_clockid(struct Qdisc *sch, struct nlattr **tb,
 	return err;
 }
 
+static int taprio_mqprio_cmp(struct net_device *dev,
+			     struct tc_mqprio_qopt *mqprio)
+{
+	int i;
+
+	if (mqprio->num_tc != dev->num_tc)
+		return -1;
+
+	for (i = 0; i < mqprio->num_tc; i++)
+		if (dev->tc_to_txq[i].count != mqprio->count[i] ||
+		    dev->tc_to_txq[i].offset != mqprio->offset[i])
+			return -1;
+
+	for (i = 0; i < TC_BITMASK + 1; i++)
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
+	if (mqprio && !taprio_mqprio_cmp(dev, mqprio))
+		mqprio = NULL;
+
 	if (mqprio && (oper || admin)) {
 		NL_SET_ERR_MSG(extack, "Changing the traffic mapping of a running schedule is not supported");
 		err = -ENOTSUPP;
-- 
2.20.1

