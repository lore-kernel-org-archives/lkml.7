Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E3C47409
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCE4206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgABSLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:11:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgABSLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:11:20 -0500
Received: from [172.58.107.60] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1in4wH-0008Hv-Hu; Thu, 02 Jan 2020 18:11:18 +0000
Date:   Thu, 2 Jan 2020 19:11:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amanieu d'Antras <amanieu@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/7] Fix CLONE_SETTLS with clone3
Message-ID: <20200102181112.rc3vnxxm2erl36ep@wittgenstein>
References: <20200102172413.654385-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200102172413.654385-1-amanieu@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 06:24:06PM +0100, Amanieu d'Antras wrote:
> The clone3 syscall is currently broken when used with CLONE_SETTLS on all
> architectures that don't have an implementation of copy_thread_tls. The old
> copy_thread function handles CLONE_SETTLS by reading the new TLS value from
> pt_regs containing the clone syscall parameters. Since clone3 passes the TLS
> value in clone_args, this results in the TLS register being initialized to a
> garbage value.
> 
> This patch series implements copy_thread_tls on all architectures that currently
> define __ARCH_WANT_SYS_CLONE3 and adds a compile-time check to ensure that any
> architecture that enables clone3 in the future also implements copy_thread_tls.
> 
> I have also included a minor fix for the arm64 uapi headers which caused
> __NR_clone3 to be missing from the exported user headers.
> 
> I have only tested this on arm64, but the copy_thread_tls implementations for
> the various architectures are fairly straightforward.

The series looks straightforward to me but I'd like a few Acks from some
of the arch maintainers before taking this.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
