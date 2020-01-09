Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0047C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10F520721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgAIUz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:55:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55671 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIUz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:55:58 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipeqO-00088L-9V; Thu, 09 Jan 2020 21:55:52 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C1ABF105BCE; Thu,  9 Jan 2020 21:55:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] x86/nmi: remove the irqwork from long duration nmi handler
In-Reply-To: <20200101072017.82990-1-changbin.du@gmail.com>
References: <20200101072017.82990-1-changbin.du@gmail.com>
Date:   Thu, 09 Jan 2020 21:55:51 +0100
Message-ID: <877e20bb8o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changbin Du <changbin.du@gmail.com> writes:

> First, printk is NMI context safe now since the safe printk has been
> implemented. The safe printk already has an irqwork to make NMI context
> safe.
>
> Second, the NMI irqwork actually does not work if a NMI handler causes
> panic by watchdog timeout. This NMI irqwork have no chance to run in such
> case, while the safe printk will flush its per-cpu buffer before panic.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Looks about right.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
