Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F09C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC75205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUijIDIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfLPNvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:51:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46918 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfLPNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:51:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so6840580ljk.13;
        Mon, 16 Dec 2019 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXwBYgNkvNJ5wqvg9BxtWh1POLG3eTx59ak2bF6nB7I=;
        b=KUijIDIbIaFg6FVPTC/5nwTDh7uyZJruDReFSQO3zNkpukrZUYbB44CfIw+LNGC6U8
         u9XzhdOSWil3oG/3DDYw7QDpj6ofVZWRay2ILhm+9+5IFKZm+FepST6a/vSVA0PAUY/M
         sxnkUx6C5nDaAmlpXzWTb7d8qBEUhGY4T+bumKi40jo/VfGoRSe3H6QSblpEQTEk9Rvu
         4RsLMPXNTeObnlPptCR0POyt0m6JqMWI7pvzsa7wVG6HoNX49K+wKPUo+emL1f5pwG6g
         CICNniuBWv24SD8I0QR7UPp6+f60c2QQRidi42r9Xg7QTWSX0t/T1CiGUsb5nJDvpFG8
         wPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXwBYgNkvNJ5wqvg9BxtWh1POLG3eTx59ak2bF6nB7I=;
        b=PWVOPmPqV/XMDA70NAxIn7epC0iBPQihAHVQvhNidMo8TcnfFmZttLyRM79+OWydMF
         ZXxtzQnQ2LNXzAAId+Q1ZIe9Q+OSrXpBw1upFZDbCgPAt+43f5c/iPZU3cfe+kmkZf50
         wG8f9Q1XlwCtcjUwgC+ln1DLM8+Ja7r9lrvJu168e/Z/3dN217nwBkHl4/msqVwqu0CF
         F1qxwQUd2LV85CTbZZLDQ3pFtDB/WEiNjsbp648GyWDZZ7vCvCv7bJrGD/iCQ2wC4J64
         e5ieUUuYae3XMF3jFcl8AAnV58pZ2B2cN2mx+b19sGd5PzVajoAQTaGc/PQh4GtS5+W2
         w/Mw==
X-Gm-Message-State: APjAAAV84XUzpXpX/9MY2+GZdcj411gU5tJhE6+fPqCOEekAQxnGwY5M
        /qBBdxN3EP8ZDyKIzTJexVXQs3tH0ETjKPHN/KQ=
X-Google-Smtp-Source: APXvYqwsCGzSg/+9sl0R5MbYelV0EVCapIw5k8mbOEsosz913WIIfMDnFgSCepz5QtxVjB+u91jm/D+jqnU/CwWS5q8=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr19664424ljj.170.1576504260714;
 Mon, 16 Dec 2019 05:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com> <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
In-Reply-To: <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
From:   Gonsolo <gonsolo@gmail.com>
Date:   Mon, 16 Dec 2019 14:50:49 +0100
Message-ID: <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
> Improve load balancing on AMD EPYC systems").
>
> Probably the node_reclaim_distance variable should be moved from
> an SMP-specific file to a NUMA-specific file.

There are two variables that are used elsewhere:

int                             sched_max_numa_distance;

Used in kernel/sched/fair.c and kernel/sched/topology.c. I would move
it to fair.c.

int __read_mostly               node_reclaim_distance = RECLAIM_DISTANCE;

Used in
arch/x86/kernel/cpu/amd.c, line 894
kernel/sched/topology.c
mm/khugepaged.c, line 725
mm/page_alloc.c, line 3529

I'm not sure where to move this one.

-- 
g
