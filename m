Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F2C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552F52464B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004002;
	bh=Yb86dZj1zmqQt6V3G33LYnP/wlfh0kQGGKcZlNl/Qlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BwM6BkXxk/uciJpS+IgJ/Is2lRNKUuACKAz4ctE8KqX15YXHhLXhjkZguOe4Et+Lw
	 ymyoXiQd5LhLQ8I7h72qvP4T9HiT1eowClpewJlp/4pi/j3eeUCx5HQT0Epam2L8Il
	 9NKjbGOItFTzu5ApvF6r/USmd1+2thzJNi+EtpTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgABW0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbgABW0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF75222C3;
        Thu,  2 Jan 2020 22:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003995;
        bh=Yb86dZj1zmqQt6V3G33LYnP/wlfh0kQGGKcZlNl/Qlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KO9qjTJDMMS7tQlXyGE/MUv8lZa1sxDMd+jFt8DDGPCv7wZ+ikf71f+RaBkIs1oct
         K+FNjFNVpORC1tAEgFVw/LPpPx+0y1UDJWXbrYl40ATpdspMdhYr/jz1RQYWhfIdvK
         0/5vc9iG0I0ziGI4CvPpfRhRWwMs2gkTlc/Mil8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sanskriti Sharma <sansharm@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.14 60/91] perf strbuf: Remove redundant va_end() in strbuf_addv()
Date:   Thu,  2 Jan 2020 23:07:42 +0100
Message-Id: <20200102220440.879731229@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattias Jacobsson <2pi@mok.nu>

commit 099be748865eece21362aee416c350c0b1ae34df upstream.

Each call to va_copy() should have one, and only one, corresponding call
to va_end(). In strbuf_addv() some code paths result in va_end() getting
called multiple times. Remove the superfluous va_end().

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sanskriti Sharma <sansharm@redhat.com>
Link: http://lkml.kernel.org/r/20181229141750.16945-1-2pi@mok.nu
Fixes: ce49d8436cff ("perf strbuf: Match va_{add,copy} with va_end")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/strbuf.c |    1 -
 1 file changed, 1 deletion(-)

--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -109,7 +109,6 @@ static int strbuf_addv(struct strbuf *sb
 			return ret;
 		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
-		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
 			va_end(ap_saved);


