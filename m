Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEEC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247320730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUx0TOH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKRLC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:02:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33548 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:02:58 -0500
Received: by mail-pj1-f66.google.com with SMTP id o14so1388714pjr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyGlNV5WszSa8ffTJ26SNFPpy8OfAvqROGAZuR1QGHk=;
        b=fUx0TOH+xKM1nJTjTXrY/ShtFyMxKe7k90oV60jZ9Rb7dqh5cqk6MYa+oGqCK5D0xT
         Bl2E+uOR3yPDRw6JoLRo9IhqpO0TKGXSb58AjGFZ7xsRmTxXpVZn86AvbHbEIWU/Sn+p
         XE5Vl80zY36MkiasFOHPnR1flyuexV22nAcKCR0GLerjVS38FcSbEtHs9VYK8YMOiP3Y
         4kL3ZkY/YQEAmO5iSVlFMf9vCNRQ7hotDKEqDrcjm5sZLsWOvCGAy87qHB7kkkJaeEEp
         /+8fHixdG5FScsrn/gL3u70Yvyiax8XMhLWgqf58Bovwf3A3zhvtaf8zKgDlfJ19fmtz
         L8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyGlNV5WszSa8ffTJ26SNFPpy8OfAvqROGAZuR1QGHk=;
        b=B0mWulCEoWaWwxpaG6DxoiYfhWpHhXpdTYGgCQgCNXRPbUkPzU6p/HMt4h3lh7ZR2P
         LBVeaX9jxpXRiMMdyRcqM48qr78JKki8VcXIw+8bn7f67YbfNHFOaDgMxzL2mcNrLtt1
         ECxR2n1Bm1l7v2m6e201bxf5J3JTcOnwWusjGbpxnAzB/e8fJOHywxF19n5ZKMXN+sAv
         njYR4Fvf2dLu2oZrnszg/LmKQldmLms4LoCW+dX02r6jUnnzjebIYBki14h25891al4s
         67yZO++Dny3BR9c34Li2kIkYStYXaXtFnR63eJ6w+iMNtjdkFUTtiKSL9oRBgJFh995q
         71uw==
X-Gm-Message-State: APjAAAWMiLKKEuVcpfDHU8QWup/Syp/qiBxAcQYsvXAT6GuQwuD7y4eO
        D8c18UjUkiou5NL8rYZ575ZGfA==
X-Google-Smtp-Source: APXvYqxYrMCA7889sWo5/bpi651L4EJ1Qzz31bn+gzxzhOOzj8MGscqUeBn9j+oE9BBd1F9DgoF2Pw==
X-Received: by 2002:a17:902:b184:: with SMTP id s4mr29368645plr.236.1574074977396;
        Mon, 18 Nov 2019 03:02:57 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id t1sm21531407pfq.156.2019.11.18.03.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 03:02:56 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Free static OPPs on errors while adding them
Date:   Mon, 18 Nov 2019 16:32:49 +0530
Message-Id: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static OPPs aren't getting freed properly, if errors occur while
adding them. Fix that by calling _put_opp_list_kref() and putting their
reference on failures.

Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Rafael: Can this patch still go for 5.4 ? The second patch should go in
v5.5 though.

 drivers/opp/of.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1cbb58240b80..1e5fcdee043c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -678,15 +678,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			of_node_put(np);
-			return ret;
+			goto put_list_kref;
 		} else if (opp) {
 			count++;
 		}
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
-		return -ENOENT;
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
+		goto put_list_kref;
+	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
 		pstate_count += !!opp->pstate;
@@ -695,7 +697,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count && pstate_count != count) {
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto put_list_kref;
 	}
 
 	if (pstate_count)
@@ -704,6 +707,11 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	opp_table->parsed_static_opps = true;
 
 	return 0;
+
+put_list_kref:
+	_put_opp_list_kref(opp_table);
+
+	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
@@ -738,6 +746,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
+			_put_opp_list_kref(opp_table);
 			return ret;
 		}
 		nr -= 2;
-- 
2.21.0.rc0.269.g1a574e7a288b

