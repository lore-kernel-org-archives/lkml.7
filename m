Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7859AC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD2D214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfCKUpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:45:55 -0400
Received: from www62.your-server.de ([213.133.104.62]:58078 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCKUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:45:54 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3Rnz-00065F-F5; Mon, 11 Mar 2019 21:45:51 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3Rnz-0004mF-3B; Mon, 11 Mar 2019 21:45:51 +0100
Subject: Re: [PATCH v7 perf,bpf 02/15] bpf: libbpf: introduce
 bpf_program__get_prog_info_linear()
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-3-songliubraving@fb.com>
 <20190311182631.GX10690@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b6fb25aa-5bfc-cf97-f960-5966154e5ef5@iogearbox.net>
Date:   Mon, 11 Mar 2019 21:45:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190311182631.GX10690@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2019 07:26 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 07, 2019 at 09:57:57AM -0800, Song Liu escreveu:
>> Currently, bpf_prog_info includes 9 arrays. The user has the option to
>> fetch any combination of these arrays. However, this requires a lot of
>> handling of these arrays. This work becomes more tricky when we need to
>> store bpf_prog_info to a file, because these arrays are allocated
>> independently.
>>
>> This patch introduces struct bpf_prog_info_linear, which stores arrays
>> of bpf_prog_info in continues memory. Helper functions are introduced
>> to unify the work to get different information of bpf_prog_info.
>> Specifically, bpf_program__get_prog_info_linear() allows the user to
>> select which arrays to fetch, and handles details for the user.
>>
>> Plesae see the comments before enum bpf_prog_info_array for more details
>> and examples.
>>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Alexei Starovoitov <ast@kernel.org>
> 
> Daniel, are you ok with these changes to libbpf and bpftool? Perhaps
> those should be detached from this patchkit and submitted sooner,
> eroding the size of this kit.
> 
> Alternatively, if you're ok with it, please provide your Acked-by and
> I'll process as soon as I get back to it after Jiri is done reviewing.

Overall looks okay. Are you planning to get these in for 5.1 window? If
yes, that would be great, otherwise we might need to cherry-pick the libbpf
and bpftool ones from your tree into bpf-next as well since there's just
too much going on in this area where we'd potentially run into complex
merge conflicts. In the latter case, libbpf.map would need to be fixed up
to LIBBPF_0.0.3 as convention is that this is in line with kernel release.

Thanks,
Daniel

> - Arnaldo
