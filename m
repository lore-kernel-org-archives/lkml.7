Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FD920872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZgRyZke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfI0QY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:24:59 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36038 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfI0QY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:24:58 -0400
Received: by mail-pl1-f182.google.com with SMTP id f19so1303436plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3WPW4jyuoys0xMFPzIttQ1aXUqhhQ3GvfN8DtEqHUY=;
        b=YZgRyZkexiBuESnEUV+1oM9frXsTnzVKRznzbDTBn0bEiAuGevXHMeruLdBxitzPQO
         DYrS2JXHbLPFUawn4R6VFW2JeI1/jz7hFqLL0LPVOK0/xP4t8CxfyaR1CqzQZVaKVXAJ
         1fd3gWoYkTzmH4DFmhBSeKKEt/jrzUZe40dqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3WPW4jyuoys0xMFPzIttQ1aXUqhhQ3GvfN8DtEqHUY=;
        b=ianR+4BWUszHAiL45b8dCQ5x6zNI0VUuPXu/iZuWvjI3TWbnuVUaujJmu+syhOam7X
         6kLU3MlLeZFLrEkNWg6PsfjNWevUastwsYfK3dx6QqlvNuEJ/mLe2WG3TlfFmzuAE3tj
         Zw83ftB95aC1A9nRPcL6X6rhurdvn7p2jdDqwp4STJignf+uXc+kNboV8lPFJBqCbTfa
         SY2HAlW1Yvzn/yusGmdoWpNapLnkq8QmlcHhUnkqFppcd8xzGu+mjEotEiNSGX8MzTFk
         8314LA7eLBqNCwS9h0QA0cZnEvqd0KyvSRb8y9Q9K5NvdvSxOYbcaAx5r0HS8QQ/gp1h
         UJYw==
X-Gm-Message-State: APjAAAX8LBoXRee3kWK1lEtybk3XRWqbHN4Au8W30oAiEIvT8fsui8gM
        mVn8t4nkJ1tqmci5ycuMUXbwrw==
X-Google-Smtp-Source: APXvYqz2hk5HABju6xeDLtT25AvQLra/pgUXGxs0xHE0oGv0VsFCv2Mb0EuAKweFvwzDKrfzGfUiOw==
X-Received: by 2002:a17:902:a515:: with SMTP id s21mr5760706plq.259.1569601496135;
        Fri, 27 Sep 2019 09:24:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 69sm3452769pfb.145.2019.09.27.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 09:24:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sjg@chromium.org
Cc:     joelaf@google.com, groeck@chromium.org, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v3] patman: Use the Change-Id, version, and prefix in the Message-Id
Date:   Fri, 27 Sep 2019 09:23:56 -0700
Message-Id: <20190927092319.v3.1.Ie6289f437ae533d7fcaddfcee9202f0e92c6b2b9@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the centithread on ksummit-discuss [1], there are folks who
feel that if a Change-Id is present in a developer's local commit that
said Change-Id could be interesting to include in upstream posts.
Specifically if two commits are posted with the same Change-Id there's
a reasonable chance that they are either the same commit or a newer
version of the same commit.  Specifically this is because that's how
gerrit has trained people to work.

There is much angst about Change-Id in upstream Linux, but one thing
that seems safe and non-controversial is to include the Change-Id as
part of the string of crud that makes up a Message-Id.

Let's give that a try.

In theory (if there is enough adoption) this could help a tool more
reliably find various versions of a commit.  This actually might work
pretty well for U-Boot where (I believe) quite a number of developers
use patman, so there could be critical mass (assuming that enough of
these people also use a git hook that adds Change-Id to their
commits).  I was able to find this git hook by searching for "gerrit
change id git hook" in my favorite search engine.

In theory one could imagine something like this could be integrated
into other tools, possibly even git-send-email.  Getting it into
patman seems like a sane first step, though.

NOTE: this patch is being posted using a patman containing this patch,
so you should be able to see the Message-Id of this patch and see that
it contains my local Change-Id, which ends in 2b9 if you want to
check.

[1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-August/006739.html

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Allow faking the time of Message-Id for testing (testBasic)
- Add skip_blank for Change-Id (testBasic).
- Check the Message-Id in testBasic.

Changes in v2:
- Add a "v" before the version part of the Message-Id
- Reorder the parts of the Message-Id as per Johannes.

 tools/patman/README         |  8 ++++-
 tools/patman/commit.py      |  3 ++
 tools/patman/patchstream.py | 64 +++++++++++++++++++++++++++++++++++--
 tools/patman/test.py        | 15 +++++++--
 4 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/tools/patman/README b/tools/patman/README
index 7917fc8bdc33..02d582974495 100644
--- a/tools/patman/README
+++ b/tools/patman/README
@@ -259,12 +259,18 @@ Series-process-log: sort, uniq
 	unique entries. If omitted, no change log processing is done.
 	Separate each tag with a comma.
 
+Change-Id:
+	This tag is stripped out but is used to generate the Message-Id
+	of the emails that will be sent. When you keep the Change-Id the
+	same you are asserting that this is a slightly different version
+	(but logically the same patch) as other patches that have been
+	sent out with the same Change-Id.
+
 Various other tags are silently removed, like these Chrome OS and
 Gerrit tags:
 
 BUG=...
 TEST=...
-Change-Id:
 Review URL:
 Reviewed-on:
 Commit-xxxx: (except Commit-notes)
diff --git a/tools/patman/commit.py b/tools/patman/commit.py
index 2bf3a0ba5b92..48d0529c5365 100644
--- a/tools/patman/commit.py
+++ b/tools/patman/commit.py
@@ -21,6 +21,8 @@ class Commit:
             The dict is indexed by change version (an integer)
         cc_list: List of people to aliases/emails to cc on this commit
         notes: List of lines in the commit (not series) notes
+        change_id: the Change-Id: tag that was stripped from this commit
+            and can be used to generate the Message-Id.
     """
     def __init__(self, hash):
         self.hash = hash
@@ -30,6 +32,7 @@ class Commit:
         self.cc_list = []
         self.signoff_set = set()
         self.notes = []
+        self.change_id = None
 
     def AddChange(self, version, info):
         """Add a new change line to the change list for a version.
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index b6455b0fa383..ef0660629795 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -2,6 +2,7 @@
 # Copyright (c) 2011 The Chromium OS Authors.
 #
 
+import datetime
 import math
 import os
 import re
@@ -14,7 +15,7 @@ import gitutil
 from series import Series
 
 # Tags that we detect and remove
-re_remove = re.compile('^BUG=|^TEST=|^BRANCH=|^Change-Id:|^Review URL:'
+re_remove = re.compile('^BUG=|^TEST=|^BRANCH=|^Review URL:'
     '|Reviewed-on:|Commit-\w*:')
 
 # Lines which are allowed after a TEST= line
@@ -32,6 +33,9 @@ re_cover_cc = re.compile('^Cover-letter-cc: *(.*)')
 # Patch series tag
 re_series_tag = re.compile('^Series-([a-z-]*): *(.*)')
 
+# Change-Id will be used to generate the Message-Id and then be stripped
+re_change_id = re.compile('^Change-Id: *(.*)')
+
 # Commit series tag
 re_commit_tag = re.compile('^Commit-([a-z-]*): *(.*)')
 
@@ -156,6 +160,7 @@ class PatchStream:
 
         # Handle state transition and skipping blank lines
         series_tag_match = re_series_tag.match(line)
+        change_id_match = re_change_id.match(line)
         commit_tag_match = re_commit_tag.match(line)
         cover_match = re_cover.match(line)
         cover_cc_match = re_cover_cc.match(line)
@@ -177,7 +182,7 @@ class PatchStream:
             self.state = STATE_MSG_HEADER
 
         # If a tag is detected, or a new commit starts
-        if series_tag_match or commit_tag_match or \
+        if series_tag_match or commit_tag_match or change_id_match or \
            cover_match or cover_cc_match or signoff_match or \
            self.state == STATE_MSG_HEADER:
             # but we are already in a section, this means 'END' is missing
@@ -275,6 +280,16 @@ class PatchStream:
                 self.AddToSeries(line, name, value)
                 self.skip_blank = True
 
+        # Detect Change-Id tags
+        elif change_id_match:
+            value = change_id_match.group(1)
+            if self.is_log:
+                if self.commit.change_id:
+                    raise ValueError("%s: Two Change-Ids: '%s' vs. '%s'" %
+                        (self.commit.hash, self.commit.change_id, value))
+                self.commit.change_id = value
+            self.skip_blank = True
+
         # Detect Commit-xxx tags
         elif commit_tag_match:
             name = commit_tag_match.group(1)
@@ -345,6 +360,47 @@ class PatchStream:
             self.warn.append('Found %d lines after TEST=' %
                     self.lines_after_test)
 
+    def WriteMessageId(self, outfd):
+        """Write the Message-Id into the output.
+
+        This is based on the Change-Id in the original patch, the version,
+        and the prefix.
+
+        Args:
+            outfd: Output stream file object
+        """
+        if not self.commit.change_id:
+            return
+
+        # If the count is -1 we're testing, so use a fixed time
+        if self.commit.count == -1:
+            time_now = datetime.datetime(1999, 12, 31, 23, 59, 59)
+        else:
+            time_now = datetime.datetime.now()
+
+        # In theory there is email.utils.make_msgid() which would be nice
+        # to use, but it already produces something way too long and thus
+        # will produce ugly commit lines if someone throws this into
+        # a "Link:" tag in the final commit.  So (sigh) roll our own.
+
+        # Start with the time; presumably we wouldn't send the same series
+        # with the same Change-Id at the exact same second.
+        parts = [time_now.strftime("%Y%m%d%H%M%S")]
+
+        # These seem like they would be nice to include.
+        if 'prefix' in self.series:
+            parts.append(self.series['prefix'])
+        if 'version' in self.series:
+            parts.append("v%s" % self.series['version'])
+
+        parts.append(str(self.commit.count + 1))
+
+        # The Change-Id must be last, right before the @
+        parts.append(self.commit.change_id)
+
+        # Join parts together with "." and write it out.
+        outfd.write('Message-Id: <%s@changeid>\n' % '.'.join(parts))
+
     def ProcessStream(self, infd, outfd):
         """Copy a stream from infd to outfd, filtering out unwanting things.
 
@@ -358,6 +414,9 @@ class PatchStream:
         fname = None
         last_fname = None
         re_fname = re.compile('diff --git a/(.*) b/.*')
+
+        self.WriteMessageId(outfd)
+
         while True:
             line = infd.readline()
             if not line:
@@ -481,6 +540,7 @@ def FixPatches(series, fnames):
     for fname in fnames:
         commit = series.commits[count]
         commit.patch = fname
+        commit.count = count
         result = FixPatch(backup_dir, fname, series, commit)
         if result:
             print('%d warnings for %s:' % (len(result), fname))
diff --git a/tools/patman/test.py b/tools/patman/test.py
index e1b94bd1a7db..cc61c20606e8 100644
--- a/tools/patman/test.py
+++ b/tools/patman/test.py
@@ -12,6 +12,7 @@ import checkpatch
 import gitutil
 import patchstream
 import series
+import commit
 
 
 class TestPatch(unittest.TestCase):
@@ -48,7 +49,8 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
  arch/arm/cpu/armv7/tegra2/ap20.c           |   57 ++----
  arch/arm/cpu/armv7/tegra2/clock.c          |  163 +++++++++++++++++
 '''
-        expected='''
+        expected='''Message-Id: <19991231235959.0.I80fe1d0c0b7dd10aa58ce5bb1d9290b6664d5413@changeid>
+
 
 From 656c9a8c31fa65859d924cd21da920d6ba537fad Mon Sep 17 00:00:00 2001
 From: Simon Glass <sjg@chromium.org>
@@ -79,7 +81,16 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
         expfd.write(expected)
         expfd.close()
 
-        patchstream.FixPatch(None, inname, series.Series(), None)
+        # Normally by the time we call FixPatch we've already collected
+        # metadata.  Here, we haven't, but at least fake up something.
+        # Set the "count" to -1 which tells FixPatch to use a bogus/fixed
+        # time for generating the Message-Id.
+        com = commit.Commit('')
+        com.change_id = 'I80fe1d0c0b7dd10aa58ce5bb1d9290b6664d5413'
+        com.count = -1
+
+        patchstream.FixPatch(None, inname, series.Series(), com)
+
         rc = os.system('diff -u %s %s' % (inname, expname))
         self.assertEqual(rc, 0)
 
-- 
2.23.0.444.g18eeb5a265-goog

