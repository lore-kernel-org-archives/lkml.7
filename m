Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C77FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987F120854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pc5Jrb43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfJPL6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:58:23 -0400
Received: from mout.web.de ([212.227.17.11]:44107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfJPL6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571227087;
        bh=a+1GVviXwdLUCjJJtDMUOawEAo2G33VYxdEtE7DBm8Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pc5Jrb43rsiHse/tfUegDS+Ew3+Fzh5DhUizXyYf8JPXX77NGZk9EASNDuMu8GKOF
         tnVWHtSgfZktZ5r1tKqSWV2eOXpjYGE+3S45CCS+F37tP1jgtXAkZr4D8b+23nLQTN
         hoJRHRzfUIHkM4mpVubevJP3gz7S/IN/biIsuF0I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.85.206]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPNm-1iK9yW46rq-000eYE; Wed, 16
 Oct 2019 13:58:07 +0200
Subject: Re: clk: samsung: Checking a kmemdup() call in
 _samsung_clk_register_pll()
To:     Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de>
 <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
 <39a142ae-e0a1-0683-d68c-128b388f480e@web.de>
 <CA+Ln22FCH-q-joG6i=K2u=3vZTwwytkk0Q48oKekGkVb+VtL3Q@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <43617d6a-c778-629b-81b0-aa0accf09d80@web.de>
Date:   Wed, 16 Oct 2019 13:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CA+Ln22FCH-q-joG6i=K2u=3vZTwwytkk0Q48oKekGkVb+VtL3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:54pWJEpaiZs1qxWmTa/OWZ9tXGNN4h0kEg9bN1x0P0xYr2S2ugO
 0QY6Iq5wsPy6azs/F09/Ide4O+p7A94gw244waY2OsWUVaS/AoMq4metO2pYXgUJo1CDWSE
 03dP5yYhvC5ET5FyF/MILYTkRrvUvTiPwA8k9KaRVCangwXljvtXXZtsYy0zQf9MQ7Tq1gI
 wmpYD5VR1rH2dDU3pu2Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8AAAHjxk6lk=:XKAMOU9Pa5g9aYKvsgrVAX
 r9jxuUOV0PNXWSZrdmy0IYMopWeQHKFu2M8D6kqCv3iubxOBML3/vJ7NUuNZRarLwP2bvmK7k
 zeDGaQeZKE864m03SvVvM4iYlkcCldNVRvXTHb2cg9+aqMcPT/Qw4fgDojfNMfEPhL4C0fpq7
 R0k0GvLEFz8sN7Xr1GGen+AlnFcRx1AvV/3TDv7JskBXn7kfGkRNNVv6jOQiIgettkQ+GMGUN
 MPe1AoFnKZ1E3aRpxwXyOyPXhBML9GmFHXdW2OxQ50VcfGjRRwhYwcgBMzCkmfc3UyQ3dBe3R
 v+WZ2jStn/JDbylwXzTz9ith0uT9nOojE7Rm/3QS765tHdK0OdMv6GdS5TW6KqoyXRTxteHs0
 t76NOrwPHwP1Ex4Z35ufnxQeUkm016o44Q71UCWOKbD5pNcf6nhJ8jRuPM+JjbGIB7KKh70+V
 KCmxogN3ILfJc5K6r8oFubv5HsNnxj605St3HwyRlP40HbDWYZ4iGWBICT+5AA32k7UJwJk7J
 rPpxRp3ASANzSkp3b5ySNZje50d1g98DbzO7k04kVNNlE7fjHviRXekExe3Vi3qmMaUhHweZO
 p5C3GbmnyKirAowHBb059e+GIh31BivMA1yqlKi1bnyH72euGcmUjS1HVXJPnfI6J7mnGoIKl
 FNWL6280mNWQSwxalW+UEMJMNQE0+mGeWkPcUs92h0Hm1T5PQYR990O2lkU7RwoF2ni1ru77M
 UXlNlqJunlikeuIH8ZnG0LfKujI60mqG6LILFoE+o+c9Ai1XSM2PZbWogSIhhlsOKLULK6cU5
 HzMHoTqX6lxfbHtdn9oXRj42IpQzb8/+o4f+/mSKk/11upS/EOvgOosiunMoVMpj6YbRet3zY
 HCRpygu66tDg4mVFJnrZYCz0JvQFdg6+qDbB9LEMZSjhWZK4xh8T5TJhj3TEc/iqDdDGG8djz
 ASwGFs7GS4QTOI8WQi342mwjJcXtxNTFB8rz3oJ80mnUexfujJLp72dQariZ9eo4JTy6Lrwuk
 vsvOwhl/FyfM1tPVQyHHmpPdHjnOTNXHD7CYcCE2B6VRqgeW1Df+5Sk84isuxtuG4VdoX87Lh
 MZ7PduWwA3ule6e7vLGqfl3PXeTpKt2mQZ1gJP/RsU4s2g3ANJWl7KxaGFJmouNPC3IrRyIzh
 fnZShSI7kVY7l1d8Fk3dfo6btLPRiaa2W+pYRgV2l3jynga6boJKE2nHp9+FZkjj++pm1p25c
 +pzq6nWOOXqye7wCZ9midQQlMixJFkevMA5kLF9lWl5kYgPj5TguiL5cqtYs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A backtrace should be enough for this kind of a failure that shouldn't
> normally happen and if happens, then the rest of the system must be in
> a state already about to fail anyway.

Does this feedback mean that you would like to omit two extra
error messages from this function implementation?

Regards,
Markus
