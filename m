Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3161C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939B920652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eTXJw7zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfDPPAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:53687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729757AbfDPPAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555426816;
        bh=PV90ytEQcFN65YAF2nB/G8jZs59RHJ+6SDjL/+Qu5TY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eTXJw7ztKCEZEFYmSQGmZ36vjU6Q0netk7HbUjpBf2Zf3JoD2twcLSHer0MEF0X36
         PyzSRaC66o0yBCfMm/UOJVjiUjE3m9agMCs/Wowo0gWFdZu7R1s/mq+FZ57OYJFvE9
         Zda2adY+zLvrQ1eMWO9oOUvg/gNlt7lbOh4TnC6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.178.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbMb0-1gayxG042U-00kyTp; Tue, 16
 Apr 2019 17:00:16 +0200
Subject: Re: [PATCH 4.9 64/76] parisc: Detect QEMU earlier in boot process
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Development <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183726.478117691@linuxfoundation.org>
 <e99d8712-6352-a94c-74c7-395b66293b9f@gmx.de>
 <20190416142350.GB31920@kroah.com>
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
Message-ID: <b73a9caf-2461-3361-a6ed-b36a5d0a06c9@gmx.de>
Date:   Tue, 16 Apr 2019 17:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416142350.GB31920@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YTRsTxy+NNMDf4Xg+YifHe7oKavivD+a/QqKxdFbrVMQgIVfnWv
 UfC0Gk+o1bshsPcMd/vtK3goqf+2UYDQ6m9k/fwkMOyNtQDYELXBno8cWJZO+u7UsGsVvaq
 4rs2BLZC+5Tqe7KJxqs8gQZ3+GJ6h4KH1G9YrxFiGObl1gnCzzvTogJAD7SY6/tkorLyVuD
 2Eg5GAyvTV4OUItFGYu1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i7Qh4hPZzCQ=:yR4aJSW9JYQ/j6L4VmauAg
 /weDGIyT3Y5LaamPTKMWVwM19VqrTSYIPM2H5dixGdyYfJrcjnbKPKqfmBa50XRgY02tPo7w5
 yT5uatNaGoOWggnQONcBMxavKYLCq7Y1qO1/g7Wt1EqhBYuV+j498tNdlm9IHdK+7A83tRwJM
 GsK80eeGFoUyG455B15BBYqRJBn44PBwIgdgtgjPPiteYfDMQMNq9Xs3ia9M8+aq3GSMO5sSn
 nikY0p9dnIECEoMYtlo/941XnEZ3WNcHPU3fddwC8ElqEDL6vHDxElbpS6KdljupwbNftcwhb
 bRqM0Y/HPBoexgM1oCht8F5eVUsW+av8EYorKRJQPKtFmOCVcv+/jPGXQhUHcPWS401TxvEzU
 80KdEaezPRlJTEoaWpk2MUjtng4HBm3dAtNeMoqnfqXhMm+BDwptfQNpemcS76kP40nPFIhba
 3vHhLjnRxpUiIUmcBmPYyBeZLK++Riuvrf5gcH9dptnADRthGg+CgDPLjX0GSa/Xr1iZFg4cc
 MO/kQ327r4/FFhVlqfXqhTt+a2Lo66y9Brw5AGVb6EjJS1uhpypoR9AkM0WO3/g2JBEQ4UDW7
 tf7TYBo63atEE179TzHl6NJXIi1bjoDHSFkgsGwsNnzJIUH0ObchLbtLTB3DETlVeSNKUfZY/
 qzT2FmrmF/esau3wQ2x6M4GC+uSTBL8sNFhltW3IBTv70HwWfSJq3zedDQJ2p2fR7lkY+IuPd
 TF+H0HfrOmCRIrQUFOV/ypcZ8Y+asCvTzTNkAv27KkH1193YDtipD+M1vq6so+vyxxEQeWcNr
 DKZtrW7hB7cORzGp46FjbUFAfRSzSp8nqDLEdc3NA9oLwhg3iSo8Rckh9N72YW13DI1W4M/JQ
 9bPA1H6Y2uNfy5Q1TVJmj0uA9Ir2CX6CpySH2jwK8m15hpuYPG4DsohagOBZCJUTowtKwt3n9
 9+KDlufzkbyOt9v75opQPySyGsdAVpn9WfKHBHsXydjCbIM4acgPqNLdI2oNT4ttPuJkvWdaE
 sVxAhkbivNuOBOFSUjPke3M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 16:23, Greg Kroah-Hartman wrote:
> On Tue, Apr 16, 2019 at 03:50:16PM +0200, Helge Deller wrote:
>> Hi Greg,
>>
>> please do NOT apply this patch to the 4.9 tree.
>> See below, it was tagged for v4.14+ only.
>
> Yes, but I added it to 4.9 because:

Ah, ok.

>>> commit d006e95b5561f708d0385e9677ffe2c46f2ae345 upstream.
>>>
>>> While adding LASI support to QEMU, I noticed that the QEMU detection i=
n
>>> the kernel happens much too late. For example, when a LASI chip is fou=
nd
>>> by the kernel, it registers the LASI LED driver as well.  But when we
>>> run on QEMU it makes sense to avoid spending unnecessary CPU cycles, s=
o
>>> we need to access the running_on_QEMU flag earlier than before.
>>>
>>> This patch now makes the QEMU detection the fist task of the Linux
>>> kernel by moving it to where the kernel enters the C-coding.
>>>
>>> Fixes: 310d82784fb4 ("parisc: qemu idle sleep support")
>
> This commit is in 4.9.76.  So why wouldn't it be valid in 4.9.y (with
> the exception of the fact that it doesn't build...)?

In my opinion it was not a critical-enough patch to ask for backporting th=
is
and the other depend patch.
Idle-sleep does work without this patch, it's just upcoming qemu-support
wich will not run optimal (but does work).

That said, of course it would be nice to get that backported in 4.9.
I *think* if you pull in 5ffa8518851f1401817c15d2a7eecc0373c26ff9 too,
it should be ok and fix the build issue.

Helge
