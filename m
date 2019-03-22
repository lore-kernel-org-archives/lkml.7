Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48863C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDA42070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258274;
	bh=0btQbIa7gQdGzsUcd/G+4NYqkbKZR+zbupxBSDl73PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HrD5Y/YRmLF+L6lJMklCr1n5Hyl5TiQxWgazjkbQnOPKQee8hciBsSKJCqqgCbKSp
	 hrMUk6hmGoCdbMjccc5JQbN0VF25Kv8YUwZxoP4ct7oiKu9N+lujOV3wwBXo/eE4Ns
	 +pHoWOzeh5l/hcjhFu+R/r7s2qKy44ccUpfYxMro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbfCVMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388867AbfCVMJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95BC2083D;
        Fri, 22 Mar 2019 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256576;
        bh=0btQbIa7gQdGzsUcd/G+4NYqkbKZR+zbupxBSDl73PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HH/0iX2KOQmQu0RFDtGIfR/RGsIJ7a5BcP9llgYbq6hgz5jvLaUifYlz7m75jxnAC
         mQsGqC+fFuoYrKI2sdho3hID5W40rUWAt2fRUuSYIXJM7wfRZqDMx22kb+E+QDtYGk
         Wef74c3z7eTIfCWG2WsSpff7uNkOpQxgVDELwokg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 254/280] perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
Date:   Fri, 22 Mar 2019 12:16:47 +0100
Message-Id: <20190322111342.642775743@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -709,6 +709,8 @@ static int map_groups__split_kallsyms_fo
 		}
 
 		pos->start -= curr_map->start - curr_map->pgoff;
+		if (pos->end > curr_map->end)
+			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
 		symbols__insert(&curr_map->dso->symbols, pos);


