Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1368C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA1420863
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561438812;
	bh=aB5r1ZagktSRmLc89A+Xb2Jth9eFmW+RiLkyQLLqbGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T8KVnzlFaNuOnQbxXQPBrUCbKbmcF1qsaNQC6FjIk7Tn4lTxLM/PtkTUsOiDET2/+
	 S361L9Tte7d2/j0iFC6dlxxB0GBDwdr8tZIRpx7pmElT+vB5lvnjh9o/gcKpKo2+yK
	 qmXU+y1U9Nr7WrdJ1ZXkeHCFawYsxzJ1iLWgzDmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfFYFAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfFYFAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:00:10 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A644420659;
        Tue, 25 Jun 2019 05:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561438809;
        bh=aB5r1ZagktSRmLc89A+Xb2Jth9eFmW+RiLkyQLLqbGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RGtoeTPMzumtf379vXk/ggzjUgrxyuZLm14CBA2BnvoaW0xQjSIuDEF9Lpdg1SPbF
         xr5+KebdKFCqNrbn44IZCApBNQdAM4oPbaxN8QN65Of2WQ1TCot820YyXUvCb768ne
         aBXWEA2r2e/1ogrri6+mXy3WMS34NGhyw+kY7lj8=
Date:   Tue, 25 Jun 2019 14:00:04 +0900
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
Message-Id: <20190625140004.a74443238596b297a558a66f@kernel.org>
In-Reply-To: <e5e3f55b-095b-e6fc-8734-d888ba5c87f3@gmail.com>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
        <f0cee7b6-b83b-b74c-82f5-f43e39bd391a@gmail.com>
        <20190624115223.db1e53549a15c6548bfa1fa1@kernel.org>
        <e5e3f55b-095b-e6fc-8734-d888ba5c87f3@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Mon, 24 Jun 2019 15:31:07 -0700
Frank Rowand <frowand.list@gmail.com> wrote:
> >>> Currently, kernel support boot-time tracing using kernel command-line
> >>> parameters. But that is very limited because of limited expressions
> >>> and limited length of command line. Recently, useful features like
> >>> histogram, synthetic events, etc. are being added to ftrace, but it is
> >>> clear that we can not expand command-line options to support these
> >>> features.
> >>
> >> "it is clear that we can not expand command-line options" needs a fuller
> >> explanation.  And maybe further exploration.
> > 
> > Indeed. As an example of tracing settings in the first mail, even for simple
> > use-case,  the trace command is long and complicated. I think it is hard to
> > express that as 1-liner kernel command line. But devicetree looks very good
> > for expressing structured data. That is great and I like it :)
> 
> But you could extend the command line paradigm to meet your needs.

But the kernel command line is a command line. Would you mean encoding the 
structured setting in binary format with base64 and pass it? :(

> >> Devicetree is NOT for configuration information.  This has been discussed
> >> over and over again in mail lists, at various conferences, and was also an
> >> entire session at plumbers a few years ago:
> >>
> >>    https://elinux.org/Device_tree_future#Linux_Plumbers_2016_Device_Tree_Track
> > 
> > Thanks, I'll check that.

I found following discussion in etherpad log, https://elinux.org/Device_tree_plumbers_2016_etherpad
----
If you have data that the kernel does not have a good way to get, that's OK to put into DT.

    Operating points are OK - but should still be structured well.
----

This sounds like if it is structured well, and there are no other way,
we will be able to use DT as a channel.

> >>
> >> There is one part of device tree that does allow non-hardware description,
> >> which is the "chosen" node which is provided to allow communication between
> >> the bootloader and the kernel.
> > 
> > Ah, "chosen" will be suit for me :)
> 
> No.  This is not communicating boot loader information.

Hmm, it's a kind of communication with the operator of the boot loader, since there
is an admin or developer behind it. I think the comminication is to communicate
with that human. Then if they intend to trace boot process, that is a kind of
communication.

[...]
> >>> - Can we use devicetree for configuring kernel dynamically?
> >>
> >> No.  Sorry.
> >>
> >> My understanding of this proposal is that it is intended to better
> >> support boot time kernel and driver debugging.  As an alternate
> >> implementation, could you compile the ftrace configuration information
> >> directly into a kernel data structure?  It seems like it would not be
> >> very difficult to populate the data structure data via a few macros.
> > 
> > No, that is not what I intended. My intention was to trace boot up
> > process "without recompiling kernel", but with a structured data.
> 
> That is debugging.  Or if you want to be pedantic, a complex performance
> measurement of the boot process (more than holding a stopwatch in your
> hand).

Yeah, that's right.

> Recompiling a single object file (containing the ftrace command data)
> and re-linking the kernel is not a big price in that context).

No, if I can use DT, I can choose one of them while boot up.
That will be a big difference.
(Of course for that purpose, I should work on boot loader to support
DT overlay)

>  Or if
> you create a new communication channel, you will have the cost of
> creating that data object (certainly not much different than compiling
> a devicetree) and have the bootloader provide the ftrace data object
> to the kernel.

Yes, and for me, that sounds like just a reinvention of the wheel.
If I can reuse devicetree infrastructure, it is easily done (as I
implemented in this series. It's just about 500LOC (and YAML document)

I can clone drivers/of/ code only for that new communication channel,
but that makes no one happy. :(

> > For such purpose, we have to implement a tool to parse and pack the
> > data and a channel to load it at earlier stage in bootloader. And
> > those are already done by devicetree. Thus I thought I could get a
> > piggyback on devicetree.
> 
> Devicetree is not the universal dumping ground for communicating
> information to a booting kernel.  Please create another communication
> channel.

Why should we so limit the availability of even a small corner of existing
open source software...?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
