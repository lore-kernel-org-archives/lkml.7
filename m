Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8908C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553640480;
	bh=/dVyfAw2kGjMyWvyu3Vm9/SGL97y96eNhYKN0o3GffM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MznHhs02Qf/7bAqZDUeZgcfs2AtL6alLmxeDLlnQCzmbkWS/2VDECJIbHAOcchukc
	 OHQXzVQe4+S6hqZWmmABTLCAhA4PdYqRdJFPSGaIPodJhxTwkFTGtKeAvszCcG1TG9
	 WM8kKfMVR1sY1uyq+eFQK+ZXaMetzA4n+MHFep1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfCZWr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbfCZWr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:47:59 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415272075D;
        Tue, 26 Mar 2019 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553640478;
        bh=/dVyfAw2kGjMyWvyu3Vm9/SGL97y96eNhYKN0o3GffM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0IMccCsP8i7vCc+3HTEHDNtyTUlr1YZZKfYCBN1/BJLiixOk7Citw9dU8W702Rc0G
         Ud6yHO693T0eiiaqyabMSmGzoRHXDirXo2+0Hd3rUfLpk9mp5z2ftpPC4Egv+xltho
         rfTqEUPe3LOTnkvUmIncYiEse2nIptTLZcQ8dNic=
Date:   Wed, 27 Mar 2019 07:47:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
Subject: Re: [PATCH 22/27] Lock down kprobes
Message-Id: <20190327074755.310fd73e613a7c0f8fa2d94d@kernel.org>
In-Reply-To: <CACdnJuss=NmcxS0UoTeopYzipt53ba5GTBwQ+YtJQXLj7_Q10w@mail.gmail.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
        <20190325220954.29054-23-matthewgarrett@google.com>
        <20190326212957.f5b518990c14cf21262bfdcc@kernel.org>
        <CACdnJuss=NmcxS0UoTeopYzipt53ba5GTBwQ+YtJQXLj7_Q10w@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 10:41:23 -0700
Matthew Garrett <mjg59@google.com> wrote:

> On Tue, Mar 26, 2019 at 5:30 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 25 Mar 2019 15:09:49 -0700
> > Matthew Garrett <matthewgarrett@google.com> wrote:
> >
> > > From: David Howells <dhowells@redhat.com>
> > >
> > > Disallow the creation of kprobes when the kernel is locked down by
> > > preventing their registration.  This prevents kprobes from being used to
> > > access kernel memory, either to make modifications or to steal crypto data.
> >
> > Hmm, if you enforce signature check of modules, those modules
> > should be allowed to use kprobes?
> > I think we should introduce some kind of trust inheritance from
> > signed (trusted) modules.
> 
> Is there any way to install a kprobe /without/ it coming from a
> module? The presumption in lockdown mode is that module signing is
> enforced, so I'll admit to not being entirely clear on why this patch
> is needed in that case.

Yes, there are 2 paths, ftrace and perf(bpf). If you want to disable ftrace
path (which start from user's input via tracefs), this should be done in
trace_kprobe_create()@kernel/trace/trace_kprobe.c.
If you want to disable both, __register_trace_kprobe()@kernel/trace/trace_kprobe.c
is the best place.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
