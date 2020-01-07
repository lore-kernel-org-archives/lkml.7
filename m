Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BEC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7082080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAGJQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:40856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbgAGJQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:16:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4A4EAC8B;
        Tue,  7 Jan 2020 09:16:50 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:16:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 08/20] tools lib api fs: Fix gcc9 stringop-truncation
 compilation error
Message-ID: <20200107091650.dydvcjnve7hz2345@pathway.suse.cz>
References: <20200106160705.10899-1-acme@kernel.org>
 <20200106160705.10899-9-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106160705.10899-9-acme@kernel.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-06 13:06:53, Arnaldo Carvalho de Melo wrote:
> From: Andrey Zhizhikin <andrey.z@gmail.com>
> 
> GCC9 introduced string hardening mechanisms, which exhibits the error
> during fs api compilation:
> 
> error: '__builtin_strncpy' specified bound 4096 equals destination size
> [-Werror=stringop-truncation]
> 
> This comes when the length of copy passed to strncpy is is equal to
> destination size, which could potentially lead to buffer overflow.
> 
> There is a need to mitigate this potential issue by limiting the size of
> destination by 1 and explicitly terminate the destination with NULL.
> 
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: bpf@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Link: http://lore.kernel.org/lkml/20191211080109.18765-1-andrey.zhizhikin@leica-geosystems.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
