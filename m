Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA372241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuzDHzZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKSTCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:02:24 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33879 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:02:23 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so20732267ilp.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5IXEqqYz7IFwy+gEurJhn05Az2pV/jf6zB5Y5rRxrU=;
        b=EuzDHzZzwMf9YDBFrVfiFws0Iew/P7Ki1TvB06d1mxqNSPP7AgdCaHL370iKwv5YqT
         WmQ21HBtq+tEcd3X0LqhBHsgbeEvhKBTTkxQr06rBrmfG8JAbP5drJoaDAkudj53TB0F
         LP2o9b77UViL6qR6tMqNrKVIOJ1vQcQdGbVaAYYiWScCLm0HiRSWDdslLQgyUEiVT/8Q
         0mwIuGZVfTUn3aSbi3XteKRPQEGqRU2YKYSaPHpp/Azv0l+FFbFFIbxP3ioYiTFn9sHe
         71x1IpjIIg8IUllPT/X5eLWETggefEdx74zEhMqWp7FhOZv1+g0V9x/lgJ3AZT7XFROL
         ogGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5IXEqqYz7IFwy+gEurJhn05Az2pV/jf6zB5Y5rRxrU=;
        b=GsRD8E9sf1S7kE+zWfNx+gpRck8qTQjknvrv9GCDIugcbPyp6+cVeJJe+fLYkHyS1N
         2qtYfJtqW2bScgcrwMfx9BiqqOBa0xCm50s/LM7982BaZZgwgLZcr4CrrdTX5AaT/O3A
         +cpBgAoBMAQN1p6w8FtWHpREeuT92Bf78I2bx84/gDlB95+BUF55gXowvLPKbUl7kKgN
         xJXHituKfkWMEfKxeoybc+PfBvAgwbHRD0GhCKqO+2FfnHbnh4itC9ifpbc3WEVEHmF9
         nFyPbfn19oVba+Nent5DPIefnxC5Cqi1Ua25BMEVVcf7zDnomygcHJsT3+oIWzif2008
         TqVA==
X-Gm-Message-State: APjAAAVfQ7UR4z6t8G5jWaQc7iDA5C3Cc+0CeFhWWvvQO3lRJHLksM5Q
        fMHqpnynwK6fHEli77yq3eyxtRSW8kROxmbMhXusxUua
X-Google-Smtp-Source: APXvYqygY0WZPAlqymeVmHoh5U5FF5pVHvTF/uK+WhMRNR06djsVHQOMW04efXXzpKzyR5IvdCctq+8bERDeAygkOpI=
X-Received: by 2002:a92:dd8e:: with SMTP id g14mr22948154iln.129.1574190141871;
 Tue, 19 Nov 2019 11:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20191119143411.3482-1-kan.liang@linux.intel.com> <20191119143411.3482-2-kan.liang@linux.intel.com>
In-Reply-To: <20191119143411.3482-2-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Nov 2019 11:02:10 -0800
Message-ID: <CABPqkBRrPgW+Kdkiqy0dTu6e_8G55XLfFh5mCLt1_UQEHU=Zbg@mail.gmail.com>
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

On Tue, Nov 19, 2019 at 6:35 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> In LBR call stack mode, the depth of reconstructed LBR call stack limits
> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
> perf tool may stitch the stacks of two samples. The reconstructed LBR
> call stack can break the HW limitation.
>
> Add a new branch sample type to retrieve LBR TOS. The new type is PMU
> specific. Add it at the end of enum perf_branch_sample_type.
> Add a macro to retrieve defined bits of branch sample type.
> Update perf_copy_attr() to handle the new bit.
>
> Only when the new branch sample type is set, the TOS information is
> dumped into the PERF_SAMPLE_BRANCH_STACK output.
> Perf tool should check the attr.branch_sample_type, and apply the
> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
> Otherwise, some user case may be broken. For example, users may parse a
> perf.data, which include the new branch sample type, with an old version
> perf tool (without the check). Users probably get incorrect information
> without any warning.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h      |  2 ++
>  include/uapi/linux/perf_event.h | 16 ++++++++++++++--
>  kernel/events/core.c            | 13 ++++++++++++-
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 011dcbdbccc2..761021c7ee8a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -93,6 +93,7 @@ struct perf_raw_record {
>  /*
>   * branch stack layout:
>   *  nr: number of taken branches stored in entries[]
> + *  tos: Top-of-Stack (TOS) information. PMU specific data.
>   *
>   * Note that nr can vary from sample to sample
>   * branches (to, from) are stored from most recent
> @@ -101,6 +102,7 @@ struct perf_raw_record {
>   */
>  struct perf_branch_stack {
>         __u64                           nr;
> +       __u64                           tos; /* PMU specific data */
>         struct perf_branch_entry        entries[0];
>  };
>
Same remark as with the other patch. You need to abstract this.
The TOS and PMU specific data should be limited to  x86/event/intel/*.[ch].

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..c2da61c9ace7 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -180,7 +180,10 @@ enum perf_branch_sample_type_shift {
>
>         PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT      = 16, /* save branch type */
>
> -       PERF_SAMPLE_BRANCH_MAX_SHIFT            /* non-ABI */
> +       PERF_SAMPLE_BRANCH_MAX_SHIFT            = 17, /* non-ABI */
> +
> +       /* PMU specific */
> +       PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT        = 63, /* save LBR TOS */
>  };
>
>  enum perf_branch_sample_type {
> @@ -208,8 +211,13 @@ enum perf_branch_sample_type {
>                 1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
>
>         PERF_SAMPLE_BRANCH_MAX          = 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
> +
> +       PERF_SAMPLE_BRANCH_LBR_TOS      = 1ULL << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
>  };
>
> +#define PERF_SAMPLE_BRANCH_MASK                ((PERF_SAMPLE_BRANCH_MAX - 1) |\
> +                                        PERF_SAMPLE_BRANCH_LBR_TOS)
> +
>  /*
>   * Common flow change classification
>   */
> @@ -849,7 +857,11 @@ enum perf_event_type {
>          *        char                  data[size];}&& PERF_SAMPLE_RAW
>          *
>          *      { u64                   nr;
> -        *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
> +        *        { u64 from, to, flags } lbr[nr];
> +        *
> +        *        # only available if PERF_SAMPLE_BRANCH_LBR_TOS is set
> +        *        u64                   tos;
> +        *      } && PERF_SAMPLE_BRANCH_STACK
>          *
>          *      { u64                   abi; # enum perf_sample_regs_abi
>          *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cfd89b4a02d8..8aff3aad43b5 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6391,6 +6391,11 @@ static void perf_output_read(struct perf_output_handle *handle,
>                 perf_output_read_one(handle, event, enabled, running);
>  }
>
> +static inline bool perf_sample_save_lbr_tos(struct perf_event *event)
> +{
> +       return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS;
> +}
> +
>  void perf_output_sample(struct perf_output_handle *handle,
>                         struct perf_event_header *header,
>                         struct perf_sample_data *data,
> @@ -6480,6 +6485,8 @@ void perf_output_sample(struct perf_output_handle *handle,
>
>                         perf_output_put(handle, data->br_stack->nr);
>                         perf_output_copy(handle, data->br_stack->entries, size);
> +                       if (perf_sample_save_lbr_tos(event))
> +                               perf_output_put(handle, data->br_stack->tos);
>                 } else {
>                         /*
>                          * we always store at least the value of nr
> @@ -6667,7 +6674,11 @@ void perf_prepare_sample(struct perf_event_header *header,
>                 if (data->br_stack) {
>                         size += data->br_stack->nr
>                               * sizeof(struct perf_branch_entry);
> +
> +                       if (perf_sample_save_lbr_tos(event))
> +                               size += sizeof(u64);
>                 }
> +
>                 header->size += size;
>         }
>
> @@ -10731,7 +10742,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>                 u64 mask = attr->branch_sample_type;
>
>                 /* only using defined bits */
> -               if (mask & ~(PERF_SAMPLE_BRANCH_MAX-1))
> +               if (mask & ~PERF_SAMPLE_BRANCH_MASK)
>                         return -EINVAL;
>
>                 /* at least one branch bit must be set */
> --
> 2.17.1
>
