Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C9ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1342054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hPNDOaBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfJNIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:05:27 -0400
Received: from mout.web.de ([212.227.15.14]:36661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfJNIF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571040311;
        bh=OGjufwiW0pXEZluoeOgHqIAhCn21wMcUPBSvUVvZxmE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hPNDOaBRdzhyL9s2TfiV0KGt5MMMwCV/nH11rpfoH8tgxnFO9LKdYycF7EIgSko0p
         QWzurst2Y4kMv3zO5mKNTTbV+pt7VdSy9JkfF7rIEfyjwKFsxDm5nadpS5+xIxqO+a
         TlRFRe30J9n79rq62FxJJSYF3d9pKns+0w0pnTHQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.26.106]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyftH-1hxq520yX9-016BFJ; Mon, 14
 Oct 2019 10:05:11 +0200
Subject: Re: clk: samsung: Checking a kmemdup() call in
 _samsung_clk_register_pll()
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <CGME20191012141739epcas3p31e41c151b30d49c94aeb933aa42dc9f7@epcas3p3.samsung.com>
 <c1bc5e4d-0802-4485-2c07-248bab2a3330@web.de>
 <725ace30-a4a7-25dd-2351-f007bb8b35ed@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ecfa721b-4176-71cb-85de-2aefe0b3d30a@web.de>
Date:   Mon, 14 Oct 2019 10:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <725ace30-a4a7-25dd-2351-f007bb8b35ed@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzczU0IDlNWoj1CKYrjczAsbMgABJicD3urzHjsmqf8lH3lA9Su
 3mYY4AEQxrbS8tiBelf4zSLk5dBksNwWJsxUpM70X9ced5E6O6uO2BwPIbKzz/WwpLSKMUZ
 1/p1LMJXcJmyXk5mVrGUzUWxKnA8aTkI8b/LyOPP0aNstvBzOborGywUlkzQgc4UWSevY8e
 hqHDBZGA94BJl2ULSyTcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qHVKHWSMC4s=:lmBZuD5jEWPwkI4C6vktrp
 jqeK0VzlDHkNm4osgm1EIGM96fzYCGroEx1Z73uYnQWT27uwjoIHQnBUpp/Rm0TgOK0yWO/Ox
 yjJpmrazSp4B6Ugv01choi0O4GmKZQ8BbhKD6icN21aaQ3PdUbJ42fDSel+eNdLpmZseNd8DH
 UQpmIQ8pmlb7e0j69WX0lEg5cYdxPn9t0fX9ohfODaRCgmY1LXveF4KViyVtuPSCd5mNNXu4p
 NR36IuHck26RPuRvs6Gr4DfLwLwE/wjKu8/heB5S+CXgCJqqACgO7HsIhf6HvZnfDSCAiRLL3
 918cWE9F5V7Jk0bLPKkhnBMl4LpTwBbYGvpuDY082AQxBrMx2fiaV8TOzDu4csz7Fx7NwxhiD
 bZiLucxSmH+6ctNGTvaGpK/Z0nsYzR6mt8no9szXAydUgpc3VgemOGUhROzlOGDAS0vCFmsN2
 yojFE62HlGfeT6yaYlFsryKnJ2rA8KMZ3Y1JwRwWiXrJiwSL2siM23jiZP3o5/tcehDPQ/Oj+
 YNFB5uPYYh5DLb8+AKeaPE2/3rqcevV/ls/l3L3iC6clnF6oAip6pDCtHA9rYfvIxKiGOynaB
 6un/iiHzv0aCFHUy1IxP8QdK7XDcQoHwozxL/Ixe6mRtzSHR4jJOKhWG99gNIk0k0nrBNCygd
 M4n3RBZJseMUPb+G5DODe8+3G7LjyOYLt/aeW3J5mHNSpzsvQxYwKFqdSs7u8cZzxrx26lZN8
 cClzEBDcvtNwkhIiBDn2ArovvT19q7kUCMD3ogUGg7rRgskFRnWJ2acADc6ZU09YHCpcnv2WD
 j2hxS+YoRkKCNob9HltLbTyCMNCnGvkhMhQCWvPbw233J9nFhy5NuPJEk5ziDEMMw4TL/9zDh
 yBa46MShd/QD/yPjH/6I96+vCYmahdYUk27kqSm/GgVSQ21VsNT1Qu/7vDjSXbz9whwVhzG2I
 4ruff6RtIOrF5J+gQnreyoTYwh2K5CwOB+mF8CJCG5mToq/8n6gZZMZQ+vxwfy7D1Jyjb1fJC
 VmdyLpxGqy8b8RhqJDck2B15mQLz5m90HPsqdAUCM5zYhi7KyvJ4Cgmty4z6QzV7PDZOUXAZ1
 L6hVZh5rgmnCikw2xuA9sr8zz/jHih3nxF6dZ0Wg8pgoM/uWuj9flmlL5Hjnb6wz+sOkJK59q
 gSTgcOhH+4F5ruaR0Abv/FDaWTSofQ1dNEnybiFRNnnE1HcdTqvjxFplBQt13CHeBdB/OMILF
 vaUPLfnZvhvDScBMuiDyMCWdOrpzLMWgPwOscRugJvmfMZaZKwwKT45LQmPw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/samsung/clk-pll.c?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee3=
0a#n1275
>> https://protect2.fireeye.com/url?k=3D7e77b0ebee9a0c3e.7e763ba4-43f341fd=
fe1d32b1&u=3Dhttps://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/=
samsung/clk-pll.c#L1275
=E2=80=A6
> drivers/clk/samsung/clk-pll.c considers the case of 'pll->rate_table is =
NULL'
> So, maybe just show the warning message if failed to allocate memory
> of 'pll->rate_table'.

How do you think about to recheck information sources around
the Linux allocation failure report?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3Dda94001239cceb93c132a31928d6ddc4=
214862d5#n878


> Bu, IMHO, the error handling is necessary in order to support
> what 'pll_clk->rate_table' isn't NULL.

Can an other error handling strategy make sense at this place?

Regards,
Markus
