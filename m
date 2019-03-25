Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AECC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68AE20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfCYXfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCYXfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:35:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FD0207DD;
        Mon, 25 Mar 2019 23:35:52 +0000 (UTC)
Date:   Mon, 25 Mar 2019 19:35:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 20/27] x86/mmiotrace: Lock down the testmmiotrace module
Message-ID: <20190325193550.00cbbff6@oasis.local.home>
In-Reply-To: <20190325220954.29054-21-matthewgarrett@google.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
        <20190325220954.29054-21-matthewgarrett@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 15:09:47 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> The testmmiotrace module shouldn't be permitted when the kernel is locked
> down as it can be used to arbitrarily read and write MMIO space.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Howells <dhowells@redhat.com
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: "H. Peter Anvin" <hpa@zytor.com>
> cc: x86@kernel.org
> Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
> ---
>  arch/x86/mm/testmmiotrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
> index f6ae6830b341..bbaad357f5d7 100644
> --- a/arch/x86/mm/testmmiotrace.c
> +++ b/arch/x86/mm/testmmiotrace.c
> @@ -115,6 +115,9 @@ static int __init init(void)
>  {
>  	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
>  
> +	if (kernel_is_locked_down("MMIO trace testing"))
> +		return -EPERM;

I wonder if we should take this one step further. As this module is
really just for testing the mmiotracer (and really shouldn't be enabled
by anyone that doesn't know what it's for), why not just add to the Kconfig file

CONFIG_MMIOTRACE_TEST depend on !CONFIG_LOCK_DOWN_KERNEL ?

-- Steve

> +
>  	if (mmio_address == 0) {
>  		pr_err("you have to use the module argument
> mmio_address.\n"); pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY
> KNOW WHAT YOU ARE DOING!\n");

