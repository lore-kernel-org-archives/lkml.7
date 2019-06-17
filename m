Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40EBC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD57E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpHprEV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfFQP0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:26:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42820 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:26:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so6808565lfh.9;
        Mon, 17 Jun 2019 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RODdXc2ZD5wyJFcFeho8WC0XDsY2lZXJRt8XMboVzP8=;
        b=VpHprEV3MRqB+ioJ94x+V1DngSDAAKRmXpwiKCJYLKkHh2ryBJOXyzmgxkekOAVhS3
         0DlRHF2Kr2D4rWWnerxmLuXg52Kg6NbadquKJOLB2lCKyqdH1iAbICRugQXDfsUnW+t6
         /3w0t2eTstaqQfAGbQx0rBiWxRFN7SGc0LTtAP3Ys7KoLkgjxhIfawf1j0mSmnqXkwT8
         dewp9gBbqYED6dr6JbWZwKU9/lGsPCDor30tZOcQC/COQKMzE10q1aZkRRxEzQug817s
         pp+lG9VjGrJ8N8+HlEZ55NlxuYLhBkQQoSflIi5BZ9j8prslboCA9ITnRaMSaaesXmAF
         8mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RODdXc2ZD5wyJFcFeho8WC0XDsY2lZXJRt8XMboVzP8=;
        b=o+IAtWGhcbKhlFuMzLnmXXqNsWh/HCWx5lKP6V/djZji+yUPiRLV0RX8HFBgjfHdxf
         B/IlAVqwIcf1+DpEe3mDLZquTV72GgCOCoGgdKgdt65Lf/RV37DTIuJ2VUTlJUsaOWLn
         /Wh318RlYFW0GESvF3B+tmZCUazsHhEHymgkyXlUqpisGbgAPdyKaJ2Oxde8RHR8EiqA
         X8d4EdIdvsiGEFPfS13nqQ44/rCobyB4yrJ+ShRlvHn/p+wUIltKtuTvs7os9D9tmSb4
         WG818o9EN+KQj9berjACYdsLO0NIAWU47PyVBXfw7nNhohKWtYvZegZXlQnDNA1u/cer
         phkg==
X-Gm-Message-State: APjAAAVU6LD1heOm8FLEFSWPfpxRtJySL4MKuFKOb/uEyMCOerzHzXVL
        meIMFuAoLB+waUX0NhOifxLKgEvc5PMvoclFjRYJYA==
X-Google-Smtp-Source: APXvYqxMDyI7/A0JHlYJNU0PnpEQfcBsEndnVvrovk/NsiqZpqGf2nxvTYdD3oPKQKwK0tE39WfEn6+/7XFqAvC91WA=
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr2469510lfq.100.1560785201357;
 Mon, 17 Jun 2019 08:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190617125724.1616165-1-arnd@arndb.de>
In-Reply-To: <20190617125724.1616165-1-arnd@arndb.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 17 Jun 2019 08:26:29 -0700
Message-ID: <CAADnVQ+LzuNHFyLae0vUAudZpOFQ4cA02OC0zu3ypis+gqnjew@mail.gmail.com>
Subject: Re: [PATCH] bpf: hide do_bpf_send_signal when unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Matt Mullins <mmullins@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_MODULES is disabled, this function is never called:
>
> kernel/trace/bpf_trace.c:581:13: error: 'do_bpf_send_signal' defined but not used [-Werror=unused-function]

hmm. it should work just fine without modules.
the bug is somewhere else.
