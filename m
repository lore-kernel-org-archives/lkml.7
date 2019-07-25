Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F7C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA1520856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="e6TYk6nU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGYTEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:04:37 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41269 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:04:36 -0400
Received: by mail-qt1-f177.google.com with SMTP id d17so50076259qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LKu/Qknu3DhcpvZAjH/Cg2C3TRqk9B3bltB+fAqL9wk=;
        b=e6TYk6nUklMcBLDNOXeCNg7kg6Zy+WiNNfq1X+GbMgJgt9ZpbkE0mLxrahOgvG9ikR
         Roar7pYOfSEJlGeu5C1RbUvc4byj6OfsdmaHAnOYqCfRplqNSXECeo/sbd+kJtIosD7y
         ZWZGm+7U1oOHN6ijjTX+z31n97JPV1uzg2KGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LKu/Qknu3DhcpvZAjH/Cg2C3TRqk9B3bltB+fAqL9wk=;
        b=cYM1reeFY71qcxhOd+rqkQ6SqMGQiS6g7Z99bkAASH2y3RMaxFTTyG9nQZsS14/UHV
         35miyUskkVolCyxDeH4HZ+zu6dG9JFU4vg3BPXFQ6pLBmcp0gCPYDckxYzSbGNQj5ma3
         KYo3ixSVDc8yB/flej+mP6FJtGYyxmwpjgFWna9r392jqk2V0CYHvSf9PyURuIp44RNT
         EltTSKnPXqXeKIR2rbUghraOcNeAIUnDDwAe5BpcRhFa6eX7v5PBwHMkeD7BU216cera
         76ikd3sppD79Yrqsu+M31MpqLrzhb1sl35ENH3u1tFzvIdf4XEjrlYJhbU/0D3NTVaAn
         ZTEQ==
X-Gm-Message-State: APjAAAUXZ0bk+IGBCKd6+eI4xyKEe4cOubY9JcyHun+hz/UY8UvJ841W
        M/cvDc3DWbbpS7WqfRweb+CbhT2xAyU=
X-Google-Smtp-Source: APXvYqwsOsw6JjT7srltx0Ylo5GNatkMNTx2CBFErbN69fvUDtoL+U5aRkJ9Gi6+P8FGydZ/C6FAJw==
X-Received: by 2002:ac8:1106:: with SMTP id c6mr10335368qtj.332.1564081475362;
        Thu, 25 Jul 2019 12:04:35 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id a6sm22909833qth.76.2019.07.25.12.04.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 12:04:34 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 25 Jul 2019 15:04:32 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf report segfault with 0-sized strings
In-Reply-To: <alpine.DEB.2.21.1907251423410.22624@macbook-air>
Message-ID: <alpine.DEB.2.21.1907251501290.22624@macbook-air>
References: <alpine.DEB.2.21.1907251423410.22624@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


probably all perf_header_strings are affected by this.  The fuzzer just 
tripped up cmdline now, which needs this fix.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..631aa1911f3a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1427,6 +1430,8 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
 
 	fprintf(fp, "# cmdline : ");
 
+	if (ff->ph->env.cmdline_argv==NULL) return;
+
 	for (i = 0; i < nr; i++) {
 		char *argv_i = strdup(ff->ph->env.cmdline_argv[i]);
 		if (!argv_i) {
