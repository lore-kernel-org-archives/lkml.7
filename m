Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE0CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE0F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjESDrfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfDJCcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:32:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35497 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJCcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:32:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so418636plp.2;
        Tue, 09 Apr 2019 19:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DSm60fsRvigZ9rO9v9GaStHi5ZcMD+nYH04YGyKBRU0=;
        b=fjESDrfL/POOG9UqFWuFRcxAKL0/LNLBZjmpbvCmJaBFkiRaJQuFHi/WWdPIBaUCBp
         oqBobw8ztH7yVJZw8kKSc7f8otXSgM7xKMVvvVKBLgcfshZHPzCJhkvQdTAFDFWREV/Q
         ToQOSvl+QbC//HEf2cj+u+Y3sk/KHJnc/mYYFVRrVtgX4n3B9Ox3RcnJWozk7nuIRKv4
         PDSpX5SGQco+nZhdUaKo3UprRRoV+2O/fYO+uaEjIwaOUf52BgNsD6keJEquyTrOuelJ
         Uhl3r/3/n1MAk+p3uRja4ztVajwqKiqUH1a/+BrXb+VK8M6ruWlEwZH7XQL5Zt7lZRJC
         EHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DSm60fsRvigZ9rO9v9GaStHi5ZcMD+nYH04YGyKBRU0=;
        b=SKftmbWwMzO8UjkZ5y8LOviXpfrhfAhzFD3OzlRud5Og9RxM5mV1nK0Ri2SeBcCwUv
         nzQaLqU/l8OzxJFB1QPJ2Wb32zln+a5eSFqZHgPUjdWxLR2YdbWFdsEFZ3jIWsW69sJZ
         KuWA+N+ghrBQYHzEewA5u+e/st7HdKJKFxe7/4q+RidymAlntZnFYQW7ijh+kFKOhjzu
         kraW4EXDV/TVEYyU4S2FHqVxfcJYZLNoAVcEVgQVpcDYM4CB2KhlAgkEucr0iX5XaTz4
         VphJ6jog45ygeq1xCDATKZAMSmhTi8THmSwwWJkdZjSuyXUsAXBhbePrpTMaxQ473OZQ
         gRYw==
X-Gm-Message-State: APjAAAVJFzWfCSKLLskTjBXo1uYeJZkgiRJeCqCoMe3Tt+5FCOXOLYLc
        tdx37yVqQrdWeO2D/vtEU78vz8I5b3A=
X-Google-Smtp-Source: APXvYqzt2rHkRsTxseTLrXBuCEh9uIGSiGoPqukgo8bPGqZTvVhOLHWGcZN8O7jaS+xWyyJ8PzGx5w==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr40171141plt.187.1554863534670;
        Tue, 09 Apr 2019 19:32:14 -0700 (PDT)
Received: from shadowsocks.asia-east1-b.c.nth-highlander-219506.internal. (191.202.194.35.bc.googleusercontent.com. [35.194.202.191])
        by smtp.gmail.com with ESMTPSA id u7sm36720689pgp.26.2019.04.09.19.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:32:13 -0700 (PDT)
From:   Huang Rui <huangruippp@gmail.com>
X-Google-Original-From: Huang Rui <huangruiPPP@gmail.com>
To:     davem@davemloft.net
Cc:     ast@kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, jiri@mellanox.com,
        ecree@solarflare.com, idosch@mellanox.com, petrm@mellanox.com,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        lirongqing@baidu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org,
        huangruiPPP@gmail.com
Subject: [PATCH] net:bridge:always disable auto-tuning when the user specified MTU
Date:   Wed, 10 Apr 2019 02:32:08 +0000
Message-Id: <20190410023208.25435-1-huangruiPPP@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example.
My purpose is to create a bridge br0 and join eth0 into br0.
if we use this following way, the auto-tuning flag will not be disabled.

If eth0's mtu is 1200
step 1.brctl addbr br0
step 2.brctl addif br0 eth0
step 3.ifconfig br0 mtu 1200
step 4.ifconfig eth0 mtu 1500

Result:
br0's MTU: 1500, eth0's MTU: 1500

Expected:
br0's MTU: 1200, eth0's MTU: 1500

I have specified br0's MTU,  but auto-min policy works. So the MTU is
not the result what we expected.
As expected, if i have specified bridge's MTU, it will set the flag:
BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
policy will not work.But in this case, because the dev_set_mtu return
early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
auto-min/max policy will still work.

Signed-off-by: Huang Rui <huangruiPPP@gmail.com>
---
 net/core/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b67f2aa59dd..ba410d76bb49 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7670,8 +7670,12 @@ int dev_set_mtu_ext(struct net_device *dev, int new_mtu,
 {
 	int err, orig_mtu;
 
-	if (new_mtu == dev->mtu)
-		return 0;
+	if (new_mtu == dev->mtu) {
+		if (dev->priv_flags & IFF_EBRIDGE)
+			return __dev_set_mtu(dev, new_mtu);
+		else
+			return 0;
+	}
 
 	/* MTU must be positive, and in range */
 	if (new_mtu < 0 || new_mtu < dev->min_mtu) {
-- 
2.11.0

