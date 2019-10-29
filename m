Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4EE2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lTmmSq+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfJ2JlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:41:21 -0400
Received: from mout.web.de ([217.72.192.78]:35015 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbfJ2JlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572342068;
        bh=7ZL4HdBgXcYe/RxvZqwRIZfjdHjgathOXOjI3o/giec=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=lTmmSq+HVcFsiEMRUF1yfACHphXnP8v3Jn9KAzFZ/YKkdnqlZHa5sIWth91urmjKJ
         6seEXnU03xS7P+fYYc6Vy2cy6KUSpDs/uQ+4VxBMCzmw9i/PME5VaqNfG/9ILSdTs/
         EBkVIZ5IKQ8Z46c29frreFSKOgFy/dXcZ5N0r6AU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.156.63]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8Ph-1hiwIT27VN-00jX2c; Tue, 29
 Oct 2019 10:41:08 +0100
Subject: Re: phy: tegra: xusb: Complete exception handling in probe functions
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-tegra@vger.kernel.org, JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
Date:   Tue, 29 Oct 2019 10:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cMCMA6+XbKkJ/93V15j0iHQogtzL5qc5U73UgyvflFR6fvahVFF
 YfMtczXMHqbJcuc3iaHrMtyG17ud9XvyjaC6dYA37/9ouKzcfByraX7jhk05au3TGa2VTTP
 Od5Aq/Cd8NSsgYZOYW5/Q02sJASTevdJx4GXQoU0NRks1k0r/8Lwg7XiO7iRMBX4QjlCI/H
 +Z098SdSxlKjxbnGQqAWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8X6osC7cb7A=:mgbXl19oHyKUxW0QKOISkk
 EXjgJUCIdgv5c5xuSNdFXoYFchhGDWjwPCaAtarRmPGv+jvrDUgxAFcrAeZz3aT1TXWQKdYtx
 wLaDznkCTBAhqzERjO3X0Tzrw5XlIr6CVxjPQMKmqeAP9pe6MeTn0/DX3aYp/ebCsr9/QMbZR
 CJvyFOm0KNwK5o702ylC0UyS/OIoHPWbUieseAhcF+OvenlB9Ku5I0vNVQ0TY+S1wMSStcdgh
 +iRRLMPzgUEx0aV8cv5a+NF9ubQb1GxhBRoP59J7/j2XaQenHoNUjM81eFVXKqbYjsg51D999
 rGXTBOiYlH61v7B3YgIUwl8uGsW9eK3uXa7zPPT1u6HNVYnv5t076zSX86cjORyjqzev5pv8e
 dcOi7hywEZh3nKK1WtM+eutFrnvEPIzInb+475DKyjLr4XgH/hutXo7WUxl7+o6ulcIpp+w2L
 LB4KU4HEodzBk/9+f/kgeSfljevHrZpicyzOo03KJTWQCjgoNgOztOys0/T4EvJhhO6CScEgM
 qFCjXCHDZ0AcGLbbRl2NYr0+ZgCz6Po8zNbTbIoDdK/4pUrGhZRYOJWX7S+aLUNRIE5V1bHVU
 r1UgYkU8Eyz9ewsbZf2V10ab5usBUHWXvpfqeDyEE9/QgdPMxXivh1IK/eEzfs5yO7jUV0uo9
 7gCFeCPqIX8kU8MQrC20EJ0JX6UOBEMe0mxhHT2HNhBzCzYS60uE4Qp2MKNiNjKBD5E+/faxY
 zYnllLQjb39kS22o7C6P9y8jyYxhGPNPBef6qR++KZ3YB2OkkHKXPjKu9hcN08TVSfDFcxiVR
 6vRD0USvExp1DHPIVO2atzgJm1UmpQFd6T8l2taqsnT79CaTlxntsKcajS5ruXh1lJvY1fMFz
 eJG/2jNtQwaO2k2sK3SnNdRZlQgmZonUxgIOn7yUoLbqYhi9eIpCX6mBxabgdgQwD55ZS2iH8
 dDCh5mrEH1N5sqlkn+32cvEc34aEHlZzX4/g5EBd6GJ5+cpTlWKLUEH2/MYQhZBmTqxXT3t3A
 wxwIl/FTkM3NhDFebEi1Oxpb+BhL7XQSdcRBpQw9lTRdaf6bX/Z1aQszgYt9jkkeN4zGLfUXq
 TeL0rOvdSbVLLkKXiq0XBVvGME+WmJ22Gf7+ARKA/R2+MhR1nkTOl2Gej2dsbNUnrD8NlCfSn
 JLqRwkTQbQ6XJ45EJltTxXGVmw2S1pdu72OYjAOmaSZKNZL/5wHQMOaf6tcdqQAJ9VoHc13L5
 227xSTKgDXocLokbVbrugiPX/5MlKZZwd92ByV/LTlST6feRewEPTU0bpz9w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have got the impression then that the exception handling is incomplete=
 so far
> at these source code places.

How do you think about to try the following small script for the semantic =
patch
language out on the directory =E2=80=9Cdrivers/phy/tegra=E2=80=9D?

@display@
expression object;
identifier exit;
@@
 ... when any
 object =3D kzalloc(...)
 ...
 if (...)
 {
*kfree(object);
 goto exit;
 }
 ...
 if (...)
*   goto unregister;


Will any search pattern variations become more interesting for correspondi=
ng
automatic software transformations?

Regards,
Markus
