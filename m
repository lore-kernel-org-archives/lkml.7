Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47DA213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="edsbQroI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfFYOLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:11:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:46075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfFYOLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561471750;
        bh=O/AVriiFXTyhIO2mqpq3Ioyp28ORdxttZFv5ecPR+mc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=edsbQroIWHv5PrtjtfjZNIhaA6vbnnEhe2iPxwgKuAPNIOGmyRqiQTBnaT/rlfHpm
         upx5WA233sSsPfr45ICeSv79Qf5cEZ7WBrUjnMGLpmwlqPsbkccAq0Vt0A31t0Dihd
         HbD3PjlIvvSVLRMDuhhPe5yAPKH6w2z6pgXdr9n4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.144.45]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1iQLEd1s3V-00kkGd; Tue, 25
 Jun 2019 16:09:10 +0200
Subject: Re: [PATCH RESEND 6/8] parisc: Use mmap_base, not mmap_legacy_base,
 as low_limit for bottom-up mmap
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20190620050328.8942-1-alex@ghiti.fr>
 <20190620050328.8942-7-alex@ghiti.fr>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <438124ff-6838-7ced-044c-ca57a6b9cc91@gmx.de>
Date:   Tue, 25 Jun 2019 16:09:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620050328.8942-7-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGeLQJsmVPbobDimclHPwWqvExkEWwDRtzy5sld1Sw9SxJAviNo
 VuQB0COfpiok+m5jvyYs01Ly4kyUgKDpl5OpmZGb/VVWXwVEOjDdoK9ZoeMc+DIU6pRZJt0
 JvuTryyyRf7udxOK0xUojwH4decoxd3bBxJesqe7Pgv28mN4zgXudEpsMh5cxdU6PS/wnLK
 yVxaq1UtwUSVfYPzYTqGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jsCViK54bZY=:vmFM6D3KKJj8EdDNSBPHOx
 lzUVh6ZBu/d0aTycPJ2LhVS/jmSEMNKPUmN3LvgGTC6YrnAIyz3rS6JQHslHLHWyVmxE4saQa
 +fQQxuXvHwKqXtKwuVz1hK0lYc3/+2wJMpQLabsnIWgBZttOakJB1ypeAt861TLVxq6y4Wp2v
 X+wgqwjaG5GHOp6o1uZY2R09MQlMboRqyVThCNzlbRJkML3FJs+AkqChxGbXXVQWtlFrvLXlp
 /r3i63bR7dwqQ/lVdxROq6jgqeBusB/XX8j2vLZEUrJ5oArlXLrKS4j26V6FxvFU0bNT+dRnA
 7T0eeUu8Nw9iOswaCkE1tAwWK9ID6QyD6FIvV1alI5qogfR9w6xnfQ2n1gULDBVOQVSV4Ckpa
 ICrDPCmYhGv81wPmTrpCtIeqk1wryhgnH//XfwDUcW5aGAP2B6EXzeFjgshbKCI8igg0nlo1V
 0knzlxwd/g1dibOMDu2rlQhdYlQhXk/i4y47JiykhczbUlWLD9ZTAkuIARhRE9nTbApTXWk9k
 igKE6AKH1j1BVDP3QXtoI7Bfa/0R2y2jNvbGEJdS2hm5Grxf7WlQqutaCHBEeKUZGIugchGJH
 gBPQthXqSgnYQKIaUipVcFiGN7ASlZu/AyHXOmnK+cxPqp+7nZOrdLA+R1oJQoAPzKx+4exHU
 KKp9xUrQDhsXVEuYzRfJoNZ130+WizBAcQg2gPW6pPmtkkNgbWquLNhsc2clAT2FoPbOI8x7B
 kmAyyqfuC1EDnNrjeRo0iCSK3LYKk/fcvbZfxZa1RWn2M8ddvI9a22Bp9qq97UDj+WtLC7vzT
 chRiiAJr+z8rfg0rrxA0L/LuHLgBMrOxgWiOumM4Jze/YlpuDan2OZTHh/dmz0N/PThNRJo7g
 +cenmgWIQdaMLxxQNZ8xfIKQPhNB7txhrtbTU98rZVX8j5AONAf6BJ93pAiB33GQIZCMzB+hD
 ieobmt2ei079i9U2TIxlya1W2BfBpxKI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.19 07:03, Alexandre Ghiti wrote:
> Bottom-up mmap scheme is used twice:
>
> - for legacy mode, in which mmap_legacy_base and mmap_base are equal.
>
> - in case of mmap failure in top-down mode, where there is no need to go
> through the whole address space again for the bottom-up fallback: the go=
al
> of this fallback is to find, as a last resort, space between the top-dow=
n
> mmap base and the stack, which is the only place not covered by the
> top-down mmap.
>
> Then this commit removes the usage of mmap_legacy_base field from parisc
> code.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Boot-tested on parisc and seems to work nicely, thus:

Acked-by: Helge Deller <deller@gmx.de>

Helge



> ---
>  arch/parisc/kernel/sys_parisc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_pa=
risc.c
> index 5d458a44b09c..e987f3a8eb0b 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -119,7 +119,7 @@ unsigned long arch_get_unmapped_area(struct file *fi=
lp, unsigned long addr,
>
>  	info.flags =3D 0;
>  	info.length =3D len;
> -	info.low_limit =3D mm->mmap_legacy_base;
> +	info.low_limit =3D mm->mmap_base;
>  	info.high_limit =3D mmap_upper_limit(NULL);
>  	info.align_mask =3D last_mmap ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
>  	info.align_offset =3D shared_align_offset(last_mmap, pgoff);
> @@ -240,13 +240,11 @@ static unsigned long mmap_legacy_base(void)
>   */
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_st=
ack)
>  {
> -	mm->mmap_legacy_base =3D mmap_legacy_base();
> -	mm->mmap_base =3D mmap_upper_limit(rlim_stack);
> -
>  	if (mmap_is_legacy()) {
> -		mm->mmap_base =3D mm->mmap_legacy_base;
> +		mm->mmap_base =3D mmap_legacy_base();
>  		mm->get_unmapped_area =3D arch_get_unmapped_area;
>  	} else {
> +		mm->mmap_base =3D mmap_upper_limit(rlim_stack);
>  		mm->get_unmapped_area =3D arch_get_unmapped_area_topdown;
>  	}
>  }
>

