Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F35EC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139392133D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfFOOzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 10:55:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41738 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 10:55:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so5379175otj.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 07:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFmJrg9gTcnKcoZCiQypnNRQNxX/k8DGBmBoxNPZno8=;
        b=r4Ef5xci3IcfgANTOYuexqeiC7A1+hdCfHSv8mrCB7yFhftOgmoAdImtlBuQ08ySPF
         e+RbnhgG5Z4cosPH/h9AgPpmnEJXQcQIwQTnfCXJmKa69OvxPgaCkn9RxHd8YP+Tqyuo
         TPNpzi64mzQLNQqT66YzpMFdRaM7x+ACNK8qSR6EYXDcXXYJs8MA1z/9qR4pJVLb1LEv
         qVbCHBKrSVbh6Fi97Z0fX10RZtzbNYHpyjllu3s75puGckuwXTBJwqpXOnCrpvzpbNxS
         F0fnaZ+CulKndUb6Lj7Oi7fFejjxYkxGaY3JXZpZfHSFE5vD2GRAOn1hf316PgwoSwBG
         /Glw==
X-Gm-Message-State: APjAAAWTeg5s0jQ+NwWckza5kg5hL2z0+0/f+bLWp69NOR5HVxw776Ic
        6g1W27BNtoqa/5KqBYuwtHkeXTzsDjZxa6euDWQ/yQ==
X-Google-Smtp-Source: APXvYqwKBPzqo5TL6rFrnREFUjRgNeUMkK3klySr7NevDMq8P3LAgYuZoUbBHpsMVVHfErjvWphf4b3VQAeDVe90mDI=
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr33729557otn.243.1560610546148;
 Sat, 15 Jun 2019 07:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <1560437690-13919-1-git-send-email-jsavitz@redhat.com> <20190613122956.2fe1e200419c6497159044a0@linux-foundation.org>
In-Reply-To: <20190613122956.2fe1e200419c6497159044a0@linux-foundation.org>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Sat, 15 Jun 2019 10:55:31 -0400
Message-ID: <CAL1p7m5_uzOhk6Lj78Pgh6Y6EXPd=+YLk4vwMZd6xyoiJutt5g@mail.gmail.com>
Subject: Re: [PATCH v4] fs/proc: add VmTaskSize field to /proc/$$/status
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most immediate use case is the optimization of an internal test,
but upon closer examination neither this patch nor the test itself
turn out to be worth pursuing.

Thank you for your time and constructive comments.

Best,
Joel Savitz


On Thu, Jun 13, 2019 at 3:30 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 13 Jun 2019 10:54:50 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
>
> > The kernel provides no architecture-independent mechanism to get the
> > size of the virtual address space of a task (userspace process) without
> > brute-force calculation. This patch allows a user to easily retrieve
> > this value via a new VmTaskSize entry in /proc/$$/status.
>
> Why is access to ->task_size required?  Please fully describe the
> use case.
>
> > --- a/Documentation/filesystems/proc.txt
> > +++ b/Documentation/filesystems/proc.txt
> > @@ -187,6 +187,7 @@ read the file /proc/PID/status:
> >    VmLib:      1412 kB
> >    VmPTE:        20 kb
> >    VmSwap:        0 kB
> > +  VmTaskSize:        137438953468 kB
> >    HugetlbPages:          0 kB
> >    CoreDumping:    0
> >    THP_enabled:         1
> > @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
> >   VmPTE                       size of page table entries
> >   VmSwap                      amount of swap used by anonymous private data
> >                               (shmem swap usage is not included)
> > + VmTaskSize                  size of task (userspace process) vm space
>
> This is rather vague.  Is it the total amount of physical memory?  The
> sum of all vma sizes, populated or otherwise?  Something else?
>
>
