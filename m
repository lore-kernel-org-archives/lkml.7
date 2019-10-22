Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4CECA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E9C214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IjCNGVD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfJVPGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:06:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11144 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfJVPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:06:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46yGzZ3WYzz9txrJ;
        Tue, 22 Oct 2019 17:06:02 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IjCNGVD/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Jh8cJZ18iESD; Tue, 22 Oct 2019 17:06:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46yGzZ0Wppz9txrG;
        Tue, 22 Oct 2019 17:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1571756762; bh=ZTTwSzcfyFlbzpNpRSH3QAO6LqI52zwrKBYTswAtHNM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=IjCNGVD/m+/3chtJGoKPuCqnoE/qjdU6NrH1x41xizbG/AhCOYIRQB+QO5vlsJ7/2
         wqzZ2eWImxNZQ/T4BDEEKb61YVt/OeI3FXDBrXiajTMpFSqXvckl1n+kYp1ejLLCul
         xWiNhXxkahj2A8m2aG1TrGbwz8FSVKfdFtjxUDFc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 80D6D8B93A;
        Tue, 22 Oct 2019 17:06:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JxnfEccYQSsS; Tue, 22 Oct 2019 17:06:03 +0200 (CEST)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAC5A8B931;
        Tue, 22 Oct 2019 17:06:02 +0200 (CEST)
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e50640a4-bf6b-9859-2acf-81f4af9c6409@c-s.fr>
Date:   Tue, 22 Oct 2019 15:06:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2019 12:52 PM, Rasmus Villemoes wrote:
> There have been several attempts in the past few years to allow
> building the QUICC engine drivers for platforms other than PPC. This
> is (the beginning of) yet another attempt. I hope I can get someone to
> pick up these relatively trivial patches (I _think_ they shouldn't
> change functionality at all), and then I'll continue slowly working
> towards removing the PPC32 dependency for CONFIG_QUICC_ENGINE.
> 
> Tested on an MPC8309-derived board.
> 
> Rasmus Villemoes (7):
>    soc: fsl: qe: remove space-before-tab
>    soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
>    soc: fsl: qe: avoid ppc-specific io accessors
>    soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
>    serial: make SERIAL_QE depend on PPC32
>    serial: ucc_uart.c: explicitly include asm/cpm.h
>    soc/fsl/qe/qe.h: remove include of asm/cpm.h

Please copy the entire series to linuxppc-dev list. We are missing 5/7 
and 7/7 (see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=137048)

Christophe

> 
>   drivers/soc/fsl/qe/gpio.c     | 30 ++++++++--------
>   drivers/soc/fsl/qe/qe.c       | 44 +++++++++++------------
>   drivers/soc/fsl/qe/qe_ic.c    |  8 ++---
>   drivers/soc/fsl/qe/qe_ic.h    |  2 +-
>   drivers/soc/fsl/qe/qe_io.c    | 40 ++++++++++-----------
>   drivers/soc/fsl/qe/qe_tdm.c   |  8 ++---
>   drivers/soc/fsl/qe/ucc.c      | 12 +++----
>   drivers/soc/fsl/qe/ucc_fast.c | 66 ++++++++++++++++++-----------------
>   drivers/soc/fsl/qe/ucc_slow.c | 38 ++++++++++----------
>   drivers/soc/fsl/qe/usb.c      |  2 +-
>   drivers/tty/serial/Kconfig    |  1 +
>   drivers/tty/serial/ucc_uart.c |  1 +
>   include/soc/fsl/qe/qe.h       |  1 -
>   13 files changed, 126 insertions(+), 127 deletions(-)
> 
