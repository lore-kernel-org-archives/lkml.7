Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C312190F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HJpBQZgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfI2SBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 14:01:04 -0400
Received: from mout.web.de ([212.227.17.11]:55599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729614AbfI2SBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 14:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569780031;
        bh=Byb8prglkMbu1VfKpXO4gmDou1DD+hKDpSkYfARS7sg=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=HJpBQZgLDpSGuRt3XmTR98EnloTPPpTBlvVSIVHTLQaQ9KQN01At9JtgdnuU77caY
         Z38HmeP8sDXiZdYBAAiz2v593PjrgiCMhkAP2pVwMaE8Tm/XmYxHHwnCcC1nJY8cmQ
         VzLNfkkUKmAIF/JZxWaeFRq9Aaq5yJ+KoYqx8Yl0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.99.91]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPf8-1hpirR1qWU-00jsEc; Sun, 29
 Sep 2019 20:00:31 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Martijn Coenen <maco@android.com>
References: <alpine.DEB.2.21.1909291810300.3346@hadrien>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
To:     cocci@systeme.lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <90cea5d2-b586-6f82-34dd-d7a812f57396@web.de>
Date:   Sun, 29 Sep 2019 20:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909291810300.3346@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BNlksPpwEPuS1eXwfD/ULEcR5GPOPyxQDXWNLD+Y3axlyLzgdCi
 QGMjl9huRremf0iTvH0j/XBQqd4hk4hh4zQEY6qhgxMw3qp0MjOt4wgWDLmViwg86FtGSEF
 uGaDMwysbSkygIy42Bxc54jovXrXCo8Qn90ZwmKFu56wNSqkaYj8ZfGKsxigCC5Ru/HkZmP
 iX+p2n60q8sshwBz5bigQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p+0L9Q8twJE=:u++eNefVSw+miCwjT84BI9
 rxHM8XhfC25IOYzbVnWwAM94DREZF+VRr9UZBnBcXtxHhucBbAKud7pNhmnxiCzAZumLJambj
 HkCo3fP/tiuKRAnRTJXjQ49IiFS4Q0vvrq3vATMYFkFu0FWjMxpqRWpXx+68ALUtLYoz+ajB9
 iITxDDaA7oyM6FEtBLfgWOxFUmIvw6C5eSVyXGFdjIAjA1RofqrpMR5EQ49jJdAO1IyoFlhQC
 WX50+a4DnMTNBg3RBtQqJosos7BjwZFkmsns6XLV2NFZOCZlNviFuCzIlfQn3754cqkV1xYa8
 Su5vCuaZ9ukf9hJFQfMxFE5O7jWIkpPEaDkuYOMGBc+QBkHHI097PGBEQzisU1TxJidl2XQ4H
 ChC0/4KPMG09eE5+tE/auTZrPGnTIPIowfMkgCfwqtogi5ZXvzig/XP4AqiStexyU1jyg2CTI
 Xv2DfGMUrWjxxoiE1zR+BY6pNiPTamiuQnui0oV64wcfYsODwGx3m+XYgLdEX/ccc7fRMn4mz
 09QZmLxbQVvxD2Ruh4U/JfvTwNxGJnwrbkebISD4px/J3EctVD+2Fb6pjJaua98kQxJcb8rql
 InG4cEXBLZpgNZly3IwWxOq1iMMY3YHgaQOeeV83b2jdkRd7kVYVjGQvah539eBRNjgV10FwS
 xMWJkRsLnNfxWpY7S2hWndu+9j4FQlqzC7p093fqYK0mRCJW5Qxtlf+knijQb5mWSy3wB18FI
 5H3gklRDCYNjCeuB9g1/ewT5TTfiuXkffaJPaLLehJcIcpcZVbdf50VU5Cg9nEt9LwM4qow1t
 prbZV7cLmSbEfShhtnzIV70z3eDMa9ajt1OzNkI4YAnIlxlH8KluMkc6GHKyU2SIblXctZrdu
 rwM+yv+vqWi+CJiY4HdHNJe28JtrYN+rpJz5mNvZt4bmPC2S3Lc5yXVHJzyvWevDrdvrmMCpf
 PBpk+R+O7IlnSjjEUwe0iLZ/a4eCpQA9hPiTIgtwC9BnXCXhuaoMg8cpxXnM9pH1AHSeOQbZg
 IaAtp9xHIZUt/+Oc0GeJNslrTEX0kDcNY5wW3riXDY7VV1BgNmAzZ6Nd3edTU9d9onGZU/TD6
 ix7cBp3U2zoul4/z8+GrJm7z0ClvU+/XCPGXAAs56JfRuYjA3u1RKV7ASYIlGymVv20/TQHPl
 FnCzbfzLXGL9MPmK7DLuc60WTnp+6pUHKV59VIFrAOFeOrZ22DVrcRTAKK0wHRb2M6aEQOrC+
 nIbGTFcJ9BSjP/v6xj4G16Ulof3e1I6qCHjkuiHPBOh3OWY9liLh/XvSg7xQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe the problem would be solved by putting virtual report at the top o=
f the rule.

I assume that support for the operation mode =E2=80=9Cpatch=E2=80=9D can e=
ventually be considered.


> But it might still fail because nothing can happen without a value
> for the virtual metavariable ns.

I imagine that the safe handling of this command line input parameter
will trigger further software development concerns.


> Should the coccinelle directory be only for things that work with make c=
occicheck,

I hope not.

But it seems that a filter command expressed such a restriction so far.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccicheck?id=3D02dc96ef6c25f990452c114c59d75c368a1f4c8f#n257

Is this place an update candidate now?


> or for all Coccinelle scripts?

I would prefer file storage selections in this direction.
How do you think about to improve the software taxonomy accordingly?

Regards,
Markus
