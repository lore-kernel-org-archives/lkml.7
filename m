Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0AC20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfCDUbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:31:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDUbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:31:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAF2A3DDBD;
        Mon,  4 Mar 2019 20:31:35 +0000 (UTC)
Received: from krava (ovpn-204-135.brq.redhat.com [10.40.204.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 47F7A5C2EB;
        Mon,  4 Mar 2019 20:31:33 +0000 (UTC)
Date:   Mon, 4 Mar 2019 21:31:32 +0100
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
Subject: Re: [PATCH v5 perf,bpf 08/15] perf, bpf: save btf in a rbtree in
 perf_env
Message-ID: <20190304203132.GB2563@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-9-songliubraving@fb.com>
 <20190304135231.GE19809@krava>
 <8D38E918-5FF5-4404-8201-58A8FEFA086A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8D38E918-5FF5-4404-8201-58A8FEFA086A@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 04 Mar 2019 20:31:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:43:50PM +0000, Song Liu wrote:
> 
> 
> > On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Feb 27, 2019 at 09:06:36PM -0800, Song Liu wrote:
> >> btf contains information necessary to annotate bpf programs. This patch
> >> saves btf for bpf programs loaded in the system.
> >> 
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> tools/perf/util/bpf-event.c | 24 ++++++++++++++
> >> tools/perf/util/bpf-event.h |  7 ++++
> >> tools/perf/util/env.c       | 65 +++++++++++++++++++++++++++++++++++++
> >> tools/perf/util/env.h       |  4 +++
> >> 4 files changed, 100 insertions(+)
> >> 
> >> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> >> index ce81b2c43a51..370b830f2433 100644
> >> --- a/tools/perf/util/bpf-event.c
> >> +++ b/tools/perf/util/bpf-event.c
> >> @@ -34,6 +34,29 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
> >> 	return 0;
> >> }
> >> 
> >> +static int perf_env__fetch_btf(struct perf_env *env,
> >> +			       u32 btf_id,
> >> +			       struct btf *btf)
> >> +{
> >> +	struct btf_node *node;
> >> +	u32 data_size;
> >> +	const void *data;
> >> +
> >> +	data = btf__get_raw_data(btf, &data_size);
> >> +
> >> +	node = malloc(data_size + sizeof(struct btf_node));
> >> +
> >> +	if (!node)
> >> +		return -1;
> >> +
> >> +	node->id = btf_id;
> >> +	node->data_size = data_size;
> >> +	memcpy(node->data, data, data_size);
> > 
> > why don't we store just struct btf itself?
> > 
> > thanks,
> > jirka
> 
> In current libbpf design, definition of "struct btf" is private 
> to tools/lib/bpf/btf.c. So we cannot copy the struct itself. 

ok

jirka
