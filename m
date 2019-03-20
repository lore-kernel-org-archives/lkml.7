Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C556C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5WcD+HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCTRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:35:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39830 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfCTRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:35:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so2713914edc.6;
        Wed, 20 Mar 2019 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+s8sbfNcKDfbAnsHt0EGDXc7Uh4rdT0A304olFMG7DE=;
        b=I5WcD+HROkuIQLnM+/p8I46lPjG9Chi0JMvxzJ6w7L11HNoR62X6AFmjWb+naSTySc
         pod0QELmz17wgKAK4/jdao+wvGLfOiHJpGvXO73Q/XcknCnj0sSpGI1KHQ7U1PAccWwe
         hjd6JzZr2bocrjV0YYBZMuoNQdRcqHCARoUT+Xs/d/PcnqeiG4lYOrkH8dLATTGfPajH
         AvSie5ZyQSt209b+bcGsYBm4jYehZULNPc97W1avWC4TIAK4W5l9nYKBDF4TicyzCr9z
         sMrNsWpYl1BH17DBI6aamU35Gtw800oiCCrOpLmbQDHxz0bK5iiVX/8EXHrNVoXoh5TQ
         1vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+s8sbfNcKDfbAnsHt0EGDXc7Uh4rdT0A304olFMG7DE=;
        b=S37BHTX07rhiaBoRrguc4Jas2H/E6Yo5Th+YaEKlPkRq9CQB6suj5iu3Wy1w7/G+ih
         fuqBjBn6rW0/NlEfvXdwZ+KFbENJCIIAauKqXm9DtNKqXmEj34jT/WjvvZHasXi+gTun
         kj1ASmt4ifyMpVl0J4vYoNX3Sh8LyrJrow+TPc5KRvRBfGsvPGfdHfOoLPsyj7jb5SdV
         /DA0qM03kHya6B0Dc20nxItBx10A80tfiM+YC1ITfEs2oRXusbmJKregnpW9aBHBAamm
         FMnypz3bRhjGYrPIzea4NhL3dgSnHYaNo14aOKkiX4sNTh9lY1CNqu6QKbuIt9rayZlv
         6BsA==
X-Gm-Message-State: APjAAAUEjvO1Qh4SSDB2iRSOdzOf324FgJJ0RFWlA6io4+LLXWTJ58Ea
        fKewsiNyElpfEvUZyg3PICU=
X-Google-Smtp-Source: APXvYqx6Ya2fPu05woKxH0WYuioKRtmEcQ6GYeAbAiH9XlHc1L4YaKTPpIZpex0KFiHqkbMcN6pWgA==
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr17861156ejj.62.1553103311824;
        Wed, 20 Mar 2019 10:35:11 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:35:11 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 4/7] tools: bpftool: implement map exec command
Date:   Wed, 20 Mar 2019 18:33:29 +0100
Message-Id: <20190320173332.18105-4-alban@kinvolk.io>
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

The map exec commands allows to open an existing map and pass the file
descriptor to a child process. This enables applications to use an
existing BPF map even when they don't support bpffs.

Example of usage:
    # bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99
    anon_inode:bpf-map

Documentation and bash completion updated as well.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst | 11 ++++
 tools/bpf/bpftool/bash-completion/bpftool     | 22 +++++++-
 tools/bpf/bpftool/map.c                       | 53 +++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index b685641bfd74..dfd8352fa453 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -30,6 +30,7 @@ MAP COMMANDS
 |	**bpftool** **map getnext**    *MAP* [**key** *DATA*]
 |	**bpftool** **map delete**     *MAP*  **key** *DATA*
 |	**bpftool** **map pin**        *MAP*  *FILE*
+|	**bpftool** **map exec**       *MAP*  **fd** *FD* **cmd** -- *CMD*
 |	**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
 |	**bpftool** **map peek**       *MAP*
 |	**bpftool** **map push**       *MAP* **value** *VALUE*
@@ -101,6 +102,10 @@ DESCRIPTION
 		  contain a dot character ('.'), which is reserved for future
 		  extensions of *bpffs*.
 
+	**bpftool map exec**     *MAP*  **fd** *FD* **cmd** -- *CMD*
+                  Load map and exec an external command, passing the file
+                  descriptor.
+
 	**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
 		  Read events from a BPF_MAP_TYPE_PERF_EVENT_ARRAY map.
 
@@ -254,6 +259,12 @@ would be lost as soon as bpftool exits).
   key: 00 00 00 00  value: 22 02 00 00
   Found 1 element
 
+**# bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99**
+
+::
+
+  anon_inode:bpf-map
+
 SEE ALSO
 ========
 	**bpf**\ (2),
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 9e37de8bb227..63cd53c4d3a7 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -583,6 +583,26 @@ _bpftool()
                     fi
                     return 0
                     ;;
+                exec)
+                    case $prev in
+                        $command)
+                            COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
+                            return 0
+                            ;;
+                        fd)
+                            return 0
+                            ;;
+                        cmd)
+                            COMPREPLY=( $(compgen -c -- "$cur" ) )
+                            return 0
+                            ;;
+                        *)
+                            _bpftool_once_attr 'fd'
+                            _bpftool_once_attr 'cmd'
+                            return 0
+                            ;;
+                    esac
+                    ;;
                 event_pipe)
                     case $prev in
                         $command)
@@ -610,7 +630,7 @@ _bpftool()
                     [[ $prev == $object ]] && \
                         COMPREPLY=( $( compgen -W 'delete dump getnext help \
                             lookup pin event_pipe show list update create \
-                            peek push enqueue pop dequeue' -- \
+                            peek push enqueue pop dequeue exec' -- \
                             "$cur" ) )
                     ;;
             esac
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index a576f2a019be..768497364cee 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -883,6 +883,58 @@ static int do_update(int argc, char **argv)
 	return err;
 }
 
+static int do_exec(int argc, char **argv)
+{
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	int fd, ret;
+	__u32 outfd = 0;
+
+	if (argc < 2)
+		usage();
+
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	if (fd < 0)
+		return -1;
+
+	while (argc) {
+		if (is_prefix(*argv, "fd")) {
+			if (parse_u32_arg(&argc, &argv, &outfd,
+					  "out fd"))
+				return -1;
+		} else if (is_prefix(*argv, "cmd")){
+			NEXT_ARG();
+			if (!REQ_ARGS(1))
+				return -1;
+
+			break;
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
+		}
+	}
+
+	if (outfd == 0) {
+		p_err("invalid fd");
+		return -1;
+	}
+	if (*argv == NULL) {
+		p_err("empty command");
+		return -1;
+	}
+
+
+	ret = dup2(fd, (int)outfd);
+	if (ret == -1) {
+		p_err("dup2 failed: %s", strerror(errno));
+		return -1;
+	}
+
+	execvp(argv[0], argv);
+	p_err("execvp failed: %s", strerror(errno));
+	return -1;
+}
+
 static void print_key_value(struct bpf_map_info *info, void *key,
 			    void *value)
 {
@@ -1355,6 +1407,7 @@ static const struct cmd cmds[] = {
 	{ "enqueue",	do_update },
 	{ "pop",	do_pop_dequeue },
 	{ "dequeue",	do_pop_dequeue },
+	{ "exec",	do_exec },
 	{ 0 }
 };
 
-- 
2.20.1

