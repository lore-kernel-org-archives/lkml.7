Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977EC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792E42064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 09:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfit/EM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfGNJwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 05:52:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfGNJwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 05:52:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so12398511wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/SqU2gFVMBbWyLJOkiidaC1t9EiWVorSKt8/qeakt/M=;
        b=pfit/EM7wrr88HzT2SnkIejcUSxurAVRXBuC529YfAeQ7jrFbenEqOe8z7XQmVFRSO
         aFiOoRF4zzIvHNkMaREz8eMn7g2NGBmMl28b2Aoqp2oPyurfuNwyltSNovk/JRiBMVim
         gmVRWXd2xypNmS4xQbc3sTm+l15sMiUlzZp6ayA46Vjgxa807fuSv33Ha7drReVJZvwT
         oLtHQsQepoxP0Rgh/8tQoimqcVXEC2hgomR3ipKj/ZV90PvceUONNBJdEMnBdM0MYm3n
         JknLDoKAatsEbdDQJRjvlFyM+rFPRkDF0SPOEIobHs04Q7jQsTtQlrHGJgIsjLthVY0t
         RM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/SqU2gFVMBbWyLJOkiidaC1t9EiWVorSKt8/qeakt/M=;
        b=O0KKT9SKCSeTxUpZ9aw6YpDRI7NiPvzcAToI+FDnw6/Nby8xzEdYsvMji1PuOJMprC
         A5yuAx/R/sQ1C5ExQugmvMzNRfgczPoiwrvrgMFVVCawerUkWbPqsg5Aho1gjZ4ocxaB
         3zR4brULHCzDoJMnaCf4hF7j1hMaEmjNn5W5XFkS86WX3zKjv76s5jhryTTXIV4Bedbz
         BfXegdCGdmI0zX3y3rcu3NhFLyrjxHDT9BT3zPWUunT+q+RqhnpYOLpQmoSeuD8IidkR
         YBwCdryRog/IdZOFdwMId2hywBayjLlRM3Q74XGrud3dhPNaRD9p6MYP73Bp9ITzcRmr
         CrrA==
X-Gm-Message-State: APjAAAWV5+uSLyGHWrB3eETawwIc61siXCVTOUY7hGMvtlYHF276pZRR
        1Diq4IYWrVZQ8xMUpEooY9Y3H4w=
X-Google-Smtp-Source: APXvYqyg5kF3L2Tbl+LIpyWp0IPVfnjfDoxPe66saiIJxJrMWHWhtKi30Z89o6Z4jYvgxOv2uiAZFg==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr19402838wmi.14.1563097920485;
        Sun, 14 Jul 2019 02:52:00 -0700 (PDT)
Received: from avx2 ([46.53.254.7])
        by smtp.gmail.com with ESMTPSA id z6sm9606950wrw.2.2019.07.14.02.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 02:51:59 -0700 (PDT)
Date:   Sun, 14 Jul 2019 12:51:57 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, izbyshev@ispras.ru,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Kubecek <mkubecek@suse.cz>, shasta@toxcorp.com,
        linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] proc: revert /proc/*/cmdline rewrite
Message-ID: <20190714095157.GA2276@avx2>
References: <20190713072855.GB23167@avx2>
 <CAHk-=wj_mrNnM-q_z95GcNB=Ab4LaUC6Bi6Q-+3Q9u9NC=3iDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_mrNnM-q_z95GcNB=Ab4LaUC6Bi6Q-+3Q9u9NC=3iDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	[re-add lists]

On Sat, Jul 13, 2019 at 10:50:20AM -0700, Linus Torvalds wrote:
> On Sat, Jul 13, 2019 at 12:29 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > /proc/*/cmdline continues to cause problems:
> 
> If we're reverting this, then we should revert all the way back to the
> original fixed-length one that had the original semantics and was
> simple.

No, because all those Java applications have command lines measured in
dozens of kilobytes.

> What was the problem with the one-line fix instead?

The problem is that I can't even drag this trivia in out of _fear_ that
it is userspace observable:

	https://marc.info/?t=155863429700002&r=1&w=4
	[PATCH] elf: fix "start_code" evaluation

and yet the patch which did a regression and an infoleak continues
to be papered over and for which the only justification was
"simplify and clarify".
