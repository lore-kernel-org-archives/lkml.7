Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FADFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE8320869
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="EvR+n8YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfKJKLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:11:05 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:46512 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbfKJKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:11:05 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 0A5F72E0AFB;
        Sun, 10 Nov 2019 13:11:02 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ufELG9Uhqi-B1A4JkDe;
        Sun, 10 Nov 2019 13:11:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573380661; bh=118Ya5YU895aT4nYO/kh6q7oC2jIJWTHCPfcXWmapWc=;
        h=Message-ID:Date:To:From:Subject;
        b=EvR+n8YQfb/QNUBIB4cGNDXvO6K6TPsKflXlhpOlksH8skTMFkR1YR2d+LoNw4kpA
         1P8t7pyAmmeWWwdmvMYtKA1SdSkkaKHBFup7AhR1sPDo0pYRCzJjtwz2vP4VwSL3Nv
         6fnJqXsZal5jATd0PfbyxH78MvF/EKRZn4Dt8PUQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id B6bc5NkSSF-B1WSjArq;
        Sun, 10 Nov 2019 13:11:01 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH resend] libtraceevent: fix parsing event argument types
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Sun, 10 Nov 2019 13:11:01 +0300
Message-ID: <157338066113.6548.11461421296091086041.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing "%o" and "%X". Ext4 events use "%o" for printing i_mode.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/lib/traceevent/event-parse.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475585ce..beaa8b8c08ff 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4395,8 +4395,10 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 				/* fall through */
 			case 'd':
 			case 'u':
-			case 'x':
 			case 'i':
+			case 'x':
+			case 'X':
+			case 'o':
 				switch (ls) {
 				case 0:
 					vsize = 4;
@@ -5078,10 +5080,11 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 
 				/* fall through */
 			case 'd':
+			case 'u':
 			case 'i':
 			case 'x':
 			case 'X':
-			case 'u':
+			case 'o':
 				if (!arg) {
 					do_warning_event(event, "no argument match");
 					event->flags |= TEP_EVENT_FL_FAILED;

