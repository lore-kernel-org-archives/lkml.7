Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D5C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD6320863
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWHSQ88l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfEIABp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:01:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEIABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:01:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so422688ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GB8jreGg4VZYtPBoB9kcqZSYlkH1FrXZGlEq5Cw8HWE=;
        b=EWHSQ88l4pmf8aYlogAQdLJyoQx2530eBeKC3U703BVfeSQBlhbSEQ0ZAa3yfIj+DH
         VtKVIc2aNHUph9IK1GAVp68kFLna8GmL8IXYwqOl5GFGKeV2Ynd1hDWB2V/6u7/H94Jb
         mwH3K7zeNzWa2/Dpl6K/oOvh8WyhLSPZ1t7IZ3UcP8vdudx+VCbn/s/WY/6YIa5HGOeJ
         LdqqzPV2txK58TdxQJuUF5/HVXyj1WJp9Z1WEsycFwKNdUN32ohhTrsojvRGABaMt0fm
         P5facCvhsEeQPIOy9Pio2tcPcAauRZUA5Hx2QOHYwsQXSanYXzXTWO9Q3bE5Kf+8jQtU
         Kt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GB8jreGg4VZYtPBoB9kcqZSYlkH1FrXZGlEq5Cw8HWE=;
        b=C1Mpr3009QpFFhr2iZ4nQDALLTMpckm4kJXVs4DxyYd5toqk3zyFquzhKb/5ea+bua
         CTlaNI64o8dgBHp9rrGlDhTpOfqN+p2ldWqvRdKsU4n78Z3PhFfUj5MTSC5kkIjfeupo
         jT2a4tIiwRo8YmRo8LeZ+MtQJeVb0NwP3YOlkhTyQ/EAlZgxkRtIXZ8BpYq13Pepozq7
         AZeMGVSLbr923jeEkCVz31m6nH/zmCb7MuQLqZDUwBv3NxlxC6wAp8FH9nF6nyNmZxr/
         aWzkdzcNVMeUOZBa5Tk5ilY4m0eapWZEWzxVgc/AJrQjagu6SlQuRcJQRoPcmu9Tqr5C
         b4Aw==
X-Gm-Message-State: APjAAAXiwxE8UEkYc/YH1yd6oXOs9QNLWWV0S57LyXSoMoiBQtkDxUOB
        1e0UEEsPVYGvT1uIR1iQjtSQmLFc6zwmm/8F7I0=
X-Google-Smtp-Source: APXvYqxAlc1F8jlUT4uoypTdHudqsdx9SUWt8ozwU6MkJj3IV3rSeKANDGHNU41yFbGy19N/fNnLZAoUrfJZYqnNRE8=
X-Received: by 2002:a2e:984d:: with SMTP id e13mr347470ljj.61.1557360103300;
 Wed, 08 May 2019 17:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429061516.GA9796@aaronlu> <6dfc392f-e24b-e641-2f7d-f336a90415fa@linux.intel.com>
 <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com> <CAERHkrvU0nay-cG9equdOBejOZ5Ffdxo+67ZRp9q0L9BQkcAtQ@mail.gmail.com>
 <eb9abb34-d946-c63c-750b-8f52ed842670@oracle.com> <28fb6854-2772-5d29-087a-6a0cf6afe626@oracle.com>
In-Reply-To: <28fb6854-2772-5d29-087a-6a0cf6afe626@oracle.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 9 May 2019 08:01:31 +0800
Message-ID: <CAERHkrsavsBoEOR5Eq-nm6ADarS0zTi5Mu-T7TO6JoSUi7TRfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 2:41 AM Subhra Mazumdar
<subhra.mazumdar@oracle.com> wrote:
>
>
> On 5/8/19 11:19 AM, Subhra Mazumdar wrote:
> >
> > On 5/8/19 8:49 AM, Aubrey Li wrote:
> >>> Pawan ran an experiment setting up 2 VMs, with one VM doing a
> >>> parallel kernel build and one VM doing sysbench,
> >>> limiting both VMs to run on 16 cpu threads (8 physical cores), with
> >>> 8 vcpu for each VM.
> >>> Making the fix did improve kernel build time by 7%.
> >> I'm gonna agree with the patch below, but just wonder if the testing
> >> result is consistent,
> >> as I didn't see any improvement in my testing environment.
> >>
> >> IIUC, from the code behavior, especially for 2 VMs case(only 2
> >> different cookies), the
> >> per-rq rb tree unlikely has nodes with different cookies, that is, all
> >> the nodes on this
> >> tree should have the same cookie, so:
> >> - if the parameter cookie is equal to the rb tree cookie, we meet a
> >> match and go the
> >> third branch
> >> - else, no matter we go left or right, we can't find a match, and
> >> we'll return idle thread
> >> finally.
> >>
> >> Please correct me if I was wrong.
> >>
> >> Thanks,
> >> -Aubrey
> > This is searching in the per core rb tree (rq->core_tree) which can have
> > 2 different cookies. But having said that, even I didn't see any
> > improvement with the patch for my DB test case. But logically it is
> > correct.
> >
> Ah, my bad. It is per rq. But still can have 2 different cookies. Not sure
> why you think it is unlikely?

Yeah, I meant 2 different cookies on the system, but unlikely 2
different cookies
on one same rq.

If I read the source correctly, for the sched_core_balance path, when try to
steal cookie from another CPU, sched_core_find() uses dst's cookie to search
if there is a cookie match in src's rq, and sched_core_find() returns idle or
matched task, and later put this matched task onto dst's rq (activate_task() in
sched_core_find()). At this moment, the nodes on the rq's rb tree should have
same cookies.

Thanks,
-Aubrey
