Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79522C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AE621473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFOOgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 10:36:22 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52171 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 10:36:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45R0Qp6Gd5z1rWTY;
        Sat, 15 Jun 2019 16:36:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45R0Qp5Wgzz1qqkh;
        Sat, 15 Jun 2019 16:36:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id CV3ATwZ73GD7; Sat, 15 Jun 2019 16:36:17 +0200 (CEST)
X-Auth-Info: WeiuE3FkP22bpwRZXiPgSc5kxd0EGyhb2xJKE3Lx5DsQLNHL9KEEXkKT6N7vRlPZ
Received: from igel.home (ppp-46-244-181-62.dynamic.mnet-online.de [46.244.181.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 15 Jun 2019 16:36:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 98FE02C0C9A; Sat, 15 Jun 2019 16:36:15 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/32s: only use MMU to mark initmem NX if STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
        <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
        <8736kb9fry.fsf_-_@igel.home>
        <20190615152559.Horde.0lTFIZALxZ-RI75z94G3jA8@messagerie.si.c-s.fr>
X-Yow:  I'm using my X-RAY VISION to obtain a rare glimpse of the
 INNER WORKINGS of this POTATO!!
Date:   Sat, 15 Jun 2019 16:36:15 +0200
In-Reply-To: <20190615152559.Horde.0lTFIZALxZ-RI75z94G3jA8@messagerie.si.c-s.fr>
        (Christophe Leroy's message of "Sat, 15 Jun 2019 15:25:59 +0200")
Message-ID: <87pnne9aqo.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Andreas Schwab <schwab@linux-m68k.org> a écrit :
>
>> If STRICT_KERNEL_RWX is disabled, never use the MMU to mark initmen
>> nonexecutable.
>
> I dont understand, can you elaborate ?

It breaks suspend.

> This area is mapped with BATs so using change_page_attr() is pointless.

There must be a reason STRICT_KERNEL_RWX is not available with
HIBERNATE.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
