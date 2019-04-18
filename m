Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA21C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480BD20674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD+KImZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389206AbfDRNwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:52:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:52:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so1158965pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+gTgz05BNx7uub3111l5GhblzcFwSkI+uRnNcEDs17k=;
        b=mD+KImZniWD4bYI1NFXaO1Wa5nLSA6Ov1x8wxJLa5sJKOIP9v/cbNADNq2HlIe2wmq
         7PFQEjWT1aL40LuLMlvCbDJcgFswS5XjVWfNrdnn4FgXvhAMA3ctBouyF4E73HckI6Pr
         ZbtU3V/hwvKnD54yRGtOl1hgYL6EvEnjZYYV0m/qSOu1QhM3l8awneolp8jmqWGaP4Yy
         jQxn1riXGWZjjyk1yKQWaROyxv+FDZ1lqe3sRN4yBQJmQ8/ggNPwmVXHcJdJCBUF/28V
         vry9OZnB575I9lWgEysnfnlZmjn/s7WPV4sPFY2ciUvZFuMsgOGswI4FZQ1ei1UopOiM
         PtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gTgz05BNx7uub3111l5GhblzcFwSkI+uRnNcEDs17k=;
        b=pgxvzl9ttLSeJglXZLqFx8KNrQLFQg8E2tNzaZhYabBWiZiXOWt/58ma1k+JgMDk5H
         MX6x9LtEPgr4SxpwpfHrPT36e2pI3flPv/PjzyBK57OdtloLJAZ2lx7bYBD6ZeL29xg6
         n0caEWdDYrLGflzV/LNfKiLn1LdXyDmYDojSny++zc2UK17Wlom21hxHMCo/P8ABzDMl
         nre4Ttyq2v/IdRVh58qTpnQV9NuoQ0LDQzPhZvsaQ/EasuuaQhTAxitdCpqcWNA/QkD1
         rk7uekFsDoURHOznrn+POTr/gmMSd24WjN9Ow1vYfjX4KER2nFaBt1aJOHWkWyBFTxnN
         FOLg==
X-Gm-Message-State: APjAAAVF9YnmhpIuTQXK1tmPoyM+ZpJMsxQqn+Q6dyPs0JEjjADBUmHl
        KNaPS6EuxXRt8N2tktm6Ick=
X-Google-Smtp-Source: APXvYqyGOoe1lTyOXcw7sopwmqLRtxt5x0K0YeJVDuLTom58kfJffXOkibM8Q28MoE1BezEg6cZYwg==
X-Received: by 2002:a65:4183:: with SMTP id a3mr90874145pgq.121.1555595555965;
        Thu, 18 Apr 2019 06:52:35 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id f71sm5668978pfc.109.2019.04.18.06.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 06:52:35 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 18 Apr 2019 23:50:45 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown
 pointer specifiers
Message-ID: <20190418145045.GC16037@tigerII.localdomain>
References: <20190417115350.20479-1-pmladek@suse.com>
 <20190417115350.20479-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417115350.20479-8-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 13:53), Petr Mladek wrote:
> A reasonable compromise seems to be writing the unknown format specifier
> into the original string with a question mark, for example (%pC?).
> It should be self-explaining enough. Note that it is in brackets
> to follow the (null) style.

Ah, I misunderstood the meaning of the question mark. The question
mark here is not a question, but a `wildcard' symbol which is replacing
a missing or unrecognized symbol.

	-ss
