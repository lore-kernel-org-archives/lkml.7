Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C729CA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEC7217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="ALbnm26q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfKEIL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:11:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38212 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbfKEIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:11:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so5049822ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 00:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnPxUgcY+eJznzWuRNBGSFKsUKuKOJYTW/84Xz2aVtI=;
        b=ALbnm26qSw3qBI6lwMVbfQgweiwJhyxCdMHw/LwqnaCS272kbxVvPcR76yPD8jg8vn
         uPMaImK/pL75XFyu5TLMoTandyhlAIQR293BUbWt7WAA3r1AqUDNAp2G3BrXsBHs/Vlz
         Mx/SRmaZ1ZhCSjuuLMu/Oa/arJ/oaQdFsPYWvCnXadICxJEeVFugRYJnL+aweXDefKd7
         b9ne6Wx5s0X5ASMeij7ukUWXVRVSQ+9d0XmlnwlzIgdVZ0+5SBKoQbj1AI3yZa8AJLXX
         +C4U2A21AKXVI4ClSgnbd3Ve8hiRCGOtd2IS6CHBNFlVYQFshSd5Tpo6TkAEQ0vgwfKk
         OIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnPxUgcY+eJznzWuRNBGSFKsUKuKOJYTW/84Xz2aVtI=;
        b=M3cVSmwSos2NF0YVieD/EUaizveZkiEkb0QTV/dbJbK8+vfgzF9I+0sQkb5UDF3THU
         HtCGKkGHzj0OguLVSgxPmOPVKTRSRtNMwVld8SZYRNPzxQBQQYeo9kxMlsZvNA10uMj2
         E2tfb85Zeo+YHeU2je8tg4bPi2UbF3K8614BCmaD9OtKh4hzu0pXadjGLBuID4ibp0PS
         59XRkxbomDGVTG0Sh6xSphpaSOiyUK6Jlb9XwTTm3oyaDmtpuaHmzJDrgBHoriJmplw/
         n/bGG0RHkcQvjkE/lvhhoLVr6I7pyvqPu2lKH4P3xlSGXcpeH1TBuZdSYMHCJ6/FZGQ1
         xeog==
X-Gm-Message-State: APjAAAWkouGylwK3t9owMC61zkLTvJGpudaBd4kBdG79evhhFbFPUDPS
        obl6uByySpMol3+Hqp27PRj+iA==
X-Google-Smtp-Source: APXvYqx6e9T6EGwOfg+Sq1No54UmmdSneBfCpkVLjQJ4U9kLq7x32Mqaaru8yAR89aQi5EkowqQz/w==
X-Received: by 2002:a2e:b5a2:: with SMTP id f2mr21485342ljn.108.1572941485453;
        Tue, 05 Nov 2019 00:11:25 -0800 (PST)
Received: from mimer.lulea.netrounds.lan ([195.22.87.57])
        by smtp.gmail.com with ESMTPSA id m7sm7275986lfp.22.2019.11.05.00.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 00:11:24 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/5] rtnetlink: skip namespace change if already effect
Date:   Tue,  5 Nov 2019 09:11:09 +0100
Message-Id: <20191105081112.16656-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105081112.16656-1-jonas@norrbonn.se>
References: <20191105081112.16656-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTM_SETLINK uses IFA_TARGET_NETNSID both as a selector for the device to
act upon and as a selection of the namespace to move a device in the
current namespace to.  As such, one ends up in the code path for setting
the namespace every time one calls setlink on a device outside the
current namespace.  This has the unfortunate side effect of setting the
'modified' flag on the device for every pass, resulting in Netlink
notifications even when nothing was changed.

This patch just makes the namespace switch dependent upon the namespace
the device currently resides in.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
---
 net/core/rtnetlink.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 269d1afefceb..a6ec1b4ff7cd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2393,11 +2393,15 @@ static int do_setlink(const struct sk_buff *skb,
 			goto errout;
 		}
 
-		err = dev_change_net_namespace(dev, net, ifname);
-		put_net(net);
-		if (err)
-			goto errout;
-		status |= DO_SETLINK_MODIFIED;
+		if (!net_eq(dev_net(dev), net)) {
+			err = dev_change_net_namespace(dev, net, ifname);
+			put_net(net);
+			if (err)
+				goto errout;
+			status |= DO_SETLINK_MODIFIED;
+		} else {
+			put_net(net);
+		}
 	}
 
 	if (tb[IFLA_MAP]) {
-- 
2.20.1

