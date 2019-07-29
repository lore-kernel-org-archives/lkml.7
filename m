Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC4206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564435500;
	bh=wF6Rn2cCLpNyUpz0n2CK6Ij39365IIqLkTxT8fB2LDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gbk+6ErfjOAqKaHmB0vBmkFlIcXWYZsiMgwJZQT/aaanKNbzjnlEtKyoxkg9g9whp
	 QwWZO+Ry2xFfSiMxe/7DXni0NLqdiiCim0HzYnvjCuv6vmvxXj0WzUUtXjLwExG31f
	 HYUeTrqQspydEdvpmykluYcLw9Z55haqsRUK2hFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfG2VY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:24:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40018 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfG2VY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:24:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so63390229wrl.7;
        Mon, 29 Jul 2019 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSTcvSt+ZVRSVT43ALESN1EoeFMWXoH1XZ7cNPvpUjk=;
        b=oxBhgZ86TydV8I1zoEoDZM7PJgMf1/DYmjk2j/6n/CC38hDrspdDM6L7ayjVzH5HL3
         JW1Z3ITIv1cfwR+ZSCnH9d6erbDY60Y/wWbAb+yh1g5Q3XiMpSgysGvz876tPJFruhp7
         HR4k0ro/QdIKR+ar7oBWZdTxVgzoTSD8XPkQwJf5NSPVEEkpOmPM1eL3D2UatXfwcAWR
         TSj9PHWPY9msN7vMCoHi1wRPvAz3Ci5LZnZhOdTaxJdFmBhb7I8FFep40p07uc3ap5hP
         2/NmzRssHTNyn/mgSIUw0uVIkovOJ1kdC86ejqxQceZr9g4vRQDDspm0kzbKzu7qmhWz
         VdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSTcvSt+ZVRSVT43ALESN1EoeFMWXoH1XZ7cNPvpUjk=;
        b=h7jVxKX9evqpT3V2ZeQdJTFGlPAN/a75chtBL4N11eQTgGJ6G2HJ1kchN5PGM1W02i
         cv5O1gUPDgkUEnMa3p+64EWUXFU0ou9vm7/3OtarUGqSNmHWGDYM8aRnGmk9iMI2ocdK
         7cs+UI3oo7puCdWNfVm0FbI8Wqj8J7EC9Ie4PZRv1tPQwkhn5TkYBco1m7MypRVko+uU
         eOXrC90dcmARzpkxKuLlSLhedQCIBUUBZ7eYxBD+FqoRF4UUrB4tCTp1NAyAzE+hY0gO
         DK6PP2DBuWReQFRp5F6YXB1HpkO7TDZFP2Me2j9rhpQwxLEvqsMunDF9nGkXlu8XGC05
         CLqQ==
X-Gm-Message-State: APjAAAWFRijytS3EU3i4SL3jZKuHvKTNWI6FgJ50KJd2WN7qA23I81Y5
        jxF3IjIvFTkndmmA7sg6Los=
X-Google-Smtp-Source: APXvYqx3Nd+UIQEKCTmIet4VFqLvZhFT5ZgK8HLe/yX2X4S7lYukxOZAzAt5Mfnv1owDOsKgBcwa9g==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr33256117wro.209.1564435494297;
        Mon, 29 Jul 2019 14:24:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f70sm81086039wme.22.2019.07.29.14.24.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:24:53 -0700 (PDT)
Date:   Mon, 29 Jul 2019 23:24:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20190729212451.GA44602@gmail.com>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 289a2d22b5b611d85030795802a710e9f520df29:
> 
>   perf/x86/intel: Mark expected switch fall-throughs (2019-07-25 15:57:03 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.3-20190729
> 
> for you to fetch changes up to 8aa259b10a6a759c50137bbbf225df0c17ca5d27:
> 
>   libbpf: fix missing __WORDSIZE definition (2019-07-29 10:18:08 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf header:
> 
>   Vince Weaver:
> 
>   - Fix divide by zero error if f_header.attr_size==0, found using a perf tool fuzzer.
> 
>   Numfor Mbiziwo-Tiapo:
> 
>   - Silence use of uninitialized value warning pointed out by clang's MSAN tool.
> 
> libbpf:
> 
>   Andrii Nakryiko:
> 
>   - Fix missing __WORDSIZE definition in some systems, such as musl libc (Alpine Linux).
> 
> tools header UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync headers to address perf build warnings:
> 
>     - syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open.
> 
>     - With new ioctls: kvm.h, drm.h and usbdevice_fs.h.
> 
>     - No tooling change: mman.h, sched.h and if_link.h.
> 
> Documentation:
> 
>   Vince Weaver:
> 
>   - Fix perf.data documentation units for memory size, its kB, not bytes.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andrii Nakryiko (1):
>       libbpf: fix missing __WORDSIZE definition
> 
> Arnaldo Carvalho de Melo (8):
>       tools include UAPI: Sync x86's syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open
>       tools headers UAPI: Update tools's copy of kvm.h headers
>       tools headers UAPI: Update tools's copy of mman.h headers
>       tools headers UAPI: Update tools's copy of drm.h headers
>       tools perf beauty: Fix usbdevfs_ioctl table generator to handle _IOC()
>       tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new ioctl
>       tools headers UAPI: Sync sched.h with the kernel
>       tools headers UAPI: Sync if_link.h with the kernel
> 
> Numfor Mbiziwo-Tiapo (1):
>       perf header: Fix use of unitialized value warning
> 
> Vince Weaver (2):
>       perf header: Fix divide by zero error if f_header.attr_size==0
>       perf tools: Fix perf.data documentation units for memory size
> 
>  tools/arch/arm/include/uapi/asm/kvm.h              |  12 ++
>  tools/arch/arm64/include/uapi/asm/kvm.h            |  10 +
>  tools/arch/powerpc/include/uapi/asm/mman.h         |   4 -
>  tools/arch/sparc/include/uapi/asm/mman.h           |   4 -
>  tools/arch/x86/include/uapi/asm/kvm.h              |  22 ++-
>  tools/arch/x86/include/uapi/asm/vmx.h              |   1 -
>  tools/include/uapi/asm-generic/mman-common.h       |  15 +-
>  tools/include/uapi/asm-generic/mman.h              |  10 +-
>  tools/include/uapi/asm-generic/unistd.h            |   8 +-
>  tools/include/uapi/drm/drm.h                       |   1 +
>  tools/include/uapi/drm/i915_drm.h                  | 209 ++++++++++++++++++++-
>  tools/include/uapi/linux/if_link.h                 |   5 +
>  tools/include/uapi/linux/kvm.h                     |   3 +
>  tools/include/uapi/linux/sched.h                   |  30 ++-
>  tools/include/uapi/linux/usbdevice_fs.h            |  26 +++
>  tools/lib/bpf/hashmap.h                            |   5 +
>  tools/perf/Documentation/perf.data-file-format.txt |   2 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   2 +
>  tools/perf/trace/beauty/usbdevfs_ioctl.sh          |   9 +-
>  tools/perf/util/header.c                           |   9 +-
>  20 files changed, 352 insertions(+), 35 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
