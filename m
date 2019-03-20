Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C9721841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATpSTJT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCTRfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:35:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44709 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfCTRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:35:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so2695218edh.11;
        Wed, 20 Mar 2019 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3d4L7qgjXukp3nae2eWfDw2JFI933yOhfTDnPpdn0FI=;
        b=ATpSTJT0UXYTy91sNHIv2PtCjo+0TKF5BuCHnLUfRtVYwFCvkrQsLsQc9nNyw8tSYF
         C11V8HgLD04nR3UhCLgvzBNAO32i+yL/W2SSl4yWbBbQSK3lI6D4SJz4On9L5jtFIPdu
         7JDg6jckDjXB5JTgCYN0o1ud9J6Y3lIry/PJsghmvZ+985l5EWOPeln8uCUhX3dbvjZm
         agunkDYUzOp4zSbfYSShIw/8/vnTd6kpneGAWwdWM9dPiTu57tO6wJnCM0RCg+HMt8xo
         /o3/hlmgVaJCB9R5A5N2i9u1wtZzWOEVqZ2okTjt84Cq5GZWWwjSMsi8h3ghG53qr5sa
         WTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3d4L7qgjXukp3nae2eWfDw2JFI933yOhfTDnPpdn0FI=;
        b=UB5MaU0xTpo4uoCWE1A6mylKB1R3NjNa8nQ9yAUA6PmEi4/SutyogVe2xsfnPJAUr4
         YB4OXhD2zBD2EuUccoUmE2fjQtHuJzcMEJfH4Lf5WfVc59MDWApj4Hp3sJD8l+yy/UeW
         UeuKl42Asj65Y5zb3zpGPCDyt1yEjsrSZbBCkUcECCxJwnz7YfzrxUu7tRIBil1CM3mX
         OGBW55BCDa14CGCtYjhJLoxg0JVVrcVxQ+Hv1bMz93nxkQ+E7htV8iTAEGB3W9Wg5rbn
         z4YRYBIpknY9iSqr0k9IWfHKoyBbEtV+basTtKlSZFMEtEPlxQOnzUcu0bBYdo04vxjJ
         F4Pw==
X-Gm-Message-State: APjAAAXz3/mLKZhm4fGhB0evgNvj/ORGAfSth0ilDTl05Xd5IwfiRo68
        dzVWCCkgslGa9LS9QEoh17Q=
X-Google-Smtp-Source: APXvYqwUBX0YXl6+1hXKwliyZn3/rokWbPkW9YVsKAWfWmPwvRCp7UyN9U40+O3AT12SdsOYowNNHA==
X-Received: by 2002:a17:906:828f:: with SMTP id h15mr10115535ejx.170.1553103330401;
        Wed, 20 Mar 2019 10:35:30 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:35:29 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 5/7] tools: bpftool: support loading map by fd from parent process
Date:   Wed, 20 Mar 2019 18:33:30 +0100
Message-Id: <20190320173332.18105-5-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320173332.18105-1-alban@kinvolk.io>
References: <20190320173332.18105-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

Using a file descriptor passed by the parent process enables
applications to fork a bpftool command to inspect a map they know by
file descriptor even when they don't support bpffs or map ids.

Documentation and bash completion updated as well.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst |  8 ++++++++
 tools/bpf/bpftool/bash-completion/bpftool       | 10 +++++-----
 tools/bpf/bpftool/map.c                         | 13 +++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index dfd8352fa453..658fe2fb8ecf 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -265,6 +265,14 @@ would be lost as soon as bpftool exits).
 
   anon_inode:bpf-map
 
+**# bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- bpftool map show fd 99**
+
+::
+
+  10: hash  name some_map  flags 0x0
+	key 4B  value 8B  max_entries 2048  memlock 167936B
+
+
 SEE ALSO
 ========
 	**bpf**\ (2),
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 63cd53c4d3a7..9ec1833bda1e 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -253,7 +253,7 @@ _bpftool()
             esac
 
             local PROG_TYPE='id pinned tag'
-            local MAP_TYPE='id pinned'
+            local MAP_TYPE='id pinned fd'
             case $command in
                 show|list)
                     [[ $prev != "$command" ]] && return 0
@@ -343,7 +343,7 @@ _bpftool()
                     obj=${words[3]}
 
                     if [[ ${words[-4]} == "map" ]]; then
-                        COMPREPLY=( $( compgen -W "id pinned" -- "$cur" ) )
+                        COMPREPLY=( $( compgen -W "id pinned fd" -- "$cur" ) )
                         return 0
                     fi
                     if [[ ${words[-3]} == "map" ]]; then
@@ -406,7 +406,7 @@ _bpftool()
             esac
             ;;
         map)
-            local MAP_TYPE='id pinned'
+            local MAP_TYPE='id pinned fd'
             case $command in
                 show|list|dump|peek|pop|dequeue)
                     case $prev in
@@ -462,7 +462,7 @@ _bpftool()
                             return 0
                             ;;
                         innermap)
-                            COMPREPLY+=( $( compgen -W "id pinned" -- "$cur" ) )
+                            COMPREPLY+=( $( compgen -W "id pinned fd" -- "$cur" ) )
                             return 0
                             ;;
                         id)
@@ -525,7 +525,7 @@ _bpftool()
                             # map, depending on the type of the map to update.
                             case "$(_bpftool_map_guess_map_type)" in
                                 array_of_maps|hash_of_maps)
-                                    local MAP_TYPE='id pinned'
+                                    local MAP_TYPE='id pinned fd'
                                     COMPREPLY+=( $( compgen -W "$MAP_TYPE" \
                                         -- "$cur" ) )
                                     return 0
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 768497364cee..9befcabc299d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -125,6 +125,19 @@ int map_parse_fd(int *argc, char ***argv)
 		NEXT_ARGP();
 
 		return open_obj_pinned_any(path, BPF_OBJ_MAP);
+	} else if (is_prefix(**argv, "fd")) {
+		char *endptr;
+
+		NEXT_ARGP();
+
+		fd = strtoul(**argv, &endptr, 0);
+		if (*endptr) {
+			p_err("can't parse %s as fd", **argv);
+			return -1;
+		}
+		NEXT_ARGP();
+
+		return dup(fd);
 	}
 
 	p_err("expected 'id' or 'pinned', got: '%s'?", **argv);
-- 
2.20.1

