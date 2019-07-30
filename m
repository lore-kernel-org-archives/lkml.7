Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6178EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326D0208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="m9w6IXJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfG3XKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:10:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41993 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfG3XKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:10:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so29518196plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbc1U09jTLuENF9CdH6+fFSH+tS4PtmX724pOlUGPis=;
        b=m9w6IXJhaX17fLH03jYIFT4rvYZraozkY0fj39hcVFch7xhdlcjJ8NeHFY4RJX0P+0
         azT01AYPo6pDsNy7bzXQUtGNjVec7gVS/Cq+jgM/kc9A0NnefzYGs2RDloLY4/8VnFGi
         Zk9PDPGnjixjL/1tY63Tz7u2K8TJLsV6s2r24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbc1U09jTLuENF9CdH6+fFSH+tS4PtmX724pOlUGPis=;
        b=T6NxOX5Dbc5/NIE2RPp7hkPXaS8c84gYjaMldgKXwWj/InX6B7Fo4ub9r8RxIi1jUF
         YCeaagfmdjPXvtOV4LwOhAhGo6O+ybNqZbxsChCRxO45URDM1jV+/LvqgNg3ri8/LHTM
         g00voWJwiSB5yEs3RB7ruz/mxpAXbaPf09Uah3ate0uVyrGWZAURzunYNw1wp2PX1fgw
         jyDMV2p+8v8NHlL+3G9O7pky2o2vT/dDrb1UqqhibywhmzpeQpHL6lXz63Bne4Aq7OFi
         jNkViZQWQp+zXDKTgR5nJSNNYgedJC/YrotUNNv7z29qk5GLaMTGkXFQazfqn6mLEVdL
         I9lA==
X-Gm-Message-State: APjAAAWWCMva6yPf1K9PGMw/VVM/sz9U4GoasHA2BxsM0DT+78oiWvVC
        Rh1ne8nny3dox/tGjGiNNDMtG5q3
X-Google-Smtp-Source: APXvYqxG5b+Rl+s/o26fAgQL3b/XbMAGNNZfCtMZEji8+gv7G2h6iYo2cE+Deq37qEUg6911+AjL1g==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr119943082plo.1.1564528249715;
        Tue, 30 Jul 2019 16:10:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm75205576pje.3.2019.07.30.16.10.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 16:10:49 -0700 (PDT)
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
Subject: [PATCH v3 3/3] docs: rcu: Increase toctree to 3
Date:   Tue, 30 Jul 2019 19:10:30 -0400
Message-Id: <20190730231030.27510-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730231030.27510-1-joel@joelfernandes.org>
References: <20190730231030.27510-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These documents are long and have various sections. Provide a good
toc nesting level.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 94427dc1f23d..5c99185710fa 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -5,7 +5,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 3
 
    rcu
    listRCU
-- 
2.22.0.709.g102302147b-goog

