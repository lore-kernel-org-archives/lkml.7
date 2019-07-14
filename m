Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9AEC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4012063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RuHyFsX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfGNQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:06:04 -0400
Received: from mout.web.de ([217.72.192.78]:45025 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfGNQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 12:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563120327;
        bh=6ul08N0Yg2Fi0KueVuVksC96Pqnj+lQwd+aBEH7fEaU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RuHyFsX764dr8x8Npatn4Y3EfB8/C9wTMkKL6nj2kpEhgqSz5eqCO/PgYi4YPtYwH
         Me62lAYbfgT7rbNYcJG1Tj9lq05WDB/rqsrtvjkeswNoPZRw2+cDqLgqEQFpkSN8JV
         Q1+ZLXChnztTBP8mQLWh8oThEN71GYbE/9fQSosc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.159.144]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lw0ht-1iXoWQ2lkj-017jTw; Sun, 14
 Jul 2019 18:05:27 +0200
Subject: Re: m68k: One function call less in cf_tlb_miss()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, kernel-janitors@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <c5713aa4-d290-0f7d-7de8-82bcdf74ee95@web.de>
 <alpine.LNX.2.21.1907060951060.67@nippy.intranet>
 <CAMuHMdWd31ch+eSje4ww=_JFSZgnxRAUAvS0TCHXq0nzLeVfgg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e75a25de-861a-8ab8-ffe7-c83572d6e553@web.de>
Date:   Sun, 14 Jul 2019 18:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWd31ch+eSje4ww=_JFSZgnxRAUAvS0TCHXq0nzLeVfgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y9IS2ET9NhQFPEgECELOmGYZGQooFBdL7C+9rcS8oJTLcDEINgV
 ULB+OV/mdPMbGH7pARfX3I5qj1AV+qxD6iPqLNZ8FLNu+x64rOuzhrxPbfsBh+ymLczjs1U
 QPVm/cVlZOX+d0jj6KBHHor9GLzGrmZuDC+sPQL7pOM2Am4/laAmQGubaWOjC3BpvcaOqA5
 +TDarpX44izVqW+nUlPlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFzyn65fay0=:RpfY5CzupkgUxnEbEXzYZ2
 sKWfVwL0mzlhyn7rvR6K/5YIpw3YrexKPy8GgxAPv2usB6UsOgjkUDwcO8kH+7HiuShbkjrBE
 VLsgxp6aD98sQ7XgubY8u28F+pi+LYnvPUKvCD8NaGdAAE4vIPQbQ2+t+9yBc/aWMP12FBMla
 O4LzBeMXpxAjCOhWv5x/VttJ6cMKewb8+surv/x/sk6MBUTbJXLev2hqxVzmmfv3Nvq5Nlzzv
 /AJF7fDjoS6TS44d9NwvV1kHsMubchLeDJ9CYUX4sLQUVB1XpwNIlKaLkf+eiu0LXnrLuduF7
 bkhE2yFbrUokUPXP2xfUn3psdFqX2IC1buoRvcF5vrEcZr7V+BDh67kkNB0bDV2okQo2NL2oz
 VLiOXu6EzQqYje+AW76VuyLHY9lz35FgYKsnoNzEv1z6+zxNPSAWOdqcgjmGrWMc7AXZRAxZf
 SzcJMhXInY72g6/YdXCVZyxhgvhYToNb++VTfmrFfldsK3qKQZ+NhfyRd0Y6vtIdaSvXHgDia
 VqQA7P5DQPeiDod+YBHB6r9JQT4Z9MGhaF817Gqu7W6Pl6b0NVpRyIYlXprnQtFOyI0pgsCVD
 XIcB9BiDuWhcOoG0PQs3QzImUfwVIFJhxDVD09Qiat7RpeNn3ER/Au7H/3PU85dgVfApZLrfd
 e3itcKR3V+L9lkqweDQurGgyfsHt8j8SIfdH/AlYjm5CuaOUv6uB+mNpA/lql+PKuRhRaO1VQ
 Qd0RYoKzdQhx3eGXRBzYKLDsi+U2OpoVhq2p0k3qA9M0VPffVUAv8Jk5g5jEdkHgBqOkx70gm
 yH9MilMvv0NsxeySkOoI7KRc+u/CBmn0GvM0PWvqIrKM1y89V6pBwPw7o8WQJDHf0FndVXm8d
 t8+MFqAAE5h+GB2fI322yBUebPC+0gfUL1CPIPsVe6E6AktSjXtlnnr8/F+SlDkb/thMCOflS
 2ygpyj3+HzztseZL9OD5AxK7p/9aFWvdLWaCAEWrXxSzMFsbiiLm0l0l+LquyQuTztL1eMs+T
 7fLTaj5f4B1OtIrlzMng2sklxJb0fZV3fQillbqVvLKJgymnw3oNze6jzuTM79K91ZeSrxGs0
 984AvbVjKrjcQuwDvs+TZfP+9tZlaFw5++T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Avoid an extra function call by using a ternary operator
>>> instead of a conditional statement for a setting selection.
>
> Have you looked at the actual assembler output generated by the compiler=
?

Not yet.

* Can the suggested small refactoring matter for a specific software combi=
nation there?

* Would you like to clarify this change possibility a bit more?

Regards,
Markus
