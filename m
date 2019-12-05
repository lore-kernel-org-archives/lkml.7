Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90652C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A38B2466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPQL7iwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfLEVwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44570 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387525AbfLEVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:50 -0500
Received: by mail-io1-f68.google.com with SMTP id z23so5192298iog.11;
        Thu, 05 Dec 2019 13:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DItobioE2v0mcjvG7rtQWbeO2Gh9dZ5P9FoUFdI1r8=;
        b=dPQL7iwe36qPjYatnqnyMK7+wQcq/+GaIbuumJSYp+Odzdr29W4dj+1GMvZFPEkLfM
         oNmNdpZg2sTDEI/oKXIUKo/HKR99JM9odseNtG5FtKpfeB3k04kTZE8xpQ+wh5sgowmC
         rTTgQqq+7LfhVB7gPQrOSEilZFv/rYaMluz46geLr/ut3X6TD0GA59ekD4poXUrDF2xK
         JxQbqtw1xXN3GtclgVuveNgkX+MVDUwTgno7kM2POx4KSLcyFjR/0mqxaBQWPeNb4h3M
         2KOlJM2pkKbOGvU7dIk430gVwcAPLnk6jaIEJ52jc5zAzoml8pZDPymIughrtVJHuG1F
         1ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DItobioE2v0mcjvG7rtQWbeO2Gh9dZ5P9FoUFdI1r8=;
        b=oj9G1pWGxjYV82LZliWlCqnvmBwzftC2KOB1aWDLCB1GxQdifuyLP0rWHFDsBOVyrB
         SQz8fmog3gVS7IHJUpE20Tf5emQ3ATSQZLuv3q5+SzRzmqkgCYelF1xnu8IfMHJEvNPa
         QoijkMXAwauICHEFCxACR5o+4cNGnQ6BQbK7w4z/mnML2xGjshtJ3TrIpt/QWZ1pjXXX
         2ZdNkxsH84BuQ1QQWVpY0QPHI50TqPcwfT/kXyWmNRVOsIXFarJOzwVlvZXxQsFfZPWS
         6shXDnBh2ghrOBiVVwVQKtnfnasdkK4rld3KaU3y8KRKVGzSf9XfpqWGj25+2jS5UGin
         LQBw==
X-Gm-Message-State: APjAAAULiwyC1jrA5VTYTd/bH8sbPVcsUnniPIlMsuYDuGy9bRFTTNUp
        qn09lXmThBLuDhSGFaenaU5O2JzKTDyQRQ==
X-Google-Smtp-Source: APXvYqy2RPf1EWJTE5thsigSgQnTSK9fZBeGJmChON0tx5U/ZvgnYBw2HIVw83BdYuHDLHTSkkrmbw==
X-Received: by 2002:a02:ca42:: with SMTP id i2mr10497732jal.87.1575582768972;
        Thu, 05 Dec 2019 13:52:48 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:48 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 18/18] dyndbg-docs: normalize comments in examples
Date:   Thu,  5 Dec 2019 14:51:51 -0700
Message-Id: <20191205215151.421926-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

given that:
  ~# cat batch-of-dyndbg-cmd-queries > /sys/kernel/debug/dyndbg/control

works, and since '#' is a legal comment character accepted
by >control, the syntax is much more like bash than c++.

So replace '//' with '#'.
Someone might copy-paste these examples, lets make them more usable

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 51 ++++++++++---------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index d91dbb52721d..33eed4713bb8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -189,11 +189,11 @@ format
     characters (``"``) or single quote characters (``'``).
     Examples::
 
-	format svcrdma:         // many of the NFS/RDMA server pr_debugs
-	format readahead        // some pr_debugs in the readahead cache
-	format nfsd:\040SETATTR // one way to match a format with whitespace
-	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
-	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
+	format svcrdma:         # many of the NFS/RDMA server pr_debugs
+	format readahead        # some pr_debugs in the readahead cache
+	format nfsd:\040SETATTR # one way to match a format with whitespace
+	format "nfsd: SETATTR"  # a neater way to match a format with whitespace
+	format 'nfsd: SETATTR'  # yet another way to match a format with whitespace
 
 line
     The given line number or range of line numbers is compared
@@ -204,10 +204,10 @@ line
     the first line in the file, an empty last line number means the
     last line number in the file.  Examples::
 
-	line 1603           // exactly line 1603
-	line 1600-1605      // the six lines from line 1600 to line 1605
-	line -1605          // the 1605 lines from line 1 to line 1605
-	line 1600-          // all lines from line 1600 to the end of the file
+	line 1603           # exactly line 1603
+	line 1600-1605      # the six lines from line 1600 to line 1605
+	line -1605          # the 1605 lines from line 1 to line 1605
+	line 1600-          # all lines from line 1600 to the end of the file
 
 Flags Specification::
 
@@ -345,44 +345,47 @@ Examples
 
 ::
 
-  // enable the message at line 1603 of file svcsock.c
+  # enable the message at line 1603 of file svcsock.c
   nullarbor:~ # echo -n 'file svcsock.c line 1603 +p' >
 				<debugfs>/dyndbg/control
 
-  // enable all the messages in file svcsock.c
+  # enable all the messages in file svcsock.c
   nullarbor:~ # echo -n 'file svcsock.c +p' >
 				<debugfs>/dyndbg/control
 
-  // enable all the messages in the NFS server module
+  # enable all the messages in the NFS server module
   nullarbor:~ # echo -n 'module nfsd +p' >
 				<debugfs>/dyndbg/control
 
-  // enable all 12 messages in the function svc_process()
+  # enable all 12 messages in the function svc_process()
   nullarbor:~ # echo -n 'func svc_process +p' >
 				<debugfs>/dyndbg/control
 
-  // disable all 12 messages in the function svc_process()
+  # disable all 12 messages in the function svc_process()
   nullarbor:~ # echo -n 'func svc_process -p' >
 				<debugfs>/dyndbg/control
 
-  // enable messages for NFS calls READ, READLINK, READDIR and READDIR+.
+  # enable messages for NFS calls READ, READLINK, READDIR and READDIR+.
   nullarbor:~ # echo -n 'format "nfsd: READ" +p' >
 				<debugfs>/dyndbg/control
 
-  // enable messages in files of which the paths include string "usb"
+  # enable messages in files of which the paths include string "usb"
   nullarbor:~ # echo -n '*usb* +p' > <debugfs>/dyndbg/control
 
-  // enable all messages
+  # enable all messages
   nullarbor:~ # echo -n '+p' > <debugfs>/dyndbg/control
 
-  // add module, function to all enabled messages
+  # add module, function to all enabled messages
   nullarbor:~ # echo -n '+mf' > <debugfs>/dyndbg/control
 
-  // boot-args example, with newlines and comments for readability
-  Kernel command line: ...
-    // see whats going on in dyndbg=value processing
+  # boot-args example, with newlines and comments for readability
+  # Kernel command line: ...
+
+    # see whats going on in dyndbg=value processing
     dyndbg.verbose=1
-    // enable pr_debugs in 2 builtins, #cmt is stripped
+
+    # enable pr_debugs in 2 builtins, #cmt is stripped
     dyndbg="module params +p #cmt ; module sys +p"
-    // enable pr_debugs in 2 functions in a module loaded later
-    pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
+
+    # enable pr_debugs in 2 functions in a module loaded later
+    pc87360.dyndbg="func *_init_device +p; func *_find +p"
-- 
2.23.0

