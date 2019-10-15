Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02283C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BEE20663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XODjQi2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfJOToC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:44:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37991 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfJOToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:44:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id s6so7779766ywe.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwF3UovUJQM4lIZOxzxPbkJHR0pkb72kpecDlmrnReI=;
        b=XODjQi2tQm5hqkLwP+VbgANGcu6RvgWN8kN+xHLxAjnkj3s25skyfNejbMoU92LZno
         YAxE1QgQ5Drh3afgV3gqCh0auh8qm+A9r0gtfi8D8Xm/sI+2cfswt4hT/7/jtY48ce3O
         jJdiOwkHBPpKUfFL/dvKORFBPQoFmi/X1YgX8voScl9VAX8MjLEeVf2HEsAfoOagTyCc
         G8X9C9fGtsiTdhm3gG9ZFbfVyfTdAnHlIuys8P7iP0ifA4O3e2xYB/aKaEb+Q2wHcMCN
         HLxNwzCSzxlZHBZqL3XypTJen0jjEutErT9R+RAAVps4owtcMl6Wn7IuiAciPPZYeD6p
         HwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwF3UovUJQM4lIZOxzxPbkJHR0pkb72kpecDlmrnReI=;
        b=bQMxVOEUqfeddfPAIMKzkX6bOnnyFbxphcnHhl0EdXvJDg1Y4NO3JrzKPnAiiXuVx3
         dwffpAkr8VtdAyPVBl+W19SvC+slYn9etyswaKBeUagHhRMr0g9mlr/0tFOJeWgZ5JbY
         e5IkrjI3bTuTaIrjvdqEkFIILFMYXQmbDYaIk/k9iLjGgYoqHM6VCPImvRyD2EB7TQ4V
         VzPf5EuIPVUj8t40daiPCFEeDhmpcx1w717+3xm/fk3yip3PEDla6UTiX8mNfrugQ/V6
         NMS5XrVB6b9QfMVlZo+TriUo2VSFLdP2cLi4hFWDUPnjZHdQRaMstXAdL0rHlw/ksmP4
         fl3A==
X-Gm-Message-State: APjAAAXk9N+X+qfdE1A9lAw4KiElz3AlIxOyTBtMvrU0HptGO7aA24d3
        xsClvrB+UXO8dAlr56m8do3TCfWa41iv/kaDyykVA990
X-Google-Smtp-Source: APXvYqxg/ocWm0Vdt6TA/rSb3L5qnhnb+zg1qq/R2n7id6WlidlESVt5rWqPACBSRFtFQeGLeboCSpx9jA9o07ZPxD0=
X-Received: by 2002:a81:74d4:: with SMTP id p203mr17581738ywc.234.1571168641550;
 Tue, 15 Oct 2019 12:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-21-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-21-bigeasy@linutronix.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 15 Oct 2019 12:43:49 -0700
Message-ID: <CAMo8BfJRN3D4+UW-9FQd7JBJuszRPT5whNXoPuWjdofvzF=NsQ@mail.gmail.com>
Subject: Re: [PATCH 20/34] xtensa: Use CONFIG_PREEMPTION
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:18 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
>
> Switch the entry code over to use CONFIG_PREEMPTION. Add PREEMPT_RT
> output to die().
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +traps.c]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/xtensa/kernel/entry.S | 2 +-
>  arch/xtensa/kernel/traps.c | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
