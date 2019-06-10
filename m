Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A818C5ACC3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1107520862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560176510;
	bh=0q0JDs/XvjyzKVHfqOA4UDSjVijHYPYF7aTj5ganjQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VCwck6OMZTuxr8ST0E1+p6OYTusZUX3efqQ62gl7PHuRJY5AoYiSScKiHsqgDkfej
	 kU477Rxhqjqh7mDTnGKZ/qKQNC706vd1uSRfas3iW/Qfvma61tW9z2c1y5ARylx2fE
	 uPoDasTTkFUTtrh1RmW7uwZ2tI6liTcMfILs8QXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403835AbfFJOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390708AbfFJOVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:21:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7A3207E0;
        Mon, 10 Jun 2019 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560176507;
        bh=0q0JDs/XvjyzKVHfqOA4UDSjVijHYPYF7aTj5ganjQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNq8D2lbEuW83CsAWd5W6/oi+NvDlAscZ02Tgb6/7mV7l1Sr2REukOrMx6YCsZK2R
         JfUG/cHSnwFgsJT0aKM892TIPiEcQOWiXWK1xSKK2bBl7N6lx9UKUyWuIRMx9DHQRy
         jNE02Fd+LQPntRoXDq5AKEUzdhaTkJm/RU2CNdI0=
Date:   Mon, 10 Jun 2019 16:21:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Linux 4.19 and GCC 9
Message-ID: <20190610142145.GC5937@kroah.com>
References: <20190517073813.GB2589@hirez.programming.kicks-ass.net>
 <CANiq72nUPoNHWM-dJuFc3=4D2=8XMuvO0PgGPjviOv+EhrAWUw@mail.gmail.com>
 <20190517085126.GA3249@kroah.com>
 <CANiq72muyjE3XPjmtQgJpGaqWR=YBi6KVNT3qe-EMXP7x+q_rQ@mail.gmail.com>
 <20190517152200.GI8945@kernel.org>
 <CABWYdi2Xsp4AUhV1GwphTd4-nN2zCZMmg5y7WheNc67KrdVBfw@mail.gmail.com>
 <4FE2D490-F379-4CAE-9784-9BF81B7FE258@kernel.org>
 <CABWYdi2XXPYuavF0p=JOEY999M4z3_rk-8xsi3N=do=d7k09ig@mail.gmail.com>
 <20190610074510.GA24746@kroah.com>
 <CALrw=nEp=hUUaKtuU3Q1c_zKO3zYC3uP_s_Dyz_zhkxW7K+4mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nEp=hUUaKtuU3Q1c_zKO3zYC3uP_s_Dyz_zhkxW7K+4mQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:32:25AM +0100, Ignat Korchagin wrote:
> Hi Greg,
> 
> For us it seems applying the following 4 mainline patches makes 4.19.x
> branch perf compile with GCC-9:
> 
> 4d0f16d059ddb91424480d88473f7392f24aebdc: perf ui helpline: Use
> strlcpy() as a shorter form of strncpy() + explicit set nul
> b6313899f4ed2e76b8375cf8069556f5b94fbff0: perf help: Remove needless
> use of strncpy()
> 5192bde7d98c99f2cd80225649e3c2e7493722f7: perf header: Fix unchecked
> usage of strncpy()
> 97acec7df172cd1e450f81f5e293c0aa145a2797: perf data: Fix 'strncat may
> truncate' build failure with recent gcc
> 
> I also checked that 4.19.49 compiles fine with GCC 9, although with a
> lot of warnings, mostly from objtool, like "warning: objtool:
> sock_register()+0xd: sibling call from callable instruction with
> modified stack frame". But it's a start.
> 
> Can we apply the above-mentioned patches, please?

I'll look into these after the next round of kernels are released.  I
guess I'll go find a distro that has gcc9 on it to actually test
things...

thanks,

greg k-h
