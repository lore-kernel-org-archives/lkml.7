Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE83C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C17D20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hGTPmHXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAEKeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:34:08 -0500
Received: from mout.web.de ([212.227.15.3]:46759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEKeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578220425;
        bh=muH259ZrVBOfTqtFpN9JkhF6J+OpPXzBewzhweUeW7o=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=hGTPmHXOrB1Oaj+JRe0FltZtwkKviWQySJxtmiviiLpOV8FcJf+asVsKkfat5XLHB
         WZ12/UcZodu/1MdZQWKpp/KPUA7ZcREcsYjKESMnhQNgE/aZDaaSwNc72aChwPjyx9
         Y3V4mdrn3jJujc3ZL8DWMZqS9zyhID2Akkr1SJwU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.187.152]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgfTT-1j2g6Z3Rnb-00O1J2; Sun, 05
 Jan 2020 11:33:45 +0100
To:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200104064448.24314-1-wenyang@linux.alibaba.com>
Subject: Re: [PATCH] coccinelle: semantic patch to check for inappropriate
 do_div() calls
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <21e9861a-5afc-fd66-cfd1-a9b5b92b230b@web.de>
Date:   Sun, 5 Jan 2020 11:33:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200104064448.24314-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VIV8v8u9Q1RaSJVobU8xpVE6WoEQ0VEvvQRheL77vCrL2iKnRqU
 JhSd90SxsIEyA+Hd09OaiKJzdWUtNHDz2aLaD0vk0/7qOmEugdjujcunrNLC5W0ZCO516vm
 QHuSm0Gr9PIRqxg8rMCfU4UK6BOI6XFxc8y5zPJeTgVKwOViIgwazXndfkE9L5mkxT6ZbnH
 MWeopDbb9jL91KlvtX3nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cIerbdjllpU=:e6JwhzOyc/g8RQiUaFmMVj
 ziT+85bMJOrsFx2JCzZBbP9P21GhSTkmQieOkEhmiXIuxk3Vys59qxHdJFAOaVRw1Mf75Wvof
 vcLZph8AKp77wjvXKaSKerLdQgCrSPEpoPqPkOeGSVbpE+4wCGR2B/mhTdRxPcO0r5lykk4Nr
 sG4OpESVOm9kzS5xWqKG5MnDOj2iHE6cE1RR0GUI/tqNDlQEmO3HTByupBkEGrU2huTpzo12c
 wcYTBIM9hzYUO10ZZ59rcjShU00qkDw36DwrNN5YuamWhl057drv8FUVLCy1JxcECKfi9YgOr
 gcvhXzMaCY0WL/8h8jbpokAWWsNLJ5jHMi2kISsqP4Z4ukUFXEe1dytHCFrZO43bkUuCkoQcO
 nOn7hYFb+DuT8ksQl4rBVLPBglVITQsAkUyiy254u9FB1eRy2A+TuW6L9oUzIqF4A6jRNvXjR
 AbNCkIQu82nhq3RCKGcud49sJQ+8R9/9w12+cnr23lA0wQw40fdjxvXWmPVZxQXaDWn1beDn7
 AYpSEvDkcMJsXzkATNDxKR0yGQlfdMXZ0nHtDRPWMOEO8Njf7wcfL17Om21W1kZIlc2qvyUIK
 J9yqa3KRKVGsKxYV/XIfP592o3fJvfPiEsLyn6dpcavmcWgm5+LB73M7PboWj1j3wk2UNw6EY
 qmhTp3EU9WJNyA2ggUtBmqv0We97uzBKHfs7woOdpjFhwSiuOwh6zJq1eS+KhszjPcVRNL+ty
 DcJRJ6XaiG5Fs8WCn531y7OIwcTxp0nlBc0L6UrJ1Pu3UMoerBHXO9vW1yEWhFVvztDej47N5
 nWCkfieo2Pdq4zyy9zLeYjtKJ9slo9tX8bc1pYArp7ILIvkf8Ps/V7zYltfjN/9hppABe9xNt
 GkkwAj24jZWWflysT4SQvWd2YfC3SA6TNsdBb44S8FYNB0dZF/w3DD1NITrs4ZyvfWvDBdoBC
 Jte/3m5o8H6BortlrkccOvT+DacQFjkNgMWiZVJP0bL/2stp67On23sHBpvqQh1kXBDEN1Oq+
 0GxQqUPRcVV0q64fZx0Yw/+MD0Txj+UgegBLP6TmU8GV6Rzsi4QMtznlHmKKRHdLfmd4SvbeB
 cSla4XmiHSU6Re4BOoj36htyIRdPD8dwJDjaGpNR1k5pPQSrck6t9WmguxZwryM15abjGtX34
 PIj1aE7I6eHXbYvJ+/aPCTIDY0G6WQXeYAmDyvuo5IuE1MC7baa2YSM7Y4slIOfzA4LQlLt5U
 1fNna5KqoSB/ASzUAUwxccob5Zkh9b5dRvfr73ryhjZW5lcTJ2OT6jO3A9QU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +virtual context
> +virtual org
> +virtual report

The operation mode =E2=80=9Cpatch=E2=80=9D is not supported here.
Should the term =E2=80=9Csemantic code search=E2=80=9D be used instead in =
the subject again?


> +@@
> +(
> +* do_div(f, l);
> +|
> +* do_div(f, ul);
> +|
> +* do_div(f, ul64);
> +|
> +* do_div(f, sl64);
> +)

I suggest to avoid the specification of duplicate SmPL code.

+@@
+*do_div(f, \( l \| ul \| ul64 \| sl64 \) );


Will any more case distinctions become helpful?


> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg=3D"WARNING: WARNING: do_div() does a 64-by-32 division, which may t=
runcation the divisor to 32-bit"
> +coccilib.report.print_report(p[0], msg)

Please improve the message construction.

Regards,
Markus
