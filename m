Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BEDC4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D964214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcOazIdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389589AbfIMTq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:46:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35364 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388211AbfIMTq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:46:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so23025189lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hODFJZyoJjSmmRYWMOJEJfcm53I4w912l6n4+LWHTEE=;
        b=RcOazIdH9d40Xk6cQVhkhqCPkv5+tWTB7oyy0tbMqmeCtuHLwUhwBEYetiFHLmqNeS
         N+fvPM7ietagWkoeuNc/klR5GmqrvRS4Y2JPUY56yqoC0MOP4zbB+loU4Iw8Kw6SHYsh
         +rIN1sUn14h34Dt0/XhbN7eBEAr3LnukmE/4Z+shbyxtLvDeS3Gf0OU/y6a5T/Kx01rt
         vxN1a/gSxKGGYEIE6W8SUbBdxd+WblMUi7JoQVg46FfRsoc3X+33PhLjmdb2TcZd1hOM
         Ueke4akyz3ncYUYE0l5i1Otos+1fQZOVhl6dP6pU4nI/jAi9tvaUqBO4bmpQ823zW9Mk
         4gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hODFJZyoJjSmmRYWMOJEJfcm53I4w912l6n4+LWHTEE=;
        b=kwUo2ngzO7OM7VHPLXmnl/VLmPlPGyKInjcbxYDAbcWaRKoEDk72im4pGf2/018hDX
         r1Fz1EXyZoHpfNMNpcvHGEJd8BEqVE0rVRos63eyYhfFiXYWTLEPUKiMLSGXZGbjQ3rJ
         4HYxmhBzT9Sk4o6YCHRvlcM/IyGUQ91UKqLhSWgc9Nu6P3OrluvpWy2UhDYXUuZbYHo9
         UTcmi6FgVDmhaNhFKv8nR/ilbvEM73NvsExLCSMkabEv4HZ5MVGkJbxJiNR+3mpkg+z8
         1Yv6+P3oddbmIyhL+GjUmfw5zOJo6x5nhSFvElEMVlD8524E6F8RPOtx8KpWoSEhMogJ
         zSBQ==
X-Gm-Message-State: APjAAAU1m+gAU03uszXIxvnU1nMugZpvnN9aUt+6wDaFxV0FCjMnhhNS
        F8E1RvW2AJvQvO9AAyyI62ksAULqub9chzGTVms=
X-Google-Smtp-Source: APXvYqxtGatgstWPZclceZPd8UN+I5XKmjT31SJ8PK5IdB229s04CTMLdkLCjHf/S94qc2rIKV+4KV+VFvLGrpgFHdA=
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr1679174lfm.105.1568404016517;
 Fri, 13 Sep 2019 12:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqt6zaVAuvoHveT9YeU5GWjWPZBeTXWnRjmHEazxZSUctT7+Q@mail.gmail.com>
 <20190913192907.96530-1-lucian@fb.com>
In-Reply-To: <20190913192907.96530-1-lucian@fb.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 14 Sep 2019 01:16:44 +0530
Message-ID: <CAFqt6zaXWLk7uNQrHPWc_HacZN6=ZxAriT_g3nDLrh_ZxfCmfA@mail.gmail.com>
Subject: Re: [PATCH] mm: memory: fix /proc/meminfo reporting for MLOCK_ONFAULT
To:     Lucian Adrian Grijincu <lucian@fb.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:59 AM Lucian Adrian Grijincu <lucian@fb.com> wrote:
>
> As pages are faulted in MLOCK_ONFAULT correctly updates
> /proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.
>
> - Before this /proc/meminfo fields didn't change as pages were faulted in:
>
> ```
> = Start =
> /proc/meminfo
> Unevictable:       10128 kB
> Mlocked:           10132 kB
> = Creating testfile =
>
> = after mlock2(MLOCK_ONFAULT) =
> /proc/meminfo
> Unevictable:       10128 kB
> Mlocked:           10132 kB
> /proc/self/smaps
> 7f8714000000-7f8754000000 rw-s 00000000 08:04 50857050   /root/testfile
> Locked:                0 kB
>
> = after reading half of the file =
> /proc/meminfo
> Unevictable:       10128 kB
> Mlocked:           10132 kB
> /proc/self/smaps
> 7f8714000000-7f8754000000 rw-s 00000000 08:04 50857050   /root/testfile
> Locked:           524288 kB
>
> = after reading the entire the file =
> /proc/meminfo
> Unevictable:       10128 kB
> Mlocked:           10132 kB
> /proc/self/smaps
> 7f8714000000-7f8754000000 rw-s 00000000 08:04 50857050   /root/testfile
> Locked:          1048576 kB
>
> = after munmap =
> /proc/meminfo
> Unevictable:       10128 kB
> Mlocked:           10132 kB
> /proc/self/smaps
> ```
>
> - After: /proc/meminfo fields are properly updated as pages are touched:
>
> ```
> = Start =
> /proc/meminfo
> Unevictable:          60 kB
> Mlocked:              60 kB
> = Creating testfile =
>
> = after mlock2(MLOCK_ONFAULT) =
> /proc/meminfo
> Unevictable:          60 kB
> Mlocked:              60 kB
> /proc/self/smaps
> 7f2b9c600000-7f2bdc600000 rw-s 00000000 08:04 63045798   /root/testfile
> Locked:                0 kB
>
> = after reading half of the file =
> /proc/meminfo
> Unevictable:      524220 kB
> Mlocked:          524220 kB
> /proc/self/smaps
> 7f2b9c600000-7f2bdc600000 rw-s 00000000 08:04 63045798   /root/testfile
> Locked:           524288 kB
>
> = after reading the entire the file =
> /proc/meminfo
> Unevictable:     1048496 kB
> Mlocked:         1048508 kB
> /proc/self/smaps
> 7f2b9c600000-7f2bdc600000 rw-s 00000000 08:04 63045798   /root/testfile
> Locked:          1048576 kB
>
> = after munmap =
> /proc/meminfo
> Unevictable:         176 kB
> Mlocked:              60 kB
> /proc/self/smaps
> ```
>
> Repro code.
> ---
>
> int mlock2wrap(const void* addr, size_t len, int flags) {
>   return syscall(SYS_mlock2, addr, len, flags);
> }
>
> void smaps() {
>   char smapscmd[1000];
>   snprintf(
>       smapscmd,
>       sizeof(smapscmd) - 1,
>       "grep testfile -A 20 /proc/%d/smaps | grep -E '(testfile|Locked)'",
>       getpid());
>   printf("/proc/self/smaps\n");
>   fflush(stdout);
>   system(smapscmd);
> }
>
> void meminfo() {
>   const char* meminfocmd = "grep -E '(Mlocked|Unevictable)' /proc/meminfo";
>   printf("/proc/meminfo\n");
>   fflush(stdout);
>   system(meminfocmd);
> }
>
>   {                                                 \
>     int rc = (call);                                \
>     if (rc != 0) {                                  \
>       printf("error %d %s\n", rc, strerror(errno)); \
>       exit(1);                                      \
>     }                                               \
>   }
> int main(int argc, char* argv[]) {
>   printf("= Start =\n");
>   meminfo();
>
>   printf("= Creating testfile =\n");
>   size_t size = 1 << 30; // 1 GiB
>   int fd = open("testfile", O_CREAT | O_RDWR, 0666);
>   {
>     void* buf = malloc(size);
>     write(fd, buf, size);
>     free(buf);
>   }
>   int ret = 0;
>   void* addr = NULL;
>   addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>
>   if (argc > 1) {
>     PCHECK(mlock2wrap(addr, size, MLOCK_ONFAULT));
>     printf("= after mlock2(MLOCK_ONFAULT) =\n");
>     meminfo();
>     smaps();
>
>     for (size_t i = 0; i < size / 2; i += 4096) {
>       ret += ((char*)addr)[i];
>     }
>     printf("= after reading half of the file =\n");
>     meminfo();
>     smaps();
>
>     for (size_t i = 0; i < size; i += 4096) {
>       ret += ((char*)addr)[i];
>     }
>     printf("= after reading the entire the file =\n");
>     meminfo();
>     smaps();
>
>   } else {
>     PCHECK(mlock(addr, size));
>     printf("= after mlock =\n");
>     meminfo();
>     smaps();
>   }
>
>   PCHECK(munmap(addr, size));
>   printf("= after munmap =\n");
>   meminfo();
>   smaps();
>
>   return ret;
> }
>
> ---
>
> Signed-off-by: Lucian Adrian Grijincu <lucian@fb.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
(For the comment on v1)

Patch version need to be change to v2.

> ---
>  mm/memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e0c232fe81d9..55da24f33bc4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3311,6 +3311,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>         } else {
>                 inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
>                 page_add_file_rmap(page, false);
> +               if (vma->vm_flags & VM_LOCKED && !PageTransCompound(page))
> +                       mlock_vma_page(page);
>         }
>         set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>
> --
> 2.17.1
>
