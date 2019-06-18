Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E4C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62258205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Iz1IGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfFRRzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:55:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFRRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:55:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so8108822pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sZQNDbvRCX1/xmAgz48y9nkM0uP28/QjVvVkkR3CQOA=;
        b=C4Iz1IGyiHO+KxnxVZJMXrvK0VMpgE0VV8M58ezWEBhGaMJqGoxNPncfAY9jQXro1a
         q2Dzr43f5dlfHfhfUcftvrpCzA/BC3JWfBqDig80Yi+GH7GTGVcyEBvjlU4h93NUMTU2
         +Vklf+mbjyEb6tgJFqATVI5ElgnQ8aZb5U95w6io2EoG9i6QBhq77xIblzZdHUys2JRy
         0LBU6WNQ2ZZsau9C761+3HwY60Nx2/yUBgCKfAonztX4KVHD1vomR22vIfTmFOCMSPqV
         q6Gl2llLemRxkoD0x8cQq0zZfmEQmxMSNapLKLrpIX0CTkoiBtCm7l+1eaHX3ykn+one
         WwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sZQNDbvRCX1/xmAgz48y9nkM0uP28/QjVvVkkR3CQOA=;
        b=JeilnJL+XHr+xAsdDy5Er7eZcuXh2BMyhchCCJNHdfvQkSPE1t8JIeDsTcoOpFfd1n
         H0oQ6BL5vsi+IjoorrQhdDts4KYpiXcDtYoQEvbDP77fMb94KU5G+cKZrz6M9LhptPyv
         SU7aBT5ymQnhIxE2e1vDFXsVwlS3tQYU4pjN7M2dlSC7415LirHyg952y+SfYH0s+/UE
         TYE/XdvyzCWjk3rtDZOYNymhJ97vVgRXzJDuFGsZcK2Jd8QUdlItTs6SKWSDhyVMBBdd
         3MwQOYmneKGDCpwPL0rsh/O6mEQwYfqJNwRCIpv6TqDfuShZibrqj0Pxz66DLd/azo+p
         PpsQ==
X-Gm-Message-State: APjAAAWu7zd8S329jvYCgscJjwnRDeO4da77TdfB99fcVdB4P0fsK0+3
        aatugqAtcRBo5WkL8wJikNQ=
X-Google-Smtp-Source: APXvYqx96I5XvE7xRAPdGzOeTmm+5O+cLVaDcbbg2VIuBv+nd9XhInsanHzz00TGwE4M8MslR6ab5w==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr6347869pjz.140.1560880520698;
        Tue, 18 Jun 2019 10:55:20 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id c18sm17498763pfc.180.2019.06.18.10.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 10:55:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:25:16 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: ieee80211: Remove redundant memset
Message-ID: <20190618175516.GA6518@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_etherdev function internally calls kvzalloc . So we may not need
explicit memset after this call.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 3532ea9..4a6c3f6 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -109,7 +109,6 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	}
 
 	ieee = netdev_priv(dev);
-	memset(ieee, 0, sizeof(struct ieee80211_device) + sizeof_priv);
 	ieee->dev = dev;
 
 	err = ieee80211_networks_allocate(ieee);
-- 
2.7.4

