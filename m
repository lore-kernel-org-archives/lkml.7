Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F8FC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A20217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="rSYSKuL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfEWVJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:09:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35504 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388179AbfEWVJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:09:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so3247631plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWxjjBa0A/xAHkZKZESed79idk/kmC17ydpMN9al/rY=;
        b=rSYSKuL+X6Y4Ew4dkJ9qfTYMNXnuw3BGGEHULcUuCD4WE0GsLI8bMZS2qjaPzqpFXp
         A23xzPsJyAekIe9tRGvZQS4ZcPXtF8BGzzKRsoVvZg0eGB34QTZZnm6QHTA66ObhXsKB
         CC/tX101GPkGRdIUC8eWD+9cdlNUQPVOt7cT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWxjjBa0A/xAHkZKZESed79idk/kmC17ydpMN9al/rY=;
        b=qqbbVaeD66//NXJfs6qpFbjIEULi9D3Um6xwUfp0x8rWDnkhBlOCMcYEH19TKU9GVy
         wT/bf5s3XnkRuJTVh+qdlsZqkOHh3cKSL0BKOw/UzIdEHX+28H8iY58r6tkajp+7to43
         5LJAjYsUzgbT89cq+yxlmQaU3WdQxfj+FVKz6mckbEN5H2szWJ2EZyKXemI8MHm5YgIm
         +Url906ALorZW4bzfLfCjejuk/ledfKd9nxiOCUQ+3OYcIeO0ZMM1mXJYsqK5ho4nHCN
         rEwFkwsB2eXBATtwyvKjO8FkzmBSMeJC0ZKDMEa0cFpKO7YiZ7wdVJ1VWJDyUCP1b6uo
         xLdw==
X-Gm-Message-State: APjAAAWH8lKOvgsR4mefnG/uLSTuMhSWG2wUk5FrPJ1ACOSYfjt2DZ5a
        vIjQQk5OZ8uc1Yt51EFlIpMpn3NQl4LLhYTK
X-Google-Smtp-Source: APXvYqwuKL1lL2awDPJqSwiPV3yM/nA6OmuBTiRvg2vfkb3p8daEtzhahL+pk752VQkrxbWF7sbVsg==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr100197673ply.33.1558645752680;
        Thu, 23 May 2019 14:09:12 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y17sm333481pfn.79.2019.05.23.14.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:09:12 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net 3/4] net/udpgso_bench_tx: fix sendmmsg on unconnected socket
Date:   Thu, 23 May 2019 14:06:50 -0700
Message-Id: <20190523210651.80902-4-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190523210651.80902-1-fklassen@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following error if using both -m and -u options:

    # ./udpgso_bench -4um -D 172.16.120.189
    ./udpgso_bench: sendmmsg: Destination address required

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 tools/testing/selftests/net/udpgso_bench_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index a900f016b9e7..56e0d890b066 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -378,6 +378,8 @@ static int send_udp_sendmmsg(int fd, char *data)
 
 		mmsgs[i].msg_hdr.msg_iov = iov + i;
 		mmsgs[i].msg_hdr.msg_iovlen = 1;
+		mmsgs[i].msg_hdr.msg_name = (void *)&cfg_dst_addr;
+		mmsgs[i].msg_hdr.msg_namelen = cfg_alen;
 		if (msg_controllen) {
 			mmsgs[i].msg_hdr.msg_control = control;
 			mmsgs[i].msg_hdr.msg_controllen = msg_controllen;
-- 
2.11.0

