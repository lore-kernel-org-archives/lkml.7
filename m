Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C6FC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1320821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfDSTMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:12:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36740 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfDSTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:12:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so5405109ljg.3;
        Fri, 19 Apr 2019 12:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=t2b8hKSB9bE3GF35nhN2D/Hy2IkxYn4RYTr1JRBMDTA=;
        b=mMWK6MoHxi1QS6qsw5db4BQ2HBC9Toq57+baNkGZkXVLTDz7hKNzh3X3ZsHGx9jJjF
         8ORIzRG1hR2Kbuwd6MoKULLj0zx42p+aA9Q4jxdx1Tjb9/p+wvosp+MCFZDH8zvUVvpI
         j7G/APD/HTI11OZrOngNRdKiuNDbFt7G3sTqLZLq8KA3XqyfnIsqyvaLUhxJmZH1daUN
         eTvCy7Jr+dKy4pWoKjh6MlQdD5dxV1+k8b+91SLaDNdYevJDu0S2w1MH6Sp1oc88VN8s
         3CqZ0i0h1GyD6XAHwCqSMXSpmAdd2j1aIOluo0bL32Q2GkYFQr2hqzb77aYPpoNoKgN/
         uk0g==
X-Gm-Message-State: APjAAAW4UjRCgHLQCppyXug2a6O0IaIpN7Q5LHa/e2quLBwcVeQi5KIA
        9LLhgeQ3yZrISuLpOBdS2gociQro
X-Google-Smtp-Source: APXvYqxm5Hc65JJpVTMiMbxLn5MG6yYqKj/BmCEPH2AtzGazViZYSb6TLlui5ffGGA8/PwGM9yrwDg==
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr1890821ljk.131.1555669788380;
        Fri, 19 Apr 2019 03:29:48 -0700 (PDT)
Received: from localhost.localdomain ([213.87.148.66])
        by smtp.gmail.com with ESMTPSA id 192sm831030lfh.14.2019.04.19.03.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 03:29:47 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 1/1] kconfig: Terminate menu blocks with a newline in the generated config
Date:   Fri, 19 Apr 2019 13:29:33 +0300
Message-Id: <1555669773-9766-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently menu blocks start with a pretty header but end with nothing in
the generated config. So next config options stick together with the
options from the menu block.

Let's terminate menu blocks with a newline in the generated config.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/kconfig/confdata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 08ba146..1459153 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -888,6 +888,8 @@ int conf_write(const char *name)
 		if (menu->next)
 			menu = menu->next;
 		else while ((menu = menu->parent)) {
+			if (!menu->sym && menu_is_visible(menu))
+				fprintf(out, "\n");
 			if (menu->next) {
 				menu = menu->next;
 				break;
-- 
2.7.4

