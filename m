Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FFDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FFF20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369239;
	bh=Qm/CwupD/ZA9t7BeblLHA0euXYkV/9WjpdGnRkuN/Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6mPlCUkWQVbBciIYOcICrUvW821LKFnSGzeJYyFLVp9lrBVF4mXQdAKTFKK7c5vE
	 KJxbn4hG4+Wa0Y82ElWRSvkdN75QVfwPfNTEThfaiujFWEb5v0ZM2vq4HIABn2cZN8
	 Xn7JctLwgUvT/A7r/9YDuAtngMipXLaAddkCQKzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfDDJN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbfDDJNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1182054F;
        Thu,  4 Apr 2019 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369232;
        bh=Qm/CwupD/ZA9t7BeblLHA0euXYkV/9WjpdGnRkuN/Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyhB+GlyVddTi+lB9aKFtDIHUnG/LXIq3NfslW15d9AeHPaXi2HXHp22WyeoMTadU
         7L9TAq3FDhsxqqsNxb+hhk+G5jymQ1T/hQoloFlXfBv0jlZ9aBjLD2DrclRF/nN9zB
         tG0ROzsq6XTZYObnImuoAoacOl6H/XlVAJgkiedE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 133/246] perf beauty waitid options: Fix up prefix showing logic
Date:   Thu,  4 Apr 2019 10:47:13 +0200
Message-Id: <20190404084623.822148329@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1da7e0022784b0e05b49bf73521fa2cc4633af85 ]

When introducing the possibility for selecting if the common prefix to
options such as the waitid ones, i.e. all 'waitid' options start with
'W', so, to make it make it more compact if configured to suppress it,
'perf trace' will do so, other examples include mmap's PROT_ prefix for
its 'prot' argument, etc, which, when showing the syscall argument name
ends up producing duplicated info that clutters the screen, i.e.:

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/20886 mmap(len: 112595, prot: PROT_READ, flags: MAP_PRIVATE, fd: 3) = 0x7f3e986d2000
     0.041 ( 0.005 ms): sleep/20886 mmap(len: 8192, prot: PROT_READ|PROT_WRITE, flags: MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f3e986d0000
  #

So it is possible to suppress that and make it more compact by having
this in your ~/.perfconfig:

  # cat ~/.perfconfig
  [trace]
	show_prefix = no
  #

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/8009 mmap(len: 112595, prot: READ, flags: PRIVATE, fd: 3) = 0x7ff2373de000
     0.040 ( 0.005 ms): sleep/8009 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7ff2373dc000
  #

To have it look more like strace's output, we instead want to suppress
the arg name and show the prefix, so use:

  # cat ~/.perfconfig
  [trace]
	show_prefix = yes
	show_arg_names = no
  #
  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.006 ms): sleep/15513 mmap(NULL, 112595, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f7a9b6d3000
     0.020 ( 0.002 ms): sleep/15513 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f7a9b6d1000
  #

When this logic was introduced a bug came with it when processing the
waitid 'option' arg that ended up expecting 3 strings when just two were
being provided, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/trace/beauty/waitid_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index 6897fab40dcc..d4d10b33ba0e 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -11,7 +11,7 @@ static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
 
 #define	P_OPTION(n) \
 	if (options & W##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "",  #n); \
 		options &= ~W##n; \
 	}
 
-- 
2.19.1



