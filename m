Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070812054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLgHYvbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCEQiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:38:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37805 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:38:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so7767745edv.4;
        Tue, 05 Mar 2019 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnhcV/ZyxNZgbNPWXuYc7A3itDoQsLSS3KxRarlrvEk=;
        b=rLgHYvbk9kbVovFsFpJJbvCS4/CQz2cl1G5pR6iZ1ZbAcj3BIawr2pQTfRjObfyCRx
         LWECCxJiPMdo6IES5GWrdd9UwPpu/FtDtnbTqFZxG/qHJ4NQMphY5Suo59FiP142cUu2
         RmbCtRa2uC1HGSZ6GWSODa2Pu2lJnvB4Tm4YFYrJnxyXY0xXcEdBLpBWuOZ3V1BG48Lu
         maLGMCAGpz3jFwxe8oVT6p/x0bl5U/gD49jcxTLrFduu9pIQFB/3KZtkCiiNQvDRBhvU
         EWb8hgfiF/RPq912c82zow+mRMDifQrHkDg9U44SY27ffZSvhzJb8w6PeCh+uXGic7MB
         FsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xnhcV/ZyxNZgbNPWXuYc7A3itDoQsLSS3KxRarlrvEk=;
        b=JBMMnXkWAIyVTQewq1nynFlx8PBd0THdy4IXTftGV6pWfusIVxRqGwOmpy+bj0aEFW
         hcqW3I860vQ/K6q14Xd3vr/wmawLuKIf6i0mGve8raoh0CMRzlaFVThQHWqWDOSQ4YwZ
         QAbPrDCoAZoEwrxxETEl55iTUjYBHlPIW/lVjgC4fB2m2vEYXRPWr9AaMj15wGMSsYPX
         DlSP5APZjB2rwmQP0eizK56AX2uLqRfL1eHC05GE5Xpd3I2eMZStOX7i9BmEHONIOZSp
         a/r0uKiH5OnylDn1DoBmWkeY/pjOa7aIxg21b5gv6eB3wY8Wk1bOIOWIoc5/wicTYBaw
         cKcg==
X-Gm-Message-State: APjAAAVbrm/u7Knq+U6A/goDd299+mzIzHHjbmo87XuO9Fq0zpOKSU2b
        W+nqJAX2/UP4oc574agk9zw=
X-Google-Smtp-Source: APXvYqziPr814jkBPyFmvztJlFuiIKCRo/j8R9Sp952DeKKQrrmm2Up1B2DuLoIGh6OY9qp/4x+SDg==
X-Received: by 2002:a17:906:5781:: with SMTP id k1mr904007ejq.34.1551803928911;
        Tue, 05 Mar 2019 08:38:48 -0800 (PST)
Received: from localhost.localdomain (ip5b402483.dynamic.kabel-deutschland.de. [91.64.36.131])
        by smtp.gmail.com with ESMTPSA id g24sm3159825edc.67.2019.03.05.08.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 08:38:48 -0800 (PST)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1] tools/bpftool: create map of maps
Date:   Tue,  5 Mar 2019 17:38:03 +0100
Message-Id: <20190305163803.18915-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

Before this patch, there was no way to fill attr.inner_map_fd, necessary
for array_of_maps or hash_of_maps.

This patch adds keyword 'innermap' to pass the innermap, either as an id
or as a pinned map.

Example of commands:

$ sudo bpftool map create /sys/fs/bpf/innermap type hash \
        key 8 value 8 entries 64 name innermap flags 1
$ sudo bpftool map create /sys/fs/bpf/outermap type hash_of_maps \
        innermap pinned /sys/fs/bpf/innermap key 64 value 4 \
        entries 64 name myoutermap flags 1
$ sudo bpftool map show pinned /sys/fs/bpf/outermap
47: hash_of_maps  name myoutermap  flags 0x1
	key 64B  value 4B  max_entries 64  memlock 12288B

Documentation and bash completion updated as well.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool        | 13 +++++++++++++
 tools/bpf/bpftool/map.c                          |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 9386bd6e0396..35902ab95cc5 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -25,7 +25,7 @@ PROG COMMANDS
 |	**bpftool** **prog dump xlated** *PROG* [{**file** *FILE* | **opcodes** | **visual** | **linum**}]
 |	**bpftool** **prog dump jited**  *PROG* [{**file** *FILE* | **opcodes** | **linum**}]
 |	**bpftool** **prog pin** *PROG* *FILE*
-|	**bpftool** **prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*]
+|	**bpftool** **prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**innermap** MAP]
 |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
 |	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
 |	**bpftool** **prog tracelog**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index b803827d01e8..dcdc39510dc3 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -461,6 +461,18 @@ _bpftool()
                             _sysfs_get_netdevs
                             return 0
                             ;;
+                        innermap)
+                            COMPREPLY+=( $( compgen -W "id pinned" -- "$cur" ) )
+                            return 0
+                            ;;
+                        id)
+                            _bpftool_get_map_ids
+                            return 0
+                            ;;
+                        pinned)
+                            _filedir
+                            return 0
+                            ;;
                         *)
                             _bpftool_once_attr 'type'
                             _bpftool_once_attr 'key'
@@ -469,6 +481,7 @@ _bpftool()
                             _bpftool_once_attr 'name'
                             _bpftool_once_attr 'flags'
                             _bpftool_once_attr 'dev'
+                            _bpftool_once_attr 'innermap'
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e0c650d91784..7d8ce903a471 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
 				return -1;
 			}
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "innermap")) {
+			NEXT_ARG();
+			attr.inner_map_fd = map_parse_fd(&argc, &argv);
 		}
 	}
 
@@ -1231,7 +1234,7 @@ static int do_help(int argc, char **argv)
 		"Usage: %s %s { show | list }   [MAP]\n"
 		"       %s %s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
 		"                              entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
-		"                              [dev NAME]\n"
+		"                              [dev NAME] [innermap MAP]\n"
 		"       %s %s dump       MAP\n"
 		"       %s %s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
 		"       %s %s lookup     MAP [key DATA]\n"
-- 
2.20.1

