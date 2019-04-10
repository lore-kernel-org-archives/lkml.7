Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BD8C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foreca.com header.i=@foreca.com header.b="IOjE0o+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfDJKUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:20:20 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:33672 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfDJKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:20:19 -0400
Received: by mail-wr1-f100.google.com with SMTP id q1so2294825wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foreca.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vI7ruPzpUPREcaOqSaDKx5BAPKGyNixmHz5zVAr3Sf8=;
        b=IOjE0o+ceSAIkYociAOManH3puI7rMgMPkkGDYLpwFDaC0GyT3GBfCoUzoyabnWyXu
         YSTnYpJtcrCPxSdW3yLm28HMQxEuHPYEXuz+LUWA6KOMWqCZ3gdnu1qIPJ64OccBfjwl
         6sduuClhbt5McHr7Y+PC4CKCg3WuAfVEOEx0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vI7ruPzpUPREcaOqSaDKx5BAPKGyNixmHz5zVAr3Sf8=;
        b=pkM/a7j/GJZkcEwiPrcrNP+Gn+AFfW4kjUhMjNm5Lhmq3VkMNMZ56jDOhYnVS1ZW6W
         HzZQMqgABJ3xKeXztT6o5e8WYx72ZbgViPjeoOe4U41K9pbr4IdzcKAm/+DKX0JQehk7
         H65y7WV7Vr5BkRbYjXPc730RoiNu8VC/5upy3P70yEztOvGkk0dbXWfWSCmaW0SvtJPj
         AIa0Yh/dnMYC2mo2z6FZepLQbN+2ZiGrw5eSpjGI9eUjtaRHkI/BKH71wy9uV4IUCqzg
         xQgpqEoQkqsi3IsVkUAJPHQ+Ol+01tLzUAfZi+UczQuEIGtZBrOBAdj4XsMdFlxkBSXN
         HaTQ==
X-Gm-Message-State: APjAAAXzQH/O2kNl2491gFLqhdziGr2J/ssKbKlNp0cYvkMSMrinVodd
        vfpeEZYb8mVt1zJgIBxf2hvOXoGLfPhfMQpsRGKGbVOsQmh6BQ==
X-Google-Smtp-Source: APXvYqzBO39YNBE+QzyoJuwJn6zuw8+xvSPoSUKOeuY4F7i4xO16Ld3EGtazbQiBrZ760/BQmzothFItO2rG
X-Received: by 2002:adf:dbce:: with SMTP id e14mr27277330wrj.249.1554891617325;
        Wed, 10 Apr 2019 03:20:17 -0700 (PDT)
Received: from juhisz240.foreca.com ([62.209.167.158])
        by smtp-relay.gmail.com with ESMTP id u16sm726155wri.12.2019.04.10.03.20.16;
        Wed, 10 Apr 2019 03:20:17 -0700 (PDT)
X-Relaying-Domain: foreca.com
From:   Juha-Matti Tilli <juha-matti.tilli@foreca.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     juha-matti.tilli@foreca.com, Eric Dumazet <edumazet@google.com>,
        Rafael Aquini <aquini@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>
Subject: [PATCH] net: add big honking pfmemalloc OOM warning
Date:   Wed, 10 Apr 2019 13:19:47 +0300
Message-Id: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A system administrator is not notified (except via an obscure SNMP
counter that most sysadmins don't know to look for) if packets are
dropped due to out-of-memory condition when SKBs use pfmemalloc
reserves. This can for example lead to NFS connections hanging on
high-volume systems.

Implement a ratelimited big honking out of memory warning that directs
the sysadmin to bump up vm.min_free_kbytes in case this problem happens.
Our experience shows that with default vm.min_free_kbytes (90112, or
about 90 megabytes), NFS connections hang approximately once per day,
whereas with 901120 (default multiplied by 10) NFS connections never
hang.

Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Murphy Zhou <xzhou@redhat.com>
Cc: Yongcheng Yang <yoyang@redhat.com>
Cc: Jianhong Yin <jiyin@redhat.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fc92ebc4e200..7d8ef239b9af 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -99,6 +99,8 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
 	 * helping free memory
 	 */
 	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
+		printk_ratelimited(KERN_WARNING
+				   "dropped packet due to out-of-memory condition, please bump up vm.min_free_kbytes\n");
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
 		return -ENOMEM;
 	}
-- 
2.17.1

