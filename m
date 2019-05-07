Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B304C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031E820675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdk78+Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEGEsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 00:48:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43401 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfEGEs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 00:48:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so7508798plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkdv0bUN3uopdZ00bPbwW8foVdMqDPZsqAqI6CV5JHU=;
        b=hdk78+Yi6w3qCScDwe7QVwVz2ekqRUjtsoEjuwEU7r4V1tbmquogaZCIXdSxM3LyOZ
         Tn9jnAKT8lIwhOPmUOqT7OO5Xg7NLD2fQp9XRWg2f/JCDvpIZAB/OPAPRlkciycca7IS
         UzRCgI676utKBb8CLfvuY9n8AXprbI+sFRJGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkdv0bUN3uopdZ00bPbwW8foVdMqDPZsqAqI6CV5JHU=;
        b=nr/mvHwwww+tMpdv6CAxw0EQ7+Jl5+QfitxmuwwI6Qg3xwxTRnTu9jyP4GDLuPDL8A
         CxKHxj1yFlXtiW0+O4tq9FWsefCaWfXAG6mX0uyuOLbSIQgvsk+K7RVsmmvwgKBJXcyf
         fyb+WnaTxZWoUJoWoD7jhzD8mYnTtrGCBG9GEgiiWLxsZR3tZuH3ip4lk6Ua37zFzLJP
         t51Myr0O3Ds7byZLOSopISo629DemuZdUgW+296X/VEq67hMF6VAIZSOd+zffSyxJLhP
         /EwviNVy3TDX51LvfDChz6BgkhYjbKSQzj5fbLQFADBj4riSMo7gFqau05RH/jdJ9wAM
         2qvQ==
X-Gm-Message-State: APjAAAX7WlEnjUxgHjYxyQCe/8XUqtRKYc8LCrU9sVl781ZkFJP9Datg
        AKB3aVwWfhfZhJpSXfYazd/IDw==
X-Google-Smtp-Source: APXvYqwWA001dZpEA2DWbP4kSMexNIS+bd1oqMMpvY+KncWs/Pp2prHek40GJdI/BJaWgi2oZzheXw==
X-Received: by 2002:a17:902:f302:: with SMTP id gb2mr37496476plb.162.1557204508944;
        Mon, 06 May 2019 21:48:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n188sm16298641pfn.64.2019.05.06.21.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 21:48:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-rockchip@lists.infradead.org, jwerner@chromium.org,
        groeck@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
Date:   Mon,  6 May 2019 21:48:01 -0700
Message-Id: <20190507044801.250396-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll add a dummy to just return false.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/of.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 0cf857012f11..62ae5c1cafa5 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -653,6 +653,11 @@ static inline bool of_have_populated_dt(void)
 	return false;
 }
 
+static inline bool of_node_is_root(const struct device_node *node)
+{
+	return false;
+}
+
 static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
 					const char *compatible)
 {
-- 
2.21.0.1020.gf2820cf01a-goog

