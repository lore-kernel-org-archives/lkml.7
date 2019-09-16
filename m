Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53DEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3632067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sJNElFea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbfIPP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:26:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33255 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfIPP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:26:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so486452edl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSIktH9km/kyTVe24lUXRvnlhwyDxHT2TsCMoTfS1so=;
        b=sJNElFeauOxjMQ8z2ZIZtXIa8pA9pcv/0pSdwPtnjJkhdKgwInXiNvk6uWLpzNQENg
         QzkWm6a9OBTknXCxjuJX6JQNbYdNL8jnHbT5M96rQZjGGejMxKAdFlijVkz8w+IQMQ+i
         TM2l73rCktTeQ+X1SzYXAfjHGqpMEDpL8yy7g/ifUasupaLK8YTVSekBJb2b/jgfZWpQ
         k4Du4KfHMTfbJjN2Sp+0qVafzab1hFbDrZuyVOQ49bhiP3TZxIfBzQeenj1hlF3BPtLP
         51vaN9MFTyRjL4TsOyfGen/u2aRYX7Q5apccKlDrtfKDsJc6JBBs8fpc7Nt/AkxaNzBw
         kdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSIktH9km/kyTVe24lUXRvnlhwyDxHT2TsCMoTfS1so=;
        b=dL1jOquuiI62eg3L4oYj8mAI0PAZ+PNq9ZGn6yI5RIRvnZRjSNIMa5tlolUNsd3d7C
         xrHiSTHW7zcTSGWGXHCf+joS8a5XURUfB38S9lPna+BKgmEdQxhK6+Wn/mZBBNzzIt1F
         QkOu9FrJ3XX2/f9734hB471eqadFS9tJ1fBkUD1lDgK+DxIw2S3dBSg6KvyqN1j/wT+m
         Ci/Vwi8b4rmGz1n94SfYI5mp1Gv2EwKRlw1j0AYogUW/FhaQj280w9mvyiFDECtk4zLx
         NqNae9LMb6TDFrz6xnKSSQnpu62Iu8aXjtVh6twJZFvnLpo5Yrki4SNp53J55nBZoPcB
         xoYQ==
X-Gm-Message-State: APjAAAUZL26VGNH9CnAEbz9+TAvXmodK6weHBJDuv8t1ZYaTXOpG3OeG
        +vDs3cTE5k/apwRJBwrnoFZnhQ==
X-Google-Smtp-Source: APXvYqwCLcAHfbFHqaEByVwi3tAUBFKQkzty77a4gpu/5KG4r7S+5O+7Xnuzhj7550/CudAfoVjKHw==
X-Received: by 2002:a05:6402:1501:: with SMTP id f1mr8782718edw.76.1568647577966;
        Mon, 16 Sep 2019 08:26:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y18sm1383264ejw.87.2019.09.16.08.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:26:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0CBDA10019A; Mon, 16 Sep 2019 18:26:19 +0300 (+03)
Date:   Mon, 16 Sep 2019 18:26:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Lucian Adrian Grijincu <lucian@fb.com>
Cc:     linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm: memory: fix /proc/meminfo reporting for
 MLOCK_ONFAULT
Message-ID: <20190916152619.vbi3chozlrzdiuqy@box>
References: <20190913211119.416168-1-lucian@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913211119.416168-1-lucian@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:11:19PM -0700, Lucian Adrian Grijincu wrote:
> As pages are faulted in MLOCK_ONFAULT correctly updates
> /proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.

I don't think there's something wrong with this behaviour. It is okay to
keep the page an evictable LRU list (and not account it to NR_MLOCKED).
Some pages, like partly mapped THP will never be on unevictable LRU,
others will be found by vmscan later.

So, it's not bug per se.

Said that, we probably should try to put pages on unevictable LRU sooner
rather than later.

> 
> - Before this /proc/meminfo fields didn't change as pages were faulted in:
> 
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
> 
> - After: /proc/meminfo fields are properly updated as pages are touched:
> 
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
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  mm/memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e0c232fe81d9..55da24f33bc4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3311,6 +3311,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>  	} else {
>  		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
>  		page_add_file_rmap(page, false);
> +		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(page))
> +			mlock_vma_page(page);

Why do you only do this for file pages?

>  	}
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>  
> -- 
> 2.17.1
> 
> 

-- 
 Kirill A. Shutemov
