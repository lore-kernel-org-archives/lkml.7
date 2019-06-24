Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3AFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5325820820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561344750;
	bh=VkbMuwCphYI8uGxaBCG//nLfz474AdAA5lslPezgjig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ArzmqDymvh138CF8PYBAd6ToR+oRo1Jdh6Pk3h8rsc8CpWK8CjQ1wcJ1ATClyv8XN
	 5wUoBHUtsMoj9nYDBBNelW3ADoDTzCv4O7q6ZfgND5DsbzT+CkcX+GA1sbDammFFUJ
	 6U9XUtFEqj3gcENDPh6NYLsNKwQAwnoAKLHHYyrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfFXCw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXCw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:52:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710092073F;
        Mon, 24 Jun 2019 02:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561344747;
        bh=VkbMuwCphYI8uGxaBCG//nLfz474AdAA5lslPezgjig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LpVN7Q7fNPad8f+qFoOFbk6qmlnDc8XgshQ0IbiMqwpFxfk2BQkXR1L6FyLOW1uvQ
         h8pr/r6CcHfCjsNLufOFWevv/W+ax1IGs3P2tn9jhZ1FlEc3MFyvkG8qrwTXFPhJjA
         swCA6fHeB8ywCohpHL6HoL58bNdtN/tmKWfUwjmM=
Date:   Mon, 24 Jun 2019 11:52:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using
 devicetree
Message-Id: <20190624115223.db1e53549a15c6548bfa1fa1@kernel.org>
In-Reply-To: <f0cee7b6-b83b-b74c-82f5-f43e39bd391a@gmail.com>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
        <f0cee7b6-b83b-b74c-82f5-f43e39bd391a@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Thank you for your comment!

On Sun, 23 Jun 2019 12:58:45 -0700
Frank Rowand <frowand.list@gmail.com> wrote:

> Hi Masami,
> 
> On 6/21/19 9:18 AM, Masami Hiramatsu wrote:
> > Hi,
> > 
> > Here is an RFC series of patches to add boot-time tracing using
> > devicetree.
> > 
> > Currently, kernel support boot-time tracing using kernel command-line
> > parameters. But that is very limited because of limited expressions
> > and limited length of command line. Recently, useful features like
> > histogram, synthetic events, etc. are being added to ftrace, but it is
> > clear that we can not expand command-line options to support these
> > features.
> 
> "it is clear that we can not expand command-line options" needs a fuller
> explanation.  And maybe further exploration.

Indeed. As an example of tracing settings in the first mail, even for simple
use-case,  the trace command is long and complicated. I think it is hard to
express that as 1-liner kernel command line. But devicetree looks very good
for expressing structured data. That is great and I like it :)

> > 
> > Hoever, I've found that there is a devicetree which can pass more
> > structured commands to kernel at boot time :) The devicetree is usually
> > used for dscribing hardware configuration, but I think we can expand it
> 
> Devicetree is standardized and documented as hardware description.

Yes, at this moment. Can't we talk about some future things?

> > for software configuration too (e.g. AOSP and OPTEE already introduced
> > firmware node.) Also, grub and qemu already supports loading devicetree,
> > so we can use it not only on embedded devices but also on x86 PC too.
> 
> Devicetree is NOT for configuration information.  This has been discussed
> over and over again in mail lists, at various conferences, and was also an
> entire session at plumbers a few years ago:
> 
>    https://elinux.org/Device_tree_future#Linux_Plumbers_2016_Device_Tree_Track

Thanks, I'll check that.

> 
> There is one part of device tree that does allow non-hardware description,
> which is the "chosen" node which is provided to allow communication between
> the bootloader and the kernel.

Ah, "chosen" will be suit for me :)

> There clearly are many use cases for providing configuration information
> and other types of data to a booting kernel.  I have been encouraging
> people to come up with an additional boot time communication channel or
> data object to support this use case.  So far, no serious proposal that
> I am aware of.

Hmm, then, can we add "ftrace" node under "chosen" node?
It seems that "chosen" is supporting some (flat) properties, and I would
like to add a tree of nodes for describing per-event setting.

What about something like below? (do we need "compatible" ?)

chosen {
	linux,ftrace {
		tp-printk;
		buffer-size-kb = <400>;
		event0 {
			event = "...";
		};
	};
};

[..]
> > 
> > I would like to discuss on some points about this idea.
> > 
> > - Can we use devicetree for configuring kernel dynamically?
> 
> No.  Sorry.
> 
> My understanding of this proposal is that it is intended to better
> support boot time kernel and driver debugging.  As an alternate
> implementation, could you compile the ftrace configuration information
> directly into a kernel data structure?  It seems like it would not be
> very difficult to populate the data structure data via a few macros.

No, that is not what I intended. My intention was to trace boot up
process "without recompiling kernel", but with a structured data.

For such purpose, we have to implement a tool to parse and pack the
data and a channel to load it at earlier stage in bootloader. And
those are already done by devicetree. Thus I thought I could get a
piggyback on devicetree.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
