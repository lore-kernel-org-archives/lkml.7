Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820DCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E32222B2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iu95ZF7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfDPNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:50:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:44713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfDPNuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555422617;
        bh=sAs/3a7DyeCMxgHNtqf1DGpre6Kj8B6slX0hMSVNicg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iu95ZF7RslCJReLV2FsNR40z6BPc88yuVGY9L0hEc/93PtStH6b+/1pY4j1tAqHAU
         gxtVVYSj+hu479RV9LUaqnq+MXk2WjzZ6/rYuwHNvjsbGNwlwqYaqoOw1vPJYgUrQ7
         4vCI1rt9f224E3b1eiYEkl5kG2VEKn0/2w2/fp94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.178.48]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1hIrRq09Bz-0035D3; Tue, 16
 Apr 2019 15:50:17 +0200
Subject: Re: [PATCH 4.9 64/76] parisc: Detect QEMU earlier in boot process
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc:     stable@vger.kernel.org
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183726.478117691@linuxfoundation.org>
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
Message-ID: <e99d8712-6352-a94c-74c7-395b66293b9f@gmx.de>
Date:   Tue, 16 Apr 2019 15:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183726.478117691@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9GzOCumGAfDa7ID73EnRic/kPYozKNdEMK8Of1UC2+Wkn0b5FKp
 JgpQ5YvoR0qSrcxRNCYjPPmZXNpyMt/pz5yWdHc070+HQH18LlJWMVk3Kkt6SSD24e/zAjq
 V6oqvyhH6IuDeVWkAVdqywanEMEn8u1aE6yUJFIq/6ojvq26tRvd+LrY1gTdem0WbO8AxdY
 fF4O9lpBvTk7YlLlsx7/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MIh6PDZFZ6k=:BoYUTeDkjjw18CHw8kzLwL
 szLFu1TIsGDXPSvDJWcTk/bMw/IFv8l6VNOxIjzjt8/uA/y9KPrxohMfgVrV4Oq4aBX+y4nBr
 hXOkjS5PZYaApvXfCCEMdJofANsujSD/cxtTRC/v6VLutL9xZ7GmSPIWfBPC0vAePPA8+UWXg
 Ihj9vYdoY+RF02YsLmF2MouI1Du3+f8Yx/WKXzE3Uhc/ceKFXEYP7pWhWsp6f60IlhpG+MZUF
 t4/k0QovEwRNnp7mMR9ogfF55t0iiJojdEBxHZWqwex3Jk/D17sPe6yzNakqvtB1RNqymbG2M
 NcSBKmHvpXibMVLboAEc3bFudjDoTTujxqGzO3QNtzix9KMbDjgpMd25FI1qKHzEZ5LHRkfKn
 beT4Vj7XesCNlCxRMGzwzSoud5KDrf8gI+4Ju+RcZGUsM/yS80EoghrYL1KBmetSh0zrJH+vR
 5EQ9R5uVzGDuUr23TTZEQtZgaCha2No8BJ2UwShYFAZr2m4kLwz6RIU53euh7mjU4O163S7zc
 chYHIQH6600E7Svyp0XfD3nbHVQoXB0v1MsxH+ZQM5eE2EyJd1OuBrNpxhkBNMjoKfzjUTaaS
 BpnM518ttuKU491+1elTu7sqmX1JGp/DOJTy13bVHH/ihlUrNlTOTJldoR27OlwDy/Oi8pvco
 iduJEmc82FGZooVBsDkQwdcj25PFIyuykCZm+lFu56Sqq1AWQ64PNDVgfgfa0Qrv6tS8KAIcj
 Iy19NGXt5Eek5hvV04n6W0oQSPtQTICYLP5ekgvkEJ9Xd2vuuVNJWt1DV8eBxlkOK97Uurlh+
 u7aJA+zqTzV7Q/vHVQGAK8lySt7ykEU0H98gaObC6nAvEMpWHuosEMimtMNhIl4dNm/jIzG5i
 jVj2q5870B0cJRi5Vqj7M98Oj5OgrP5QdQSznRDPcaKQI+bkI+LwP4phbCqBOk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

please do NOT apply this patch to the 4.9 tree.
See below, it was tagged for v4.14+ only.
It breaks the build on 4.9, I got a 0-day build bug about it.

Thanks,
Helge


On 15.04.19 20:44, Greg Kroah-Hartman wrote:
> From: Helge Deller <deller@gmx.de>
>
> commit d006e95b5561f708d0385e9677ffe2c46f2ae345 upstream.
>
> While adding LASI support to QEMU, I noticed that the QEMU detection in
> the kernel happens much too late. For example, when a LASI chip is found
> by the kernel, it registers the LASI LED driver as well.  But when we
> run on QEMU it makes sense to avoid spending unnecessary CPU cycles, so
> we need to access the running_on_QEMU flag earlier than before.
>
> This patch now makes the QEMU detection the fist task of the Linux
> kernel by moving it to where the kernel enters the C-coding.
>
> Fixes: 310d82784fb4 ("parisc: qemu idle sleep support")
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/parisc/kernel/process.c |    6 ------
>  arch/parisc/kernel/setup.c   |    3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -206,12 +206,6 @@ void __cpuidle arch_cpu_idle(void)
>
>  static int __init parisc_idle_init(void)
>  {
> -	const char *marker;
> -
> -	/* check QEMU/SeaBIOS marker in PAGE0 */
> -	marker =3D (char *) &PAGE0->pad0;
> -	running_on_qemu =3D (memcmp(marker, "SeaBIOS", 8) =3D=3D 0);
> -
>  	if (!running_on_qemu)
>  		cpu_idle_poll_ctrl(1);
>
> --- a/arch/parisc/kernel/setup.c
> +++ b/arch/parisc/kernel/setup.c
> @@ -403,6 +403,9 @@ void start_parisc(void)
>  	int ret, cpunum;
>  	struct pdc_coproc_cfg coproc_cfg;
>
> +	/* check QEMU/SeaBIOS marker in PAGE0 */
> +	running_on_qemu =3D (memcmp(&PAGE0->pad0, "SeaBIOS", 8) =3D=3D 0);
> +
>  	cpunum =3D smp_processor_id();
>
>  	set_firmware_width_unlocked();
>
>
>

