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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D78DC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5EC208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4acSM1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfIMLRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 07:17:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41822 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387588AbfIMLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:17:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so3794488lfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eig8YBgc4AIpYsp7lUznhvhsAXEYkZmmBdoySh4xCVY=;
        b=K4acSM1HTjeaBZXU0S8sxve39tZHmse4wCZFy6gfKu7vs+elpkudnaNrN4NqM3SGrD
         DozWLFqC+bdV5LrOeXtaQINgd9qZpkpeb3a+fyia3zu8EdSaQqYx5zBysJuH1OV2/mOq
         bSiJDh1qUHpISV07C0TRurnSoPNhDad9AwS6dujj7dyfT+GL1l1vinCKDNF0i8FOJdby
         wZLUniDM+JbHEHenP3GXSu9NxwiVAGcphZsjlXCgPgir/NLE4Elig+94/zIHYsOrgw3y
         sSU8bsUTFp4x0x9N0fC+domZwopl+bCTIbLnEvpyr0idO+KdD7NYFk7d0KHLWIHDI+/F
         P3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eig8YBgc4AIpYsp7lUznhvhsAXEYkZmmBdoySh4xCVY=;
        b=A/m5m57FrP0Ii6c60lRqraHUybzZxDCYhwzU2NQBNXxSfkwhwp9nc2M31fQenmJ+Vi
         Vmraqf7aJMRPJ7EbWD4DFtes07suyotMVjQNs2l6NtBUBHhASihe8iV1ZrRquGKoPAo9
         65E66BztC6S8SS1hO7B+RApz8ZvibOe8E6TrzjPNV1CRzsWwmH4gyNfgvR+JqUH/OPOi
         c4cAy5zwGzoweFTVazgjPlnDOoOpyb/CGyQlgOTkMLAS+IaWBp0xVhgms6gH7YE9eoxF
         2VTOXevS/wi0g3xCcxKEw/qg1zr6lkRqqizeeF2jiytvN65a3HvZxSj5Cg5Z0r5wiQzM
         0nSw==
X-Gm-Message-State: APjAAAVHn1GRwks91HLByb3G0jlOhomlrfqE+k5NA/ajukpOlddZddWd
        hYMt4E70+0AkCiokIQYBHssyMLmL+Srbqw6Qjn0lyywg
X-Google-Smtp-Source: APXvYqyUUgNUqZtDaRJ2n59eFJk5+ew4BYuPqaQ2r4WCfz1h/2Z2Hxw6sIjkQ7zICPTJpL+Cs7ygm1884Bpkm3yrw5Q=
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr5844411lfl.74.1568373472512;
 Fri, 13 Sep 2019 04:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190912231820.590276-1-lucian@fb.com>
In-Reply-To: <20190912231820.590276-1-lucian@fb.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 13 Sep 2019 16:47:40 +0530
Message-ID: <CAFqt6zaVAuvoHveT9YeU5GWjWPZBeTXWnRjmHEazxZSUctT7+Q@mail.gmail.com>
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

On Fri, Sep 13, 2019 at 4:49 AM Lucian Adrian Grijincu <lucian@fb.com> wrote:
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
> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e0c232fe81d9..7e8dc3ed4e89 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3311,6 +3311,9 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>         } else {
>                 inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
>                 page_add_file_rmap(page, false);
> +               if ((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED &&
> +                               !PageTransCompound(page))

Do we need to check against VM_SPECIAL ?

> +                       mlock_vma_page(page);
>         }
>         set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>
> --
> 2.17.1
>
>
