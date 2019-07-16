Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8735BC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563289365;
	bh=UKqLUL0iFkw5NKdAQPkNvKrr+HrW0INlyWXqa+xDVL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p1PYe2xubb81yk3dtWTLTloxoMuOMpfN5AfwPSRZwgVfsBTCxqUN4BCx+ktIojJjX
	 +FUgES6UbG+p4Zs0ePNZqVF8ovNeInYFWF466znCFoHmSkzFp5V3MgGktO7yO7lOLb
	 cheJdCE1t5/vOKjY/29TSnd707lIyK5Heq3DNtrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfGPPCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388009AbfGPPCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:02:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA08D20693;
        Tue, 16 Jul 2019 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563289361;
        bh=UKqLUL0iFkw5NKdAQPkNvKrr+HrW0INlyWXqa+xDVL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=138gRvkM/+FBSswU+kekPztTXCd/UiX6GMW0JsTOutz3ThFhjT3gupFb3hoVICc8M
         yHHInoWbr0YHO6PKLhEdn1LmUFFitj5uT56YQMnjfkwVAwNahnQRWF1kjz8Xp7cph4
         ESWHJT021rXQEgH5jvZ5G5UKYrw9AaasnQmIA1wo=
Date:   Wed, 17 Jul 2019 00:02:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>, Tim Bird <Tim.Bird@sony.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/15] tracing: of: Boot time tracing using
 devicetree
Message-Id: <20190717000235.9ab100f0dac4af797a0fb76a@kernel.org>
In-Reply-To: <488a65e6-1d80-0acb-5092-80c18b7ff447@gmail.com>
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
        <488a65e6-1d80-0acb-5092-80c18b7ff447@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Mon, 15 Jul 2019 07:21:27 -0700
Frank Rowand <frowand.list@gmail.com> wrote:

> Hi Masami,
> 
> After receiving this email, I replied to one email on the v1 thread,
> so there will be a little bit of overlap in the ordering of the two
> threads.  Feel free to reply to my comments in the v1 thread in this
> thread instead.

OK, thanks for the notice :)

> 
> More comments below.
> 
> On 7/14/19 10:11 PM, Masami Hiramatsu wrote:> Hello,
[...]
> > 
> > Discussion
> > =====
> > On the previous thread, we discussed that the this devicetree usage
> > itself was acceptable or not. Fortunately, I had a chance to discuss
> > it in a F2F meeting with Frank and Tim last week.
> 
> Thanks for writing up some of what we discussed.
> 
> Let me add a problem statement and use case.  I'll probably get it at least
> a little bit wrong, so please update as needed.
> 
> (1) You feel the ftrace kernel command line syntax is not sufficiently user
>     friendly.
> 
> (2) The kernel command line is too small to contain the full set of desired
>     ftrace commands and options.
> 
> (3) There is a desire to change the boot time ftrace commands and options
>     without re-compiling or re-linking the Linux kernel.

Thank you for covering these items :) Yes, these are what I'm thinking.

> > 
> > I think the advantages of using devicetree are,
> > 
> > - reuse devicetree's structured syntax for complicated tracefs settings
> > - reuse OF-APIs in linux kernel to accept and parse it
> > - reuse dtc complier to compile it and validate syntax. (with yaml schema,
> >   we can enhance it)
> > - reuse current bootloader (and qemu) to load it
> 
> Devicetree is not a universal data structure and communication channel.
> 
> Devicetree is a description of the hardware and also conveys bootloader
> specific information that is need by the kernel to boot.

Yes, I see. But I think there is a room to contain a small communication
channel under /chosen, from bootloader.

> 
> > And we talked about some other ideas to avoid using devicetree.
> > 
> > - expand kernel command line (ascii command strings)
> > - expand kernel command line with base64 encoded comressed ascii command 
> >    strings
> 
> Base64 being one of possibly many ways to convert arbitrary binary data to
> ascii safe data _if_ you want to transfer the ftrace options and commands
> in a binary format.

I actually don't want it :( but if the ascii commands can be compressed
(maybe not so efficient), it is a possible way. 

> > - load (compressed) ascii command strings to somewhere on memory and pass
> >    the address via kernel cmdline
> 
> Similar to the way initrd is handled, if I understand correctly.  (I am not
> up to date on how initrd location is passed to the kernel for a non-devicetree
> kernel.)

Initrd is not passed via kernel cmdline, it is loaded and passed via architecture
dependent way. As far as I know, x86 and arm (without DT) uses own data structure,
arm64 (and arm with DT) uses devicetree /chosen node.

> Compressed or not compressed would be an ftrace design choice.
> 
> 
> > - load (compressed) ascii command strings to somewhere on memory and pass
> >    the address via /chosen node (as same as initrd)
> 
> Compressed or not compressed would be an ftrace design choice.
> 

Yes, it is optional.

> 
> > - load binary C data and point it from kernel cmdline
> > - load binary C data and point it from /chosen node (as same as initrd)
> > - load binary C data as a section of kernel image
> 
> For the three options above:
> 
> Binary data if ftrace prefers structured data.
> A list of strings if ftrace wants to use the existing kernel command line
> syntax.

Yes, any data which doesn't need complex parser is OK.

> 
> For the third of the above three options, the linker would provide the start
> and end address of the ftrace options and commands section.

But that means we need to fill the data structure when we build the kernel,
isn't it?

> > The first 2 ideas expand the kernel's cmdline to pass some "magic" command
> > to setup ftrace. In both case, the problems are the maximal size of cmdline
> > and the issues related to the complexity of commands.
> 
> Not a "magic" command.  Either continue using the existing ftrace syntax or
> add something like: ftrace_cmd="whatever format ftrace desires".
> 
> Why can the maximum size of the cmdline not be increased?

We can, but we also has to change bootloaders.

> > My example showed that the ftrace settings becomes long even if making one
> > histogram, which can be longer than 256 bytes. The long and complex data
> > can easily lead mis-typing, but cmdline has no syntax validator, it just
> > ignores the mis-typed commands.
> 
> Hand typing a kernel command line is already not a fun exercise, even
> before adding ftrace commands.  If you are hand typing kernel command
> lines then I suggest you improve your tools (eg bootloader or whatever
> is not allowing you to edit and store command lines).

Indeed, if we extend kernel cmdline to support it, such tool we have to
introduce (like dtc)

> > (Of course even with the devicetree, it must be smaller than 2 pages)
> > 
> > Next 2 ideas are similar, but load the commands on some other memory area
> > and pass only address via cmdline. This solves the size limitation issue,
> > but still no syntax validation. Of course we can make a new structured
> > syntax validator similar to (or just forked from) dt-validate.
> > The problem (or disadvantage) of these (and following) ideas, is to change
> > the kernel and boot loaders to load another binary blobs on memory.
> > 
> > Maybe if we introduce a generic structured kernel boot arguments, which is
> > a kind of /chosen node of devicetree. (But if there is already such hook,
> > why we make another one...?)
> 
> I got lost in the next sentence, so for my benefit:
> GSKBA == generic structured kernel boot arguments

Oh, sorry, that's my bad.

> > Also, this "GSKBA" may introduce a parser and access APIs which will be
> > very similar to OF-APIs. This also seems redundant to me.
>  
> 
> > So the last 3 ideas will avoid introducing new parser and APIs, we just
> > compile the data as C data and point it from cmdline or somewhere else.
> 
> Or if in a kernel data section then the linker can provide the begin and
> end address of the blob.  This is already implemented for some other data
> structures.

Yeah, but does that mean we have to rebuild kernel image?
In some cases, (e.g. debugging distro kernel) we can not modify kernel image
also, I don't like to replace entire image. I would like to choose a tracing
command file from boot loader.

> > With these ideas, we still need to expand boot loaders to support
> > loading new binary blobs. (And the last one requires to add elf header
> > parser/modifier to boot loader too)
> 
> Why would the boot loader need to access the elf header?  The linker
> can provide the location of the new kernel data section via kernel
> variables.

Oh, I thought you meant that the new data was added boot time by
boot loader.

> >>From the above reasons, I think using devicetree's /chosen node is 
> > the least intrusive way to introduce this boot-time tracing feature.
> 
> This is still mis-use of the devicetree data structure.  This data
> does not belong in the devicetree.

I think if the boot loader supports overlay file, we can choose
the overlay file when booting for /chosen node. That can be a
part of boot loader choice, isn't it? :)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
