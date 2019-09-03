Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337EAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0359620882
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYUxI3Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfICPH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:07:28 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:38714 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfICPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:07:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id d21so7926603vkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XfkuPAzUg0cWTsSII8UxfvUGODgh66Dt0PdffmfP8ds=;
        b=BYUxI3MrD4U+BDkDqOah6HY4Bw3pPfx8gK6OvtG3TXQTUxrmLgeaUM0pE8m3+shX6r
         a/m7v+yD6KHnNo+2ozvu18HPRGjOHvfslAqkS5IswlmTxW49zalq4r2NEg5CdB8oQkZJ
         pAapdfiGvhDtqiSUAMffWLVrPJkbibNXNTmF7aR7IOEMKWP7svSLCs82N06Qiv1VX1m/
         5vbEakyc4zD9nCo5vutlPMx63M7oy2fEEfWiVlMm+JhP/hBcAkGEKvPBGRSCkvuGoziM
         55t1VRH8ly44VKnD8mGx4rlnGVDfwwQI67M2aRWLr9QioEbqXOZ2lppuU09AhqkaX4S+
         GWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XfkuPAzUg0cWTsSII8UxfvUGODgh66Dt0PdffmfP8ds=;
        b=qprRqIt3JM2zmQmLfBqDSMdr63gYFQaLyYkPRQWzuzJ402cIbwhc1zhvEcAPUtMG5m
         vcoaXwBmrIt38A7ey9Rf/N7qY+BcxfjK8RzgAZ16MppCJFQPvdiDSbY6dzt86A/9DK5y
         ou4E29TsBSk4D6ZW8fLPU1SmIOyivyIFla//8i453Ap8D596Et7WaWkdVJMlS9jqazlp
         mx9vb+PJib6kXy1jr/ZYmZPfUVv/fewj98ZM/WZ4bOWcS2YKXNrnp5lIhEAAHxmcruPg
         n19bqN8wVgUfp3zaFFT4WWfRSJLB+1Ha2ZKyjwrs5tvc6qxf7iEhScB//iVqy5W2YDlf
         cwIg==
X-Gm-Message-State: APjAAAUfBcsZdvArKyR1IDJfXImQC84Lyrpn1Ju74gWqSELJ3JsRcYQO
        NiVjAcqIeYqHqFwX7j/t8W6KzwkuO3ALK0vlMsXryJRGjlAfAlqFy1WJ6FrIQOjrK54P9Memiox
        BzGTTQeSR9AgK/2TdGq+fD5aOEoT8Iy1w/xq4E+sEuF18UCp/LUtY5WSdio490vU+6xqJElMpL9
        E=
X-Google-Smtp-Source: APXvYqwpDXpoU/tekMTm7cq8cLvZxAh2XQiVvLYuHJwsk/oxVDEJdK9XflLHkcImHQpKAl2LR/xVFUqqHgFc+A==
X-Received: by 2002:a67:fb90:: with SMTP id n16mr19342370vsr.7.1567523246431;
 Tue, 03 Sep 2019 08:07:26 -0700 (PDT)
Date:   Tue,  3 Sep 2019 16:06:27 +0100
In-Reply-To: <20190903150638.242049-1-maennich@google.com>
Message-Id: <20190903150638.242049-2-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190903150638.242049-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v4 01/12] module: support reading multiple values per modinfo tag
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to modpost's get_next_modinfo(), introduce get_next_modinfo() in
kernel/module.c to acquire any further values associated with the same
modinfo tag name. That is useful for any tags that have multiple
occurrences (such as 'alias'), but is in particular introduced here as
part of the symbol namespaces patch series to read the (potentially)
multiple namespaces a module is importing.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 kernel/module.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 9ee93421269c..3ee507c0a92f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2481,7 +2481,8 @@ static char *next_string(char *string, unsigned long *secsize)
 	return string;
 }
 
-static char *get_modinfo(struct load_info *info, const char *tag)
+static char *get_next_modinfo(const struct load_info *info, const char *tag,
+			      char *prev)
 {
 	char *p;
 	unsigned int taglen = strlen(tag);
@@ -2492,13 +2493,25 @@ static char *get_modinfo(struct load_info *info, const char *tag)
 	 * get_modinfo() calls made before rewrite_section_headers()
 	 * must use sh_offset, as sh_addr isn't set!
 	 */
-	for (p = (char *)info->hdr + infosec->sh_offset; p; p = next_string(p, &size)) {
+	char *modinfo = (char *)info->hdr + infosec->sh_offset;
+
+	if (prev) {
+		size -= prev - modinfo;
+		modinfo = next_string(prev, &size);
+	}
+
+	for (p = modinfo; p; p = next_string(p, &size)) {
 		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
 			return p + taglen + 1;
 	}
 	return NULL;
 }
 
+static char *get_modinfo(const struct load_info *info, const char *tag)
+{
+	return get_next_modinfo(info, tag, NULL);
+}
+
 static void setup_modinfo(struct module *mod, struct load_info *info)
 {
 	struct module_attribute *attr;
-- 
2.23.0.187.g17f5b7556c-goog

