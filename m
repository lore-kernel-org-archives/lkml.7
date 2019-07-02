Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A4B21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562060859;
	bh=XXGYqdnt+JvoUqIOPLoPD7ttjH4BJlU3ObVXMgm6v1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZSr8c44QCMXEW3xQgvSeclm3PR1xX7QiN+6LFVwP4AAZ4gyihCB7IDXf4CDjLjT0j
	 VPjlZo/23FVcOvMpr1gF7ArZgMZMJgg+V8fuehRARIV8rSom2++VmfCfBo+KyOvlOh
	 j+s9AiSJa8BYefU4XNlsPFfnFHL9rvlmrJkppyBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGBJrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:47:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E85206A2;
        Tue,  2 Jul 2019 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562060855;
        bh=XXGYqdnt+JvoUqIOPLoPD7ttjH4BJlU3ObVXMgm6v1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GGcqLRZLgFspvPOTr+y81lZOjSwzvvwnwZzGLc4sKQWgx/I5675TzMvLmh1pzl/BP
         3iVoRDPCRX3zDKsqwI+Ytlkt66IzrI1GKuzhcci5f0NdHR4QAQaQ7fNHckYcYYImHc
         fwsH5Wq38nV8djxEeGfAqBv4N8I8OAjfIpz1QA9g=
Date:   Tue, 2 Jul 2019 18:47:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using
 devicetree
Message-Id: <20190702184730.b0247eb780ffa48d40a61a81@kernel.org>
In-Reply-To: <20190627195817.211ab4bea422f37e539e47e8@kernel.org>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
        <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
        <20190627195817.211ab4bea422f37e539e47e8@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 27 Jun 2019 19:58:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Rob,
> 
> On Wed, 26 Jun 2019 15:58:50 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
> 
> > On Fri, Jun 21, 2019 at 10:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > Here is an RFC series of patches to add boot-time tracing using
> > > devicetree.
> > >
> > > Currently, kernel support boot-time tracing using kernel command-line
> > > parameters. But that is very limited because of limited expressions
> > > and limited length of command line. Recently, useful features like
> > > histogram, synthetic events, etc. are being added to ftrace, but it is
> > > clear that we can not expand command-line options to support these
> > > features.
> > >
> > > Hoever, I've found that there is a devicetree which can pass more
> > > structured commands to kernel at boot time :) The devicetree is usually
> > > used for dscribing hardware configuration, but I think we can expand it
> > > for software configuration too (e.g. AOSP and OPTEE already introduced
> > > firmware node.) Also, grub and qemu already supports loading devicetree,
> > > so we can use it not only on embedded devices but also on x86 PC too.
> > 
> > Do the x86 versions of grub, qemu, EFI, any other bootloader actually
> > enable DT support? I didn't think so. Certainly, an x86 kernel doesn't
> > normally (other than OLPC and ce4100) have a defined way to even pass
> > a dtb from the bootloader to the kernel and the kernel doesn't
> > unflatten the dtb.
> 
> Sorry, the grub part, I just found this entry. I need to check this
> can work on x86 too.

I've confirmed that grub-x86 doesn't support devicetree option. I tried
to add it, and tested it.

https://github.com/mhiramat/grub/commit/644c35bfd2d18c772cc353b74215344f8264923a

This works if there is ACPI, if it includes /chosen/linux,ftrace node only.
(Anyway, we don't need other nodes on x86)

At this moment, grub doesn't support DT overlay, so on arm/arm64 user must
decompile DTB, add linux,ftrace node for tracing and compile it again.
But if it supports overlay, I think we can give an overlay for tracer setting
on boot up, that will be handy on arm/arm64 too. :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
