Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743EBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3766420835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CGo3Vg5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfJFGks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 02:40:48 -0400
Received: from mout.web.de ([212.227.17.12]:51741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfJFGks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 02:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570344017;
        bh=sWP2SY8wom2GDKE3LpKb1h22cbcrFVjdmM3Wl1NDElo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CGo3Vg5UD/cJRNwn3xt62XpPcJ2ItSxHXpn0AvNrFzD7f6z0ep3wczVgHuxkxeJjF
         /SqBeqRGnV2hr757NF8ZOs89d6BsjQtJk+pd2nc6xUycbmNwfO1LJB1UPzyJpR2HRV
         IopTAYee4H8OeLKqhGfT42/YjeiayI2JKStnVjR4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o3y-1hxg9D2FuE-00tni1; Sun, 06
 Oct 2019 08:40:17 +0200
Subject: Re: [PATCH] scripts: add_namespace: Fix coccicheck failed
To:     YueHaibing <yuehaibing@huawei.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <20191006044456.57608-1-yuehaibing@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f9862128-8fa2-812e-cfb3-c9953b9e98a2@web.de>
Date:   Sun, 6 Oct 2019 08:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191006044456.57608-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TyfA1w6YQs9bcygtA6k7xpfOrI+oVQ127NQYVccFzBaSCPilVFX
 RKF4Srv+Q8PrsyyoPmd/KKkWS9LFLrzGyWCYDb05Rdgg5QL4oQ1str4LDbeMTVYQm908IvU
 a1ms1C2qyeS9PwjJ3bpEIOXN8co9LwSWpI9K7qjQmXuSuaBCBY/HiYSwDAMzYAipMLV2D0m
 eYQx4B8Rs2do8PMpJB6vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q2K3p08Do3Q=:6ymNo6jeVPvLYf8BM+s5ZK
 Aq4xzoh9M5ZYHMtlH9ObuX+a0FgkoEekwg8XiIZsQnGIFqbi+qsAGVpvV2POuL5kA5afIMjR5
 lNd5ygxQ3QnkgP4fF+OIKlwHYarUqgCn6MOwG5YqvgIg6zR2i1vnMd6invKU3FI/wr31yBbkw
 wWDfCKI8Ky6C+5Dd5TM4kp8iQUI8vez9/FXh4ruDVZCPtp+hy6ravYDQpUyH837RsNXnYHZyc
 I1vPLIdjOBtagBtCgZSEMmV4yfH+9mog4GfUnnRGj6kiDjvLUyfPRYRQ3YS6AkiflkJ1inXDV
 YVJ4GfnumS8Wgu+EbOjYJmF/n23ecu1NWPVXRxbRaYSpdVpq879xyAu0X0VOtviFer4w9wB9R
 qKDsgYIBHVSiPVV0we+wYYge43yLS3tmQI+oA7j8jpgueAC6feGVfb6W2FX4lSjs56qSZySXm
 IGPf8Rp6j932WWXJEd88/T8JOG82yuaQ3/nBVRvhcL5EaqpC0MEpmKLnO/8DfaJlJJa0LvlQk
 xaMvk3FO8RwnwGn1ZezTY6RqjLshsEUkYFMDylXNeKany1D17QYxqh1WBleJnSCmjDm4IDz8+
 COcQ5zDPJPcrXCugKB7xk1p+BF9NmcoOz0yWtpDMopCQ1mQiC+bbpGSrsIYTcsKMBr7In9jjd
 1ZtZBrKJcqebXwaC170yR/pOAMqSyJmKi616uwhcLyQsdEq2iuDxKFxFKVii6XbfCjKyBKvDs
 BBjuM63bVRcCRY7krxlNtUEeGaWO0lsVTiHF0ihI1KNbGgIaZKuqokSRRyypvFjJeAeekBNeb
 jpL3vhL1a0tcxWQfVmWh52kbVPBX4vN663SsbUWIBJjTQmsvF3qq2rJG++HyLYIU62ySFh3Cj
 COcW+SLlOR+jT1qSz7fjoKh+wAupTIuwQvQ/p1dGfWFthc0aCV8yEhxat/MMcTT/8TkAvw6++
 K/4zZI91xbjIFmUNAu+3ZMhv9tHMhDzmzkHHFV8Fx/Z3tOt3TegDzIOS98Ujh0BNho416xTeN
 cLdCpc2T4BIwJL/0vLKdooQvht4wYW3o0ieaJPf6r7rIZXNHYET2xWdd8hr3EbJzixIwgd7dn
 2tGaBAj8x/vrOMwddHYdtbv9v8iEHh8j+JWujD+fK+W0p3YSzaqbSHt4zteNve3apwLEtJUhv
 xr37cdvttwovldYECfvKXkhp9wmJPIb/EQB/nhYrZzAIAhyrbKAzFmW38IX9dGTQsU6s5zkZD
 h/H5+rlfYgoV8nK+D7F0ZO2rIhsPXmgi9zBownK6nYLA6SRFNfZqJitD4GjE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now all scripts in scripts/coccinelle to be automatically called
> by coccicheck. However new adding add_namespace.cocci does not
> support report mode, which make coccicheck failed.
> This add "virtual report" to  make the coccicheck go ahead smoothly.

I find that this change description needs improvements and corrections.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D43b815c6a8e7dbccb5b8bd9c4b=
099c24bc22d135#n151

I would find a commit subject like =E2=80=9Cscripts: add_namespace:
Add support for the default coccicheck operation mode=E2=80=9D more approp=
riate
(if this software development will be clarified further in the shown direc=
tion
at all).


> Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependenc=
ies.")

I got the impression that a sub-optimal solution approach would be chosen =
here.
The automatic script execution is requested despite of the fact
that the input parameter =E2=80=9Cname space=E2=80=9D (SmPL identifier =E2=
=80=9Cvirtual.ns=E2=80=9D)
will be required.

I am curious under which circumstances an other transformation
can become more attractive.
[PATCH 0/2] Coccinelle: Extend directory hierarchy
https://lore.kernel.org/cocci/d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de/
https://lore.kernel.org/patchwork/project/lkml/list/?series=3D412494
https://lkml.org/lkml/2019/10/2/60


> +++ b/scripts/coccinelle/misc/add_namespace.cocci
> @@ -6,6 +6,8 @@
>  /// add a missing namespace tag to a module source file.
>  ///
>
> +virtual report
> +
>  @has_ns_import@

If you would insist on the complete support for the operation mode =E2=80=
=9Creport=E2=80=9D
of the tool =E2=80=9Ccoccicheck=E2=80=9D, I would eventually expect that a=
nother SmPL rule
will provide a helpful message instead of immediately exiting after
the script variable =E2=80=9Cns=E2=80=9D was defined.
Are you going to take any additional software design options better
into account?

Regards,
Markus
