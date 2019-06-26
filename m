Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9E0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75834214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561586346;
	bh=dp3wSsPNYah0quSfVuxFUWJYCawQNw3wrHk37cc0CCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uxUyUAiTT/F0aNUtHMkNqjErxy4IDfEu1UCmrsDCVth3qDF2i6IYVfi5Iau6wDjRK
	 UdEMorbNuYCotGAgZXfkvF523WCNwXWReDh8I/1cTBRLFjceJmxCZWXh4AoU5DVBBk
	 +VuennEX6zLz8UvExNEJ5dVk72JSwqgSI18oO0pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFZV7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfFZV7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:59:04 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A555221743;
        Wed, 26 Jun 2019 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561586343;
        bh=dp3wSsPNYah0quSfVuxFUWJYCawQNw3wrHk37cc0CCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QlRu2S4GcDicDAUHvW8Ndm1sD/BnM/FPYr0MPJZMarYL6aDAnEnluttBu1crIOsAo
         f1HvVyY+iRLJO80XuK8Vgt65SuXS0mersjGCOS9vqSK6+F0QyBE1VlbjIOMaPAUGPj
         uMtQC0vPqTLPFsGhF1/ArzSWy0+OfVyQDwip7T/w=
Received: by mail-qk1-f172.google.com with SMTP id l128so39018qke.2;
        Wed, 26 Jun 2019 14:59:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUbnrgGsRH3sAz+kvnZ7/Po+WSOu+9jgDWCIocZZL6I3mA6fycA
        l+O67UDZd63r010yuNHQwA0aA7XY5CexGv65ng==
X-Google-Smtp-Source: APXvYqxuinlLaUR/0xCYGvj5qXU4IVL5IKudGzHnRidM4al+AE+ur52RvUa1X1QjoOtwwoQuds1mokcgTUI/Rz4zSlI=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr316379qkl.254.1561586342888;
 Wed, 26 Jun 2019 14:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 15:58:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
Message-ID: <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using devicetree
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is an RFC series of patches to add boot-time tracing using
> devicetree.
>
> Currently, kernel support boot-time tracing using kernel command-line
> parameters. But that is very limited because of limited expressions
> and limited length of command line. Recently, useful features like
> histogram, synthetic events, etc. are being added to ftrace, but it is
> clear that we can not expand command-line options to support these
> features.
>
> Hoever, I've found that there is a devicetree which can pass more
> structured commands to kernel at boot time :) The devicetree is usually
> used for dscribing hardware configuration, but I think we can expand it
> for software configuration too (e.g. AOSP and OPTEE already introduced
> firmware node.) Also, grub and qemu already supports loading devicetree,
> so we can use it not only on embedded devices but also on x86 PC too.

Do the x86 versions of grub, qemu, EFI, any other bootloader actually
enable DT support? I didn't think so. Certainly, an x86 kernel doesn't
normally (other than OLPC and ce4100) have a defined way to even pass
a dtb from the bootloader to the kernel and the kernel doesn't
unflatten the dtb.

For arm64, the bootloader to kernel interface is DT even for ACPI
based systems. So unlike Frank, I'm not completely against DT being
the interface, but it's hardly universal across architectures and
something like this should be. Neither making DT the universal kernel
boot interface nor creating some new channel as Frank suggested seems
like an easy task.

Rob
