Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC36C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA0D2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119096;
	bh=YguYYRHa7pxbgWOAPbbpBNA7eGUgBYUkdSRQ4YqKIUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VD/7q/Lx8OVHAuOcCCblxdCPjcqH3HjSnsz1JkoUnEVzSbvNONw8+7eh2wUEG8zby
	 /sC2xZkU6nkpVdo1ln7rqBBj32aLEXyvb23H9HZtAAoP75n+2stLCU8TMnUs9BJPKK
	 pEo7TD+OdC66XqcMq3Vy/mrjk6Yt+o8TexSXRtc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbfJCQLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbfJCQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:11:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416FB2054F;
        Thu,  3 Oct 2019 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119090;
        bh=YguYYRHa7pxbgWOAPbbpBNA7eGUgBYUkdSRQ4YqKIUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPaz00VoHnLR1nEPQB+cSmnUpKEkHRSgUKFRSj9H+4E7SSvmv+aOwvTBjsP+RwAJD
         2WPr5ra145ajLU0vSu8NhIp6cKFLiCSYzFKQdz4bm+ZrRtzoMf/yF6tbuibFhvqJuU
         9bWZPHNw5dRjVRhkR78YWQ5FAppwD0BSO6n06gM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 085/185] perf test vfs_getname: Disable ~/.perfconfig to get default output
Date:   Thu,  3 Oct 2019 17:52:43 +0200
Message-Id: <20191003154457.247847023@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 4fe94ce1c6ba678b5f12b94bb9996eea4fc99e85 ]

To get the expected output we have to ignore whatever changes the user
has in its ~/.perfconfig file, so set PERF_CONFIG to /dev/null to
achieve that.

Before:

  # egrep 'trace|show_' ~/.perfconfig
  [trace]
  	show_zeros = yes
  	show_duration = no
  	show_timestamp = no
  	show_arg_names = no
  	show_prefix = yes
  # echo $PERF_CONFIG

  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: FAILED!
  # export PERF_CONFIG=/dev/null
  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: Ok
  #

After:

  # egrep 'trace|show_' ~/.perfconfig
  [trace]
  	show_zeros = yes
  	show_duration = no
  	show_timestamp = no
  	show_arg_names = no
  	show_prefix = yes
  # echo $PERF_CONFIG

  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: https://lkml.kernel.org/n/tip-3up27pexg5i3exuzqrvt4m8u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 2a9ef080efd02..a8a516dec4ed2 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -30,6 +30,10 @@ if [ $err -ne 0 ] ; then
 	exit $err
 fi
 
+# Do not use whatever ~/.perfconfig file, it may change the output
+# via trace.{show_timestamp,show_prefix,etc}
+export PERF_CONFIG=/dev/null
+
 trace_open_vfs_getname
 err=$?
 rm -f ${file}
-- 
2.20.1



