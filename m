Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E0C33CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFA82072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgAGVIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:08:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37159 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729389AbgAGVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:35 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007L7OUj026037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:07:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BA95E4207DF; Tue,  7 Jan 2020 16:07:24 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:07:24 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qian Cai <cai@lca.pw>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
        dan.j.williams@intel.com, peterz@infradead.org, longman@redhat.com,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
Message-ID: <20200107210724.GN3619@mit.edu>
References: <1573679785-21068-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573679785-21068-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:16:25PM -0500, Qian Cai wrote:
> From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> 
> Sergey didn't like the locking order,
> 
> uart_port->lock  ->  tty_port->lock
> 
> uart_write (uart_port->lock)
>   __uart_start
>     pl011_start_tx
>       pl011_tx_chars
>         uart_write_wakeup
>           tty_port_tty_wakeup
>             tty_port_default
>               tty_port_tty_get (tty_port->lock)
> 
> but those code is so old, and I have no clue how to de-couple it after
> checking other locks in the splat. There is an onging effort to make all
> printk() as deferred, so until that happens, workaround it for now as a
> short-term fix.

Applied, thanks.

					- Ted
