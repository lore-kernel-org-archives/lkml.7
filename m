Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A02920848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAuPyuD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfCYTxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:53:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41916 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:53:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id y5so445053plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y13WbTUHg0s22GjCN73zlNZAc4XwlWrPDIGwTVHPyA0=;
        b=ZAuPyuD1RCG2o4oewWwrcxDcElGP6p3GWeVyEfoO55fr9G2A8a7hANESkJ/oVQauyU
         LlU8LATfjiHgpBqmfw/3IauQuOzIJ+M2LWgzWk9A04IR2wSsQ2f8nL9pyHs+LGeRMl1l
         +4i6HgNGWz5UeNoYwwajJCF1uKr+r+iEFRy8/Q4bRP8NHiMR2fqGN2gpKWpILGooSvAN
         aDgk7BFoCZ0n0sVLVM2NMcbbx/llHx+RrJ/SL+44Z7OaR9A124Calrh9yny1r8V2O4Ko
         VxU9sIBGnL2xkKeYJ0r+5FdvKd02MD+oijlEyNTUToGQlqnJRV9+v178dh6KRDBF+06/
         QghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y13WbTUHg0s22GjCN73zlNZAc4XwlWrPDIGwTVHPyA0=;
        b=edtWNUVyu8nT5bXIw9Lx3xAY3AGVoMSuLJAHPyh1/mAgCQz31TUIM4aoUul05skjIj
         iSTFNA+vsv4bemgL6SffOt99Nxxz1r1EmZEwG2HB/av6rogR4xW5vYzL0HwOEBh4HrnF
         1OxVd7pXRA9fEBenDdJFaJaldHifU9PxnO22LfuC7cwosEwIMQlNXyYkoCXq5ea55c6a
         iNRYFzAyQoCF4g2xXAr2sZc0BWQm/atiD+f57gDU2EJS7GJmZ3bu33b6d3vJh71wNv+v
         I9bk/aKh0TYC/h6ZycPIjctMM0OPltLk8H0kPfQGbC4jnUCeiPySfEcyVGau9zh+vLY2
         dy2g==
X-Gm-Message-State: APjAAAXFk6idti++k00Hj5sSwavD7Qrxx8uXnZiPmy54bmim8uX7ARHw
        jtTp4LXN/VYIELhpMitJapUbtdnR
X-Google-Smtp-Source: APXvYqxlh5bjITFInW+mjMGshgtLRjALQL5KCssdfh/ZiarVb1jDPkMYDro2PgdZ/pA+s/WQ2Ext1A==
X-Received: by 2002:a17:902:e48c:: with SMTP id cj12mr3701009plb.93.1553543589509;
        Mon, 25 Mar 2019 12:53:09 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id v2sm24912328pfg.118.2019.03.25.12.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:53:08 -0700 (PDT)
Date:   Tue, 26 Mar 2019 01:23:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, roopa@cumulusnetworks.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190325195303.GA20629@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below spare errors.

Sparse error:
make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
./include/trace/events/neigh.h:73:1: error: directive in argument list
./include/trace/events/neigh.h:78:1: error: directive in argument list
./include/trace/events/neigh.h:150:1: error: directive in argument list
./include/trace/events/neigh.h:155:1: error: directive in argument list

Changes below two lines to signle line to avoid sparse error
 #if IS_ENABLED(CONFIG_IPV6)
               if (n->tbl->family == AF_INET6) {
to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)

and removes reassigning pin6 pointer when IPV6 is enabled

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 include/trace/events/neigh.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
index 0bdb085..6e310ea 100644
--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
 		else
 			*p32 = 0;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl->family == AF_INET6) {
-			pin6 = (struct in6_addr *)__entry->primary_key6;
+		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
 			*pin6 = *(struct in6_addr *)n->primary_key;
-		} else
-#endif
-		{
+		else
 			ipv6_addr_set_v4mapped(*p32, pin6);
-		}
+
 		__entry->confirmed = n->confirmed;
 		__entry->updated = n->updated;
 		__entry->used = n->used;
@@ -147,15 +143,10 @@ DECLARE_EVENT_CLASS(neigh__update,
 		else
 			*p32 = 0;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl->family == AF_INET6) {
-			pin6 = (struct in6_addr *)__entry->primary_key6;
+		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
 			*pin6 = *(struct in6_addr *)n->primary_key;
-		} else
-#endif
-		{
+		else
 			ipv6_addr_set_v4mapped(*p32, pin6);
-		}
 
 		__entry->confirmed = n->confirmed;
 		__entry->updated = n->updated;
-- 
2.7.4

