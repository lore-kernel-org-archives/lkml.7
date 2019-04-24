Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC91C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00FA218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfDXMDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:03:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45492 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:03:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so14433037lfl.12;
        Wed, 24 Apr 2019 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=1wmjcio481D8mlO0QqPUrXZVauN7FfOlIK4AbaVKz9U=;
        b=L6kpjape0DCn2FGPxvUag+fw5tAe7W9gDQ5jizqNyIrTo6I7uDRTHV4QOvbiVzUcmg
         zZ2UVcznj1KDpsm3wATTCYAKc88hgrMUa/SSjOp9qR/W9xxXyaJ8xXUWD6fMFg9w45b3
         ieNJBfRUCnY4QtEuBP3P99l8A+TF9sPin9Z+iYIOLNaQT/N2OJ1SGuhgkOjn8RnJVREi
         9jW3APeT5Ci08vMxDwy9/CtsLl4eCmV/yOE6IzNQ/0/msr4yXvNafvIJb716YUkYphdR
         Be/Ki5K8OKZZKlbUGHkWo/RiQPUjApdMOhTj+p/MxlkzUeRUth7XSeeQdtXOfm4aj07q
         btbA==
X-Gm-Message-State: APjAAAXrabqwkdop+kwKd1TKOcu3c9lzkE5vtNjSonRqPndtyXB6Hpwh
        MBmbmkjOj4QwVX3zKGleta2n+NCF
X-Google-Smtp-Source: APXvYqxRrp1/1O04z7cQcxbZROdkBopUpww+f9o9VZJHxTT921JxknnMPC+xmxbgnQdIJSrtrHAyRg==
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr16784482lfp.51.1556107381822;
        Wed, 24 Apr 2019 05:03:01 -0700 (PDT)
Received: from localhost.localdomain ([213.87.153.202])
        by smtp.gmail.com with ESMTPSA id 125sm642200lfl.60.2019.04.24.05.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 05:03:00 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: [v2 1/1] kconfig: Terminate menu blocks with a comment in the generated config
Date:   Wed, 24 Apr 2019 15:02:49 +0300
Message-Id: <1556107369-7655-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently menu blocks start with a pretty header but end with nothing in
the generated config. So next config options stick together with the
options from the menu block.

Let's terminate menu blocks in the generated config with a comment and
a newline if needed. Example:

...
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y
...

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/kconfig/confdata.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 08ba146..486b4c7 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -819,6 +819,7 @@ int conf_write(const char *name)
 	struct menu *menu;
 	const char *basename;
 	const char *str;
+	bool need_newline = false;
 	char dirname[PATH_MAX+1], tmpname[PATH_MAX+22], newname[PATH_MAX+8];
 	char *env;
 
@@ -871,12 +872,16 @@ int conf_write(const char *name)
 				     "#\n"
 				     "# %s\n"
 				     "#\n", str);
+			need_newline = false;
 		} else if (!(sym->flags & SYMBOL_CHOICE)) {
 			sym_calc_value(sym);
 			if (!(sym->flags & SYMBOL_WRITE))
 				goto next;
+			if (need_newline) {
+				fprintf(out, "\n");
+				need_newline = false;
+			}
 			sym->flags &= ~SYMBOL_WRITE;
-
 			conf_write_symbol(out, sym, &kconfig_printer_cb, NULL);
 		}
 
@@ -888,6 +893,11 @@ int conf_write(const char *name)
 		if (menu->next)
 			menu = menu->next;
 		else while ((menu = menu->parent)) {
+			if (!menu->sym && menu_is_visible(menu)) {
+				str = menu_get_prompt(menu);
+				fprintf(out, "# end of %s\n", str);
+				need_newline = true;
+			}
 			if (menu->next) {
 				menu = menu->next;
 				break;
-- 
2.7.4

