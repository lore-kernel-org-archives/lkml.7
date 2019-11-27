Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB803215F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G08yPCm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK0XTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:19:32 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38272 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0XTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:19:31 -0500
Received: by mail-pg1-f202.google.com with SMTP id l13so916811pgt.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3DvG1Qi/9kLi2+lMfxuoRgIDiLfz9oW0Dvr00Re3MJI=;
        b=G08yPCm7fV3eNIe0YnB6BkhBTG7Tpw/+wTOYlOFUt7oWMaoUlKrEP1phO2WI9m+MG7
         5LSEO7HQ1GdibWwnc9GggdXa2Jgy3g0ESsAzVVjyRG7fvm3c602985pTOTAE/RWW5zZs
         74Np5nhm9WcJltyOS2ROsj4A1/JnF7U3FXuj7yPLwAtajRwV8s0Cp/GEeCdbJWSYDueH
         YK9OC4gr/M5Ug5o6CxK7zAVD+Rk5BPFcfKmr07k0F2ZhWc2OejnKhADzy/Hr7hY6hKq4
         ouCddGLaKbRM0lvWY9W5Qq3WjqFdAgKwwzVWTyzLhYpxXVpSeuPC1auGokoZKKCwgydY
         43dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3DvG1Qi/9kLi2+lMfxuoRgIDiLfz9oW0Dvr00Re3MJI=;
        b=OPcCKOkEbsAP4xFy1EuTiFsaua5SydBMYnnj5yHXvyUgZkW7+RftWDvz44Yc/CNTs+
         6NGlXYFu/4JAVA+S5A4tL03zzO9MtkIHzVbk8eVFtv9GPoDF+6YH78tZbeKC5G+Fu2hX
         YbXe23NqN2Yy2OPJY90XfSeRMUWnWmS3tmPlwmatJ3N+3yxy9ynrMHt5BqnxBnb+y5O9
         z6sGzF4EaYGCWwmk7fqnmByoCEBh4+nfiW8OVB09XamWJlXL3LSCaq73rV+B3iOoPqPT
         c01LehVYka8rdQ3Mlw/Ua7XKtu6cXqqp9vzWP1ln3phFhYbQgHytsIcNKr4DJRsxbO2o
         KgtQ==
X-Gm-Message-State: APjAAAVn1oewONu2lSIu9fAoJh7dvbgH/VtUCLCSPCr8ip1ihIzRrq5O
        rPVeE3WBg2jFIngLFMxLavjSooMny23zemNM
X-Google-Smtp-Source: APXvYqxawEYKLTsvj/e5/gqkRVZd4KqUw9qL6XftCyPY3DlpzNdVvSr4jDZF9Q+axqeQkstpIozJd31umW9KD3xD
X-Received: by 2002:a63:565c:: with SMTP id g28mr7657844pgm.409.1574896770856;
 Wed, 27 Nov 2019 15:19:30 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:19:26 -0800
Message-Id: <20191127231926.162437-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] kunit: testing kunit: Bug fix in test_run_timeout function
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, shuah@kernel.org
Cc:     sj38.park@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert in test_run_timeout was not updated with the build_dir argument
and caused the following error:
AssertionError: Expected call: run_kernel(timeout=3453)
Actual call: run_kernel(build_dir=None, timeout=3453)

Needed to update kunit_tool_test to reflect this fix
https://lkml.org/lkml/2019/9/6/3

Signed-off-by: Heidi Fahim <heidifahim@google.com>
Change-Id: I6f161c72c6a5f071a4dc31582ba08b91974502ce
---
 tools/testing/kunit/kunit_tool_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 4a12baa0cd4e..a2a8ea6beae3 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -199,7 +199,7 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=None, timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
-- 
2.24.0.432.g9d3f5f5b63-goog

