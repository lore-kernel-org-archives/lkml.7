Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F74206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUaZgiQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfCZSuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:50:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47032 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbfCZSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:50:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so500750pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9F4IeB6jf+9vw5lH/4HiJ40P7k4RBB1mw/tnqn6qjUo=;
        b=mUaZgiQiWbGA7cBUXtQl2EW2DuZKr6j9HiZ9I7vnhE0RNTwd0jApavR1VV7ims8RfP
         7qAy0txFG0oBuSeGvS6NZOg0Pb3uFQ0non85L/PK3P15rJz217yyOcyg8JDnWdexK594
         5zK9gYh2LKZmaIryx9Hs3GpW2VqHDUcSNE633pX+WDXPVvZFQlpP46Bk8wMf86kSiNbf
         JHQZvePlccqmmtkIG0WknCWCctKlFEz4LlyKWzFEJViGtKQC1YnmXc3ZWoFC45a5JNND
         8E2ByKeT/IS5TEubA59aZdtki8jaBcGcW0Hu8d8pt1ksbRAPfkQBdPQATrnTKGdhDeof
         OXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9F4IeB6jf+9vw5lH/4HiJ40P7k4RBB1mw/tnqn6qjUo=;
        b=JyrMagJyuKd4NTre/GQTD5yqbxZmoGUJFrV5IyE7M3DGp1WPthN+cK/kc9L96ftPvG
         QXuvzvPjbNy9D41mfU5MrzcUrLVknF51BlyWtr0ZEsStotkQ3EcMWHImq3dcXSYApSyy
         KdkBeAzJ8uDeyoRb8ADcXw0jeh0vmwEp8rI2r8oO8U/0R9v8mFS9gseqVBlFlte2zCn7
         doUTJATM4kC55fOJYPnf93nhqjOHWV4K0NudfP9zf0oH74vJgpaODO+jQSQBsAz1VsC4
         0EG0oUINXGhWex80CqZ+g1qsOWwZtrR5iYbMG/6nn8sDbTaXW6T1jLQ2J4HlHAUas/c9
         N2AQ==
X-Gm-Message-State: APjAAAVaqqEcf/MhDWJDmyDwtdQxjQKGCYsdeFcc+SeVIXmVZ9o9xUC9
        oJr4ZuYeEX6fxg9zehWVEGo=
X-Google-Smtp-Source: APXvYqz7iOCqycczy9OjGpuGGYaF3mV+daU3pNiUTjM59JIIRym9kIf/mzcALJGg0YAldI3EoO0i6w==
X-Received: by 2002:a65:6201:: with SMTP id d1mr30870583pgv.382.1553626218276;
        Tue, 26 Mar 2019 11:50:18 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id q207sm30131495pgq.88.2019.03.26.11.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:50:17 -0700 (PDT)
Date:   Wed, 27 Mar 2019 00:20:12 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, laoar.shao@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] net: trace : fix  error directive in argument list
Message-ID: <20190326185012.GA7233@hari-Inspiron-1545>
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

./include/trace/events/sock.h:177:1: error: directive in argument list
./include/trace/events/sock.h:184:1: error: directive in argument list
./include/trace/events/sock.h:177:1: error: directive in argument list
./include/trace/events/sock.h:184:1: error: directive in argument list

Changed below two lines to signle line to avoid sparse error
-#if IS_ENABLED(CONFIG_IPV6)
-		if (sk->sk_family == AF_INET6) {
    to
if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {

Moved address assigning of pin6  struct outside the loop.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 include/trace/events/sock.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index a0c4b8a..22bee26 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -174,16 +174,14 @@ TRACE_EVENT(inet_sock_set_state,
		p32 = (__be32 *) __entry->daddr;
		*p32 =  inet->inet_daddr;

-#if IS_ENABLED(CONFIG_IPV6)
-		if (sk->sk_family == AF_INET6) {
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
+		pin6 = (struct in6_addr *)__entry->saddr_v6;
+
+		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {
			*pin6 = sk->sk_v6_rcv_saddr;
			pin6 = (struct in6_addr *)__entry->daddr_v6;
			*pin6 = sk->sk_v6_daddr;
		} else
-#endif
		{
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
			ipv6_addr_set_v4mapped(inet->inet_saddr, pin6);
			pin6 = (struct in6_addr *)__entry->daddr_v6;
			ipv6_addr_set_v4mapped(inet->inet_daddr, pin6);
-- 
2.7.4

