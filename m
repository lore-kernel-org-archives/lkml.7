Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF6C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2BF2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e5YTgzrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgAIGvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:51:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:36415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgAIGvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578552660;
        bh=50wkIf2j3bSuVaQbjQeyQqMF794GvhIKb6N4Rwk/e4s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=e5YTgzrxZm+19ZdKErqtSww/XWMfAO7zj98Nv72wyuE9wI375uEEYimzFzW0CNLTh
         hjmdnfBnwJ9yiAW2UqLGktrqoSPUfIjJSVLVG6Utyh+wVeUEsAGQyvekII8/sFBqYO
         VuEFoCbM+AqNXC5RWnxZ9rolxcYtLI2TJPkTT2G0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.133.168]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1j8cP829HO-00KOD5; Thu, 09
 Jan 2020 07:51:00 +0100
Date:   Thu, 9 Jan 2020 07:50:55 +0100
From:   Helge Deller <deller@gmx.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Meelis Roos <mroos@linux.ee>, Jeroen Roovers <jer@gentoo.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] parisc: fix map_pages() to actually populate upper
 directory
Message-ID: <20200109065055.GA13038@ls3530.fritz.box>
References: <20200108125852.19823-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108125852.19823-1-rppt@kernel.org>
X-Provags-ID: V03:K1:RouwXvLm/K7tK2RObMV4/68vrcf/1lzoB40AEaqMH5Y/eLZ76Hg
 nQIErEWeY/eFEMvl+BRVbbt6dASKI1jrlXD/MJv1z6tfpEvxwwdkcC7iYy8M+TVNw8JC337
 meKLX46dY9WOdS6IpIz/QoKbfir2TELCK7MYnbWGxyqLzvMUK1eF4bkUR9ygXOLNPCXTSM2
 0Lci4c1NrIeNMyrWuTbIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IC4pifuUL9o=:r2pFbZznz8vqxtAJfEkvce
 fD+SEwDkBJlStI07upp7kN9XuOTdPma0OhzBmH0F9+LPerKMFNTbNkvYeW8F5VWPVw4S/kWoU
 WEym63MKHf5/bvh8+95tQFsuJuvgaKMYWXpJQJPCUw5ueAKjwssZcuTSKd4TCMkw5A6XpwU4/
 f+BmQrRNBtCuvow8iNuP4XlmTAVkiaSxWPu35NyDHlPLfxc7KCltfv9u51BaDJ5X789mWGp3b
 zdIrrKmEOcym67e6aaD+yH79wIAK7T9f3UGLN4AU7196sEnR27pvFdhRMgTpd9B6u+71xQUp6
 9CNXOazzmIbrpNX+Ynd1U0dJYAPUzHiUGU5nH3dKvPWa5n4Ua2VjucoDusUAEXbd//R7f7izt
 ine/wMuSxJajnmhwdCSKrjmGRUomCpFIW/AUfSY4oZO5QIHjoeV1pxrp2Y6cZ1KBhruBh7J32
 WK1lhjzYE5CaFXftGk2Co5abzhCVcUU0jyWwznZOF8tfuLpuNGlK3uz61U3o5WAVzH4exdRYc
 3BtyxZiOwFGnTmF27M1GYxFe46k725lQN4NbtzDqg+SL1MjFcpnd1KGMr+BmfZu50D9hcnyAn
 Xuks3fH6T4VWLQouoJYb+/VZ7Vd9P7h1v3kJ+whYYTrbEO/0uOzdf0ZLmPv7G1ktTQlZartfu
 ijkUEMx2TNPVW4SthOgAW563W2PThZUs3X1mZfQZYQZ7YtCUzanDmFlL8BWNFzjOdv1K3eZHj
 RfJ/9alo2Omrv/XHGcmPzEt3qBbkPVQ5Yxcw7q3SkZAeAeivT+9piScMiceMbLEt+kqYGT2oU
 EVbQI2wmByfSlAwQ7Z5nRTp3iejBXlWhZXsDygFAfQfsHYDwIWdCdZHuBqFgaukbwkOxzNSzk
 L0YGZBdCg7EuIE58WA1rXevFIuZd6RPyNu3xPPDk9ODqyLFaSCGhd/KMyHm8zdYcx72e3mqBQ
 xNrYi33+0VYBsJg5N8biJlQiFt8IgYmv2/RZbW6qQz4ySx7nOjpRaldPPA0+im++fqs+gjmxz
 Px5hIi49aPuhtX4L8dWqrTnKmbhODvQGA8Rp0FX6+Jhm/e6I9jJmU7ubjxNF2sJ0cfrowrGM0
 tPs/86+4YTOxAKMXS5geBSsAqTzbraSUrxOkkAWpP/lBRRF0waScvZ/DONPf6F69qDgf7/HxB
 cWXMdstDXR5xvZ4ac/6AiB7DAqvlpYEWuwNabytzj+7fBonHSM5ZWu42oofVDzLIcji79TO7F
 SWsHCIXPrprW3dyUXJxtEyv/fWkpPzmqiu883Sw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The commit d96885e277b5 ("parisc: use pgtable-nopXd instead of
> 4level-fixup") converted PA-RISC to use folded page tables, but it misse=
d
> the conversion of pgd_populate() to pud_populate() in maps_pages()
> function. This caused the upper page table directory to remain empty and
> the system would crash as a result.
>
> Using pud_populate() that actually populates the page table instead of
> dummy pgd_populate() fixes the issue.
> ...
> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index ddca8287d43b..354cf060b67f 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -401,7 +401,7 @@ static void __init map_pages(unsigned long start_vad=
dr,
>  			pmd =3D (pmd_t *) __pa(pmd);
>  		}
>
> -		pgd_populate(NULL, pg_dir, __va(pmd));
> +		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
>  #endif

Wouldn't the untested patch below be more clean?

Helge

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index ddca8287d43b..73de58f31f5f 100644
=2D-- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -387,6 +387,8 @@ static void __init map_pages(unsigned long start_vaddr=
,
 #if PTRS_PER_PMD =3D=3D 1
 		pmd =3D (pmd_t *)__pa(pg_dir);
 #else
+		p4d_t *p4d;
+		pud_t *pud;
 		pmd =3D (pmd_t *)pgd_address(*pg_dir);

 		/*
@@ -401,7 +403,9 @@ static void __init map_pages(unsigned long start_vaddr=
,
 			pmd =3D (pmd_t *) __pa(pmd);
 		}

-		pgd_populate(NULL, pg_dir, __va(pmd));
+		p4d =3D p4d_offset(pg_dir, vaddr);
+		pud =3D pud_offset(p4d, vaddr);
+		pud_populate(NULL, pud, __va(pmd));
 #endif
 		pg_dir++;

