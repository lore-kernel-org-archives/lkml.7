Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB60FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C4321925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263133;
	bh=Ck7Qxf1I86oSI9qJ6PU0dWKBQw+DaL5W0bIa78RXrRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vGng3oiR1yjT8dnar4YppO6HzdFNq2d76nGbd0moJ/4oi8VghJBlealH6Lonxf9ba
	 5A3gqLWC4M+CfeEKFkO6i1GuokEviwhy2hEy93SQJ3cY7NiK8Fb/HW65cqA3Q5oYQX
	 OThrGpXASXctxjFqqFZXYpzNbFKaUyiCBi6W198c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438300AbfJPV6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438109AbfJPV6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:02 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00620222C1;
        Wed, 16 Oct 2019 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263082;
        bh=Ck7Qxf1I86oSI9qJ6PU0dWKBQw+DaL5W0bIa78RXrRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIwnO5hgvG5nwx6A9xOG5SzVh/mGG6lc75rSZNuQx/K0URSYTHh1jWcsB9GFwsADt
         NZR/aX1jpRb7eZ8O9pPzugbdfTbWynM/Vb3bY5x6Pi81JXyps2jLgjCDsqpe16iGAR
         6kDNvVTX4g2DNokN7mRYEAADeuA1RhkBcVeZW9hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alix Wu <alix.wu@mediatek.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 4.19 81/81] perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization
Date:   Wed, 16 Oct 2019 14:51:32 -0700
Message-Id: <20191016214848.807683440@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

commit 310aa0a25b338b3100c94880c9a69bec8ce8c3ae upstream.

If we disable the compiler's auto-initialization feature, if
-fplugin-arg-structleak_plugin-byref or -ftrivial-auto-var-init=pattern
are disabled, arch_hw_breakpoint may be used before initialization after:

  9a4903dde2c86 ("perf/hw_breakpoint: Split attribute parse and commit")

On our ARM platform, the struct step_ctrl in arch_hw_breakpoint, which
used to be zero-initialized by kzalloc(), may be used in
arch_install_hw_breakpoint() without initialization.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alix Wu <alix.wu@mediatek.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Link: https://lkml.kernel.org/r/20190906060115.9460-1-mark-pk.tsai@mediatek.com
[ Minor edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/hw_breakpoint.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -426,7 +426,7 @@ static int hw_breakpoint_parse(struct pe
 
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = { };
 	int err;
 
 	err = reserve_bp_slot(bp);
@@ -474,7 +474,7 @@ int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = { };
 	int err;
 
 	err = hw_breakpoint_parse(bp, attr, &hw);


