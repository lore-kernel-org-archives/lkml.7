Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45873CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5380208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="FuYFnqnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJ1Qu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:50:57 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:60568 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbfJ1Qu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:50:57 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C8F7C2E098C;
        Mon, 28 Oct 2019 19:50:53 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mZxdmCtIYN-orlSdj0x;
        Mon, 28 Oct 2019 19:50:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572281453; bh=118Ya5YU895aT4nYO/kh6q7oC2jIJWTHCPfcXWmapWc=;
        h=Message-ID:Date:To:From:Subject;
        b=FuYFnqnLKpUX2GSOy1BLHIGwxcOPUIuEwmtdZGZ9mlxLsQVIWEEUt1OAWixrhlHRS
         ccXVIAQqcs+RGFTGj7F2+/yvydAZ8ZeNIP4W+VVOW+6op7oAjp/lT3HgsmlT6u9EOD
         1cCQHU2qmuGq4jDumK7r0FDcg/xszRXIMKMk+h4E=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id jPBulGAOyt-orWO4C5u;
        Mon, 28 Oct 2019 19:50:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] libtraceevent: fix parsing event argument types
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Oct 2019 19:50:53 +0300
Message-ID: <157228145325.7530.4974461761228678289.stgit@buzz>
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

