Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699CC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE642086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561633107;
	bh=eqIMm2IvCi/2kqSke0jwsbTzK/3H02BMhTr01hNqdt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZOITUfqYUa2eRVCje1IiT1h1qjpBrz0Wui48dK3DMfFVLnpVWEZxhE783oTdoKXA3
	 ToH+EYhBnPXQVqBBmAHE6Yq2ASE1hmSbf/sNwJQN9yLo2L1VaHm9yXi1fXr5uEQEJg
	 7eZ/yxc3mdofaAezQktGb/jbf7DDb8YfXkz4O0mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfF0K60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0K6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:58:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4F32085A;
        Thu, 27 Jun 2019 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561633104;
        bh=eqIMm2IvCi/2kqSke0jwsbTzK/3H02BMhTr01hNqdt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iauW/gb5jLquigQ+Cdzh/i9Pn3zW17VkPlONdHo7xFd7dA32bVmDJ/Yyb0bkTe8EG
         kIrY8RkURU97+7yoOa31J72E27OcFr0fIRUwyB35ALlHqV0dmT8JKXqUb21IVMoo+X
         l5U9Ro8xIQgWHOpJmZaP0lAAll1CxzuY2yED7AZg=
Date:   Thu, 27 Jun 2019 19:58:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20190627195817.211ab4bea422f37e539e47e8@kernel.org>
In-Reply-To: <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
        <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 26 Jun 2019 15:58:50 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Fri, Jun 21, 2019 at 10:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
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
> >
> > Hoever, I've found that there is a devicetree which can pass more
> > structured commands to kernel at boot time :) The devicetree is usually
> > used for dscribing hardware configuration, but I think we can expand it
> > for software configuration too (e.g. AOSP and OPTEE already introduced
> > firmware node.) Also, grub and qemu already supports loading devicetree,
> > so we can use it not only on embedded devices but also on x86 PC too.
> 
> Do the x86 versions of grub, qemu, EFI, any other bootloader actually
> enable DT support? I didn't think so. Certainly, an x86 kernel doesn't
> normally (other than OLPC and ce4100) have a defined way to even pass
> a dtb from the bootloader to the kernel and the kernel doesn't
> unflatten the dtb.

Sorry, the grub part, I just found this entry. I need to check this
can work on x86 too.

https://www.gnu.org/software/grub/manual/grub/html_node/devicetree.html

Anyway, I've tested this series on qemu-x86 with --dtb option.
The kernel boot with ACPI and DT (hardware drivers seem initialized
by ACPI), and it seems unflatten the dtb correctly.

> 
> For arm64, the bootloader to kernel interface is DT even for ACPI
> based systems. So unlike Frank, I'm not completely against DT being
> the interface, but it's hardly universal across architectures and
> something like this should be. Neither making DT the universal kernel
> boot interface nor creating some new channel as Frank suggested seems
> like an easy task.

I don't want it making this for all architectures but an option for
architecutres which supports DT already...

Thank you,


> 
> Rob


-- 
Masami Hiramatsu <mhiramat@kernel.org>
