Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6419FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MoTEa90j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfG3XKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:10:43 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:34212 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfG3XKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:10:42 -0400
Received: by mail-pg1-f172.google.com with SMTP id n9so24602191pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMAGuu53qq71mkY/dOmSePxlYMgR7q2jwJRIFacTZR4=;
        b=MoTEa90jICHzSc9qjZVoXVjbhgfPIwQxVoUmnzBO+/jwc1ZXZP7xkmkT+FKzuMxvU/
         b05duTgHj6xs0Odm6O6LZIFIj4tAjp31T+mBH7RKtpahLlDqA3yJ1VpXpO1b3ngZnwt6
         8v/KOjYU//zDdt7hxsWOShUiN0bl0YVl2oq+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMAGuu53qq71mkY/dOmSePxlYMgR7q2jwJRIFacTZR4=;
        b=cA+pnHjRAFG3N/W4JbPLrQ4DOyh7/bNMCw5HdnxQvct/4Hb1P8qM99Q+CgfmZsNCwi
         uqf9bMSTWIveqep45Vn8XwVO5BVPuPgrB9Wdd2Q+1idG/cFDRJ95nkWeMH92dHyxuljJ
         LKK+FLHrOQhDOGCeR4KBQ5qcnVJCQLenlUa46xOZ0l8/HEf0MSEIqRRoDHSF5POOz5Ie
         NDHXql0ThhaU9gpmn5TV+2MccuHc0WTLIk8KdCGST2P+BTYHRo7ZrtzQUd4DQ5auLScM
         2BnG/h3TSloOjXMG/rsC1LMI0Phv6/Aj195li8zUS6mHmoIRVtJDQdxyU7HVPIjof2l1
         Y75A==
X-Gm-Message-State: APjAAAWeX1H0ExNb+z+yZy7SAJyMrovaXiCC4zT3L/FQnxytszqAJUxr
        asG8N6ocwGBoC1Mcnh3zbzSbK/Qu
X-Google-Smtp-Source: APXvYqwfFo9JwMIZ3bQ77MPOxt4Ns64+bY5Qq4p8zaKdoy5I8EHTisW4rFsjt7rfNTa8WaLYx+WBgA==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr45725265pfr.38.1564528241582;
        Tue, 30 Jul 2019 16:10:41 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm75205576pje.3.2019.07.30.16.10.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 16:10:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 0/3] Convert some RCU articles to ReST
Date:   Tue, 30 Jul 2019 19:10:27 -0400
Message-Id: <20190730231030.27510-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a respin of the RCU ReST patch from Mauro [1].

I updated his changelog, and made some fixes.

[1] https://www.spinics.net/lists/rcu/msg00750.html

Joel Fernandes (Google) (2):
docs: rcu: Correct links referring to titles
docs: rcu: Increase toctree to 3

Mauro Carvalho Chehab (1):
docs: rcu: convert some articles from html to ReST

.../Data-Structures/Data-Structures.html      | 1391 -------
.../Data-Structures/Data-Structures.rst       | 1163 ++++++
.../Expedited-Grace-Periods.html              |  668 ----
.../Expedited-Grace-Periods.rst               |  521 +++
.../Memory-Ordering/Tree-RCU-Diagram.html     |    9 -
.../Tree-RCU-Memory-Ordering.html             |  704 ----
.../Tree-RCU-Memory-Ordering.rst              |  624 +++
.../RCU/Design/Requirements/Requirements.html | 3330 -----------------
.../RCU/Design/Requirements/Requirements.rst  | 2650 +++++++++++++
Documentation/RCU/index.rst                   |    7 +-
Documentation/RCU/whatisRCU.txt               |    4 +-
11 files changed, 4966 insertions(+), 6105 deletions(-)
delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst

--
2.22.0.709.g102302147b-goog

