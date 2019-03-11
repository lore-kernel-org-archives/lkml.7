Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFC62075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AvDPgqvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCKGPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:15:14 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48244 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfCKGPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:15:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id D0DF1A99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rLyig7EA4Av3 for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:15:12 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 9EC799A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:15:12 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q184so4213435itd.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y3kHNp6HzE/B4z4DcMOrdvPbKSVHL4QedcEUEsmr9mI=;
        b=AvDPgqvDFnPdwvaEsK7gaTz9W5Twres2goOsrheNf7ofxSdc84TsnXDjGX+G4utBl6
         CYgeFuChvzo82XG5k2KCu1IjGsH/tSNkL++R+w8+hQfB/jF8CIeZbqnTTEI84YSoc3/X
         br7JhPic4D5f6wEAmnXW32uRLT3IWxf5KbJvCaR/WZLxD12gyE03QFbKF9Bh63tBAlkJ
         yFvtajRZyMtpDlgSAU1Hq417edPNafHWk68NUCmcml7MO2BleGYtUO/caGrO8VdLMtru
         Z9C51ypdRtxPVPyE9MlB5r7Eg+Mla8NTTq/Lszah5ElCpvYHlXX84wzKe2MIdofB2ElD
         5biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y3kHNp6HzE/B4z4DcMOrdvPbKSVHL4QedcEUEsmr9mI=;
        b=szQNdUcY2V/vRTZwl3lWDcSuSbjF+MiCO9UovPqfUhDlRLqFeW0OUYgDqXqEUbntbE
         TUWXzlyHsHzpnCEu9+ZhdRBrELrVTwsX8E0EYdeTsR5Amvg/Cee5oqYwmeamN8JS/9pr
         aJTPP5mug/0ynWd+Qt4obh1l3xrZNZ/JhaK4DWtafHo3lv0k7tSfsWmTC0QLBFKrFxeE
         6G4K3li0lPyk1JghOxzJ3imWcbVobRQK1u62asTt7SNIw9goAD3vvZhhh6NJ4QXIEU+e
         ff34ERydrOMynDBIIbiy9tiijre/0E+q0t28Hz6EVPqXJfkbDGLdMrUMdvbKNI5Y/7qA
         yjhA==
X-Gm-Message-State: APjAAAWRcX62x/Em3BE8L9wbTQs7wByNoKjbtv121k6gQHcLXxE8CVbM
        sYPfyLPfU7d0V2/eY8jAeNKoO4k+JEoaY7WUIqW9ooxxP0ZExFQhNSpDqYgu/9DOV+WRTan2qk/
        vq/WAR8mTmfSQfMEtaxKvGGNnG3vC
X-Received: by 2002:a5e:9741:: with SMTP id h1mr15761829ioq.87.1552284912260;
        Sun, 10 Mar 2019 23:15:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlAcMJo/1EGvCzOWVLdNLMG1hmAUbUkcOh0IH4JZmP0xlEDJSIEjXmna2XBxIgNbgCak8uSw==
X-Received: by 2002:a5e:9741:: with SMTP id h1mr15761824ioq.87.1552284912022;
        Sun, 10 Mar 2019 23:15:12 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id a4sm7703964ita.41.2019.03.10.23.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:15:11 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: fujitsu: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:15:01 -0500
Message-Id: <20190311061503.18181-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix returns -ENOMEM to avoid the
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
index a69cd19a55ae..5061ddf699a7 100644
--- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
+++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
@@ -547,6 +547,9 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
 	return -1;
 
     base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
+    if (!base)
+	    return -ENOMEM;
+
     pcmcia_map_mem_page(link, link->resource[2], 0);
 
     /*
-- 
2.17.1

