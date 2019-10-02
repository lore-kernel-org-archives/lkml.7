Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEEC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C8120640
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AhGOc3or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfJBHL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:11:26 -0400
Received: from mout.web.de ([212.227.15.4]:56211 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBHLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570000258;
        bh=i1FVGx7dSZCAXR1CegTHrRZN4pjtKq5DP6ogcc8nls0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=AhGOc3orE8tuw80MmHpasAGQFCohVSFWeWAwK2WB5Ie79fF94ICFixZN7yKtqCwFp
         P4io+FZIWe3aIhoeJNrHmekp9pqQZUIa1DNcg4sFJeW9wUf6nfgNwxwm1hbq9bHfUO
         sFswKZ/Hh1Ydd7boa0+RdjIm5uSUO7LGanOuMloU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.73.205]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwU2B-1i4OVR0UdL-018OOk; Wed, 02
 Oct 2019 09:10:58 +0200
Subject: =?UTF-8?Q?=5bPATCH_1/2=5d_Coccinelle=3a_Move_the_SmPL_script_?=
 =?UTF-8?Q?=e2=80=9cadd=5fnamespace=2ecocci=e2=80=9d_into_a_new_directory?=
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <7664d59f-78cf-7644-0ee8-304b3d78d752@web.de>
 <alpine.DEB.2.21.1909291840280.3346@hadrien>
 <d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2b4e3866-d0fc-e6ca-9977-777b2a0cfc0e@web.de>
Date:   Wed, 2 Oct 2019 09:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YFk7IJLTLs9EBIFc3QFUQmpbfO/3OiQOJwxkJx1Q8bZrt2nBtio
 frf2PDq97/gx7J+xN58DGzPgMT4kh9ADPJMix+Lep0ixHUmWXCEvSHuXyX1vMoXPYsm831u
 BBqJQJmuYfZZk7TOej7NeHMGOIjQCs8OHKrkAlgJnPHlO1ejKFuWE5ogAU8vJ3g8KHCrzzk
 p1gMdfgwZjFxBLTDQCr2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KCO38XKGN7Y=:gn1D/5VV6kGCMfjBhmjnpX
 GT5enhXKxUEafgBxMUIZEQ0UVyKlrora/4BlEQSwnHqXUdAtbrhcFzLjKpDLLzannGOORAgGa
 ggCBYFXe03lLeYFk8soiBhouubf2zK6r8aCatz4FbKs+0A3ekIJzO/IZURuioATbzwY8Ig+sm
 Gd3YVmulye8XqtsGCtuNi93Gb2C3LFnJduVvP5VYiCDV1Q57MJGQFelYJWjgYIB9ibT+SxzUs
 HSSbLMWZfwNQUbtPM9xTZysepNlz4/IOnRsblR9YyiL/BWUIhzSokkkXUxAKWVodJNHCFTwGu
 d0Nn7ypu4xQ67NfSQJpxVT2iflS0u5YBhODCplZOP4YpBa6ey8UMxOnpIeSW9Lpew63gK2gDA
 RppI5OmIBqKJGskAesSb6TZBFUilUTpIGeXjaNTkCkNV7N9+fw1XDECA3w1Y90s9RWwL8pZBf
 7+nqBi+NtNYdsDlaE3gfcIWRSL18bwNQnFIIQ043paZ6dXmgjM50TZH4B3xfsuoIu8gwac6eq
 ItoHAinr1sWvNgaDTe0jPh2yd0iXKcWXLfQeGh6sfySCeuf0zG+jyzXL3z4nBg8sO6+kn5/6k
 xbFgLOJv/cFp3zy9CkWfmgYhKZdC9Or4PMqw9hFVB9hIl//eDB/3SgK9q3OEMM3I7ZVtLqcvM
 U1AXfeHyuIN4YFCYegKcGz+UAiFXez+mxWibBj1SbbHaKOM1BuupRbz/4mh7BAOlhTH3WVYMQ
 E60M7lihy58S9xWd+bTTcAbdDDN2qaZr9NRhcWE6A6fWmIEqbXt50GNr1v6u4q5Vkg13duDzV
 O22S4fVpP0aG8X1olX+1K8jdwjkI1ArRtPW3HkcqeAEQ9GOv0SPr2i6P+890dOohjsiqgEAQd
 5zD7KPG3WT3tMPSxoIMNKjSOgz8yuVdzMXCqOqLUV6shhv1e/4yINQOoF6ARQTP01E6AwGR0C
 FXgU37PLT3eZ+bnyfxpXUIIgQlFAPU31xGXi4fsAObUFvLLYpz2Hak3bIg5NtMjzyHYfTxpPl
 cIy7cKTOeq8VVse9rgGIqAdpBOxtZBgfwVftI/EuBGj8/h6wZSIazPXQnOAyrrMk5RZr3+K9K
 yVIvL/TLX5a1EJA/VvVNPf97fylg3xQPjXas3AvGSAt98CMVoN7m/SQFFqKRe/3KfydEBdr85
 cHrMDAYaRXfFNWDvD6LydyXz6DdO/GvuhLGhLgGjhdE283wi7rONvoNw6nl3zzlklkErkQ9Vu
 YmlFKw3w9zS2/evgVT8C6QwBP/K8tdItmdB1ugUHdQFDoZajDmJtmE/LoZ8E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 1 Oct 2019 20:56:45 +0200

The script =E2=80=9Cadd_namespace.cocci=E2=80=9D was integrated into a kno=
wn directory
without taking all relevant system dependencies into account
(despite of positive code review feedback).

See also:
* Commit eb8305aecb958e8787e7d603c7765c1dcace3a2b ("scripts: Coccinelle sc=
ript for namespace dependencies.")

* Topic =E2=80=9C[Cocci] [RFC PATCH] scripts: Fix coccicheck failed=E2=80=
=9D
  https://lore.kernel.org/cocci/20191001125742.GD90796@google.com/
  https://systeme.lip6.fr/pipermail/cocci/2019-October/006351.html
  https://lkml.org/lkml/2019/10/1/503


YueHaibing reported then that the standard system configuration
did not work any more as it was expected for the tool =E2=80=9Ccoccicheck=
=E2=80=9D.
https://lore.kernel.org/cocci/20190928094245.45696-1-yuehaibing@huawei.com=
/
https://systeme.lip6.fr/pipermail/cocci/2019-September/006341.html
https://lkml.org/lkml/2019/9/28/29

The added SmPL script was designed in the way that no corresponding
operation modes were supported so far.
This approach can also work finally if additional script execution
criteria will be taken into account.
Thus move it into a directory which will not be directly included
by the filter command of the tool =E2=80=9Ccoccicheck=E2=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/{misc =3D> direct}/add_namespace.cocci | 0
 scripts/nsdeps                                          | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename scripts/coccinelle/{misc =3D> direct}/add_namespace.cocci (100%)

diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccine=
lle/direct/add_namespace.cocci
similarity index 100%
rename from scripts/coccinelle/misc/add_namespace.cocci
rename to scripts/coccinelle/direct/add_namespace.cocci
diff --git a/scripts/nsdeps b/scripts/nsdeps
index ac2b6031dd13..9000524f9347 100644
=2D-- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -23,7 +23,7 @@ fi

 generate_deps_for_ns() {
 	$SPATCH --very-quiet --in-place --sp-file \
-		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=3D$1 $2
+		$srctree/scripts/coccinelle/direct/add_namespace.cocci -D ns=3D$1 $2
 }

 generate_deps() {
=2D-
2.23.0

