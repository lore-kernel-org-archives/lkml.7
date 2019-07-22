Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31502C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA521955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817292;
	bh=Gg4yc9y6IvlwvNfMui1tPLSs/ukvOGgDdlqGjKALhSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvaKFacKgitsBQhHcdWn2PrNyaLUzk8c0/8DOlJ4CavT2S8CDO4SiU/bwqD1oARqL
	 oyuAgJC6TQnEUVbQrlfKR50aY8ZKT1zo7M81eyNQaqy8og9A88XU9/bQEfZExTR6k5
	 Ew7rzmX30AehYcPXeGl1k1q9XAD5mfU+BJYoqGiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfGVRlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfGVRla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:41:30 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B0121903;
        Mon, 22 Jul 2019 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817289;
        bh=Gg4yc9y6IvlwvNfMui1tPLSs/ukvOGgDdlqGjKALhSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3yJLvfMUU+HheP/3l+xy7NJo1NcMCRTmT3jA99jHe3/X3o5b94/Sipo3lgeaIMPn
         24WGbxvAp+UNQTmXC8VGDNIqysHMjCdultq88jq5pGHIkaj7i2kVLZYMahnu5m5G31
         fUjgxEVOniydlD1hJyfB+Bw/5ASrqcS3KijDeLbE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 22/37] perf trace beauty: Make connect's addrlen be printed as an int, not hex
Date:   Mon, 22 Jul 2019 14:38:24 -0300
Message-Id: <20190722173839.22898-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

