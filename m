Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607BC2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3CDYuq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfI0XEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 19:04:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33033 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0XEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:04:30 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so20871562ior.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3C0HA3rep2Lc3MZTrD1oapIO+QMbRJYvuWMJcdan3Co=;
        b=D3CDYuq9MctzEpnD/OnMxMf9TGNKB4bZ16LhjSnFJamhQxK75UIhtlJqAs3ut8xj18
         gwKmuGrat/w57Ve4QF2r6nG57lE6JlbTkjNp2fgwG5QboLNzyAgsD9Ym++vbmgm+5NZQ
         PP4HoltNmsa4LMJH/+uHo6c/B4rLzxvuj4RaiN7nE/drPnDOmG2uZsEY8IFCvC3ex1KV
         StFfeoRruV3OxJ2vlmpSiM01VAqtDhEr21mBc5RNyr90baBxp5qFcat+Yihn91CXpzB4
         z6JJbrlhuP/0gMRcKYfeIb93zLfetD0rTNiwVS+rk1IV813zMh0o0d72sG4tPAINdcK6
         uxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3C0HA3rep2Lc3MZTrD1oapIO+QMbRJYvuWMJcdan3Co=;
        b=GiRL8dkCCVSvId4m2KrZ3DIKmhfpN/ki5t0TrYWkEMrUgasIX3MqAZRgX2+SDpgKpy
         8OReBFQ87sqtg7Ft3h8wfIkS1iD4QSnC1on4BHR/uLEaruYat94zKdThy/ccjI9NN1Sa
         p5DAnBa7W0DqkEPMniWmbCh3vgKail4q6W0sA+Ts+N57GzG65L5I1ceiDvFUlA1pT8Je
         HAj8dzeep9UDA+KDc4SFGi1zgP2ytTNC43CANR2OxpDVQgldO4aayGMZpCFc8VjpLyYV
         CXSU5Q6WRvQyiFEpeGsbmL/i3SuSad3A+DemIqbWVOmilKyDO2fNrQBoUjkhIRBnTUVS
         C0/g==
X-Gm-Message-State: APjAAAUWGW96b4sEjJXkjwmrYBr3e92s9uyKJ4Ir4EuVGS88LTVue6R3
        mOQk9rs+SZ6hbEVhWp3PKoE=
X-Google-Smtp-Source: APXvYqxtgkOjPglCYuub0x5U14V8deWlz4d8clEqPxxP+itk3/8J8q7h00LUcI1F4MILauOcBxR/Lw==
X-Received: by 2002:a92:910a:: with SMTP id t10mr8177611ild.46.1569625469387;
        Fri, 27 Sep 2019 16:04:29 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id 2sm2224940ilw.50.2019.09.27.16.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 16:04:28 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr
Date:   Fri, 27 Sep 2019 18:04:20 -0500
Message-Id: <20190927230421.20837-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
is not released if copy_form_user fails. The release is added.

Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/virt/vboxguest/vboxguest_utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 75fd140b02ff..7965885a50fa 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -222,8 +222,10 @@ static int hgcm_call_preprocess_linaddr(
 
 	if (copy_in) {
 		ret = copy_from_user(bounce_buf, (void __user *)buf, len);
-		if (ret)
+		if (ret) {
+			kvfree(bounce_buf);
 			return -EFAULT;
+		}
 	} else {
 		memset(bounce_buf, 0, len);
 	}
-- 
2.17.1

