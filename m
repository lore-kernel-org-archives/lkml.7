Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD19C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8747222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZbGZyCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKSWvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:51:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43559 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKSWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:51:42 -0500
Received: by mail-io1-f66.google.com with SMTP id r2so20141290iot.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRjxm3LKiDcxqNBGS6tcDgWeqEqzYMXc7gZaYJw28cE=;
        b=EZbGZyCUrBD+SQI2cbw2k4yScOLaMBfyt+4IKBB2yNoVUd3Jl5BRcqQW+xB24cwWpe
         TDrtEBz4g0q+g0Fbr6Zw3z7OmjrTqd1HvlWWpWlysEkoXCeP97k3mRIvYxmaAVjglnv4
         45CXrhWle/DbQmTvCbyO4hkImxsm7rWtsBlCFuFTqbohzVA18fjvwJ5LcFNsw0s/X82W
         S3TAnWNojntdX9GI4qkVCPY/oVL0WAzf69o6oaDxA3j5FsRcsrfBYNobajLeuF2rnpLj
         R5aOvPMeTj/KUQENMCIpWJ/SFnIKkJih0Z1NiUqNgtuC/UUoM8GG4yeQZLAU6Ga/wz6k
         XLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRjxm3LKiDcxqNBGS6tcDgWeqEqzYMXc7gZaYJw28cE=;
        b=IBADVM9EPmYNgqGjjj6LSCGDrKhLDPpg4gLyKao4lReGyI7PzR6tRiMsitdbB7Eykq
         AYqH2KzbKoV6GDNbK2OoZcIwQUBFSuQTeU+tmdEO1eqEwByeKF50H6ubzJ9+Bj6G82qi
         w85Zk7/S5Nlmn3dIm9/2AHrtgMuRdyW1k6x+LPyHxiJgIzGnc/VN/nmjneL4M9IhXEAc
         6l07yM+pVE3w+sHowgyhsX7936QR9FxzApu2hY5lBrlI6iojJHwpSMmFCG/PwP89X+wA
         pqVMMa4K5nHscAdA3TB74m+bWQDA7uJCTH4kZ7yrx8FCpRFN+PgVukpHRH7UXeqxX+RI
         p9GA==
X-Gm-Message-State: APjAAAW9nmdSUK60r2EG6+/ZzNwV9KIJOqgaD7A8Wrl5hxzxSRtCQk5F
        knqOmRzjR4Wu3dbzH3jlJ7l/BS7tNofmPphd2pH77g==
X-Google-Smtp-Source: APXvYqzGI2fV64j5/2ER1xSgYQJZr6fYKTr1lyP8u/LcCQRq+gvHLJe9ErYhVnDKGFtdkz9Q6UqSQekYo4kKeQ08dR0=
X-Received: by 2002:a6b:2d4:: with SMTP id 203mr12923784ioc.193.1574203900831;
 Tue, 19 Nov 2019 14:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20191119143411.3482-1-kan.liang@linux.intel.com>
 <20191119143411.3482-2-kan.liang@linux.intel.com> <CABPqkBRrPgW+Kdkiqy0dTu6e_8G55XLfFh5mCLt1_UQEHU=Zbg@mail.gmail.com>
 <6c233145-fb30-b629-2290-8595e192ba82@linux.intel.com>
In-Reply-To: <6c233145-fb30-b629-2290-8595e192ba82@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Nov 2019 14:51:29 -0800
Message-ID: <CABPqkBREzL_k9noerYrYLq8UqTJsahQdNRT4vhFoNSub09xyoA@mail.gmail.com>
Subject: Re: [PATCH V4 01/13] perf/core: Add new branch sample type for LBR TOS
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 2:25 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/19/2019 2:02 PM, Stephane Eranian wrote:
> > On Tue, Nov 19, 2019 at 6:35 AM<kan.liang@linux.intel.com>  wrote:
> >> From: Kan Liang<kan.liang@linux.intel.com>
> >>
> >> In LBR call stack mode, the depth of reconstructed LBR call stack limits
> >> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
> >> perf tool may stitch the stacks of two samples. The reconstructed LBR
> >> call stack can break the HW limitation.
> >>
> >> Add a new branch sample type to retrieve LBR TOS. The new type is PMU
> >> specific. Add it at the end of enum perf_branch_sample_type.
> >> Add a macro to retrieve defined bits of branch sample type.
> >> Update perf_copy_attr() to handle the new bit.
> >>
> >> Only when the new branch sample type is set, the TOS information is
> >> dumped into the PERF_SAMPLE_BRANCH_STACK output.
> >> Perf tool should check the attr.branch_sample_type, and apply the
> >> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
> >> Otherwise, some user case may be broken. For example, users may parse a
> >> perf.data, which include the new branch sample type, with an old version
> >> perf tool (without the check). Users probably get incorrect information
> >> without any warning.
> >>
> >> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
> >> ---
> >>   include/linux/perf_event.h      |  2 ++
> >>   include/uapi/linux/perf_event.h | 16 ++++++++++++++--
> >>   kernel/events/core.c            | 13 ++++++++++++-
> >>   3 files changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >> index 011dcbdbccc2..761021c7ee8a 100644
> >> --- a/include/linux/perf_event.h
> >> +++ b/include/linux/perf_event.h
> >> @@ -93,6 +93,7 @@ struct perf_raw_record {
> >>   /*
> >>    * branch stack layout:
> >>    *  nr: number of taken branches stored in entries[]
> >> + *  tos: Top-of-Stack (TOS) information. PMU specific data.
> >>    *
> >>    * Note that nr can vary from sample to sample
> >>    * branches (to, from) are stored from most recent
> >> @@ -101,6 +102,7 @@ struct perf_raw_record {
> >>    */
> >>   struct perf_branch_stack {
> >>          __u64                           nr;
> >> +       __u64                           tos; /* PMU specific data */
> >>          struct perf_branch_entry        entries[0];
> >>   };
> >>
> > Same remark as with the other patch. You need to abstract this.
> > The TOS and PMU specific data should be limited to  x86/event/intel/*.[ch].
> >
>
> If we change tos to a generic name, e.g. pmu_specific_data, can we still
> keep it here?
>
It's not just about the name, it is about what it points to?
What value does it return when the hw does not have a TOS?
I added the PERF_SAMPLE_BRANCH_*. I did not just expose the
raw LBR. There is an abstraction layer, so it is easier to map to other
architectures, like IBM Power, for instance. You cannot just add a TOS
and say it is PMU specific. If you do that for all architectures, then it
becomes very messy and hard to understand and use especially for tools.

This is an interface you are trying to define. This needs to be specified
precisely so that tools can make the right assumptions across hw platforms.

Note that the entries[] array is normally already sorted by most
recent to least recent.
So exporting a TOS there is bizarre. The TOS is likely always pointing to the
most recent entry. The TOS you want is exposing a low level index which does not
map to the abstracted branch stack. And that's a problem.  You need to reconcile
your definition of TOS with the branch_sample_entry [] abstraction.

> If not, I think the only way is to introduce a new method, e.g.
> output_br_pmu_data(), at struct pmu.
> When outputting the sample data, the generic code will call
> event->pmu->output_br_pmu_data() to retrieve the TOS in Intel code.
> I think it's too complicated.
>
> Thanks,
> Kan
>
>
>
>
