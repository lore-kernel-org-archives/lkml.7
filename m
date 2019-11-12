Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F056C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA3B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573580606;
	bh=xwxtyC0AXj0ksCo8SmNdjblvoZqcxlf8VXMMfMSNIFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wbx1CYsPZMQ9uLLdY8cfZ9QTA1q0cUZHYI6NlJbycxvnzHclOh43p7m4vqgYAhiWa
	 Tnfmx0D9uevw8/2AsS5ju+Dq1DPMhilWfbJ4xg4UE2IPWiWbdkvbkb3OT2vjYZgvzh
	 VPEsv7vXqG6g8m8qJLrhg+mbNnjPt9MBHKZ1Ndzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKLRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfKLRnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:43:25 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60599222C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580604;
        bh=xwxtyC0AXj0ksCo8SmNdjblvoZqcxlf8VXMMfMSNIFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYXd01Csut0FMBhxjI8Pr9vS9FaLHU2s7H09ewvL5b2GJdTza5MAzhWZU+0LAIS0M
         efVYQ0m9CP7asmxVpuEpE/lf4GjPMgDlbw+QIEYJaGPjrUqAalNhcMzXs2QuBluORg
         waAAczd6GGesNyaDtc6nN1NeGQPfKLn1t6Z1njAI=
Received: by mail-wr1-f41.google.com with SMTP id w9so12718933wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:43:24 -0800 (PST)
X-Gm-Message-State: APjAAAVQCGyWanyyhjIef3XjHfSenGNjeEyjIROprVcBK7Ye6Yk0nkms
        krgqRs9yn/7f4f5yZw0FMRm3/9Rad7e1v8zfiWkKgw==
X-Google-Smtp-Source: APXvYqxF8nMeX4jg2o7yQ2IVWo8QTc9SYoxZNBeh7PxlVxrXgCbqSypO9QOFlCXMbDpiI8vIIv8ih/bmEZ2OLloYHQI=
X-Received: by 2002:a5d:640b:: with SMTP id z11mr20907035wru.195.1573580602932;
 Tue, 12 Nov 2019 09:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.509914905@linutronix.de>
In-Reply-To: <20191111223052.509914905@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 09:43:11 -0800
X-Gmail-Original-Message-ID: <CALCETrVggkQ1fstXB3+VKA2otOi9z0JTU0PH-fvfqM-kudNtdQ@mail.gmail.com>
Message-ID: <CALCETrVggkQ1fstXB3+VKA2otOi9z0JTU0PH-fvfqM-kudNtdQ@mail.gmail.com>
Subject: Re: [patch V2 10/16] x86/ioperm: Remove bitmap if all permissions dropped
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> If ioperm() results in a bitmap with all bits set (no permissions to any
> I/O port), then handling that bitmap on context switch and exit to user
> mode is pointless. Drop it.
>
> Move the bitmap exit handling to the ioport code and reuse it for both the
> thread exit path and dropping it. This allows to reuse this code for the
> upcoming iopl() emulation.

Acked-by: Andy Lutomirski <luto@kernel.org>
