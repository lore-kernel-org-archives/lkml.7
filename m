Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B3DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62473218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfB1Vjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:39:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:55707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfB1Vjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:39:47 -0500
Received: from [192.168.20.60] ([92.116.140.166]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh6lB-1gdf9k194z-00MItU; Thu, 28
 Feb 2019 22:39:37 +0100
Subject: Re: [PATCH v7 15/22] parisc: define syscall_get_error()
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
References: <20190107025101.GA1182@altlinux.org>
 <20190107025414.GO1207@altlinux.org> <20190228193855.GA13217@altlinux.org>
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
Message-ID: <1abba4b1-82ef-c23c-c59e-5562dcb5b1bb@gmx.de>
Date:   Thu, 28 Feb 2019 22:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228193855.GA13217@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yPpfGJTTW761uqh83UILaB+2c86T844OQ1LmJudcKPTC7BiURCk
 mH1WaUOWfxydjjoh+h8jZqYsdAXUKD2r9Acuu910psR9tiIaIU8kaK6NqPne7GoZUr3rPt2
 mfuHspxMpyhusB4EiUt+XffAch8LHu39wNgINX8AOIL6f3j1iyemvYwN7LLyFwPLGLTyxv0
 YlAW8mMS72CCULCdUlqAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gBbuB15lc9g=:H47O/nMlvnM7uYUrwUjm83
 it5UQ6or29JLV3MUNqpalvFG3W8G5nkBes+U3wt+5zAO6J3pwW91DQNfDHco/9FK5aMzyYff8
 ClRoWaUTRmD5GQZj6q1QZmxCoqweofzXxPqXQ4YruH5fUc4JHR92q9d5v8JufHvURnJcC5cGH
 +ASiUpzExzU0/iYf4c6r0uGp5BdtCV1HmAiw74vpaFF9Bf9+hWqFCxcgqW3pbupEgqT2jCPoS
 8z2EJF2V/5AZbGwH3RVyPdzxRt2xmnQyEemHHph9mVT99w4PCIhn7jCtyLElpk9lY2GfcOOwh
 c/EtY0qzKMQHPfTqpbGOoYOgfMi9Q+FDh4K4X1uAUSWSwV7dO+4e1GVIBxJXvfOUI7w0DS7B7
 QImeeeF3GXKOyXkyuPpSdQAY9wjEMA+Dr+a7ImTHaoxl8h9zsg9hOQMRZCqgojHi+HVL8xB0l
 sn4g8T4apKdM6RQOdK8u7Puk2/rd2j2qwhK7wq6CjEv49BVk5B3vnQNe1c7ryHHRVi+nLShoE
 kXO2QB0NWyunVFVUKeQToAHdFaaX0KqEUvyBjCr6AXKdrEILeqqAf3SGCCq/g8P3IN/+iDPmr
 UpJX9MWskOfJhbq+9M0TOjCbqZ5b5vA5ZBz7vi9+MkCPxu2DY9yNosYuL/uhmYLHy4v6N5w37
 YrC1+grPWMIkz0MbX72bUkJ2phXgEFmV5epTh+YcvrjZtCU6w/Nvp5ajSIHIaqGMGV+BZmp75
 CMjhpW8i3GtPctoxvwxBnepezgkpWxau3pyfUkefPZCFiHaa6LFC9WNPfVOdmj06+Ix7PcKyg
 evH3Un38SnFk/GV9kO8SGX+4kY+gMunbDGLTpVhZlJ36eN3GdDBSwod9OOXJdWLYEIJP8XceK
 XajxXTrd9N2fjj59JRiDWfGtjyNDTnVHuAGssXKL1DiRanBr1NGB/zKYkyffX5GqtGkwciSEv
 /cfI0jvthu0ntRN3anFrzXtAQK+DLy66GWbRMVGcfskNxR5QZeC3ZNgnB9VwgcS5y+HXRqWvi
 0eVZvtCX8LaYGbser48BY2o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.19 20:38, Dmitry V. Levin wrote:
> syscall_get_error() is required to be implemented on all
> architectures in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_return_value(), and
> syscall_get_arch() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
> 
> Cc: Helge Deller <deller@gmx.de>
> Cc: James E.J. Bottomley <jejb@parisc-linux.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge


> ---
> 
> This is just a gentle ping, the patch is unchanged.
> 
> Notes:
>     v7: unchanged
>     v6: unchanged
>     v5: initial revision
> 
>  arch/parisc/include/asm/syscall.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
> index 8bff1a58c97f..477511ff7546 100644
> --- a/arch/parisc/include/asm/syscall.h
> +++ b/arch/parisc/include/asm/syscall.h
> @@ -43,6 +43,13 @@ static inline void syscall_get_arguments(struct task_struct *tsk,
>  	}
>  }
>  
> +static inline long syscall_get_error(struct task_struct *task,
> +				     struct pt_regs *regs)
> +{
> +	unsigned long error = regs->gr[28];
> +	return IS_ERR_VALUE(error) ? error : 0;
> +}
> +
>  static inline long syscall_get_return_value(struct task_struct *task,
>  						struct pt_regs *regs)
>  {
> 

