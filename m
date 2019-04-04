Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53AFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EDC20674
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/YNUu1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfDDIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:31:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39574 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDDIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:31:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so1295657ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JW+kUaU0T3wMsVavz10Dn9m72dQQtgXgjTBSP4gmbA=;
        b=H/YNUu1otWttlXYVufQRI/VGFyRNQSHuLGwDH+48SdrK6cIiNUf1KWRWSETDMjMlJ1
         a9MknVTgNaiSYk9evRmjUynsfGcpEYWR+MM+ZHsQsZ6IWtAdRJSFxrqaGfgEysOzjAjP
         YNLr2t++AtxOcYqMwE/DJXDT/tmcOXoOQ8uBwkiU70tGskmO5jxmlBU5gpXN5NQ/z+kM
         H9NqVnVfyHFt4pkU433Bdxe9l75XzU1vxT7XRQA5/B8fFaP21OJeZiXiBvG227huaRtB
         B7ubnTVPobmEWL/TJ2Q+uvYgIXR3oEuoIvsZwbUeqzHr4mrO7C5n2ld2kKYL2B/r9E9F
         tvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JW+kUaU0T3wMsVavz10Dn9m72dQQtgXgjTBSP4gmbA=;
        b=ombeP1LtfMDGz21JrUBkFmghopqI6Ts9/mzmfcismojQttRBrMHIXdmRuY9iiDfMOo
         hqB63jrdJlL3fcuq6njl6Oa0O+S8hV4+ASMIslmRhmy8N/Y99H0WdF9ukY0I5IXYc+vm
         rY/YnI0yQt0sPuCpn2F23wx7vP5NRQh6C8AmyU45nU4FkTg26PpKsM96KoY82RE/DlRm
         Hc5PQLPWeqCiL6S7OVJhzW9tAlgDaHEblHo9rK1NL5QiHhUjuMDsxTrhIaElHXMWF5bh
         HuDNGhbRZ03s2PcWWmgNCxxfrdf3dhXJ9wjyiCWrCNHHrRaOAd2wBplXv9OYfrQ/X+dc
         t1NA==
X-Gm-Message-State: APjAAAULSYTviluRH4ubPNYpiIZQdFw8CyBabQ4eN5CEZSsrhWmE/w8f
        tLCWO0SAkjQADfnv4XfSL5nhyWf1GKV+dNjB6w7sHw==
X-Google-Smtp-Source: APXvYqydKogtETT4wtX8s1/D+eoHQWfKdyUTxpmtxSN1HIJwmT18V5OG3e/Ar/g6U+K871e4TfkYhsaLb1ckRt4pf2Y=
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr2606675ljj.128.1554366706566;
 Thu, 04 Apr 2019 01:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <20190218173514.796920915@infradead.org>
 <d7a408c0-b86a-da56-5440-d7cb380708c6@arm.com> <20190221164146.GV32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190221164146.GV32494@hirez.programming.kicks-ass.net>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 4 Apr 2019 16:31:35 +0800
Message-ID: <CAERHkrv1W4vC9h1g1iifcdLeMAHar3KiHS=hP=Y2iUyM2wswhg@mail.gmail.com>
Subject: Re: [RFC][PATCH 15/16] sched: Trivial forced-newidle balancer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 21, 2019 at 04:19:46PM +0000, Valentin Schneider wrote:
> > Hi,
> >
> > On 18/02/2019 16:56, Peter Zijlstra wrote:
> > [...]
> > > +static bool try_steal_cookie(int this, int that)
> > > +{
> > > +   struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
> > > +   struct task_struct *p;
> > > +   unsigned long cookie;
> > > +   bool success = false;
> > > +
> > > +   local_irq_disable();
> > > +   double_rq_lock(dst, src);

Here, should we check dst and src's rq status before lock their rq?
if src is idle, it could be in the progress of load balance already?

Thanks,
-Aubrey

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e3162f..a1e0a6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3861,6 +3861,13 @@ static bool try_steal_cookie(int this, int that)
        unsigned long cookie;
        bool success = false;

+       /*
+        * Don't steal if src is idle or has only one runnable task,
+        * or dst has more than one runnable task
+        */
+       if (src->nr_running <= 1 || unlikely(dst->nr_running >= 1))
+               return false;
+
        local_irq_disable();
        double_rq_lock(dst, src);
