Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D438C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 04:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ED1217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 04:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcZBKKiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEKEYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 00:24:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45184 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfEKEYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 00:24:24 -0400
Received: by mail-io1-f67.google.com with SMTP id b3so6071591iob.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 21:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id;
        bh=2jZyehS3G3FY2bNunYG+uq4x3aco0eThMbCya7DpVmI=;
        b=XcZBKKiQfeSf7Db1XtlY2TjYgH7zi1cSFVLnY23q1b/+zFgF+8iVzwhaiLJ/JDAMkZ
         mWQXqqqv0jggjfZDeX75Mgd208jyDGSVk3RQ6AlfNpEB4o23MD0bynIccMEFvtvveSJk
         /9MFPSXSqQKbqXnWd8BXQZ5frdD6nmE7YHf5F48AklYYkOYwnM3z5qweuKdeXbpTFAHN
         B1GrdQiH++W32IeHqV2h+XKJBQojyrMlbtQa8tstTC1bwqH0lG+yrPQ+G36RlblxTaDS
         MS9eXkmvxJD4TuMShIBpf1hwt37qzc2lzZJrObVxqcT8qBL5M9O6hZr3G5cJVPEbuz7t
         9yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id;
        bh=2jZyehS3G3FY2bNunYG+uq4x3aco0eThMbCya7DpVmI=;
        b=ksvlI3Eo+/ZU7gQCP9/s6nNn924ZG/mSkvpcQWClbpZ65XXGWhNbYfTE6VqYFPnQCJ
         uOGqAwXg9BnpiHAQR8vzgSAMgSl9vQfCGuv/Eq3EmKnvil8ciQ3VVDnRDgs/HM2uC7qU
         sKq1Hdnps5SG6oM9fsQ/hRxw4Zso4Cg8+y4gn6I2DN5CswNy6fP11qJYPtetLyH+fzfa
         8HpoG1ZiGhjhdKObFMTbFy4Z/T2yam+2V+EI8h/utaB31/sNvSzNa3o571pdb5GifY4r
         9CYc/+5c66046AALthhwbfnK83Xd0fpKSvbURQMcBJ8SO4tFI3ctGFEX7pmw5x2jDfBz
         iPAA==
X-Gm-Message-State: APjAAAX8kJhslPzWRwQKmaN/uW8CpMKRXuXAbX7MFtQSt1JOJf9DKvfh
        /ELNwpg9IsBUa2KQFtn2zeg=
X-Google-Smtp-Source: APXvYqwUcEjalmPHoPace5sO9uIVW5vl3OKhKzEv+HAauLIObwuvUmq/pkWKbs6K552wEbiJ06295w==
X-Received: by 2002:a5d:8b0d:: with SMTP id k13mr3575545ion.134.1557548663032;
        Fri, 10 May 2019 21:24:23 -0700 (PDT)
Received: from gmail.com (slc-exit.privateinternetaccess.com. [173.244.209.5])
        by smtp.gmail.com with ESMTPSA id x187sm3451947itb.39.2019.05.10.21.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 21:24:21 -0700 (PDT)
Subject: The UAPI references Kconfig's CONFIG_* macros (variables)
Date:   Sat, 11 May 2019 04:14:56 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <874f34f9bfc840c39719707a2e12fed4-mfwitten@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The  UAPI  headers  contain  references  to  Kconfig's  `CONFIG_'
macros. Either this is a bug,  or there needs to be some standard
way for users  to provide definitions for these  macros, in order
to complete Linux's user-space API. Consider:

  #!/bin/sh
  cd "${linux_repo}"

  # Careful!
  #git reset --hard HEAD
  #git clean -fdx

  git checkout v5.1
  #zcat /proc/config.gz >.config

  mkdir -p /tmp/uapi/include
  make INSTALL_HDR_PATH=/tmp/uapi headers_install

  printf >/tmp/uapi/raw.c '%s\n%s\n' \
    '#include <linux/raw.h>' \
    'int main() { return MAX_RAW_MINORS; }'

Then:

  $ gcc -c -I/tmp/uapi/include /tmp/uapi/raw.c
  In file included from /tmp/uapi/raw.c:1:0:
  /tmp/uapi/raw.c: In function ‘main’:
  /tmp/uapi/include/linux/raw.h:17:24: error: ‘CONFIG_MAX_RAW_DEVS’ undeclared (first use in this function)
   #define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
                          ^
  /tmp/uapi/raw.c:2:21: note: in expansion of macro ‘MAX_RAW_MINORS’
   int main() { return MAX_RAW_MINORS; }
                       ^~~~~~~~~~~~~~
  /tmp/uapi/include/linux/raw.h:17:24: note: each undeclared identifier is reported only once for each function it appears in
   #define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
                          ^
  /tmp/uapi/raw.c:2:21: note: in expansion of macro ‘MAX_RAW_MINORS’
   int main() { return MAX_RAW_MINORS; }
                       ^~~~~~~~~~~~~~

As you can  see, the UAPI is actually incomplete;  there is not a
valid  definition for  `MAX_RAW_MINORS'.  Indeed,  on my  system,
`CONFIG_MAX_RAW_DEVS'  isn't   ever  defined   anywhere,  because
`CONFIG_RAW_DRIVER' is not set:

  $ git show v5.1:drivers/char/Kconfig | sed -n 467,469p
  config MAX_RAW_DEVS
          int "Maximum number of RAW devices to support (1-65536)"
          depends on RAW_DRIVER
  $ zcat /proc/config.gz | grep RAW_DRIVER
  # CONFIG_RAW_DRIVER is not set

Even if `CONFIG_RAW_DRIVER' were  set, the desired definition for
the  macro  `CONFIG_MAX_RAW_DEVS'  would  only be  found  in  the
following  header (generated  at  built-time),  which is  neither
officially nor likely available to user space:

  "${linux_repo}"/include/generated/autoconf.h

Other  such  references to  `CONFIG_*'  macros  are seen  in  the
following  (some  appear only  in  comments,  but perhaps  that's
conceptually a mistake, too):

  $ (cd /tmp/uapi/include && grep -R . -e \\bCONFIG_)
  ./asm/mman.h:#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
  ./asm/auxvec.h:#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
  ./asm/e820.h: * kernel was built: MAX_NUMNODES == (1 << CONFIG_NODES_SHIFT),
  ./asm/e820.h: * unless the CONFIG_X86_PMEM_LEGACY option is set.
  ./asm/e820.h: * if CONFIG_INTEL_TXT is enabled, memory of this type will be
  ./mtd/ubi-user.h: * default kernel value of %CONFIG_MTD_UBI_BEB_LIMIT will be used.
  ./linux/pkt_cls.h:	TCA_FW_INDEV, /*  used by CONFIG_NET_CLS_IND */
  ./linux/pkt_cls.h:	TCA_FW_ACT, /* used by CONFIG_NET_CLS_ACT */
  ./linux/cm4000_cs.h: * member sizes. This leads to CONFIG_COMPAT breakage, since 32bit userspace
  ./linux/eventpoll.h:#ifdef CONFIG_PM_SLEEP
  ./linux/hw_breakpoint.h:#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
  ./linux/bpf.h: * has been built with CONFIG_EFFICIENT_UNALIGNED_ACCESS not set,
  ./linux/bpf.h: * 		the **CONFIG_CGROUP_NET_CLASSID** configuration option set to
  ./linux/bpf.h: * 		**CONFIG_IP_ROUTE_CLASSID** configuration option.
  ./linux/bpf.h: * 		with the **CONFIG_BPF_KPROBE_OVERRIDE** configuration
  ./linux/bpf.h: * 		the CONFIG_FUNCTION_ERROR_INJECTION option. As of this writing,
  ./linux/bpf.h: * 		**CONFIG_XFRM** configuration option.
  ./linux/bpf.h: *		the **CONFIG_BPF_LIRC_MODE2** configuration option set to
  ./linux/bpf.h: *		the **CONFIG_BPF_LIRC_MODE2** configuration option set to
  ./linux/bpf.h: * 		**CONFIG_SOCK_CGROUP_DATA** configuration option.
  ./linux/bpf.h: *		**CONFIG_NET** configuration option.
  ./linux/bpf.h: *		**CONFIG_NET** configuration option.
  ./linux/bpf.h: *		the **CONFIG_BPF_LIRC_MODE2** configuration option set to
  ./linux/raw.h:#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
  ./linux/pktcdvd.h:#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
  ./linux/flat.h:#ifdef CONFIG_BINFMT_SHARED_FLAT
  ./linux/videodev2.h: * Only implemented if CONFIG_VIDEO_ADV_DEBUG is defined.
  ./linux/elfcore.h:#ifdef CONFIG_BINFMT_ELF_FDPIC
  ./linux/atmdev.h:#ifdef CONFIG_COMPAT
  ./asm-generic/bitsperlong.h: * both 32 and 64 bit user space must not rely on CONFIG_64BIT
  ./asm-generic/unistd.h:/* mm/, CONFIG_MMU only */
  ./asm-generic/mman-common.h:#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
  ./asm-generic/fcntl.h:#ifndef CONFIG_64BIT

What is the correct way to think about this?

  * Should the UAPI make no reference to build-time configurations?
  * Should the UAPI headers include sanity checks on behalf of the user?
  * Should there be a `/proc/config.h.gz' facility?

Sincerely,
Michael Witten
