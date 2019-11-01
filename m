Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35EE21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NIWsRoTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfKAQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:41:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39410 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfKAQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:41:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id t8so13663810qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jj2ZpJ3W6qaiv42ekK7hG2yJnsYRtdgNJLz0ayczD4M=;
        b=NIWsRoTxNQah7NnWYAIT6IUPn5VQxxF+402RE36qdY0bMta3u0r92MnO60h6Elh3jD
         /Kxx/Z8CfpknUauRIHUymmLu3DzUZctWqzB4nqjoBfW/zmhH6UiLngKPqY9xzOL+WuNz
         11VMGlR6L2RcXOw+BDW6jhNVeY3/DoUSECITk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj2ZpJ3W6qaiv42ekK7hG2yJnsYRtdgNJLz0ayczD4M=;
        b=BA0N0khOna4zIa6c3+4qh+8btI78mPfCBORo/QY5fuSw0twKK8G5pDy8bzdl/uKnXB
         u1GEE49ySKOxA34qMqx5VpIuX/sgDtDqPOQRSPf4Hg6VPO4ZdrbkTyv+iziRW7/7NEK1
         FLNiicSgVmxFoEItiouPgy6sNOvA+8keIHYiUCHgearpGhRnlrOmHv6aOazzYqvpOC9R
         tCiTQP/3QKIQX0RkdYj7manAIPALl0lyL2vN/sb8WqpYAA9knRlHM/JFTfKPh4U9kDZg
         ZSrZATI8O/NyTpYAaj7U0mId+406aFynY6WkxoX3gZKkdQt1izJqevftQN02H8ef23o+
         swvA==
X-Gm-Message-State: APjAAAV3K9QOxrTcSty0i3MmXXTRVdbAxQAUTJL5VjBOk7ceZs9eO5Zn
        50qqrotMc3c35bEsImMkMMNSO2u1NNqyHQ==
X-Google-Smtp-Source: APXvYqxP6khL6N4dYMQ0SdrWS0UAWARcs6EamDhVbB+9y68+oqC4SBC5HgJjoxDBzA0U3gAj98FSjw==
X-Received: by 2002:ac8:394f:: with SMTP id t15mr179134qtb.179.1572626488836;
        Fri, 01 Nov 2019 09:41:28 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id r36sm5858340qta.27.2019.11.01.09.41.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 09:41:28 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id 15so11259144qkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:41:28 -0700 (PDT)
X-Received: by 2002:a37:4ac8:: with SMTP id x191mr6693149qka.85.1572626151290;
 Fri, 01 Nov 2019 09:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <20191031184236.GE5738@pauld.bos.csb> <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
In-Reply-To: <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
From:   Greg Kerr <kerrnel@chromium.org>
Date:   Fri, 1 Nov 2019 09:35:38 -0700
X-Gmail-Original-Message-ID: <CAJGSLMtnxSqKvu3C7WQhMUUbzRXmfU1MVyLz8GcAQcAscdaZdw@mail.gmail.com>
Message-ID: <CAJGSLMtnxSqKvu3C7WQhMUUbzRXmfU1MVyLz8GcAQcAscdaZdw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 7:03 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Hi Phil,
>
> > Unless I'm mistaken 7 of the first 8 of these went into sched/core
> > and are now in linux (from v5.4-rc1). It may make sense to rebase on
> > that and simplify the series.
> >
> Thanks a lot for pointing this out. We shall test on a rebased 5.4 RC
> and post the changes soon, if the tests goes well. For v3, while rebasing
> to an RC kernel, we saw perf regressions and hence did not check the
> RC kernel this time. You are absolutely right that we can simplify the
> patch series with 5.4 RC.

Has anyone considering shipping a V1 implementation which just allows
threads from the same process to share a core together? And then
iterating on that? Would that be simpler to implement or do the same
fundamental problems exist as tagging arbitrary processes with
cookies?

Regards,

Greg Kerr

>
>
> Thanks
> Vineeth
