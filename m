Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D9EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8499520675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555628816;
	bh=RTPjVCssAKTfhKfvzlCbaavMdnjhTB9RZGkxTvmQuAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2RhnjrcDETVzK0VzjEp8uM2eddybv/Jdw1sJcqxLk243ZChjl8u3vVtcgL1fLeV4J
	 E//nL7szWs2yQdvvT3hnqb25cjiEJek8H6cOOpmlIEHfyNZfcuKgZHUEh/QgFFrIuw
	 aKXZK/vBI1io/oqeHW+OTU2YBDOhCRDhBbi+vJaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfDRXGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:06:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRXGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:06:54 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D06C1749;
        Thu, 18 Apr 2019 23:06:52 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:06:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in
 kdb summary
Message-Id: <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
In-Reply-To: <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
References: <20190323015227.245455-1-dianders@chromium.org>
        <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
        <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
        <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 15:37:49 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> > It's pretty benign: Doug will still only get a single email.
> >
> >
> > checkpatch checks for duplicates cc's but I think it assumes that
> > things like
> >
> > Reported-by: fred
> > Tested-by: fred
> >
> > were intentional.
> >
> > It would perhaps be better for checkpatch to special-case the "Cc:
> > fred" tag and report a duplicated Cc: if fred was also mentioned in any
> > other tag.
> 
> Sorry, I do not understand what you mean.
> 
> 
> Douglas did not add any Cc: tag at all
> in his original patch:
> https://lore.kernel.org/patchwork/patch/1053953/
> 
> 
> It's you who added the Cc: tags
> (and I am guessing you did it by scripting.)
> 
> Why is this topic related to checkpatch?

Because I regularly check all patches with checkpatch but checkpatch
failed to detect that I had

Signed-off-by: Douglas Anderson <dianders@chromium.org>
...
Cc: Douglas Anderson <dianders@chromium.org>

and I believe that checkpatch could and should have warned about this
situation.

