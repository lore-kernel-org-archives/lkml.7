Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E1C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36406205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3+ajqRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEER1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 13:27:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40199 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEER1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:27:07 -0400
Received: by mail-it1-f196.google.com with SMTP id g71so1549454ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k2wHg8uejoitlIBs/K+e3KKZTQUXspEFmKonXrkWb1w=;
        b=P3+ajqRpL6qOcHSllvr75TIARqjJ8e1l1vC8adcjmqU37uWLB8kKeqLNJ94E3mfvht
         Ene9BX3xIrpjx6PScrZ73wH2XtbNx6c/qP0qCASi5CJNelZucdwpFda10PGMDuZp22YG
         ha1h+gBYi65PEAGlvQ28zcjDscxMn1ohQWUigB+kg2Qi/ZQ4xrkTTgayNs241bPKOu/g
         3HKwDH3xon1DcxePjLay87zEAVVz6R2ZrIeYm28yiKbdINuPbSi+zmVR/fQdYPmYiROY
         Zu1fFrax0OSZtiISRXvDZmCkw9nubTN+30nRHijFKe8zrv707tjTmvXJnwjTVAtbwwQr
         R0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k2wHg8uejoitlIBs/K+e3KKZTQUXspEFmKonXrkWb1w=;
        b=a1tId/bwlXAThjdcoz/fBbBBS66nBQNvG9tzNHOjudSFN+YgLJbHnUf/4E1RYfSlCV
         e5Q9Y50AfSB3BFhB6YiwmTsLI3kFXS9HkHmnD1QzqhZcoGWdBla0TMyevnN5uzXiW2lf
         VhcUyAAQ/UTiS+JgYrbNzLlAuX3ikxnDjkg/+f30QJPlc9AzXfoSdWLtwgelrL7y2hf6
         eIzgf/1bE5v8LlfzkL8a2tHOLIYELkddVyZiueWP6rIvqP/1MPJLEuFSLCMmjQdG+KRz
         R5H/pu8S5jaKQrJJRsG81FNu81JWxmTqF0Gv/1xdd8FiMZUs7FpwxVpDXdeJiVymQ8/a
         aUtw==
X-Gm-Message-State: APjAAAWpIrxAWE0fhd45FzwEyEytgOJqN2xLS8ihy2VlTnbpfmls6fSd
        iv7t5lC7fBGUadUhyjtSnLI=
X-Google-Smtp-Source: APXvYqyN0DLItpFjIbKovt5UzHVKb/PPJK1p2J/BquK7NGDJDuN7xhveFgB5YRx5fjULwCTcbO8gTQ==
X-Received: by 2002:a02:bb10:: with SMTP id y16mr15809264jan.132.1557077226246;
        Sun, 05 May 2019 10:27:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4580:b719:6901:c850:6df:b2c3? ([2601:647:4580:b719:6901:c850:6df:b2c3])
        by smtp.gmail.com with ESMTPSA id 19sm3788532itm.6.2019.05.05.10.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 10:27:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [tip:x86/mm 36/36] init/main.c:540:2: error: implicit declaration
 of function 'pgd_cache_init'
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <201905052117.1f4kabef%lkp@intel.com>
Date:   Sun, 5 May 2019 10:27:03 -0700
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com, kbuild test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A235E429-B992-42C1-9B96-2309C95196E7@gmail.com>
References: <201905052117.1f4kabef%lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 5, 2019, at 6:06 AM, kbuild test robot <lkp@intel.com> wrote:
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git =
x86/mm
> head:   ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5
> commit: ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5 [36/36] x86/mm: =
Initialize PGD cache during mm initialization
> config: openrisc-or1ksim_defconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
> reproduce:
>        wget =
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross =
-O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        git checkout ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5
>        # save the attached .config to linux build tree
>        make.cross ARCH=3Dopenrisc=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>   init/main.c: In function 'mm_init':
>>> init/main.c:540:2: error: implicit declaration of function =
'pgd_cache_init' [-Werror=3Dimplicit-function-declaration]
>     pgd_cache_init();
>     ^~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors
>=20
> vim +/pgd_cache_init +540 init/main.c
>=20
>   519=09
>   520	/*
>   521	 * Set up kernel memory allocators
>   522	 */
>   523	static void __init mm_init(void)
>   524	{
>   525		/*
>   526		 * page_ext requires contiguous pages,
>   527		 * bigger than MAX_ORDER unless SPARSEMEM.
>   528		 */
>   529		page_ext_init_flatmem();
>   530		mem_init();
>   531		kmem_cache_init();
>   532		pgtable_init();
>   533		debug_objects_mem_init();
>   534		vmalloc_init();
>   535		ioremap_huge_init();
>   536		/* Should be run before the first non-init thread is =
created */
>   537		init_espfix_bsp();
>   538		/* Should be run after espfix64 is set up. */
>   539		pti_init();
>> 540		pgd_cache_init();
>   541	}
>   542=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology =
Center
> https://lists.01.org/pipermail/kbuild-all                   Intel =
Corporation
> <.config.gz>

Sorry for that - I got confused and forgot this is not arch-specific =
code. I
don=E2=80=99t see the latest commit in the x86/mm tree, so I assume you =
can squash
the following on top?

-- >8 --

Subject: [PATCH] x86/mm: Fix breakage due to missing pgd_cache_init()

Set pgd_cache_init() as a weak symbol.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pgtable.h | 1 -
 include/asm-generic/pgtable.h  | 2 ++
 init/main.c                    | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h =
b/arch/x86/include/asm/pgtable.h
index 9635662e1163..6b6bfdfe83aa 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1027,7 +1027,6 @@ static inline int pgd_none(pgd_t pgd)
=20
 extern int direct_gbpages;
 void init_mem_mapping(void);
-void pgd_cache_init(void);
 void early_alloc_pgt_buf(void);
 extern void memblock_find_dma_reserve(void);
=20
diff --git a/include/asm-generic/pgtable.h =
b/include/asm-generic/pgtable.h
index fa782fba51ee..75d9d68a6de7 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1126,6 +1126,8 @@ int phys_mem_access_prot_allowed(struct file =
*file, unsigned long pfn,
 static inline void init_espfix_bsp(void) { }
 #endif
=20
+extern void __init pgd_cache_init(void);
+
 #ifndef __HAVE_ARCH_PFN_MODIFY_ALLOWED
 static inline bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 {
diff --git a/init/main.c b/init/main.c
index 7fac4ac2fede..2f99b3f40aaa 100644
--- a/init/main.c
+++ b/init/main.c
@@ -506,6 +506,8 @@ void __init __weak mem_encrypt_init(void) { }
=20
 void __init __weak poking_init(void) { }
=20
+void __init __weak pgd_cache_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
=20
--=20
2.17.1=
