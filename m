Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A080C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099752085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049540;
	bh=rc10ssGyNqn3eBycMw4Z1WjUheVx6y77q+CGXIqx3ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nhDjbCgVSHSAMKxjjIPUZeJXL9J5tRNzcyb7ykE8OIZMfsEzBmJV4bqNh+457gns6
	 1tJgNWdGQGgD1oTFojgjNdS7AIQFikkxAoZJJXDwRWnvPbpauqy1HDH3A2nLPtWeqz
	 VOiZQD6WlZaxIExvZGRj9j/iKQrlzf6kdHlg3B8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCHMwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfCHMwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9026D2133F;
        Fri,  8 Mar 2019 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049535;
        bh=rc10ssGyNqn3eBycMw4Z1WjUheVx6y77q+CGXIqx3ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i97yD/pcXqsV2IiB9G5LtWfOH61+Kk/9t+G7q+N7h1VEvIqf3GYIufqb08yFJ8Buv
         pvPKglGjAqaj6mYiJH6J3r4we9URauJLbPwdsFh8CdI8+mMNRbfx0i3EHCj+7C+4pS
         piPHvy6ur7UB2W6GuOEwpVoaAr8/YXy5qrKli0fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 31/46] tracing: Fix event filters and triggers to handle negative numbers
Date:   Fri,  8 Mar 2019 13:50:04 +0100
Message-Id: <20190308124904.282819500@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

commit 6a072128d262d2b98d31626906a96700d1fc11eb upstream.

Then tracing syscall exit event it is extremely useful to filter exit
codes equal to some negative value, to react only to required errors.
But negative numbers does not work:

[root@snorch sys_exit_read]# echo "ret == -1" > filter
bash: echo: write error: Invalid argument
[root@snorch sys_exit_read]# cat filter
ret == -1
        ^
parse_error: Invalid value (did you forget quotes)?

Similar thing happens when setting triggers.

These is a regression in v4.17 introduced by the commit mentioned below,
testing without these commit shows no problem with negative numbers.

Link: http://lkml.kernel.org/r/20180823102534.7642-1-ptikhomirov@virtuozzo.com

Cc: stable@vger.kernel.org
Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1301,7 +1301,7 @@ static int parse_pred(const char *str, v
 		/* go past the last quote */
 		i++;
 
-	} else if (isdigit(str[i])) {
+	} else if (isdigit(str[i]) || str[i] == '-') {
 
 		/* Make sure the field is not a string */
 		if (is_string_field(field)) {
@@ -1314,6 +1314,9 @@ static int parse_pred(const char *str, v
 			goto err_free;
 		}
 
+		if (str[i] == '-')
+			i++;
+
 		/* We allow 0xDEADBEEF */
 		while (isalnum(str[i]))
 			i++;


