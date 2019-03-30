Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E9FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A7E218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553977606;
	bh=8OY/ItTyUOhPFnyjzzdRbzXdDRs7IFweANtitvY+6KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ruDSvAg/YTjLet9QooRniodK5NQl+kLmdNg+uWk2yGBdNzk8CeLpOAP3mxTkHAF8t
	 teJSfCgs0m5yP3nqZ5iomvhgnHjjQxutDpWGuDXR6JKjfN1uzxXtLvhdKMRkw7S43T
	 mRhgTv+pAbIadu5Iy5tOC4UG2zjWnPCjDl7cEegg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfC3U0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbfC3U0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 16:26:44 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6C4217F5;
        Sat, 30 Mar 2019 20:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553977603;
        bh=8OY/ItTyUOhPFnyjzzdRbzXdDRs7IFweANtitvY+6KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxlWEt3Nkux3GdHexw2pfqsMlXdnxshN7LdK9rLw+AzsoD//2/FedDy4QIs+mQqyY
         j2NnyRfDdWsbB71h5cLfwU1Pl5Se9Yp1C5rxBqDCL+oynq3t1BJ8YdksqA26dSFumq
         ju5S7JFY2eK2iaftl61mv4aRwY8A38jvQ5dbZyDg=
Date:   Sat, 30 Mar 2019 21:24:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     st5pub@yandex.ru, adrian.hunter@intel.com,
        ard.biesheuvel@linaro.org, benh@kernel.crashing.org, bp@alien8.de,
        darrick.wong@oracle.com, dchinner@redhat.com, dedekind1@gmail.com,
        hpa@zytor.com, jlbec@evilplan.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        mark@fasheh.com, mingo@redhat.com, mpe@ellerman.id.au,
        naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org, richard@nod.at,
        tglx@linutronix.de, vgupta@synopsys.com, x86@kernel.org
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Message-ID: <20190330202418.GB27435@kroah.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
 <20190330183826.GB21828@kroah.com>
 <201903302015.x2UKFnSL003850@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903302015.x2UKFnSL003850@sdf.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 08:15:49PM +0000, George Spelvin wrote:
> On Sat, 30 Mar 2019 at 19:38:26 +0100 greh k-h wrote;
> > On Sat, Mar 30, 2019 at 07:43:53PM +0300, Andrey Abramov wrote:
> >> Replace int type with size_t type of the size argument
> >> in the swap function, also affect all its dependencies.
> >
> > This says _what_ the patch does, but it gives no clue as to _why_ you
> > are doing this.  Neither did your 0/5 patch :(
> >
> > Why make this change?  Nothing afterward depends on it from what I can
> > tell, so why is it needed?
> 
> It's just a minor cleanup, making things less surprising for future
> programmers.  As I wrote in a comment in my patches, using a signed type
> for an object size is definitely a wart; ever since C89 it's expected
> you'd use size_t for the purpose.

You did not say that in this commit log :)

> The connection is that it's a natural consequence of doing a pass over
> every call site.
> 
> You're right it could be dropped from the series harmlessly, but it
> comes from the same work.  But it's all of *three* call sites in the kernel
> which are affected.  Surely that's not an unreasonable amount of churn
> to clean up a wart?

If you think it is a wart, wonderful, yes, let's fix it up.  But again,
a changelog comment should explain _why_ a commit is needed, not _what_
it does, as we can see from the diff itself exactly what the commit
does.

thanks,

greg k-h
