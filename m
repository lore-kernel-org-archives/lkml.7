Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52617C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E01920650
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EZtKxspf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfKFQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:40:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:51659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732172AbfKFQj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573058378;
        bh=JQXg8hNUzrWyatdDFQgJj+8X8SU+sERH0m5SVc2HB60=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=EZtKxspfvVzAoDso4LwsF2wOSvLdXodktOeZEQxMQRkNAk/ILe4SRvbK4VC8bDaaE
         UUmgBof5TDcotPrUXPWlN5VY3tg7mhRb9pZ9p0naTPjoxK36iriCzpuFOUR789gDHN
         z8MvpLDztqJy4qLetQ4bdx/b8wY48hXCZeiR/JoE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1iKaJ40zcy-00RVuf; Wed, 06
 Nov 2019 17:39:38 +0100
Message-ID: <9f6b707c69ceb34e3916b1d47f2e2fa6a4f025ab.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Wed, 06 Nov 2019 17:39:35 +0100
In-Reply-To: <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
References: <20191025135749.GK17610@dhcp22.suse.cz>
         <20191025140029.GL17610@dhcp22.suse.cz>
         <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
         <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
         <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
         <20191105182211.GA33242@cmpxchg.org>
         <20191106120315.GF16085@quack2.suse.cz>
         <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
         <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
         <20191106150524.GL16085@quack2.suse.cz>
         <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: multipart/mixed; boundary="=-tHCgSIlg3PheX7osEgF8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:4RuDGROlTwxb9rRaonlVDNEpGFPXgE5cqINsbE9QQM/x4FN8OYB
 7icV2hCrUOfcm+QNTr6wVbnxG4P5zx5Et39xqyRDOjBCcLPPRy/ThCKe3SoIHc3WdIG20J2
 umghYgcU9LWH8jgR7Zxb1GbfirYHuGSm1JkGVoTaIFMk2hiAHwNJWuD7sYgvjsWcdACiTrg
 dkSKU24PxZbi4kYjKmsjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5yH4tQZfFmg=:XHN+BzY0RNYa5TWCU3tloy
 sEIGRlRoJwFSQqOcNCMYA2HdRJxAyPS80euHQIztsgEwwIqDfQbk8S3ZlLj9x86J7fWPrwYxU
 2KMqNFpVmE74uFKYwAV1NJwEewb4gcaH4xtq2+eX5kGkWcujr9f2R3JJiLludpeAJZmmadfwz
 F9OneHwYvrYqhnA4v2vx6euhGJc2yAVGo6TC/jXxoQo1DDrk8OiekBx2Q49q6eCiIsu4yPY1K
 gr9/Uf3jNNrPRHW64jvxGaDMGW8MWmXJcSlvZnQc69gZ+jP9DXGf2PGVFOUmFg5+kBHhWd2vn
 D7Fn5wdqK/iwtPqQDoTzQkjk4cBrySPM0CdSZiRJfDYW1Ir4zYqV1tdVFNCzzHZDMYvqyVjAQ
 MPgrzcxOiW+tgLfZWLe7p10U1Xv16DykdAGsEp0RkngCTHFGYh/NQouWsv26dHKeDEyXlKbgX
 GmPlAKod0V9nMAoNKFXTuYss2Tu8xvSDrjk8ZSUa5+uh81CM+hRtqoWTemUoHg2sjjj1qNqWo
 1uWvRoHqlINWrwilRORLAdaFf97OB9JJjXQGkXXY4S8Z2kB1OhztzDM3y5N14vJinsg42EwYD
 vaq3IpnbtCgpEToO+vEwpqoQQiyHJisIGfNaVJMBeWNOx+tGq0UYQlxaH35AgdKr9Meh1DGrJ
 6cpK43nnA3RzaA6SmcGKrepYUNNi+MMRqUnXhAuLexbwqUvphrZNAAYB/0pcK0HdIce1V4ni8
 2e736BN6YRCIy7Zyh/dAVhyHqkLW9PtNr9FCiDXhi9+wp/iDZbfcWDA7SgFxNpY3fzUntPxuC
 QgNxmC3OiXqDEvR9HPJemai8i84LFwPmXNcaisRo0uKBjxG021prSlOmQyA2nYCzHiaEwfTvf
 PaFMdNM4w0CH7QWGBVs/xOYCgKs0VHOHh4kwtay3Hdf9IvJd4qptZ0VdFjFGG/X3U9wGgmX1d
 tmanliJQ4D25mtsQKEosJOKKWiVTpDaM1gQyapk5ou+gbzqDI36h0hW0sdD9gUNK5tU0kgvQV
 /uh2Rm4Ye3Pi8yE419NW8JB5q4g/tMrWZ7Div8T0bzB/roEeHrCB7kn1PSk1gdE3HmVjayFei
 ngqLqDHO95AOot09yDKyTQ6faxNtwvNTabjtkVy1cCI6/eRwrDpZRoBuZb2kRbSlXZbGOsFoU
 WN0TxtJ9z2m2IaOSOYDzUx/egKFEgCZdufRmeJYk3GnCL3/+XVET6eek4TpEu2d2GQu7E7Qu9
 owoN1EDHOXw+mxiZ4XODXjq5QH4PAZ8tYch7SUOuaY7r0PVcliSnVEFvpcxr8DPZDAGkLWD9n
 fAJcvkuxb0QV8nsKY48GGnpVn9ZrTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tHCgSIlg3PheX7osEgF8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-06 at 10:14 -0500, Josef Bacik wrote:
> On Wed, Nov 06, 2019 at 04:05:24PM +0100, Jan Kara wrote:
> > On Wed 06-11-19 09:56:09, Josef Bacik wrote:
> > I don't think this will work. AFAICS faultin_page() just checks
> > whether
> > 'nonblocking' is !=3D NULL but doesn't ever look at its value...
> > Honestly the
> > whole interface is rather weird like lots of things around gup().
> >
>
> Oh what the hell, yeah this is super bonkers.  The whole fault path
> probably
> should be cleaned up to handle retry better.  This will do the trick
> I think?

I tried the patch, and it seems to fix the `mlockall(MCL_CURRENT)`
issue for "my test.c".
However, shutdown & reboot are still broken - i.e. the console says
"Reached target reboot" and "hangs forever". Shutdown & reboot work
with __get_user_pages_locked(). No clue what the difference there is.

Anyway, I've captured three smaps outputs: from 5.0.21, from
5.3.9+"nonblocking patch", from 5.3.9+"__get_user_pages_locked". All
three look okay to me - although I don't completely understand why some
areas are not locked (-> "Locked: 0kB") - but "Locked" is always equal
to "Pss", so I assume that's fine?

>
> Josef
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 8f236a335ae9..2468789298e6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -628,7 +628,7 @@ static int faultin_page(struct task_struct *tsk,
> struct vm_area_struct *vma,
>  		fault_flags |=3D FAULT_FLAG_WRITE;
>  	if (*flags & FOLL_REMOTE)
>  		fault_flags |=3D FAULT_FLAG_REMOTE;
> -	if (nonblocking)
> +	if (nonblocking && *nonblocking !=3D 0)
>  		fault_flags |=3D FAULT_FLAG_ALLOW_RETRY;
>  	if (*flags & FOLL_NOWAIT)
>  		fault_flags |=3D FAULT_FLAG_ALLOW_RETRY |
> FAULT_FLAG_RETRY_NOWAIT;
> @@ -1237,6 +1237,7 @@ int __mm_populate(unsigned long start, unsigned
> long len, int ignore_errors)
>  	unsigned long end, nstart, nend;
>  	struct vm_area_struct *vma =3D NULL;
>  	int locked =3D 0;
> +	int nonblocking =3D 1;
>  	long ret =3D 0;
>
>  	end =3D start + len;
> @@ -1268,7 +1269,7 @@ int __mm_populate(unsigned long start, unsigned
> long len, int ignore_errors)
>  		 * double checks the vma flags, so that it won't mlock
> pages
>  		 * if the vma was already munlocked.
>  		 */
> -		ret =3D populate_vma_page_range(vma, nstart, nend,
> &locked);
> +		ret =3D populate_vma_page_range(vma, nstart, nend,
> &nonblocking);
>  		if (ret < 0) {
>  			if (ignore_errors) {
>  				ret =3D 0;
> @@ -1276,6 +1277,14 @@ int __mm_populate(unsigned long start,
> unsigned long len, int ignore_errors)
>  			}
>  			break;
>  		}
> +
> +		/*
> +		 * We dropped the mmap_sem, so we need to re-lock, and
> the next
> +		 * loop around we won't drop because nonblocking is now
> 0.
> +		 */
> +		if (!nonblocking)
> +			locked =3D 0;
> +
>  		nend =3D nstart + ret * PAGE_SIZE;
>  		ret =3D 0;
>  	}

--=-tHCgSIlg3PheX7osEgF8
Content-Type: application/gzip; name="smaps-5.0.21.txt.gz"
Content-Disposition: attachment; filename="smaps-5.0.21.txt.gz"
Content-Transfer-Encoding: base64

H4sICIT0wl0AA3NtYXBzLTUuMC4yMS50eHQA7dpbb5swFADg9/wK/4E0tjEE+raLqkpbpWjd9lJN
lQEnQYUkgtx//RIw1BBwAwq0Ss1DJXJic+mng88huqFhalNMIIR9ne/ohx0Q9vsLAPkGENRuIQbE
QjrGGgQn22A6D9ggmtH9buCyNfMHgRc5g/1+P1iyaNl79Pbs9nQYAS9fez9YOGP+iE5Y7ltx7OHh
z0kgjf2KopIpk9hIEnuc0pC5z998RmfCl6AQ++6Fy10xNgq9NV2y4kAixgoD43G/2JiFbOYwN3dK
8bgvs/lsF8xXhbONx/083My7kBXvG0zH3a8m7HhzosLxHqcBC0aB+0AXC+GY4vUdhy59Ox9Lr6EQ
TMZt6KLkhmaxkvudXMPceSlcd3btv+9HzPcmnu0nlwh7f4M7n04OM4UuCEIQbEDAgLsB/hxELuiJ
QDOtRqJ1m2hFSqvS+g5a2VYG1hDBDnPpFSuwCuzHSq9DUauptNbRCiVaSUOtRGktaKVODqwpgrVi
sBsOVlNgFdh3ALsJZWYdNHw16yArbzauuCC8Pf49Pel0e5oyuvhXThNp+OI0+ZylNHmsM5r8eKU0
eayUJo9dLU1+fefTfHU5HNuQWsiIayu+Y9LqTgDR4JBo6PTMB75nD7am8WyQvu/NVtv+ZLY6fuj0
8Y0Gb6J5hVliXt5sMmftdIoIaWi22WqVn6darb75/OdLVREo16oli9O0E5B0sdrSinR48Yd/Ome5
Vl2r0oqI0VArkT38K7Wm5/k5tSb/h/ObATmwidEULHGE9Iost9X0ii3j4umVz1kO1qpOrxiazcCa
ZqP0ys/zc4K1GqfXBGimdSxqZUarWgG6/AKWz1muFXW7gOXHK6+tUPUClseuVys6YwFbuXpNjKZg
dSxUVYhZCuxrTIE92VoEK6u4EqaZWbO6E1ABD7fQhcKShSjuuAuFJV0oLFmI4ivvQuGaXagTeKYm
wDOJtNTHBJHTM69Ilu4bqbLzvimUiG1a6DcqnYC8b3rlK9EkVvu1lCg05Uolb/0vzBVply+c+Jy1
ufJxnXHlx1Nc6732F5FmYpmYYLHWZoJtofsPJN1/aYLNvRnoIMFKuv9KrDTBUrF4smGOq31V6wH1
HvVjcG384l9EmolFYumEHSUWKLEf6c2/6DRDK/aozqv3lT1lr269P3YdXdN5vR/vDPUmPzmJltR5
qfzNSbd1Ur4W6uI3J0ajOonHrhYmv77zYU5cbjOFaVsCTFt8KXo2zPWahhUuW+nM83tcv93URsKU
tZtgpUtVDSXLy8UYeHPgHh7WrpgtbUdE6ebaTeeidKN5FUrVA1Uoz2oqsRjlONuMWF9f/ADVwPm0
jnaRQ32/U5gqW14LzN5/RgOIKjI6AAA=


--=-tHCgSIlg3PheX7osEgF8
Content-Type: application/gzip; name="smaps-add-nonblocking.txt.gz"
Content-Disposition: attachment; filename="smaps-add-nonblocking.txt.gz"
Content-Transfer-Encoding: base64

H4sICMPvwl0AA3NtYXBzLWFkZC1ub25ibG9ja2luZy50eHQA7dpbb6JAFADg5/or5g9QZ4aL4tte
0jTZbWLa3X1pNg3CQUlBDXirv34VBjogoBAgXTs8NMHTGQb8Msw5o6oClQcwGWCMJZWdDA8nyJek
JcLsQATLI0yRohOVUhmjk6M/W3jQD+bG/q1vwQbcvucEZn+/3/dXEKx6T84eRqfNFPT6tfcD/Dm4
Y2MKqf8KYw8Pv08CcewxCHK6jGLjktjTzPDBevnmgjHn/glzse+Ov3rLxsa+szFWkG2o8LFMw7Dd
I9jgw9wEKzWksN2X+WL+5i3WmdGG7X4eHuadD9nnhuN29+spHB9OkLne08wDb+xZD8ZyyV2Tv79j
05U7Scfie8gEo3ZbY5nzQJNYzvOO7mFhvmbuO7n3X/djcJ2pM3FhdHODe3+8O9eYHvrxLeT5yNsi
D5C1Re4CBRbq8TwTq3pkdRdZJcKqsNq5VdiVcdV5rkZqaqWCq+D6kaZWg7c6EVarWMUlVpWaVhVh
NWXVMFNcJzxXM+S6ZVxlwVVw7Zzr1i8Tqw9smojVh0ROiQ3zLIxHx7+nQ46P5xkYy7/5MIlMG4fJ
+syFyWKdwWTXy4XJYrkwWexqYbL7uxTmu8qBrU8sFSKV0YlNBsXZvyLjgSKT03H3XWfS3w21F02R
XGe+3knT+fr4oSnRWxnfBosCscqwebFRn5WnUqIoNcXWW6WycYpV6pk3P1ui8jwjqxoe2nz2T9U2
rRIVN/7aj/vMt6riIqtE0Yb1rMpaHavxOD+n1eh7uLQAwHNlQmOuls5NrUS3Wp1aqa41PrWyPvO5
6sMirujwfqnHVa/FNR7n5+QafQ+Vp1bGM7Fq8lZBa9UqIs0vXFmf+VZJtwtXdr38jIoUL1xZ7Hqt
krML16JVKxOacLW5XIqALri+xwTXk6M1riV5FkMaiwW1OPsvYEdbqDvRkgUo7bjuREvqTrRkAUqv
vO5EK9WdsuzIcVM0ZkfCs+L0nipEOR13wURpnZkmO6+TFiZMKJ34N1UnFVtQ+cn92YQpZwuK9xlj
leXi3f2GsRK5+XSJ9VkZK2vXGVZ2PYG1yvY+TzTxmtoypXKbk2sLtX5UUusvnVxT+wAdTK4ltX7h
tQyryWO1UlgnV7USEDumHwNrzQ1+nmjiFfiEiZrCKxJeP84OP680IctXpS7L8YU8Ia9ajm+bhqLr
rHYfnrBf7lX8YUmwMszXwl+WdJsdpTOgLn5ZotXKjljsalmy+7uU5dRiMmOWgDmWIJ+Wns6z3GwM
v0BlK3V49oSrF5jamCzLCky4UKXIgY4klzZyFsg6vKYtfqYEmSeppApMl5K0gkURSVHzFCQvKCNB
SNJODi20J/EfhNVO6TKaz5vgLTAN1+2UpZgp/3eWB5O9f/ZL/0MDOgAA


--=-tHCgSIlg3PheX7osEgF8
Content-Type: application/gzip; name="smaps-get_user_pages_locked.txt.gz"
Content-Disposition: attachment; filename="smaps-get_user_pages_locked.txt.gz"
Content-Transfer-Encoding: base64

H4sICNHywl0AA3NtYXBzLWdldF91c2VyX3BhZ2VzX2xvY2tlZC50eHQA7dpvb6IwGADw1/NT9As4
21IQfHd/siy5W2K2u3uzXJZKqyMDNeB089OfQmFFoQMiZOfKiyX4rPzzl4c+TzUt5FCbuRMIYd8U
O+5uB4T9/hJAsQEEjRHEgDjIxNiA4GgbPC4CPojmdPs6YHzN/UHgRe5gu90OVjxa9e68LR8dDyPg
6WvvBw/n3B/TGc/9Vxy7ufl9FEhjt1FUcMgkNlbE7h5pyNnDN5/TufRPUIp998LV62FsHHpruuKH
A4kcOxgYj7vlUx7yuctZ7pLicV/mi/lrsHg+uNp43M/dw7wK+eFzg+m46+cZ3z+c6OB8d48BD8YB
u6HLpXRO+f72Q1f+JB9L7+EgmIzb0GXBA81iBc87uYeF+3Rw39m9/7oec9+beROfjy4uYO9PcOXT
2e44IQNBCIINCDhgG+AvQMRAT+aZWWWJ1ZfEKtJWtdXOrfIXFVcmc+W51Io1V831I6VWLludaqt1
rEKFVdLQKtFWc1apm+M6lbiyeJ4abgRXQ3PVXDvnuglVYh3HNDKxjjMkObGxXwhH+7/Hl5xu94+c
Lv8Ww0QGPjlMccxCmCLWGUxxvkKYIlYIU8TOFqa4v6ow31QOp45t2Nw29yrFDqXl1T8x4JAY6Pi6
B743GbzY1oNF+r43f37pz+bP+w/dPr404GW0KBFL7NOLTY5ZO5UiQhqKbTZLFdepZ6nvvPnFFFXm
mVh1IMZy9Y/NNq0iE578tZ8es9iqZZZZRcTEzawm4+paTa/zc1pNvoeqDQCZqxCacrXkxipyWKup
FTvWyVOrOGYxV9suTa27p9CM69BqlFrFdX5Orsn3UDu1Cp6ZVbn6R9xq1SpAp5+4imMWW0XdTlzF
+YorKlQ+cRWx87WK3p24ls1ahdCU6xBLtRTijub6FtNcj7bWuCrqLIE0E2uXV/8l7HALfSesmIDi
jvtOWNF3wooJKD7zvhOu1Xc6YkcNiR0lyvIeE0SOr7skUbJ30mTnfVKo8Nq0uFf1SfUSVHFxDyu/
1d+WoGSfKVbXKl/dPzFWZJy+XBLHrI1VjOsMqzifxlpneV8mmnnNLe9jo83k2kKvHyh6/crkajTs
RjVNropev/aqwiqXTGLBNMU6OauZgF4x/RhYGy7wy0Qzr0gumLCrvQLt9eOs8MtKM7JyV6paja/l
aXn1avwpM4htiUwZ79gKdqXbfbSi7lPpL0u6rY7yFVAXvyyxGlVHIna2LMX9VWU5Y0JmyjL+VV7K
kucmnFVZrtc0LFHZSh9ePOH6DaY2kqWqwQRLVeoaaE9yOQXeArDda5rJmZLLmZKjXIOpKkkWLcpI
6p6nJlmhjcRjktNsi9/fsC9/ENPsV6N5v45eI5f6fqcsdab831nuTPb+AeHe9VADOgAA


--=-tHCgSIlg3PheX7osEgF8--

