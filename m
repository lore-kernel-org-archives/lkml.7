Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29EE20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXcj+h9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDMB2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfDMB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so13315899wmj.3;
        Fri, 12 Apr 2019 18:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HjaoTi59/IEbTgbAB9SJ505UfHzraQljzhT0PtxjkW8=;
        b=SXcj+h9TtD4gHoqJQnbh3mwA2BiC06JHKEv7xD1RiPbEhAjoaMswKEJDMlfUFzLEBV
         AbzWe5tLRjI+Mc3Qos286uYcuWm6oWYQfLC5waFlMttMYhjq45SQcA8zc+txT7wmhHiF
         ubX8KwLaQrqixQdO3clmsczPTmA7gQcmGkZatZn9dKEMN4XJcQfp9D+4Irc726ukgZYA
         w6dPhAofPyMtVWgDfFtX5lrFGwki/JAE7XFCqhKIRpMcxYjq8dKr5Osd3vcnXIMHu803
         LfeyT5aj5XoncT7Dg15T9txTNi1gHbTJbh2MsN6CMe0Sbvx/CRe1C08l2CDUWddAz8OM
         AAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HjaoTi59/IEbTgbAB9SJ505UfHzraQljzhT0PtxjkW8=;
        b=VYIQZNvejzG0hntdognEh8tEvyJMNXsKelGGrajwwXPHdQXKcw9A7OyS+BL6KDuUYk
         sdwrM1m9B8zpU+NIc9SuW+Np2RYg36udQR6qKm081gkww7lTCGQJPXPcPEdNmfsgkJXH
         ok/1jNm8zFT+f7DERDIKSBgM+Y416FtCmoP23IWmQryl/43zr6Kugl8tHX0WqGuHEZMs
         EZneSxPDcHUvjgy3xQE4LNcYIHxJuT726U+lI9aBUMOUdn2iTxkTD5A3PhITWSJRezUS
         S3RJtjV6OeXsWVK6z5zaxM3ZZTS62/10obiCETBTCIkQGGsjXEM5CtuN0C4c6oPV0wll
         2sFA==
X-Gm-Message-State: APjAAAWwbcQTeiyiRW7ZVPVU4LPsvhf9iLZXMjTQV1P56q3mwY+4BIoU
        9EajnJ9Fc3iLgfILxSk8Cw8=
X-Google-Smtp-Source: APXvYqzCUQa04q6RatvoTyf6aigcnoGFjfbFzZEQGowpejbh2MD7n8SOcaGtFhh4D78GZBwG0qus9g==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr13517440wmb.127.1555118924158;
        Fri, 12 Apr 2019 18:28:44 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:43 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 12/24] net: dsa: Copy the vlan_filtering setting on the CPU port if it's global
Date:   Sat, 13 Apr 2019 04:28:10 +0300
Message-Id: <20190413012822.30931-13-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current behavior is not as obvious as one would assume (which is
that, if the driver set vlan_filtering_is_global = 1, then checking any
dp->vlan_filtering would yield the same result). Only the ports which
are actively enslaved into a bridge would have vlan_filtering set.

This makes it tricky for drivers to check what the global state is.
Moreover, the most obvious place to check for this setting, the CPU
port, is not populated since it's not being enslaved to the bridge.
So fix this and make the CPU port hold the global state of VLAN
filtering on this switch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Patch is new.

 net/dsa/port.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index c8eb2cbcea6e..acb4ed1f9929 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -190,6 +190,8 @@ static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
 int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans)
 {
+	/* Violate a const pointer here */
+	struct dsa_port *cpu_dp = (struct dsa_port *)dp->cpu_dp;
 	struct dsa_switch *ds = dp->ds;
 	int err;
 
@@ -209,6 +211,12 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 		return err;
 
 	dp->vlan_filtering = vlan_filtering;
+	/* In case of switches where VLAN filtering is not per-port,
+	 * also put the setting in the most unambiguous place to
+	 * retrieve it from.
+	 */
+	if (ds->vlan_filtering_is_global)
+		cpu_dp->vlan_filtering = vlan_filtering;
 	return 0;
 }
 
-- 
2.17.1

