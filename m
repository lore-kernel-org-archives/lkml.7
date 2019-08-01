Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E218206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0PZ0IO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfHASbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:31:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56145 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHASbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:31:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so65565881wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlnpmyLSEDXofwtUHY0TCoG8n9WANqFQy4n4jP4iwOk=;
        b=k0PZ0IO72yUg4k17Yh2tKUXJ82Go1f1V0lPZjaremQlb2ZqbRbXF3clvOgBh/8KGBf
         ObyUmnxb7qqi/EJglERLo59dNsfd+gSvbRpDH/HwuPiiARq6tYttidptXccLw8suwB3l
         lkgqpV+5btHEQ/QMM3D4NDKCrD+hRvQFo38dfbPI0VTGDL1Cg0jVIUqFMgRk3oKFN1nU
         M4KL4sFBGHH09UDNPYHHClY7jLL7pmmuuXazXSOUAUJNi4VOxrhETaIIvjOZEgLlSlTq
         CCMo/V2MUTa2ocn9tI16t84YjsN1fazXIEcYaMjHGYjCYhUVk+pO5gkW57LIp7/TNv81
         cZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlnpmyLSEDXofwtUHY0TCoG8n9WANqFQy4n4jP4iwOk=;
        b=Rl9gNs4jDrCAq4DWHJITLu8Yt2GCn6k/ef1JeE9smXaTvAPEi37zKuOFEbOwe+4ICm
         bw/cC8prrIa9iftMkPBNNCl+HqW2gYAAICdODLoc2RN2JYch5riRmwbUolyXQyEALtwN
         C+tupui+dqLMM9DOaFatt3ZC/kHYLXRabnAZ+JRxCwF//NCIq/SIoLtWROp93kgNXERM
         Rnv03LdRbQ4N7XNRE48YRLz/Rpal6oAgIO2mdO0jwmbUV6kzvpprIrUmH5E9pQlfI1ys
         ppmCKeTyOD5pOlSCqxsd5WRHhXNriERsiRlHlnIr9iQTyJS3b7uOWhF98hGxsGzzfeJy
         du8w==
X-Gm-Message-State: APjAAAVY4gK1oNnujv7NOzLqsXMyKjow/d6Qz4IqldFr/X9xmh8O5/gw
        NaBZ8DWTX5bLamx1bJ926LE0d0q7kaykd4itPUx4hg==
X-Google-Smtp-Source: APXvYqwPqdGunmGK0/bbVNRznrDhh8bmyHWqd245e3jVAcoQU/xLwC4BnOfepv/Ojdj8dbz3keQzZLjYnCaS0C5gaGU=
X-Received: by 2002:a7b:c947:: with SMTP id i7mr98999wml.77.1564684301199;
 Thu, 01 Aug 2019 11:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111348.530242235@infradead.org> <20190801111541.685367413@infradead.org>
 <20190801174907.GA16554@cmpxchg.org>
In-Reply-To: <20190801174907.GA16554@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Aug 2019 11:31:30 -0700
Message-ID: <CAJuCfpGQsfQ8QW7_LJzsGgTj6H9r6bV529Mzv-dXCWiv+qjOpw@mail.gmail.com>
Subject: Re: [PATCH 1/5] sched/pci: Reduce psimon FIFO priority
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 10:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Aug 01, 2019 at 01:13:49PM +0200, Peter Zijlstra wrote:
> > PSI defaults to a FIFO-99 thread, reduce this to FIFO-1.
> >
> > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > it not a suitable default; it would indicate the psi work is the
> > most important work on the machine.
> >
> > Since Real-Time tasks will have pre-allocated memory and locked it in
> > place, Real-Time tasks do not care about PSI. All it needs is to be
> > above OTHER.
> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Subject should be s/pci/psi/

Thanks for the patch. Please give me a couple hours for testing to
ensure no regressions before merging it.
