Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231FE2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889692;
	bh=kpwFn9Sc0MqKe83RqXYHAMb6fci+1VqMYohUynAsflo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvJMI+UGCih2qrP5oB3dmUJ+xxAfCRT5JwaEuwNaDACrc1ydjXWGyqxTRBAQZ7NGb
	 6zN/MVqBwylbsNrqVYcQv0DJddR6dA8+pq5bT6ENuvfkPpDPSAhaU5s7YKF63fQahC
	 TIrT6hIb4WrI99HYelxnoDybmFjDuG8L2w0Uhow4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfK0VHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732190AbfK0VHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:07:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9D82080F;
        Wed, 27 Nov 2019 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888825;
        bh=kpwFn9Sc0MqKe83RqXYHAMb6fci+1VqMYohUynAsflo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hd9bQ9QiQR+3/1METwk1ntXNmRx8sOsexP0q++DPSeMD2Md5h684959qS2NxWXoIb
         gWU8krJe+5c77i+mE9vwikjTKr407qMLZVwRiBUD48V9Wv92btFltcLk0CuaDhCnZu
         CDD740pnV+KgoCsY4W/t3gTW+i2UOWCvWbB63lcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 242/306] tools: bpftool: pass an argument to silence open_obj_pinned()
Date:   Wed, 27 Nov 2019 21:31:32 +0100
Message-Id: <20191127203132.641362415@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

[ Upstream commit f120919f9905a2cad9dea792a28a11fb623f72c1 ]

Function open_obj_pinned() prints error messages when it fails to open a
link in the BPF virtual file system. However, in some occasions it is
not desirable to print an error, for example when we parse all links
under the bpffs root, and the error is due to some paths actually being
symbolic links.

Example output:

    # ls -l /sys/fs/bpf/
    lrwxrwxrwx 1 root root 0 Oct 18 19:00 ip -> /sys/fs/bpf/tc/
    drwx------ 3 root root 0 Oct 18 19:00 tc
    lrwxrwxrwx 1 root root 0 Oct 18 19:00 xdp -> /sys/fs/bpf/tc/

    # bpftool --bpffs prog show
    Error: bpf obj get (/sys/fs/bpf): Permission denied
    Error: bpf obj get (/sys/fs/bpf): Permission denied

    # strace -e bpf bpftool --bpffs prog show
    bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/ip", bpf_fd=0}, 72) = -1 EACCES (Permission denied)
    Error: bpf obj get (/sys/fs/bpf): Permission denied
    bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/xdp", bpf_fd=0}, 72) = -1 EACCES (Permission denied)
    Error: bpf obj get (/sys/fs/bpf): Permission denied
    ...

To fix it, pass a bool as a second argument to the function, and prevent
it from printing an error when the argument is set to true.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 15 ++++++++-------
 tools/bpf/bpftool/main.h   |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index be7aebff0c1e5..158469f57461d 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -130,16 +130,17 @@ static int mnt_bpffs(const char *target, char *buff, size_t bufflen)
 	return 0;
 }
 
-int open_obj_pinned(char *path)
+int open_obj_pinned(char *path, bool quiet)
 {
 	int fd;
 
 	fd = bpf_obj_get(path);
 	if (fd < 0) {
-		p_err("bpf obj get (%s): %s", path,
-		      errno == EACCES && !is_bpffs(dirname(path)) ?
-		    "directory not in bpf file system (bpffs)" :
-		    strerror(errno));
+		if (!quiet)
+			p_err("bpf obj get (%s): %s", path,
+			      errno == EACCES && !is_bpffs(dirname(path)) ?
+			    "directory not in bpf file system (bpffs)" :
+			    strerror(errno));
 		return -1;
 	}
 
@@ -151,7 +152,7 @@ int open_obj_pinned_any(char *path, enum bpf_obj_type exp_type)
 	enum bpf_obj_type type;
 	int fd;
 
-	fd = open_obj_pinned(path);
+	fd = open_obj_pinned(path, false);
 	if (fd < 0)
 		return -1;
 
@@ -384,7 +385,7 @@ int build_pinned_obj_table(struct pinned_obj_table *tab,
 		while ((ftse = fts_read(fts))) {
 			if (!(ftse->fts_info & FTS_F))
 				continue;
-			fd = open_obj_pinned(ftse->fts_path);
+			fd = open_obj_pinned(ftse->fts_path, true);
 			if (fd < 0)
 				continue;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 238e734d75b3e..057a227bdb9f9 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -126,7 +126,7 @@ int cmd_select(const struct cmd *cmds, int argc, char **argv,
 int get_fd_type(int fd);
 const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
-int open_obj_pinned(char *path);
+int open_obj_pinned(char *path, bool quiet);
 int open_obj_pinned_any(char *path, enum bpf_obj_type exp_type);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32));
 int do_pin_fd(int fd, const char *name);
-- 
2.20.1



