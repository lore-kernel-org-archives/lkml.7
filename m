Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E80CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F96214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210247;
	bh=uowiTPItwsRrmuICZPSjEomKfgT65K0+Y34I2IFq3jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ES0h/3MY6DiXzziefG2z9pX8UkjJSyXT5KIGWa2AdBOodu39eh1XOIWNPsMp1MVgU
	 3yZi+8o2NTHpFUfBTLuF2N0llo6hAWObdfKNbAV+AScarusOU4aEze80j9isbcp0+U
	 TJcB8YvE4OwtWfM0oIqi3dwTayoOnXqjtsli0OSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJ0VEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfJ0VED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:03 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FAB208C0;
        Sun, 27 Oct 2019 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210242;
        bh=uowiTPItwsRrmuICZPSjEomKfgT65K0+Y34I2IFq3jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5MFZTxotCQwSS1QgKxavccoXW5lgPv7hDSyWDqY4wb8u6Lfv74tknV++SBDnQQq4
         dQA6F/8v9NADy47wpAiECWUrBAZz7jE4IIR7EbWYQcRMnTQD5VAitIKByVEF8PMrkg
         h1EJQnJs/Qxa3jSiDS3yNNGcKqNFli9z5dr/6v3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 40/41] net: sched: Fix memory exposure from short TCA_U32_SEL
Date:   Sun, 27 Oct 2019 22:01:18 +0100
Message-Id: <20191027203136.357413424@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 98c8f125fd8a6240ea343c1aa50a1be9047791b8 upstream.

Via u32_change(), TCA_U32_SEL has an unspecified type in the netlink
policy, so max length isn't enforced, only minimum. This means nkeys
(from userspace) was being trusted without checking the actual size of
nla_len(), which could lead to a memory over-read, and ultimately an
exposure via a call to u32_dump(). Reachability is CAP_NET_ADMIN within
a namespace.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/cls_u32.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -734,6 +734,7 @@ static int u32_change(struct net *net, s
 	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_U32_MAX + 1];
 	u32 htid;
+	size_t sel_size;
 	int err;
 #ifdef CONFIG_CLS_U32_PERF
 	size_t size;
@@ -827,8 +828,11 @@ static int u32_change(struct net *net, s
 		return -EINVAL;
 
 	s = nla_data(tb[TCA_U32_SEL]);
+	sel_size = sizeof(*s) + sizeof(*s->keys) * s->nkeys;
+	if (nla_len(tb[TCA_U32_SEL]) < sel_size)
+		return -EINVAL;
 
-	n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
+	n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
 	if (n == NULL)
 		return -ENOBUFS;
 
@@ -841,7 +845,7 @@ static int u32_change(struct net *net, s
 	}
 #endif
 
-	memcpy(&n->sel, s, sizeof(*s) + s->nkeys*sizeof(struct tc_u32_key));
+	memcpy(&n->sel, s, sel_size);
 	RCU_INIT_POINTER(n->ht_up, ht);
 	n->handle = handle;
 	n->fshift = s->hmask ? ffs(ntohl(s->hmask)) - 1 : 0;


