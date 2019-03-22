Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC97C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313A8218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257336;
	bh=6cYwg8mR2fztbGTMoM69A8M8l+sHwNYiE+EhfntxaDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w1Bvgjg/Gwk8bRUDom/PnlVMvrz1roy3K3klG2520yxFzpgkY3vOzsOFLU5WQsth7
	 pwLZg81LH16nXqdVxOUL5Vhecg0eg3UN4lZAHbzPGPXICLH6dBnFmWdGLNxrDFK0YD
	 ZdYIXYoP0FrpaQVMMcrY1itUrX40g8a029EiUBXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbfCVMWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390975AbfCVMWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3AD321917;
        Fri, 22 Mar 2019 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257332;
        bh=6cYwg8mR2fztbGTMoM69A8M8l+sHwNYiE+EhfntxaDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jREPnZrhddTSr8KeDVVA2csBzrSgk3xh/5QueH1EDC53TeP3QhXI2jkFFxGxwkqSb
         so7+lwXK3LSXcMah4cQpKaXQ11UFrBy204iA8obyJoonBcBnpuI+kGI5Pme91lUSvC
         7PMBRo9pnrHVr5KfriMSth/3fxXs26Q2QINBhw8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.0 201/238] perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
Date:   Fri, 22 Mar 2019 12:17:00 +0100
Message-Id: <20190322111310.060917161@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit d6d457451eb94fa747dc202765592eb8885a7352 upstream.

Kallsyms symbols do not have a size, so the size becomes the distance to
the next symbol.

Consequently the recently added trampoline symbols end up with large
sizes because the trampolines are some distance from one another and the
main kernel map.

However, symbols that end outside their map can disrupt the symbol tree
because, after mapping, it can appear incorrectly that they overlap
other symbols.

Add logic to truncate symbol size to the end of the corresponding map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Link: http://lkml.kernel.org/r/20190109091835.5570-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/symbol.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -710,6 +710,8 @@ static int map_groups__split_kallsyms_fo
 		}
 
 		pos->start -= curr_map->start - curr_map->pgoff;
+		if (pos->end > curr_map->end)
+			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
 		symbols__insert(&curr_map->dso->symbols, pos);


