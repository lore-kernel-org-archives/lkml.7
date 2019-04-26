Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7897205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaYhPaGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfDZPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:50:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44108 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfDZPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:50:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so3529274edf.11;
        Fri, 26 Apr 2019 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDi+Ii45tj5MJsWUs6fBBvRocxOPLoEwq5/Nz9KCYSU=;
        b=UaYhPaGpclNXHVyB9uTsD8YuErnkiDq4LJIyv32A1JVJ/yeAjJoEqeW5zqPf4z+oVV
         3/UK4PqIAVObPOJzvBHJv3GAfLkOuBdfWOmBsqb4+1lK8B4CIPDYmuMsIdHzPQR41iUv
         sALrbZUmrqcjVF69cET6lQ9qrmMamlrIADyF2Nzpgihkj/BDzKERHxBXFaUVYkmIagSs
         Mw9Zc9iPPez7Ieh9RoAnqyr/4Pkc/to1lzTKZ3cli5mCRI89vLP6xXD+zG3GaH/LaZNV
         3bhBJYD2DYNphgKdVjTpq+e3PVOhL8Y6aO41lPWJZA3txKHcA0hXZg+g9QaQetvCLGSJ
         kcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VDi+Ii45tj5MJsWUs6fBBvRocxOPLoEwq5/Nz9KCYSU=;
        b=e8LYAfsGZEnLz3qxXVtMwSoYO9i/G85HlXOaKzi/urywnIx76Gg1DSbkqyUwSH9unz
         s3QWFUMesLhDfFsc8JRsQ1XnVH7JL/q0AyioVsAmAz9PUo9D05hDYyrgwJY8SCHTDMSY
         FsgwVnZF4r3GtjxZAT79J9JqbadJWUZErqO7EHxBP7K6lO5ChOzzuCbLN0Kx9rs6MfZD
         1NBiP9ANy3WFy2884pwG1VYY/D4vCezBUEgVQjvuX/7Rx/bwAOdfS4gRG2VGxzEiwSsh
         Lv7LbIdXZ9voPRivA6/ziWBIQC07nh9FfvZoItMjVqL14B1gi2m9jG5mbIP80s2Cwoe/
         4Hyw==
X-Gm-Message-State: APjAAAX6BevF1pNKAETv7RVl1beiF66QItiLlLoKBpuim2Brc6NYevkG
        BxJKPrMAy172SbH35QQJcT0=
X-Google-Smtp-Source: APXvYqw2mTFx9JW9FUyqMK3Rs27PJMfhUZ0V6c95Z/xhSErAboqQ8CQBVdC5aWEQcmyIbajFIhoVCg==
X-Received: by 2002:a17:906:7043:: with SMTP id r3mr2044364ejj.152.1556293799934;
        Fri, 26 Apr 2019 08:49:59 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id f15sm4603002eja.39.2019.04.26.08.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:49:58 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v3 3/4] selftests: bpf: read netns_ino from struct bpf_sock_ops
Date:   Fri, 26 Apr 2019 17:48:47 +0200
Message-Id: <20190426154848.23490-3-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426154848.23490-1-alban@kinvolk.io>
References: <20190426154848.23490-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

This shows how a sockops program could be restricted to a specific
network namespace. The sockops program looks at the current netns via
(struct bpf_sock_ops)->netns_ino and checks if the value matches the
configuration in the new BPF map "sock_netns".

The test program ./test_sockmap accepts a new parameter "--netns"; the
default value is the current netns found by stat() on /proc/self/ns/net,
so the previous tests still pass:

sudo ./test_sockmap
...
Summary: 412 PASSED 0 FAILED
...
Summary: 824 PASSED 0 FAILED

I run my additional test in the following way:

NETNS=$(readlink /proc/self/ns/net | sed 's/^net:\[\(.*\)\]$/\1/')
CGR=/sys/fs/cgroup/unified/user.slice/user-1000.slice/session-5.scope/
sudo ./test_sockmap --cgroup $CGR --netns $NETNS &

cat /sys/kernel/debug/tracing/trace_pipe

echo foo | nc -l 127.0.0.1 8080 &
echo bar | nc 127.0.0.1 8080

=> the connection goes through the sockmap

When testing with a wrong $NETNS, I get the trace_pipe log:
> not binding connection on netns 4026531992

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v1:
- tools/include/uapi/linux/bpf.h: update with netns_dev
- tools/testing/selftests/bpf/test_sockmap_kern.h: print debugs with
  both netns_dev and netns_ino

Changes since v2:
- update commitmsg to refer to netns_ino
---
 tools/testing/selftests/bpf/test_sockmap.c    | 38 +++++++++++++++++--
 .../testing/selftests/bpf/test_sockmap_kern.h | 22 +++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 3845144e2c91..5a1b9c96fca1 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017-2018 Covalent IO, Inc. http://covalent.io
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/select.h>
@@ -21,6 +22,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/sendfile.h>
+#include <sys/stat.h>
 
 #include <linux/netlink.h>
 #include <linux/socket.h>
@@ -63,8 +65,8 @@ int s1, s2, c1, c2, p1, p2;
 int test_cnt;
 int passed;
 int failed;
-int map_fd[8];
-struct bpf_map *maps[8];
+int map_fd[9];
+struct bpf_map *maps[9];
 int prog_fd[11];
 
 int txmsg_pass;
@@ -84,6 +86,7 @@ int txmsg_ingress;
 int txmsg_skb;
 int ktls;
 int peek_flag;
+uint64_t netns_opt;
 
 static const struct option long_options[] = {
 	{"help",	no_argument,		NULL, 'h' },
@@ -111,6 +114,7 @@ static const struct option long_options[] = {
 	{"txmsg_skb", no_argument,		&txmsg_skb, 1 },
 	{"ktls", no_argument,			&ktls, 1 },
 	{"peek", no_argument,			&peek_flag, 1 },
+	{"netns",	required_argument,	NULL, 'n'},
 	{0, 0, NULL, 0 }
 };
 
@@ -1585,6 +1589,7 @@ char *map_names[] = {
 	"sock_bytes",
 	"sock_redir_flags",
 	"sock_skb_opts",
+	"sock_netns",
 };
 
 int prog_attach_type[] = {
@@ -1619,6 +1624,8 @@ static int populate_progs(char *bpf_file)
 	struct bpf_object *obj;
 	int i = 0;
 	long err;
+	struct stat netns_sb;
+	uint64_t netns_ino;
 
 	obj = bpf_object__open(bpf_file);
 	err = libbpf_get_error(obj);
@@ -1655,6 +1662,28 @@ static int populate_progs(char *bpf_file)
 		}
 	}
 
+	if (netns_opt == 0) {
+		err = stat("/proc/self/ns/net", &netns_sb);
+		if (err) {
+			fprintf(stderr,
+				"ERROR: cannot stat network namespace: %ld (%s)\n",
+				err, strerror(errno));
+			return -1;
+		}
+		netns_ino = netns_sb.st_ino;
+	} else {
+		netns_ino = netns_opt;
+	}
+	i = 1;
+	err = bpf_map_update_elem(map_fd[8], &netns_ino, &i, BPF_ANY);
+	if (err) {
+		fprintf(stderr,
+			"ERROR: bpf_map_update_elem (netns):  %ld (%s)\n",
+			err, strerror(errno));
+		return -1;
+	}
+
+
 	return 0;
 }
 
@@ -1738,7 +1767,7 @@ int main(int argc, char **argv)
 	if (argc < 2)
 		return test_suite(-1);
 
-	while ((opt = getopt_long(argc, argv, ":dhvc:r:i:l:t:p:q:",
+	while ((opt = getopt_long(argc, argv, ":dhvc:r:i:l:t:p:q:n:",
 				  long_options, &longindex)) != -1) {
 		switch (opt) {
 		case 's':
@@ -1805,6 +1834,9 @@ int main(int argc, char **argv)
 				return -1;
 			}
 			break;
+		case 'n':
+			netns_opt = strtoull(optarg, NULL, 10);
+			break;
 		case 0:
 			break;
 		case 'h':
diff --git a/tools/testing/selftests/bpf/test_sockmap_kern.h b/tools/testing/selftests/bpf/test_sockmap_kern.h
index e7639f66a941..317406dad6cf 100644
--- a/tools/testing/selftests/bpf/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/test_sockmap_kern.h
@@ -91,6 +91,13 @@ struct bpf_map_def SEC("maps") sock_skb_opts = {
 	.max_entries = 1
 };
 
+struct bpf_map_def SEC("maps") sock_netns = {
+	.type = BPF_MAP_TYPE_HASH,
+	.key_size = sizeof(__u64),
+	.value_size = sizeof(int),
+	.max_entries = 16
+};
+
 SEC("sk_skb1")
 int bpf_prog1(struct __sk_buff *skb)
 {
@@ -132,9 +139,24 @@ int bpf_sockmap(struct bpf_sock_ops *skops)
 {
 	__u32 lport, rport;
 	int op, err = 0, index, key, ret;
+	int i = 0;
+	__u64 netns_dev, netns_ino;
+	int *allowed;
 
 
 	op = (int) skops->op;
+	netns_dev = skops->netns_dev;
+	netns_ino = skops->netns_ino;
+	bpf_printk("bpf_sockmap: netns_dev = %lu netns_ino = %lu\n",
+		   netns_dev, netns_ino);
+
+	// Only allow sockmap connection on the configured network namespace
+	allowed = bpf_map_lookup_elem(&sock_netns, &netns_ino);
+	if (allowed == NULL || *allowed == 0) {
+		bpf_printk("not binding connection on netns_ino %lu\n",
+			   netns_ino);
+		return 0;
+	}
 
 	switch (op) {
 	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
-- 
2.20.1

