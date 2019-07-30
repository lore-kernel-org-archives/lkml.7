Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B21C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171052089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w286/uqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfG3R7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:59:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfG3R7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:59:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHxNUo3321620
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:59:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHxNUo3321620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509564;
        bh=MVz8TnDc1EfA3tHI5nC91gacqZy/dsHYOJKkNl9r3dU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=w286/uqarsG/GrQpU2Cx2lcylIJe0eULgTKb3kI97lfoeKzm33UJdCEzqdOTgTiMn
         7vN4B9HQNaHbN+0QerfkWbTD5xfe6BySvqOmEkQAPj6qwFfE/WGZk5XIWk8YNqZpTa
         4szrmRdwASUTw2gyH/V9VOamLJ7ZdF8nK8pzILdulehsf8sv3kjzlIIYVC/mksodEM
         FOoZ7lqT9cCQqaGmlvPd+CMDIcDrsoW3AGoYujy+zBkDPgQOHDYM3xKIK+7OCS2CFb
         o2KXrrdA4H3eeyQhA3zEiDxItZTlKAS4w5pL72TC4/TnnSirWFsqwTV5kumG4EAj07
         qS/fhcwEzeKrw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHxNU83321617;
        Tue, 30 Jul 2019 10:59:23 -0700
Date:   Tue, 30 Jul 2019 10:59:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ekuiciyx4znchvy95c8p1yyi@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        lclaudio@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
          tglx@linutronix.de, lclaudio@redhat.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Make connect's addrlen be
 printed as an int, not hex
Git-Commit-ID: 1d86275225b4c9db3fb426e992886df5051f0047
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1d86275225b4c9db3fb426e992886df5051f0047
Gitweb:     https://git.kernel.org/tip/1d86275225b4c9db3fb426e992886df5051f0047
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 16:34:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace beauty: Make connect's addrlen be printed as an int, not hex

  # perf trace -e connec* ssh www.bla.com
  connect(3</var/lib/sss/mc/passwd>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  connect(3</var/lib/sss/mc/passwd>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  connect(4<socket:[16610959]>, { .family: PF_LOCAL, path: /var/lib/sss/pipes/nss }, 110) = 0
  connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  connect(5, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  connect(5</usr/lib64/libnss_mdns4_minimal.so.2>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  connect(5</usr/lib64/libnss_mdns4_minimal.so.2>, { .family: PF_INET, port: 53, addr: 192.168.44.1 }, 16) = 0
  connect(5</usr/lib64/libnss_mdns4_minimal.so.2>, { .family: PF_INET, port: 22, addr: 146.112.61.108 }, 16) = 0
  connect(5</usr/lib64/libnss_mdns4_minimal.so.2>, { .family: PF_INET6, port: 22, addr: ::ffff:146.112.61.108 }, 28) = 0
  ^Cconnect(5</usr/lib64/libnss_mdns4_minimal.so.2>, { .family: PF_INET, port: 22, addr: 146.112.61.108 }, 16) = -1 (unknown) (INTERNAL ERROR: strerror_r(512, [buf], 128)=22)
  #

Argh, the SCA_FD needs to invalidate its cache when close is done...

It works if the 'close' syscall is not filtered out ;-\

  # perf trace -e close,connec* ssh www.bla.com
  close(3)                                = 0
  close(3</usr/lib64/libpcre2-8.so.0.8.0>) = 0
  close(3)                                = 0
  close(3</usr/lib64/libkrb5.so.3.3>)     = 0
  close(3</usr/lib64/libkrb5.so.3.3>)     = 0
  close(3)                                = 0
  close(3</usr/lib64/libk5crypto.so.3.1>) = 0
  close(3</usr/lib64/libk5crypto.so.3.1>) = 0
  close(3</usr/lib64/libcom_err.so.2.1>)  = 0
  close(3</usr/lib64/libcom_err.so.2.1>)  = 0
  close(3)                                = 0
  close(3</usr/lib64/libkrb5support.so.0.1>) = 0
  close(3</usr/lib64/libkrb5support.so.0.1>) = 0
  close(3</usr/lib64/libkeyutils.so.1.8>) = 0
  close(3</usr/lib64/libkeyutils.so.1.8>) = 0
  close(3)                                = 0
  close(3)                                = 0
  close(3)                                = 0
  close(3)                                = 0
  close(4)                                = 0
  close(3)                                = 0
  close(3)                                = 0
  connect(3</etc/nsswitch.conf>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  close(3</etc/nsswitch.conf>)            = 0
  connect(3</usr/lib64/libnss_sss.so.2>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  close(3</usr/lib64/libnss_sss.so.2>)    = 0
  close(3</usr/lib64/libnss_sss.so.2>)    = 0
  close(3)                                = 0
  close(3)                                = 0
  connect(4<socket:[16616519]>, { .family: PF_LOCAL, path: /var/lib/sss/pipes/nss }, 110) = 0
  ^C
  #

Will disable this beautifier when 'close' is filtered out...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ekuiciyx4znchvy95c8p1yyi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5258399a1c94..123d7efc12e8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -725,7 +725,8 @@ static struct syscall_fmt {
 	{ .name	    = "close",
 	  .arg = { [0] = { .scnprintf = SCA_CLOSE_FD, /* fd */ }, }, },
 	{ .name	    = "connect",
-	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* servaddr */ }, }, },
+	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* servaddr */ },
+		   [2] = { .scnprintf = SCA_INT, /* addrlen */ }, }, },
 	{ .name	    = "epoll_ctl",
 	  .arg = { [1] = STRARRAY(op, epoll_ctl_ops), }, },
 	{ .name	    = "eventfd2",
