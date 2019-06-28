Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9699CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6141A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="rukbDA3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF1Chq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:37:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35766 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF1Chp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:37:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so2349053plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=roaztKtTkRu8pn3yWaNhfvLdHNSmDj0YJDhL6E5EN+0=;
        b=rukbDA3CpnhMC7Q3iFXSeQ2HtDS7nCRUjmzI73bUUVB22U1aRiyRjlQ9Zh9EDbi/V6
         U4nUJWUK3Xh6Y54+Rkfas3b5KPNZvIxPiAhdgV2OIj+WJMHyXoPqJSU83OaUclWn90Zi
         PZjEXxHlwrWFKhfq0Qk49+IaZcw6ssGei44MrIbwlLKRPkOwkzkv0jM9rEnCw+vOeIMs
         EITDkhfRKI28nKKknobZm+0zSIMv9Y0taN+4zXHhKeq4bxbPJ5A1d+mGh3ZDq75As6oV
         1TeJtBZJKbzU+16ItZURdexunhMxEY1sMlyuc5o8w5rmUK/A6mh1iNBSsYsz0dh8QW0J
         TRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=roaztKtTkRu8pn3yWaNhfvLdHNSmDj0YJDhL6E5EN+0=;
        b=D2Bbo5tOpgi5pvSqkU8Z7EMi/+7k+IOXjLOmdIKTxrhYE1mquCyGY9qGIVONTaDm3W
         brx+uIXlUD0yp4CXQIhkz+OefPU3wx93izm+29t2y/LKUCmiO6x4klSByiCfn6r6BZ4n
         YBhHumRN/yJ3W83S46jPWmiT9rdaZKbc0r/SRPnGLvVP2a4WQbepIJC9HSuxyXjpjyVq
         rEMPOmlkg7qMaux5DTx9gLHAJq31imR6nBcfuuZWHmMX04yghuRXxNl+UfRweJfseziv
         BbYkUkkN8TlUhYXNKJa5a7FrUtnW6hwG7cXsKORceBa2jx7RIZFZ2Wm685lWr65/h93M
         TwcQ==
X-Gm-Message-State: APjAAAXyX69XGdQwZcGmty+j5pbWtJi55HV8pWu0cquOddVFdY3dKu7M
        SZTCadJV7IrOY///kYq/wailghFiMDY=
X-Google-Smtp-Source: APXvYqzYqfCBc3iTV+51i6xo/8yVdkZVszMsUp8lcRHzgFH+naQmZdFlCFa4RWgCh79DR5QAEdb9+g==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr8245017plo.97.1561689465143;
        Thu, 27 Jun 2019 19:37:45 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id i3sm368206pgq.40.2019.06.27.19.37.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 19:37:44 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH net-next] net/ipv6: Fix misuse of proc_dointvec "flowlabel_reflect"
Date:   Fri, 28 Jun 2019 11:37:14 +0900
Message-Id: <20190628023714.1923-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/sys/net/ipv6/flowlabel_reflect assumes written value to be in the
range of 0 to 3. Use proc_dointvec_minmax instead of proc_dointvec.

Fixes: 323a53c41292 ("ipv6: tcp: enable flowlabel reflection in some RST packets")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 net/ipv6/sysctl_net_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 6d86fac472e7..831573461e19 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -114,7 +114,7 @@ static struct ctl_table ipv6_table_template[] = {
 		.data		= &init_net.ipv6.sysctl.flowlabel_reflect,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &three,
 	},
-- 
2.21.0

