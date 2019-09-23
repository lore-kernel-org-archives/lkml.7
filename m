Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBAAC432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ECB2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YeYAgY7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503171AbfIWVuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:50:55 -0400
Received: from sonic313-22.consmr.mail.bf2.yahoo.com ([74.6.133.196]:38425
        "EHLO sonic313-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387520AbfIWVuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569275453; bh=GHWSj3JfbrqwEoVYU22hKmb42OaRWOoxDaLUUGAr8+o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=YeYAgY7axWi89WRlHc1vbYk1rvItQueWlE4eDWkVvRB4GluascfWy9aMTuEB/HZ8OxEdC/jVEG1I3Wpu3AMbFwddd5bF61z9DeqLH4wrWaio7BehUJUuR1vppQ31nK1oYv46Jwe7bc8aH/sFbeYWM8gfnv5ZbCpSIkDzCllXWk3K0KhYW9PYFDD/We3/fjal6v0SR2SRf4MXtu3/9o+kYRUxN1kfP1r0UO9rT5NvfeQv70UzTrMZgL3XV0S/JKrEalc+cnRO/FU0XKYHowsvtB0waRVr+quveviPkm93wJbs6FfmRdE+iNblIV+eY9UGlKQUxloEi0CWL59IVC6E0A==
X-YMail-OSG: g2EXaCAVM1m0Tm5k22ryCQuLS18WAl919fv1xcx3Ed8Qb6Sb_RXGZ2jaE23L4MJ
 bJz0KvB95iwoE4GsDIrslyrYX4eJUMEI4oOmVqB2h1rKeY4lsLJyErHqwUK8Pcg3WmfAjhLDS0p0
 fVOSMEqpcmnJUb_x_RaX49nxF95pINg47m1ycy4YZhxsWAD9WM5kOFCPgleLR5FVnMOdPI7vsvdz
 JLsJQOyDKgYw5iVH1woFm5Y.Uu7FJasR4vKC8lmQiX8nwVZ07.zH177nEMyzcSIP2c1ocUfwyVmc
 GjokF_YjPDMssvXqdVjrAjFUptCNParkO.zIr3zfNaU_d67O0VZ_oEUC5erJORe_OVjPwKD_ruKA
 ITtZadddYLFIA7vx7nnNEmXzM1ucP8tk7vN_JnfSHYKWTvVe11wg5FGFOzwYNHvkTDq9FMm8SAkT
 uJxpXGTEXK_RPne8Kzh75q44RJ4fuKS0I4JgGN3LJN6aNUNpwTcXrQVrV.y.QhaZ4hCHE5LWwndd
 urAiRampUIqNwm27Elv9iLiUh6O84jF34txjbxnO1X7BFsjnxbOtp9gvvfXVPoIXZZI0B0O2eOl2
 3D1dYRWXUJUGKKeF6BRRHdgRf5h7ZBPF00Ep3BAZlKefrod.XkuV9lVIOy_X6.9BoMG.T5SOvgTi
 _9JSZyORagmGCOR0CqwdJoQxE_3UWJvkDlrTUWPuhh4NLPkotPMifNbKX7zbgy0nMLsQxYuEavVm
 LHKWcDpbNTuMsteoia3mjeBbFISL41Y0ibWaTvwTCuA3T7w1xEsJARhPwfBpReZcu1dCHV_oYVIq
 1G92prWVr5LaKYESTP58FP_PmFX.lT1FnF8OlretYOelXV9IKXbSTUNSyW5IhZgily_QfPwZFNg3
 GUCIoFF7XIeZt8QBAAJyWoOrIFW2lRHlywQisiU4kvElMIOH6UBHnaSjVGDtUtiUhyNolTYGVwT8
 .R_WwNP90ok1eFyTvdwW2eaELn.azP8hpVBKfIDIpPKd2DTE6zTKpk8QSIW4KCHz3vySAeQEfFxq
 Ku_R668TV_xqSS4JdpueIL_9KwmOO.Akf1YJOzytBCIVNVEDj5N3DxlFWADosuZsgoghhsy5x9wp
 JYBhsHoAf5IUHB3kLaVG0IezPbGvHiMDBAvTkVetLVwkYvDwUagJdxehd47BADtrw.kPQGzThM8Q
 QeoosFzlNLrCMKv7tuHQszMWm.GZ92WhSmYBb512ArqNTHbpMK5xrSrdntvw9U3H_02oO0idN_rU
 UQ5x4NveE3mDMSWuWAhOdzcf8SOvZAcD8Wcs8VUerkBGKb8oGkEnRYMeJ2QpLbhDh4SYiQsvsEAj
 XSRBTUOZTocL2o31pYdqYNnbqZjQMRQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Mon, 23 Sep 2019 21:50:53 +0000
Received: by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 74a8ede47fc77833356b263ef188a647;
          Mon, 23 Sep 2019 21:50:49 +0000 (UTC)
Subject: Re: [PATCH] smack: include linux/watch_queue.h
To:     Arnd Bergmann <arnd@arndb.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190909204631.1076624-1-arnd@arndb.de>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <dbbf0b7a-125c-9517-4232-dd88bea139dd@schaufler-ca.com>
Date:   Mon, 23 Sep 2019 14:50:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909204631.1076624-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2019 1:46 PM, Arnd Bergmann wrote:
> In some randconfig builds, the lack of an explicit #include
> in smack_lsm.c causes a build failure:

What tree/branch are you working with? I don't see this.

>
> security/smack/smack_lsm.c:4384:7: error: incomplete definition of type 'struct watch_notification'
>         if (n->type == WATCH_TYPE_META)
>             ~^
> include/linux/device.h:46:8: note: forward declaration of 'struct watch_notification'
> struct watch_notification;
>        ^
> security/smack/smack_lsm.c:4384:17: error: use of undeclared identifier 'WATCH_TYPE_META'
>         if (n->type == WATCH_TYPE_META)
>
> Fixes: 5301fef8ca60 ("smack: Implement the watch_key and post_notification hooks [untested]")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/smack/smack_lsm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a15e76489683..5120dd9c6335 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -42,6 +42,7 @@
>  #include <linux/parser.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
> +#include <linux/watch_queue.h>
>  #include "smack.h"
>  
>  #define TRANS_TRUE	"TRUE"
