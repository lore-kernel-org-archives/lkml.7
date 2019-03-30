Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628BBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334AC217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfC3UR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:17:29 -0400
Received: from mx.sdf.org ([205.166.94.20]:62454 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730613AbfC3UR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 16:17:28 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2UKFpBZ007337
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 30 Mar 2019 20:15:52 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2UKFnSL003850;
        Sat, 30 Mar 2019 20:15:49 GMT
Date:   Sat, 30 Mar 2019 20:15:49 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903302015.x2UKFnSL003850@sdf.org>
To:     gregkh@linuxfoundation.org, st5pub@yandex.ru
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the swap function
Cc:     adrian.hunter@intel.com, ard.biesheuvel@linaro.org,
        benh@kernel.crashing.org, bp@alien8.de, darrick.wong@oracle.com,
        dchinner@redhat.com, dedekind1@gmail.com, hpa@zytor.com,
        jlbec@evilplan.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        lkml@sdf.org, mark@fasheh.com, mingo@redhat.com,
        mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
        paulus@samba.org, richard@nod.at, tglx@linutronix.de,
        vgupta@synopsys.com, x86@kernel.org
In-Reply-To: <20190330183826.GB21828@kroah.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>,
    <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>,
    <20190330183826.GB21828@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2019 at 19:38:26 +0100 greh k-h wrote;
> On Sat, Mar 30, 2019 at 07:43:53PM +0300, Andrey Abramov wrote:
>> Replace int type with size_t type of the size argument
>> in the swap function, also affect all its dependencies.
>
> This says _what_ the patch does, but it gives no clue as to _why_ you
> are doing this.  Neither did your 0/5 patch :(
>
> Why make this change?  Nothing afterward depends on it from what I can
> tell, so why is it needed?

It's just a minor cleanup, making things less surprising for future
programmers.  As I wrote in a comment in my patches, using a signed type
for an object size is definitely a wart; ever since C89 it's expected
you'd use size_t for the purpose.

The connection is that it's a natural consequence of doing a pass over
every call site.

You're right it could be dropped from the series harmlessly, but it
comes from the same work.  But it's all of *three* call sites in the kernel
which are affected.  Surely that's not an unreasonable amount of churn
to clean up a wart?
