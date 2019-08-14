Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC8C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404CB216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808141;
	bh=nxX09MFhvxIFUzNLS2FI2TFjVrNmWlZEZblmNDEEri8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmEik3ZRqM9yMftylZKFU8WZC8ZHWwflBU/kkL4JuQl5RYeF1RmaC9Hv+P3C2PEHS
	 NITmI15DdxcmIidiZpyJ6XFmbiXRhrIMZxCnyoFE7TrUY7oVV89vgdT6fxkM6H6zVy
	 CK33muP1fh/TtM4vy3PCGBQ7erAj1ClNfqz/mUlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfHNSmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:42:19 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A584A2064A;
        Wed, 14 Aug 2019 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808138;
        bh=nxX09MFhvxIFUzNLS2FI2TFjVrNmWlZEZblmNDEEri8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQQQ+UCQl81N9OMFnOKVBBHwWynpTnphEymImxJ1NtBxSb/MuuwYRYHgw/iKWf4QF
         NTPX9jqkIQfiMS+NsnjO+zAmFyd/kwIGPmdg6I3OHP3TEtZTiO9JtiXWaOWLepkkA4
         Ju3PauxWDbykM6gW5Z9CvIOyJYdFJ6v9ErnsPhWs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 03/28] perf config: Document the PERF_CONFIG environment variable
Date:   Wed, 14 Aug 2019 15:40:26 -0300
Message-Id: <20190814184051.3125-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There was a provision for setting this variable, but not the
getenv("PERF_CONFIG") call to set it, as this was fixed in the previous
cset, document that it can be used to ask for using an alternative
.perfconfig file or to disable reading whatever file exists in the
system or home directory, i.e. using:

  export PERF_CONFIG=/dev/null

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: https://lkml.kernel.org/n/tip-0u4o967hsk7j0o50zp9ctn89@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index e4aa268d2e38..c599623a1f3d 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -40,6 +40,10 @@ The '$HOME/.perfconfig' file is used to store a per-user configuration.
 The file '$(sysconfdir)/perfconfig' can be used to
 store a system-wide default configuration.
 
+One an disable reading config files by setting the PERF_CONFIG environment
+variable to /dev/null, or provide an alternate config file by setting that
+variable.
+
 When reading or writing, the values are read from the system and user
 configuration files by default, and options '--system' and '--user'
 can be used to tell the command to read from or write to only that location.
-- 
2.21.0

