Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF70C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14972054F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGDpjo9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLBXxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:53:35 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:36564 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBXxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:53:35 -0500
Received: by mail-yw1-f74.google.com with SMTP id n34so1076455ywh.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UeRKrWFVc6wY9N41muBnONFCKBYX0ait5S3vLExo2C8=;
        b=RGDpjo9g2s0+05+TUY8HpRUB7+2PduVCQSOy60Qh1+iVPxkuooklhCwku+SiEnKI0L
         b5qB9mxFIOsHKNxJOx4a/UVd1ppbUhUPNKBrtdNOauCww107oIAuy2mTUbwR1SEJLTjq
         aRNyNcsn7aDtjYCcDJCqYlixRa7haLhQ8rvQ74PWZX4IcHjxovu/0RFFOJPuhh3taJpc
         crzz00vYIuuWE1oIEEOe9Jh2XfLXyt3Gx9wQ+npPR0quW/KBG+1VC6/+mitVnOCuIFl2
         Qf7eRhMMEk/ieWyLrXscyQz21cegxwafthWAWNmQo7SvZHgIleptKl6I/gj/+IGW3Vrs
         sRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UeRKrWFVc6wY9N41muBnONFCKBYX0ait5S3vLExo2C8=;
        b=BaepJis97c00Yy9ZYgfdvrbaZeGVfiiI/PNw19RK6ojh1k5XDwQnRH2KWijdGdYxk9
         Npyu4GbOX7sFCQwCH5/nthscMOc9Umh6QUQxhJjTmBkwoJknqSG18pbMxCoHJmbBMy3Y
         3FDFdLmeNS9F6SAXuaJftIhaRtjrfExUsHlyxfFXG0szziJIjdzt2FSTD/ICr/12E61i
         99Ot4L2tfSbe9aFJfPL6T+dr6rmm76WCSnfb3lDv4gp/WW86knczwvXWdetRgrL9UB/6
         A2YmHO8LudeEAb0KehfkZsu2EduX1aGsCjPqdd19HAAtqEwv6WO5PBvIgR5SCCiixpCX
         K4QA==
X-Gm-Message-State: APjAAAVTm10uGJuBlOBoipJYLP2sqlPhjcbo4vZPjDM2xY+RuN8vqjMz
        7PSmHV6bpZnZagkrvWZWrIbGcw3QENc4K5wz
X-Google-Smtp-Source: APXvYqzmaUROhknPs3h84wqPTsgnp/3k+KDptOqKEFmduxF1uHlGv1cWBX/AyR/Vw9ASXdFPSaggJabpNdUQnDb0
X-Received: by 2002:a0d:c205:: with SMTP id e5mr1182728ywd.165.1575330813948;
 Mon, 02 Dec 2019 15:53:33 -0800 (PST)
Date:   Mon,  2 Dec 2019 15:53:29 -0800
Message-Id: <20191202235329.241986-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] kunit: testing kunit: Bug fix in test_run_timeout function
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, shuah@kernel.org
Cc:     sj38.park@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Heidi Fahim <heidifahim@google.com>,
        SeongJae Park <sjpark@amazon.de>
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
https://lkml.org/lkml/2019/9/6/351

Signed-off-by: Heidi Fahim <heidifahim@google.com>
Reviewed-by: SeongJae Park <sjpark@amazon.de>
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
2.24.0.393.g34dc348eaf-goog

