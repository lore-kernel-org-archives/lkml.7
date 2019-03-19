Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C720835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6IpBPpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCSQzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:55:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44577 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:55:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id m65so4681002qkl.11;
        Tue, 19 Mar 2019 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cA1+mvWB52bl96k4YlbvPjUbMNYXk69riQWqrx4dZnU=;
        b=C6IpBPpngpJYJzTHT//SS9iuyJXUbP62PG3xh22kXoxprtry/2etiLncByTR689Ho7
         aW+7IJSy35P3O6dSuPOPV+R439jin5gG2lbmoPtQZqelbgHvHm99TdHnpblxZDn5GaD/
         uNx3YB7W9pfUB9dp9oc3MKVOERZezYCqWwz4PmVSoB4RRl+QL6uLzG4qOdeTqHWo7u+2
         tKKY0LEqUWZfTxjehIQRwTTmeItmfJDgp1xdEp7xajFy9dvcdFaxfYTrah2hNXZgYUpY
         lYaF/ux5TPEE4V5QEYgOirSozhZ0/9R6yO92bsZYN1BEhLQF8B+9EzDAp1tU4ItN0R/E
         3fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cA1+mvWB52bl96k4YlbvPjUbMNYXk69riQWqrx4dZnU=;
        b=mrZvE8tTfHTQgHf1PvBDZ2UItlJQ+Jwc9dp4gCIJQXeohu46Eu88cXu3LT5KABeU0l
         qvpdrUZZ0gA2YLEsKGkoYcC9XXkUBxtv8iAoCOYLkj0j87Fp/NlBxSajQ1FdGJ4GB2yg
         LDrywHe1cjR7RZzhPjfkxtDJhEYT1D32GCUH+SRws7CaK0rN1feSZ7l9ar4K/Uicebhx
         atH22yDHKxIGy3uEJExfelLVo8ieKW9fo+URDtEA20rAND5/H201L3+2d/5jUgoWc2Z/
         6mcdl67Bj5aHna8wg8AOP0SlUpyWFPxu0v/Bu1cGHXzq/KxrjllAEg7je/c0CxQbBrN5
         aDdg==
X-Gm-Message-State: APjAAAW7wmYeDkQNQAfB2Bht0jZssqOELqtwXaQJMcbaKlhjnSo2euJ0
        +AQePUbnp31ni20dMv4nZ0I=
X-Google-Smtp-Source: APXvYqw3zZI59B3rR4QRm6D/56FWO2Anywk2H1s4vneYk4eAJQLr6ELNfAHV2GcBbojeQ/pXUO0kTw==
X-Received: by 2002:a37:8505:: with SMTP id h5mr2753676qkd.66.1553014534442;
        Tue, 19 Mar 2019 09:55:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id z5sm4880213qke.51.2019.03.19.09.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:55:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95CEC4039C; Tue, 19 Mar 2019 13:55:31 -0300 (-03)
Date:   Tue, 19 Mar 2019 13:55:31 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [WORKS!] Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable
 annotation of bpf program
Message-ID: <20190319165531.GI3029@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org>
 <9BC22A6D-B0A7-47B6-9526-E32924EF409D@fb.com>
 <20190319135813.GC3029@kernel.org>
 <20190319141435.GD3029@kernel.org>
 <20190319145228.GF3029@kernel.org>
 <E51C470D-3737-4221-88F9-22C942A51952@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E51C470D-3737-4221-88F9-22C942A51952@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 04:51:44PM +0000, Song Liu escreveu:
> 
> 
> > On Mar 19, 2019, at 7:52 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Tue, Mar 19, 2019 at 11:14:35AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> 
> >> Now the test is really being performed, the test-all.bin feature
> >> detection fast path is working, proceeding.
> > 
> > Now it all works, really nice!
> > 
> > I added a 'Committer testing' section with all the steps to test this
> > and pushed to:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=6530d44e7dc1d41c73fe70b9e6ea1b9cabebb57f
> 
> Thanks Arnaldo! This looks great!
> 
> I will rebase https://lkml.org/lkml/2019/3/14/681 on top of this branch
> and resend. 

I just found one new bug, that may appear now since I took a series of
fixes found by gcc's ASan feature, i.e. on the exit path we're crashing
on:

[root@quaco ~]# perf top
perf: Segmentation fault
-------- backtrace --------
perf[0x5a785a]
/lib64/libc.so.6(+0x385bf)[0x7fd68443c5bf]
perf(rb_first+0x2b)[0x4d6eeb]
perf(dso__delete+0xb7)[0x4dffb7]
perf[0x4f9e37]
perf(perf_session__delete+0x64)[0x504df4]
perf(cmd_top+0x1957)[0x454467]
perf[0x4aad18]
perf(main+0x61c)[0x42ec7c]
/lib64/libc.so.6(__libc_start_main+0xf2)[0x7fd684428412]
perf(_start+0x2d)[0x42eead]
[root@quaco ~]#
[root@quaco ~]# addr2line -fe ~/bin/perf 0x4dffb7
dso_cache__free
/home/acme/git/perf/tools/perf/util/dso.c:713


And that is because of that union:

+       union {
+               /* dso data file */
+               struct {
+                       struct rb_root   cache;
+                       int              fd;
+                       int              status;
+                       u32              status_seen;
+                       size_t           file_size;
+                       struct list_head open_entry;
+                       u64              debug_frame_offset;
+                       u64              eh_frame_hdr_offset;
+               } data;
+               /* bpf prog information */
+               struct {
+                       u32             id;
+                       u32             sub_id;
+                       struct perf_env *env;
+               } bpf_prog;
+       };


On the dso exit path, it is trying to traverse the data.cache rbtree,
when what is that is that bpf_prog.id, etc, I'll just remove the union
for now, later we can do the data.cache access or bpf_prog based on some
other test.
