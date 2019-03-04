Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB9FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4F4206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfCDUX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:23:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfCDUX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:23:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72ABA882F5;
        Mon,  4 Mar 2019 20:23:27 +0000 (UTC)
Received: from krava (ovpn-204-135.brq.redhat.com [10.40.204.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 45E315D9CC;
        Mon,  4 Mar 2019 20:23:24 +0000 (UTC)
Date:   Mon, 4 Mar 2019 21:23:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v5 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190304202323.GA2563@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-8-songliubraving@fb.com>
 <20190304135210.GB19809@krava>
 <CE031049-FB10-4BB5-BCA1-EA48C5BF882B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE031049-FB10-4BB5-BCA1-EA48C5BF882B@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 04 Mar 2019 20:23:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:36:14PM +0000, Song Liu wrote:
> 
> 
> > On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Feb 27, 2019 at 09:06:35PM -0800, Song Liu wrote:
> > 
> > SNIP
> > 
> >> +static int process_bpf_prog_info(struct feat_fd *ff,
> >> +				 void *data __maybe_unused)
> >> +{
> >> +	struct bpf_prog_info_linear *info_linear;
> >> +	struct bpf_prog_info_node *info_node;
> >> +	struct perf_env *env = &ff->ph->env;
> >> +	u32 count, i;
> >> +	int err = -1;
> >> +
> >> +	if (do_read_u32(ff, &count))
> >> +		return -1;
> >> +
> >> +	down_write(&env->bpf_progs.lock);
> >> +
> >> +	for (i = 0; i < count; ++i) {
> >> +		u32 info_len, data_len;
> >> +
> >> +		info_linear = NULL;
> >> +		info_node = NULL;
> >> +		if (do_read_u32(ff, &info_len))
> >> +			goto out;
> >> +		if (do_read_u32(ff, &data_len))
> >> +			goto out;
> >> +
> >> +		if (info_len > sizeof(struct bpf_prog_info)) {
> >> +			pr_warning("detected invalid bpf_prog_info\n");
> >> +			goto out;
> >> +		}
> >> +
> >> +		info_linear = malloc(sizeof(struct bpf_prog_info_linear) +
> >> +				     data_len);
> >> +		if (!info_linear)
> >> +			goto out;
> >> +		info_linear->info_len = sizeof(struct bpf_prog_info);
> >> +		info_linear->data_len = data_len;
> >> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
> >> +			goto out;
> >> +		if (__do_read(ff, &info_linear->info, info_len))
> >> +			goto out;
> >> +		if (info_len < sizeof(struct bpf_prog_info))
> >> +			memset(((void *)(&info_linear->info)) + info_len, 0,
> >> +			       sizeof(struct bpf_prog_info) - info_len);
> >> +
> >> +		if (__do_read(ff, info_linear->data, data_len))
> >> +			goto out;
> >> +
> >> +		/* endian mismatch, drop the info, continue */
> >> +		if (ff->ph->needs_swap) {
> >> +			free(info_linear);
> >> +			continue;
> >> +		}
> > 
> > so in this case we can check for needs_swap in the begining
> > of the function and bail out without reading all the data
> 
> If we bail out, perf-record will fail. If we read all the data 
> but ignore them, perf-record will continue without bpf annotation 
> support. I think the latter is a better experience with little 
> effort here. 

i did not mean bail out with error, just return 0, warn and go on

jirka

> 
> > 
> > also please display soem error message saying we don't support
> > ebpf progs data report over the different endianity
> 
> I will add a warning in the next version. 
> 
> Thanks,
> Song
> 
