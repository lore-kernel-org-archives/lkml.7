Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399642081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrue6qLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCHFeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:34:10 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36702 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHFeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:34:10 -0500
Received: by mail-yw1-f67.google.com with SMTP id 189so15405501ywi.3;
        Thu, 07 Mar 2019 21:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HuoVqlZmB3nNnfApKk4NxsGfgdExOBI8qX2IeTDEpj8=;
        b=mrue6qLo5PmYFOkUjkOdpsPOLAIhuvf6o3YW0jBhmNE2xcz7eJLbAJ7kp1y/IJ8mHE
         GEgvyPhqSmdolMKF6L60UhSZfRE+afRtcNSH6H9OZ/GHUfQQsxn1ykN62NqX0rQsiRAu
         hruLS/j3YiOWNHTZruqF7iOikVRvtXfWDCtf+8SFZ+ED2tQq4sf7QHposmMXWJ+VDImX
         DQBx4yUgeyurKUmybavxAMF1e3CtExAAeXEzVv+cV+oCptbvXHZfW1tm2YtdAOfH5GoG
         FoRdW7+hPx3ZRwiDu23VKiG7YWZHCvvWiaXPE5E6cDN60V8vLfuV8l/IGKkIgCmpDQ9y
         zgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HuoVqlZmB3nNnfApKk4NxsGfgdExOBI8qX2IeTDEpj8=;
        b=oNRXyCBoYXg4kii3asn3DukiaEAbRGMlqDEYs5+nrPLM5Nq/kQUM1vYluGz6gjkX4A
         Ku0P36w7mSzLcghSTnC//BIwvcMu0Ql25I/PAPVymerfQd9DmFuxfPPwlGuEPQmCmbjo
         9W8fMKwXsFuItymq3SyzG0ai4iQKRwT9qq9e59okHq0G2D3BsasgSGXzh5hYFHZ+GhGa
         oJRUnWLptfeLYDEQ/lFR3w+dlhNPp397HjN+QK8gp/SX7SdOtNYHNXlHWfnAGmjsxSZr
         kGvmbik2HJcUSHDOK/gkLr9hbrlL5VWCArikvNuX8C4FgRBql2igTs3Ei3G7meUEA5hr
         Vnxw==
X-Gm-Message-State: APjAAAVM4wJAzJJq7q4P8Bp1n/RvWhwOQ5pSX27CBgFJjtQtFd9tD3E7
        0QGbKrM4cqrpQh2qB85d089aZQxFqbU=
X-Google-Smtp-Source: APXvYqwbhoRSWfUAKOPuzWOpemcLuoB2crd5rI2f+sxvyky5SOf6QT6f2hI8ly+bqA9R3VubPdRe5A==
X-Received: by 2002:a81:110d:: with SMTP id 13mr13446692ywr.343.1552023249608;
        Thu, 07 Mar 2019 21:34:09 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 79sm2315940ywr.110.2019.03.07.21.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 21:34:09 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net
Cc:     Bo YU <tsu.yubo@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH 2/2] net: bonding: fix incorrect type in assignment
Date:   Fri,  8 Mar 2019 00:34:05 -0500
Message-Id: <2fefb2a6962f668f76db79d2f9a2b866b077e42f.1552023000.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1552023000.git.tsu.yubo@gmail.com>
References: <cover.1552023000.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some warning when:

sudo make C=1 CF=-D__CHECK_ENDIAN__ drivers/net/bonding/

drivers/net/bonding/bond_main.c:2438:40: warning: incorrect type in assignment (different base types)
drivers/net/bonding/bond_main.c:2438:40:    expected restricted __be16 [usertype] vlan_proto
drivers/net/bonding/bond_main.c:2438:40:
...
rivers/net/bonding/bond_options.c:1089:24: warning: incorrect type in assignment (different base types)
drivers/net/bonding/bond_options.c:1089:24:    expected restricted __be32 [addressable] [usertype] target
drivers/net/bonding/bond_options.c:1089:24:    got unsigned long long const [usertype] value

So fix it

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/net/bonding/bond_main.c    | 2 +-
 drivers/net/bonding/bond_options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 135fec28daa9..07e52d863e91 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2435,7 +2435,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
 		if (!tags)
 			return ERR_PTR(-ENOMEM);
-		tags[level].vlan_proto = VLAN_N_VID;
+		tags[level].vlan_proto = cpu_to_be16(VLAN_N_VID);
 		return tags;
 	}
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index da1fc17295d9..3a196999bd1b 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1086,7 +1086,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 		else
 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
 	} else {
-		target = newval->value;
+		target = cpu_to_be32(newval->value);
 		ret = bond_option_arp_ip_target_add(bond, target);
 	}
 
-- 
2.11.0

