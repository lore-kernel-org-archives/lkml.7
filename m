Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2DA22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfH2MUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:20:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41631 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfH2MUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:20:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id g17so2684808qkk.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMsZyJ2WRqKm2D1XmKZEmDZpMnQ3g/rtY3J2qyxvyRo=;
        b=p2+EVRFqvmrTDDJrQbTgJLAJV+hkyVob52a3Wnfvgz3cmPorNFH1X8jZr1DYn1ZE0z
         aA5pDpXIaUdSFpFlM7ywyk4Vmoiv3QicsjID/3SDHiP8RKAJh1gyH4sjiII7dJJLRC9M
         9LEAzULDQoU4Yc4tEfFaE0pWUytlAmN6/sqPrXWlyT0AwcYCtGJ3F23Q135AR1HkZqJ9
         Ihuri4bMnISxElxw1WkgA3ps5x/yIe2R4GDGj5ZQHxYAvhm2boajbPYvbTYkc/Gkp5pD
         tET/DPuz5ns7G21ZC3feRAFHy0MYPi27pbFZghJjO/iIhBMRVRfHUfaq8BJw2BoMI3it
         V34A==
X-Gm-Message-State: APjAAAXD5fyucU9ZxjLJEoMbkMf5bMsJ+LlXTtq/wIxzR/2HQ7Y2myDT
        z/zsufojAYKQGxxY6mJ33hOcwIgEGx8ZyEKaN18=
X-Google-Smtp-Source: APXvYqxJ0sYDtBuO/PNqnzjVxlCa0l/KOpbtVwjqljAy2rojnkCCGYuyQWcy+W8bCid+RXA15JHm6+X90RvmUFEaluQ=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr9065773qkb.394.1567081202566;
 Thu, 29 Aug 2019 05:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567072270.git.msuchanek@suse.de> <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
In-Reply-To: <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Aug 2019 14:19:46 +0200
Message-ID: <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Fixes: aff850393200 ("powerpc: add system call table generation support")

This patch needs a proper explanation. The Fixes tag doesn't seem right
here, since ppc64 has had llseek since the start in 2002 commit 3939e37587e7
("Add ppc64 support. This includes both pSeries (RS/6000) and iSeries
(AS/400).").

> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 010b9f445586..53e427606f6c 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -188,7 +188,7 @@
>  137    common  afs_syscall                     sys_ni_syscall
>  138    common  setfsuid                        sys_setfsuid
>  139    common  setfsgid                        sys_setfsgid
> -140    common  _llseek                         sys_llseek
> +140    32      _llseek                         sys_llseek
>  141    common  getdents                        sys_getdents                    compat_sys_getdents
>  142    common  _newselect                      sys_select                      compat_sys_select
>  143    common  flock                           sys_flock

In particular, I don't see why you single out llseek here, but leave other
syscalls that are not needed on 64-bit machines such as pread64().

        ARnd
