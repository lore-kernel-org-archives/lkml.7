Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC2C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C4A26EE4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7PmfnQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfEaU7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:59:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44473 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEaU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:59:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so4668559pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZEWi+cNmZoBJktKiK90g7AJjwpQOSlexmUkUs+5YK4=;
        b=T7PmfnQOdzZe4eG2SOYeA+vx44JZE7ChhJBCQ085DDcWwyGifAYn3jFdX+L9YrDl6y
         jmh2kIzr/Kz1emx5OthNvsIHCIkhQEFWcPc13uUUY3w2wlHxNftaxbGqr3EIrbwxiGpk
         kBEjKQFQxtg7PyIl8di8FHNSTE5HXcwPSOsWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZEWi+cNmZoBJktKiK90g7AJjwpQOSlexmUkUs+5YK4=;
        b=KSAxFbqH9pbbZsXiys7eBVYyeaHDRe9tNN6yG6SyrwKBodEYLFBNmSf+UJSxTI8zRZ
         ToxxIiaAHhcjLVeWI9tf0NXi39//Rcunt5VZr+RzLqJcHvgYwN5mPJVeSahfkzaTS3ZF
         IPRQkT3dQvEuXDINcMUz8RsO+6Ap7qN9dUhns5C0ARckZwCHuKaq+Hj65g5cYY0dqg0x
         2waL2JSM9YZpk4rOuIRRVpW9oduu9pu1nL61XSYF0aR3KWV0TLKkg9XT08NxVYLC+GMc
         fK4OdOXsbCx7uK5rN8tTWwzaku56aXw3UDvdCG/LNbrt2aPxxt6f8sgAQzxq3ndNsqc0
         ebSg==
X-Gm-Message-State: APjAAAU45HeGiKwNrhP97d5++ZeHbUBukYUQugSu02AhX8Dj5A5vhJfw
        Qvq6X+S1ckEhuFCV0vf8UwWvLA==
X-Google-Smtp-Source: APXvYqzoeoQr05eou6DmgFLLVQEvE0PMdvqHgdLu948suYen4axY1LnMKEbIINACNGPV3mQUeoahAQ==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr12440323pfn.138.1559336386955;
        Fri, 31 May 2019 13:59:46 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id cm13sm1864887pjb.2.2019.05.31.13.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 13:59:46 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Manuel Traut <manut@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scripts/decode_stacktrace: Accept dash/underscore in modules
Date:   Fri, 31 May 2019 13:59:26 -0700
Message-Id: <20190531205926.42474-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manpage for modprobe mentions that dashes and underscores are
treated interchangeably in module names. The stack trace dumps seem
to print module names with underscores. Use bash to replace _ with
the pattern [-_] so that file names with dashes or underscores can be
found.

For example, this line:
[   27.919759]  hda_widget_sysfs_init+0x2b8/0x3a5 [snd_hda_core]

should find a module named snd-hda-core.ko.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Note: This should apply atop linux-next.

Thanks to Doug for showing me the bash string substitution magic.

---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa704f17275e..13e5fbafdf2f 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -28,7 +28,7 @@ parse_symbol() {
 		local objfile=${modcache[$module]}
 	else
 		[[ $modpath == "" ]] && return
-		local objfile=$(find "$modpath" -name "$module.ko*" -print -quit)
+		local objfile=$(find "$modpath" -name "${module//_/[-_]}.ko*" -print -quit)
 		[[ $objfile == "" ]] && return
 		modcache[$module]=$objfile
 	fi
-- 
2.20.1

