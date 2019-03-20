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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE3FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE321841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7QHHxEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCTRet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:34:49 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:32978 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:34:49 -0400
Received: by mail-ed1-f45.google.com with SMTP id q3so2749764edg.0;
        Wed, 20 Mar 2019 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyG0+IhSrvIsPBpMfBKUItVTc3RXjV8cpzg2PjTIN64=;
        b=c7QHHxEhCeiNhk11obJhX4GSRJWxbMQO/xGiNnzh/Mw2tGKYQQjbcXLwkDk9TSjFru
         J0IFtQJsg75DzV0iZSZyFdtP1Ryi363WWw7fvp9S/unqNiYb5ogMJiq/t+Y0R2oUhpse
         Zq9/ZlhOSV0mxcO5Sjug6ecchx+NBiOUWCl+tvSy2gMFM3F6KvHjEBS9EEb5q2xpns7e
         VYtGV3lhdu0kcpQghebFqOsqxsa0fw6pnX4zBhn/EhRumXsH9KGkbguqC9puPbg55IyJ
         YJNYwQncSlpaLQhJOwLbOh13wubinrJc4+kjbRG6ReTNB00TF6im68e5erHHSOwS536y
         PCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vyG0+IhSrvIsPBpMfBKUItVTc3RXjV8cpzg2PjTIN64=;
        b=a0dPGcmozL6cdUL1tjv5mti6Nt8nfBNmncC/otnIxcQA9Rb9j3lrbj/+7/h/6vV3jv
         d5XrfjhuA7b+Zfd1cUKu3oFfZ5b/kzqCYHNxUoLowSl7XvZkBAwJAR4f3K1WC4Y0sv0w
         MdVvbOAGdL2rq9+15cDx81T0HI0pEy1pE7Pg01GmYTLrm9gQHNUwhK8YZX0nIf/WYSJz
         pmjvBAkCrs4cuZtdYwEzXW6+Rl/hCuvfZLqIdhK1rK5UmfcG496syASAlpJsiegCc3B2
         fxFyJgb8OUYu+aDebw7yJZPmHGHxgnee9yMBzEF1YikLm994UwplVGSyYYwZXfJKatwN
         4+DA==
X-Gm-Message-State: APjAAAUBKqE159qONhclIWQP/LIoQqeluiV3FlGj+v3Lz2sIya2xHfuC
        Kk8y+sCRA4QSkYXiZvfKtLlq/71++TY=
X-Google-Smtp-Source: APXvYqxMLVLVz9UbvTAbBuM5ZrJ+Sg/0Wxl4TgD4yHJeoLWq0fwexscWglxkPdC4dazbq2Z8NUnkZA==
X-Received: by 2002:a17:906:2781:: with SMTP id j1mr17932233ejc.238.1553103286635;
        Wed, 20 Mar 2019 10:34:46 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:34:45 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 2/7] tools: bpftool: fix error message on invalid argument count
Date:   Wed, 20 Mar 2019 18:33:27 +0100
Message-Id: <20190320173332.18105-2-alban@kinvolk.io>
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

Symptoms:
$ sudo bpftool map create /sys/fs/bpf/dir/foobar type hash key 8 value 8 entries
Error: '8' needs at least 2 arguments, 1 found

After this patch:
$ sudo bpftool map create /sys/fs/bpf/dir/foobar type hash key 8 value 8 entries
Error: can't parse max entries: missing argument

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/common.c |  5 +++++
 tools/bpf/bpftool/main.h   | 11 +++++++----
 tools/bpf/bpftool/map.c    | 15 ++++++++++++---
 tools/bpf/bpftool/prog.c   |  2 --
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index f7261fad45c1..e560cd8f66bc 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -627,6 +627,11 @@ int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what)
 		return -1;
 	}
 
+	if (*argc == 0) {
+		p_err("can't parse %s: missing argument", what);
+		return -1;
+	}
+
 	*val = strtoul(**argv, &endptr, 0);
 	if (*endptr) {
 		p_err("can't parse %s as %s", **argv, what);
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index d7dd84d3c660..7fc2973446d0 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -22,14 +22,17 @@
 #define NEXT_ARGP()	({ (*argc)--; (*argv)++; if (*argc < 0) usage(); })
 #define BAD_ARG()	({ p_err("what is '%s'?", *argv); -1; })
 #define GET_ARG()	({ argc--; *argv++; })
-#define REQ_ARGS(cnt)							\
+
+#define REQ_ARGS(cnt)	REQ_ARGS_GENERIC(cnt, argc, argv)
+#define REQ_ARGSP(cnt)	REQ_ARGS_GENERIC(cnt, *argc, *argv)
+#define REQ_ARGS_GENERIC(cnt, ARGC, ARGV)				\
 	({								\
 		int _cnt = (cnt);					\
 		bool _res;						\
 									\
-		if (argc < _cnt) {					\
-			p_err("'%s' needs at least %d arguments, %d found", \
-			      argv[-1], _cnt, argc);			\
+		if ((ARGC) < _cnt) {					\
+			p_err("'%s' needs at least %d arguments, %d found",	\
+			      (ARGV)[-1], _cnt, (ARGC));			\
 			_res = false;					\
 		} else {						\
 			_res = true;					\
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 994a7e0d16fb..18f9bc3aed4f 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -98,6 +98,9 @@ int map_parse_fd(int *argc, char ***argv)
 		char *endptr;
 
 		NEXT_ARGP();
+		if (!REQ_ARGSP(1)) {
+			return -1;
+		}
 
 		id = strtoul(**argv, &endptr, 0);
 		if (*endptr) {
@@ -114,6 +117,9 @@ int map_parse_fd(int *argc, char ***argv)
 		char *path;
 
 		NEXT_ARGP();
+		if (!REQ_ARGSP(1)) {
+			return -1;
+		}
 
 		path = **argv;
 		NEXT_ARGP();
@@ -1100,11 +1106,10 @@ static int do_create(int argc, char **argv)
 	pinfile = GET_ARG();
 
 	while (argc) {
-		if (!REQ_ARGS(2))
-			return -1;
-
 		if (is_prefix(*argv, "type")) {
 			NEXT_ARG();
+			if (!REQ_ARGS(1))
+				return -1;
 
 			if (attr.map_type) {
 				p_err("map type already specified");
@@ -1119,6 +1124,8 @@ static int do_create(int argc, char **argv)
 			NEXT_ARG();
 		} else if (is_prefix(*argv, "name")) {
 			NEXT_ARG();
+			if (!REQ_ARGS(1))
+				return -1;
 			attr.name = GET_ARG();
 		} else if (is_prefix(*argv, "key")) {
 			if (parse_u32_arg(&argc, &argv, &attr.key_size,
@@ -1138,6 +1145,8 @@ static int do_create(int argc, char **argv)
 				return -1;
 		} else if (is_prefix(*argv, "dev")) {
 			NEXT_ARG();
+			if (!REQ_ARGS(1))
+				return -1;
 
 			if (attr.map_ifindex) {
 				p_err("offload device already specified");
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8ef80d65a474..e0875ef5e444 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -836,8 +836,6 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
 	}
 
 	NEXT_ARG();
-	if (!REQ_ARGS(2))
-		return -EINVAL;
 
 	*mapfd = map_parse_fd(&argc, &argv);
 	if (*mapfd < 0)
-- 
2.20.1

