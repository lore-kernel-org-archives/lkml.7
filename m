Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4963CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772D52089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571672117;
	bh=pZCpqiyLCDNTvFPbsk004IEMQVDswWtFjZ12R27kDf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EaEo9u4G/Cqyg3SUFbK6YQBF+nTqmNmw7Ifaclf2hYQbpcdvsB9bPQdymsDGmf6VJ
	 ypFmRo0cArGIcZOhMidJib743VzEnn0fo8ljBQQb6S+t6txfrfo1IHh1Mni8YdRAkj
	 /yvBPvOk+8i4tBFdByLUGx0C1huSbbdyyBQTFNJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfJUPfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:35:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:35:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so9290506wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBVfYEnRP6BKVpKba3hVaFAPYINoX02AKPoKcyB89V0=;
        b=S2Bvu+3bQNlYnJlQf+CoM/RynyEM9bDn8sHnbubKeDpvFpnk6HJg2rD0S4CeJwuYYS
         bGxjDFC0X2BJgS3/vnTAbp+NbndMI1YMC7J6Kd8W+4J/Ng7P+G+zgS7udZPt+4C2Bw1J
         M7PZIPs/fAQ2Zg+XEZFZvc/sg2Qh6TJjpOxMmGPxMb99U200+q0NKfJ2vnbgylMr+3Vd
         zQF54nmgYC7uqFB05hKYIJQVlSwGJ6CSaONA8NaKC1HEHix7LKrXgSsM4d6uvu9283Wr
         SFE+mNyTVswmAxvnzMM1SGbYUuUWlEpSoizSh1u1gcZR3um5MSO4LelJ5IeEnBPaPsb+
         osiQ==
X-Gm-Message-State: APjAAAUAxRZNIjgPEhjUb0TW7TPSsR8qIKT/rb7nrZb4gDpfFYnOR0mE
        Zx6aqVEz18BGKtSm48uH2ptWOZs8/AS6v5LT5EEfPA==
X-Google-Smtp-Source: APXvYqxt5ftUU1ga6gGoy5H7Y9TtjRrmDJL3B1JcQGcHVu9Q2i2zJvFdrGPiy+xjjTARuT+5+JO9rGNlo8/cIPJ8Mkc=
X-Received: by 2002:adf:fec3:: with SMTP id q3mr20350598wrs.343.1571672112665;
 Mon, 21 Oct 2019 08:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191018002757.4112-1-changbin.du@gmail.com>
In-Reply-To: <20191018002757.4112-1-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Oct 2019 00:35:01 +0900
Message-ID: <CAM9d7cjzbfmKdRubMHyOGeN91EZGrF5dF7=xxewjftYo8m15fw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] perf: add support for logging debug messages to file
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 18, 2019 at 9:28 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> When in TUI mode, it is impossible to show all the debug messages to
> console. This make it hard to debug perf issues using debug messages.
> This patch adds support for logging debug messages to file to resolve
> this problem.

I thought I implemented a debug message view in TUI mode by saving
all the messages in a linked list.  But it seems not sent to the list and I
cannot find it now. :(

Anyway I understand your concerns and the changes look ok to me, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


>
> v5:
>   o doc default log path.
> v4:
>   o fix another segfault.
> v3:
>   o fix a segfault issue.
> v2:
>   o specific all debug options one time.
>
> Changbin Du (2):
>   perf: support multiple debug options separated by ','
>   perf: add support for logging debug messages to file
>
>  tools/perf/Documentation/perf.txt |  16 ++--
>  tools/perf/util/debug.c           | 124 ++++++++++++++++++++----------
>  2 files changed, 92 insertions(+), 48 deletions(-)
>
> --
> 2.20.1
>
