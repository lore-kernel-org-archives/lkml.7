Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B6C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FB0217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555458262;
	bh=Wf7WkiQZakeytxYJuMHvwwg2Yc/Lpphvo4HISt9o4zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DO9O+Szyhp/6hpEqjFg7ezGrHdUjZH+LIYwyF9LoRa+48+JZq4pkwockneBcnS1vY
	 hboWiAluseGTUbB4Yr7ap9sRlB8kqJ1CyN0dbSThTmWLBTY4eSFpSaAqlTpvsm+XM/
	 N0esurmBiwVJiosypllZ2dQlhR9FZu6kxs9LkqzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfDPXoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:44:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:44:20 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EDA425A;
        Tue, 16 Apr 2019 23:44:19 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:44:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
Subject: Re: [PATCH] init: Initialize jump labels before command line option
 parsing
Message-Id: <20190416164418.3ca1d8cef2713a1154067291@linux-foundation.org>
In-Reply-To: <155544804466.1032396.13418949511615676665.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155544804466.1032396.13418949511615676665.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 13:54:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> When a module option, or core kernel argument, toggles a static-key it
> requires jump labels to be initialized early. While x86, PowerPC, and
> ARM64 arrange for jump_label_init() to be called before parse_args(),
> ARM does not.
> 
>   Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1 console=ttyAMA0,115200 page_alloc.shuffle=1
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
>   page_alloc_shuffle+0x12c/0x1ac
>   static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
>   before call to jump_label_init()
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted
>   5.1.0-rc4-next-20190410-00003-g3367c36ce744 #1
>   Hardware name: ARM Integrator/CP (Device Tree)
>   [<c0011c68>] (unwind_backtrace) from [<c000ec48>] (show_stack+0x10/0x18)
>   [<c000ec48>] (show_stack) from [<c07e9710>] (dump_stack+0x18/0x24)
>   [<c07e9710>] (dump_stack) from [<c001bb1c>] (__warn+0xe0/0x108)
>   [<c001bb1c>] (__warn) from [<c001bb88>] (warn_slowpath_fmt+0x44/0x6c)
>   [<c001bb88>] (warn_slowpath_fmt) from [<c0b0c4a8>]
>   (page_alloc_shuffle+0x12c/0x1ac)
>   [<c0b0c4a8>] (page_alloc_shuffle) from [<c0b0c550>] (shuffle_store+0x28/0x48)
>   [<c0b0c550>] (shuffle_store) from [<c003e6a0>] (parse_args+0x1f4/0x350)
>   [<c003e6a0>] (parse_args) from [<c0ac3c00>] (start_kernel+0x1c0/0x488)
> 
> Move the fallback call to jump_label_init() to occur before
> parse_args(). The redundant calls to jump_label_init() in other archs
> are left intact in case they have static key toggling use cases that are
> even earlier than option parsing.

Has it been confirmed that this fixes
mm-shuffle-initial-free-memory-to-improve-memory-side-cache-utilization.patch
on beaglebone-black?

