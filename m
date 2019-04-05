Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC048C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810622146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMX7q+jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDEU1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:27:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45583 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDEU1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:27:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id y84so5909713oia.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqXtZo3UcAnWTrLRL03ZGljz+OZNOVy44gap3m4RP6k=;
        b=qMX7q+jfCa6gnhF+VoIgI8k1iJr+iutOxi+wHJPfkfZnRtVBsn8Y6zE7t6aBoli8/b
         i74YlAazGfgInOmAHNlhr4gZjDVzOVSxCmNmNHQV5G+7uKr/BqNj8ObrPHNgEh5oF+V3
         6gr8HWVDDcQhBrwVtEgd4H9O5F3igCdgzddWkZXCOqHS6YxKjZWCBx89r9dbbdokAyKp
         FNqPD5JY7iISIQbJj9m993FeaLNSGA0c67dId2/UOOCiRACus+7DqRoBZTNIwCzCBXzX
         ihkvE0DtmNKG2RsH4iBX6IhyvcMD0nOAmGkxFZWg1NuSUFbb7lnVar/zG9/uvpaZAyII
         i5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqXtZo3UcAnWTrLRL03ZGljz+OZNOVy44gap3m4RP6k=;
        b=Kc/TYIlfrkbPpgieFaX13w5BI8TRFsz3UJrGxnpGG/C06pgff5xiXDEqhM0VB2Odyj
         NJCSX04SPd1KYqWVUE2IgxlXYrta9FVQvZqRg+4Mz0Y+QqE4HCHxoxBF3WwXhYwdIC8K
         en9Az4951Wd2giqoM0GVvZGJ2gdSdPVjRLHvGoe2EpH+nKDEkS5/1huz9uar8SPA2SlK
         fAXrARMypzfxCWhgaYSof2BMAINYFqAD8PFmJzstHZqc+H68E7wO/rs3kYP9/Ji/IO1I
         y07XKPyqvSOtlFq2MikWfLD47LLQtjZaynVAFjY3HkguFeduEw8IeGEoj22GDBfmWC3t
         n2Qg==
X-Gm-Message-State: APjAAAVNvZnOkMn5S71J1h180UVbvtmNMwQ+BULJfdXKDqCwke+WRE+9
        Sp3pfDX9KMQ6ipN/E0mpq37mcGHJtz+/5PLBRHTrmQ==
X-Google-Smtp-Source: APXvYqw2tI8VLOjSOQUkimMCEdG9SFEYH3iVaFyoN075vO55nt3b9AikRaNCn4oI0yqBZ3lW/T2HlDt0De6xvgJ9USg=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr8500940oih.39.1554496053934;
 Fri, 05 Apr 2019 13:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190224044400.34975-1-aubrey.li@linux.intel.com> <20190224044400.34975-2-aubrey.li@linux.intel.com>
In-Reply-To: <20190224044400.34975-2-aubrey.li@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 5 Apr 2019 22:27:08 +0200
Message-ID: <CAG48ez2hJvjRD-immEJ9uJAY1WRth3pMf0Qz8bApRke05kC+2Q@mail.gmail.com>
Subject: Re: [PATCH v13 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed time
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        tim.c.chen@linux.intel.com, Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        aubrey.li@intel.com, kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 10:02 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
> AVX-512 components use could cause core turbo frequency drop. So
> it's useful to expose AVX-512 usage elapsed time as a heuristic hint
> for the user space job scheduler to cluster the AVX-512 using tasks
> together.
>
> Tensorflow example:
> $ while [ 1 ]; do cat /proc/pid/status | grep AVX; sleep 1; done
> AVX512_elapsed_ms:      4
> AVX512_elapsed_ms:      8
> AVX512_elapsed_ms:      4
>
> This means that 4 milliseconds have elapsed since the AVX512 usage
> of tensorflow task was detected when the task was scheduled out.
>
> Or:
> $ cat /proc/pid/status | grep AVX512_elapsed_ms
> AVX512_elapsed_ms:      -1

(Very nitpicky, feel free to ignore: If you change the /proc/pid to
/proc/tid in the commit message, it becomes clearer that this status
is really per-task/thread, not per-process/threadgroup.)

[...]
> +
> +/*
> + * Report the amount of time elapsed in millisecond since last AVX512
> + * use in the task.
> + */
> +static void avx512_status(struct seq_file *m, struct task_struct *task)
> +{
> +       unsigned long timestamp = task->thread.fpu.avx512_timestamp;

This is theoretically a data race, right? Should this have a READ_ONCE() on it?

Is there something that zeroes out the avx512_timestamp on
fork()/clone(), or will every child inherit the avx512 timestamp? As
far as I can tell, the timestamp is inherited; I think it would be
nicer to zero it out at that point. Either way, It might be worth
documenting this decision.
