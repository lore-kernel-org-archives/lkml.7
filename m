Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C984D2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8pmopzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfKZTdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:33:32 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37618 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfKZTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:33:31 -0500
Received: by mail-pj1-f74.google.com with SMTP id a31so656170pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LZgbozaMv2++Eabt+iViPasyBMAegYsg5oYTvMeHf7E=;
        b=S8pmopzzBG0rNok5vDN976cFoAR0A7Q+p/o8pCLnSXixM+5boO1hXI9m0F7yA6sPVV
         IZyY5dqJw+zD9pjkQsCFWgDYz5wF+P5eNiXGqXXFMv+aRYKwpt3F8UawnB7gMei0i6YK
         4d66jyCvy//Wa3Vusi8E+3lZBlUxR6yn31REPHhWKiHXldKjuVnLzFRabBqqG5gAGZtG
         t2QH8dhE+35YRcXlL8MfSG9W6j2mdR4uGOafC5ful+3LPMSrTawaYmujJHXzrggLSV6H
         9lTVl+5Wl79xSAYJW8Mc3QEXtAmUzLcvXtgiiSy/iJjtsjTonesbzCbeMh7TzIaZ0qEV
         VqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LZgbozaMv2++Eabt+iViPasyBMAegYsg5oYTvMeHf7E=;
        b=RISRLvB0YxRBNCKsHALG7LKDUuMN0p0pxwz+O9jrA1u80nSdrwRTOJleh+FyK7KntR
         zCtWYdpPQwSq6w87OPHIelxyvcgoqSXrImRNUjZMeKVr3xvBP9gMAiyPy+oI2cAGP6Gc
         nVX+/9ATCPfVTJjsbbX0xci5LYDvpP6nzlVz2Cg/71htIKF/IyKEGsLfCRqkpg7BwVQ5
         CUGg03HP9JgL6/KdOc4J8o6AaRiaBUL1z60PddAeI2HCRYHGySd1ar/8Muljuem+QFb5
         0khNA91jYmiJ1UunkDbIFjDXzQQB9oEvnpTG97Mh1Yw49nbEjdDYu5JnvtXGD5/RXeH0
         Kv3w==
X-Gm-Message-State: APjAAAUBmhK1I2apySbBB60lanmU7/Xn6SR8NWMNz47EmgBAdI91NZSH
        Gg4dasKSMxKElT1ArnIgIDFCe+i1YJsYuWKm
X-Google-Smtp-Source: APXvYqwlu7Ul/+3EqoijwO89c+WDCiAnYLTJIkWSIHVcFHz5+Auv/4L5M6KXbDaJdlS2PHvKtwCyeDHSuT1v47PK
X-Received: by 2002:a63:c606:: with SMTP id w6mr156681pgg.133.1574796809308;
 Tue, 26 Nov 2019 11:33:29 -0800 (PST)
Date:   Tue, 26 Nov 2019 11:33:13 -0800
Message-Id: <20191126193313.44181-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] kunit: test: Improve error messages for kunit_tool when
 kunitconfig is invalid
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous error message for invalid kunitconfig was vague. Added to it so
that it lists invalid fields and prompts for them to be removed.  Added
validate_config function returning whether or not this kconfig is valid.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..010d3f5030d2 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -93,6 +93,19 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def validate_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			invalid = self._kconfig.entries() - validated_kconfig.entries()
+			message = 'Provided Kconfig is not contained in validated .config. Invalid fields found in kunitconfig: %s' % (
+				', '.join([str(e) for e in invalid])
+			)
+			logging.error(message)
+			return False
+		return True
+
 	def build_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
@@ -103,12 +116,7 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		validated_kconfig = kunit_config.Kconfig()
-		validated_kconfig.read_from_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			logging.error('Provided Kconfig is not contained in validated .config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def build_reconfig(self, build_dir):
 		"""Creates a new .config if it is not a subset of the kunitconfig."""
@@ -133,12 +141,7 @@ class LinuxSourceTree(object):
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
-		used_kconfig = kunit_config.Kconfig()
-		used_kconfig.read_from_file(get_kconfig_path(build_dir))
-		if not self._kconfig.is_subset_of(used_kconfig):
-			logging.error('Provided Kconfig is not contained in final config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], timeout=None, build_dir=None):
 		args.extend(['mem=256M'])
-- 
2.24.0.432.g9d3f5f5b63-goog

