Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8874B21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOCp8HA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCTRfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:35:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43888 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:35:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id m35so2692025ede.10;
        Wed, 20 Mar 2019 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxtZeD7M2qA/5TNoThqyV7HsYvGEX92bNGAs8Nl5Zdk=;
        b=tOCp8HA+7fEbLW/BgnlIUikOY5cz/dAKDU2npUDamp5aSBnnQ8GQfC5szuTiMl3oQr
         gDbJF3jxuCgDQrDqJeSrBHzQPxRZlOS/F6zELACdZErgEhw/J5UDcuFu0AkO47qFqFDQ
         ZN3wD5zh5weJ3Pe6bGHp0QEmemz9GG57qaPnT51eTh3RKMO3YY3leM3F/Oti5ocrv9/w
         PvZnB81loOb1B+a3IZ4vYru9k7xzXcQHXB2o9bVKJGWuST4mIguuSJ5pTJhqNYDjkrZk
         8QP2146Ecb5nqKfEEqkRcMqVmQpFX/X1bxpdSKeDYnLmUF8pnHNV864XeQrvpoZryrtM
         1k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sxtZeD7M2qA/5TNoThqyV7HsYvGEX92bNGAs8Nl5Zdk=;
        b=ZY9sVRsqs8qMOyBo3dcKdb12+SjzM8xH2Am4vILTY0mFhFlbBmjpwkrKgCJzq5CZ2d
         8QyfPKInipfFbILcuQlB+je7QSvXtfxrJXZKJ+BHYcHCAS/7ZK9PegM7guJ+Npu1u7kj
         Kwta1Lr9i5UQoEzYidu9baw2MBwK1p80c34H0sT3kE0QGwGraa7DT5gxkqOfJU6ZSQqQ
         t4c8qy+OaQxyg31g49bLHZOJ0dz7mxbnGcIqGlRmGTWoOFA2lOw2MI/KmaZThmhxXDeq
         lC2PBPSOB0gjr5W5zLa/X0XuDoDWt94Gl8gHYEwl5CKNJkHT7fzASFZxu3rkhxqypY46
         44/g==
X-Gm-Message-State: APjAAAVuxjBhKC4hvydLiJ9x5F3OrRVvLDru6nwkXWejv5y+OiAZfX1m
        iywSshriP5VgbQ+PxFkZgt0=
X-Google-Smtp-Source: APXvYqxCvkFLqLvoU+PJcTnVIB/q3p9HMzfwgecP4OCu9GGSJrRGaxfaLtbKLEU2kFk2XohNvx1dQw==
X-Received: by 2002:a17:906:fd5:: with SMTP id c21mr17844911ejk.86.1553103301297;
        Wed, 20 Mar 2019 10:35:01 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:35:00 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 3/7] tools: bpftool: create map of maps
Date:   Wed, 20 Mar 2019 18:33:28 +0100
Message-Id: <20190320173332.18105-3-alban@kinvolk.io>
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

Previous version of this patch was sent while bpf-next was closed.
https://marc.info/?l=linux-kernel&m=155180393501258&w=2

Since then, the following changes were done:
- error management when calling map_parse_fd (review from Jakub)
- fix documentation and bash completion (review from Quentin)
---
 .../bpf/bpftool/Documentation/bpftool-map.rst |  9 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  9 +++
 tools/bpf/bpftool/map.c                       | 75 +++++++++++++++++--
 3 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5c984ffc9f01..b685641bfd74 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -23,7 +23,7 @@ MAP COMMANDS
 
 |	**bpftool** **map { show | list }**   [*MAP*]
 |	**bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
-|		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*]
+|		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*] [**innermap** MAP]
 |	**bpftool** **map dump**       *MAP*
 |	**bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
 |	**bpftool** **map lookup**     *MAP* [**key** *DATA*]
@@ -60,10 +60,15 @@ DESCRIPTION
 		  Output will start with map ID followed by map type and
 		  zero or more named attributes (depending on kernel version).
 
-	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*]
+	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*] [**innermap** MAP]
 		  Create a new map with given parameters and pin it to *bpffs*
 		  as *FILE*.
 
+		  To create a map of type **array_of_maps** or
+		  **hash_of_maps**, the additional parameter **innermap** needs
+		  to reference an existing map with the type and size of the
+		  maps in the values.
+
 	**bpftool map dump**    *MAP*
 		  Dump all entries in a given *MAP*.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index b803827d01e8..9e37de8bb227 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -461,6 +461,14 @@ _bpftool()
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
                         *)
                             _bpftool_once_attr 'type'
                             _bpftool_once_attr 'key'
@@ -469,6 +477,7 @@ _bpftool()
                             _bpftool_once_attr 'name'
                             _bpftool_once_attr 'flags'
                             _bpftool_once_attr 'dev'
+                            _bpftool_once_attr 'innermap'
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 18f9bc3aed4f..a576f2a019be 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1100,6 +1100,7 @@ static int do_create(int argc, char **argv)
 	struct bpf_create_map_attr attr = { NULL, };
 	const char *pinfile;
 	int err, fd;
+	int inner_map_fd = -1;
 
 	if (!REQ_ARGS(7))
 		return -1;
@@ -1108,48 +1109,75 @@ static int do_create(int argc, char **argv)
 	while (argc) {
 		if (is_prefix(*argv, "type")) {
 			NEXT_ARG();
-			if (!REQ_ARGS(1))
+			if (!REQ_ARGS(1)) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 
 			if (attr.map_type) {
 				p_err("map type already specified");
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
 			}
 
 			attr.map_type = map_type_from_str(*argv);
 			if ((int)attr.map_type < 0) {
 				p_err("unrecognized map type: %s", *argv);
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
 			}
 			NEXT_ARG();
 		} else if (is_prefix(*argv, "name")) {
 			NEXT_ARG();
-			if (!REQ_ARGS(1))
+			if (!REQ_ARGS(1)) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 			attr.name = GET_ARG();
 		} else if (is_prefix(*argv, "key")) {
 			if (parse_u32_arg(&argc, &argv, &attr.key_size,
-					  "key size"))
+					  "key size")) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 		} else if (is_prefix(*argv, "value")) {
 			if (parse_u32_arg(&argc, &argv, &attr.value_size,
-					  "value size"))
+					  "value size")) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 		} else if (is_prefix(*argv, "entries")) {
 			if (parse_u32_arg(&argc, &argv, &attr.max_entries,
-					  "max entries"))
+					  "max entries")) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 		} else if (is_prefix(*argv, "flags")) {
 			if (parse_u32_arg(&argc, &argv, &attr.map_flags,
-					  "flags"))
+					  "flags")) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 		} else if (is_prefix(*argv, "dev")) {
 			NEXT_ARG();
-			if (!REQ_ARGS(1))
+			if (!REQ_ARGS(1)) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
+			}
 
 			if (attr.map_ifindex) {
 				p_err("offload device already specified");
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
 			}
 
@@ -1157,28 +1185,59 @@ static int do_create(int argc, char **argv)
 			if (!attr.map_ifindex) {
 				p_err("unrecognized netdevice '%s': %s",
 				      *argv, strerror(errno));
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
 				return -1;
 			}
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "innermap")) {
+			NEXT_ARG();
+			if (!REQ_ARGS(1)) {
+				if (inner_map_fd != -1)
+					close(inner_map_fd);
+				return -1;
+			}
+
+			if (inner_map_fd != -1) {
+				close(inner_map_fd);
+				p_err("innermap already specified");
+				return -1;
+			}
+
+			inner_map_fd = map_parse_fd(&argc, &argv);
+			if (inner_map_fd < 0)
+				return -1;
 		} else {
 			p_err("unknown arg %s", *argv);
+			if (inner_map_fd != -1)
+				close(inner_map_fd);
 			return -1;
 		}
 	}
 
 	if (!attr.name) {
 		p_err("map name not specified");
+		if (inner_map_fd != -1)
+			close(inner_map_fd);
 		return -1;
 	}
 
 	set_max_rlimit();
 
+	if (inner_map_fd != -1)
+		attr.inner_map_fd = inner_map_fd;
+
 	fd = bpf_create_map_xattr(&attr);
 	if (fd < 0) {
 		p_err("map create failed: %s", strerror(errno));
+		if (inner_map_fd != -1)
+			close(inner_map_fd);
 		return -1;
 	}
 
+	if (inner_map_fd != -1)
+		close(inner_map_fd);
+
 	err = do_pin_fd(fd, pinfile);
 	close(fd);
 	if (err)
@@ -1243,7 +1302,7 @@ static int do_help(int argc, char **argv)
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

