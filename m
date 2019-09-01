Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754DEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A4522CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567342113;
	bh=Tt6DcirK0dwhOR4FZYS73K93eqtpSi720DLV4xx2Rss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nL5xuRZodhZuYBTOv3c3QxktVwhQ9OW/PxvA3GUdGOdvG+ufpSEgFeeVcpHuN7Bvo
	 lf3KiZtJJNNzerB2Oikz8hsCdNZGIkviGIm/vAHbeMy7rWAavKx8P3Pi1eHDonKJE7
	 ogMfh3q3qkfVfcsCitar/XgURsRJdkCbGoxM6CJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfIAMsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfIAMsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:48:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 380991108;
        Sun,  1 Sep 2019 12:48:30 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FE5C600CE;
        Sun,  1 Sep 2019 12:48:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 2/4] perf tests: Fix static build test
Date:   Sun,  1 Sep 2019 14:48:20 +0200
Message-Id: <20190901124822.10132-3-jolsa@kernel.org>
In-Reply-To: <20190901124822.10132-1-jolsa@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 01 Sep 2019 12:48:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link: http://lkml.kernel.org/n/tip-ibdgg163291sx5m5xkojx5sq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 70c48475896d..17ee3facfd4d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -100,7 +100,7 @@ make_install_info   := install-info
 make_install_pdf    := install-pdf
 make_install_prefix       := install prefix=/tmp/krava
 make_install_prefix_slash := install prefix=/tmp/krava/
-make_static         := LDFLAGS=-static
+make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_JVMTI=1
 
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
-- 
2.21.0

