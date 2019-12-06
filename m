Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B4BC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3213F21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575637418;
	bh=1P4JJX8/2H20+EM+DrAXFfSI4JjlzpxUMZw4FcxpDLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GbwiA7O8lvG44XnZXXwlYjktrV24T8cDY6w/7/uBloIL56SQK9Uq0RU7o43Fgj5uj
	 obKZSAP6rKNv21SlayrzY0NmXOyDjPGTQpS0Ni9UmJjS2bYxlzOQpTgmJLv/80Eheh
	 Z6vYJ4NiCanaIr7h2G35P5aSfAbuvFNnFjZ91WPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFNDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:03:37 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:45593 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfLFNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:03:33 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xB6D34Gp005873;
        Fri, 6 Dec 2019 22:03:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xB6D34Gp005873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575637387;
        bh=ekwM9UUGKGl3f+58UAKf0ESmjI1Emgokd72qoh9WRnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhoE4qNwV+ZeVhLWKFj3IQCl3XNJt03vtMY2I1LAWMZyj0ZoXgeaL/tMGmv1DeKH7
         Q+/8JyBFo10WNHvx6Hb/2K4aQ0rI81KnCUU6T94z+Lm+IgSi6P6VTjYls8xGglxFf3
         WN01PAPEUKI5advI/4ft1YMlBOQeovQd9ifuYDa2a0kOgvyeVOYKQWoAuL+WxojluZ
         5XXcPUU4rLc4p1hvkfOF5JTp+D7hJ4P7N9/LMvwUpDxfWO2BLouLws10pyXCvzjamT
         O/TpMjtTgHbfKzD7udhU6R03WiuCYBSYj5HonVVyg945tpHkiD0SkZt6FenaPaxkkW
         NjqBvEB9dsx1g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mkcompile_h: use printf for LINUX_COMPILE_BY
Date:   Fri,  6 Dec 2019 22:03:02 +0900
Message-Id: <20191206130302.11473-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206130302.11473-1-masahiroy@kernel.org>
References: <20191206130302.11473-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 858805b336be ("kbuild: add $(BASH) to run scripts with
bash-extension") shed light on portability issues. Here is another one.

Since commit f07726048d59 ("Fix handling of backlash character in
LINUX_COMPILE_BY name"), we must escape a backslash contained in
LINUX_COMPILE_BY. This is not working on distros like Ubuntu.

As the POSIX spec [1] says, if any of the operands contain a backslash
( '\' ) character, the results are implementation-defined.

The actual shell of /bin/sh could be bash, dash depending on distros,
and the behavior of builtin echo command is different among them.

The bash builtin echo, unless -e is given, copies the arguments to
output without expanding escape sequences (BSD-like behavior).

The dash builtin echo, in contrast, adopts System V behavior, which
does expand escape sequences without any option.

Even non-builtin /bin/echo behaves differently depending on the system.
Due to these variations, echo is considered as a non-portable command.
Using printf is the common solution to avoid the portability issue.

[1] https://pubs.opengroup.org/onlinepubs/009695399/utilities/echo.html

Fixes: 858805b336be ("kbuild: add $(BASH) to run scripts with bash-extension")
Reported-by: XXing Wei <xxing.wei@unisoc.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mkcompile_h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 3097fec1756a..3a5a4b210c86 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -69,7 +69,7 @@ UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
 
   echo \#define UTS_VERSION \"$UTS_VERSION\"
 
-  echo \#define LINUX_COMPILE_BY \"$LINUX_COMPILE_BY\"
+  printf '#define LINUX_COMPILE_BY "%s"\n' "$LINUX_COMPILE_BY"
   echo \#define LINUX_COMPILE_HOST \"$LINUX_COMPILE_HOST\"
 
   echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | grep ' version ' | sed 's/[[:space:]]*$//'`\"
-- 
2.17.1

