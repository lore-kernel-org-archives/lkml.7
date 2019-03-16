Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C5CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112D6218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552762872;
	bh=yPEKZ/ogjKX5/biN/Bau0WOdp5dHwfTZBX0iP0x1HDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WZ7vzpaqUB4/Oo8xAErepk8g7waopwYFdkpMPX4u2YFAYXBlD/AditzXISbRW9hBP
	 Y94zW0+6wEnDDGBFYmgUf7KL5BomBD2hyyF4txwvr2ufsbVzx982XyQ9nkRt22Ksla
	 lBdDkiESeYo3WkBN1Iam/ZH0SaYf6gf+h8URd+Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCPTBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfCPTBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 15:01:10 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A20B218FC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552762869;
        bh=yPEKZ/ogjKX5/biN/Bau0WOdp5dHwfTZBX0iP0x1HDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TyZdF7jCdUeOFZhtv3YLYD4lAdIL8MDDOP7RmsurpOUE6QVOTW4ni2T1G+oztHZQW
         3BILe0ERlLOYVDXzE71ju7e4OJoZfhnMCSwtqS8oSSKzJL9dEMYqYLuKCt4nuY2HqW
         jRmMhIf2XTyW33Mm781YExYHq0CSlrIzpibU0GU0=
Received: by mail-wr1-f44.google.com with SMTP id p1so12833993wrs.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 12:01:09 -0700 (PDT)
X-Gm-Message-State: APjAAAW/5UcANXP/eVI0j4aJZuN1AENCAHV6kJlkzfgeu0xbk+ODmkFX
        ycNWnmaGqArSBTuC5+0ABYUy0p6qWNddHiKtO/YjfA==
X-Google-Smtp-Source: APXvYqyHhnrsKt1T5lm46xsQSqbAbnh+6q1ihQh60d/t7QGXZyCKapzwvxzFLmUJkRQri4X0staolM41EvDi01MQ31I=
X-Received: by 2002:adf:e710:: with SMTP id c16mr6328520wrm.176.1552762867811;
 Sat, 16 Mar 2019 12:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
In-Reply-To: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 16 Mar 2019 12:00:49 -0700
X-Gmail-Original-Message-ID: <CALCETrWY+PsiHJdRFTAXp6yVJQJG0a08UBxrmZ-p=6XdNEZaig@mail.gmail.com>
Message-ID: <CALCETrWY+PsiHJdRFTAXp6yVJQJG0a08UBxrmZ-p=6XdNEZaig@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/CPU: Use correct Cyrix-specific macros
To:     Matthew Whitehead <tedheadster@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 1:46 PM Matthew Whitehead <tedheadster@gmail.com> wrote:
>
> Replace the incorrect Cyrix-specific macro calls with the correct
> setCx86() and getCx86() calls. Also remove the unused setCx86_old(),
> getCx86_old() and their related comments in the code.
>
> Matthew Whitehead (2):
>   x86/CPU: Use correct macros for Cyrix calls on Geode processors
>   x86/CPU: Remove {get,set}Cx86_old macros used for Cyrix processors

This series looks reasonable to me.  Also, Matthew seems to be the
best tester around for this old hardware, so, if he says it works, I
believe him :)  I certainly can't test this stuff.

--Andy
