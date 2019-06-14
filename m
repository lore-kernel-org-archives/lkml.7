Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C36CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF132173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SYTRyH4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFNQOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:14:48 -0400
Received: from mout.web.de ([212.227.15.14]:39921 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfFNQOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560528875;
        bh=hyoTZ1ls8fCxTlRhyKqOMD4QbhgTz2apZlCbsS/JVlU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SYTRyH4vSo+tpZZtiCNI5sHFN/1395QFg9f7kG0sYnb166pDw9nPjcMafUQwOgZV9
         qr0ozidR3Bz5Bs9MnwCWIHeGVOwW0RK7PdbQ7AiI1g84qPtS20lZBVGoTxpGW57/iL
         Ce57aU7IM7RFRRTclDQlcvjtpUhudVXRBS97v2SE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.126.132]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MejjU-1hzyTL0hmC-00OFOv; Fri, 14
 Jun 2019 18:14:35 +0200
Subject: Re: drivers: Provide devm_platform_ioremap_resource_byname()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de>
 <20190614133840.GN9224@smile.fi.intel.com> <20190614141004.GC7234@kroah.com>
 <20190614144706.GO9224@smile.fi.intel.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <48877575-90b9-3db5-7a25-53cf3817b2ee@web.de>
Date:   Fri, 14 Jun 2019 18:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614144706.GO9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jetwct6VoPVrtCSuGday/wHl1sy73I8q96GuDTV3uBgpga5/TI8
 DgLGris4ynVEr+h9Xkcp17Qj7WTMa5esinBfO3RXJaSZc6gZrjpEPRYSfegp/5Vhn3dvuNr
 6vtkuw3YlGFNs2XyE/SbEKP269xWqPAfWxawxvzrC2ON8YlUBKwNWbnzQtBnjFsM5KIQzri
 ZN0Y2RF7qQ3kuhbi5MZUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wCYArlFSLMk=:rI1RwxGr9fNTWCHTyaOoY7
 HHkmmqxWSPrhDNKnbidUyRC3vaLRkdl4tV9exh77ng5R/QrVglKfcE77augOjD3K2iGjFXbmr
 3NGYpMAKV4CSzKOQ4/MBFDMqSEF1BMeRvX9oFmewmIabbhy068MaZwZuXIbp9udQoyxQ93jik
 CUROGONDmdxPBVC/VYO5AMATdpbbZbhaiSZ+WubmI0sykdPc9RBvE11hJ0YKFSlliR0GXTqru
 z8ZpR/8iuqHuCdtQio++VZLSwmSqRuAYcLzv6TlBiIxcLND+mWcp6KMdhmfbrhPOQhW6HlHHB
 rZ1uyj1yD2fpPXG9aSqgmvgCOherZ9R46gPG2HI0ove4k6GnjI1HdEiiN1hXm2lGGMTEMXTRn
 pZHd8gNYFLSxF+miJxbD6X6W3GBMO8Xn7wX4CSqZCBJB/gLTsGPV29w8L3S09rlqLSa+aWOfY
 Cyf3Tdz0SQt1xPtkKFoYSat4Pk03f0H8Trb+pXmK+Dns2T4yH7AP2sW56gBdpWj3kV+KnkEZc
 +NKOsUOuAiTjTBCIyHEVBUc4TfSg09gtHqes5nZiwoPFNhJXc5MpmLtvAUCxIkwQM4/zBfuHV
 d/gkZQ3u8utND42yUfA4bkhSu/EDWqN4jvfCT4XuKPlZVCcAoN7KrZTGsvAzocld/tOZjiZj3
 s5VlRQFGYn5sgEhNWjTu0nFYxeNoB2zhTPhmmTlsv3LW6QBlhOG2femaXNwhlVQDhFYrH8YBJ
 YY2Ysxv327/u2LhdpVJvA5NT7ooI8wbwP0bgV/Tc9uOWKgEEx4lZB4w2AuDxCZmOGhVaJTCxY
 qNyqmuCq4zARK34z3H65PBuCTB7+tDIzqwwNMJTnsqa2pSLW4aCQLIXi7xYCi1uedhoumlZPK
 9YFN/YcHN5LENJ5bMS8+lzH21FIGX+sWh5FJPL6e5MZQA67+ixQWJmT7ickPNK+EMfPsl1Vva
 S5R38hjX6CKCy4SlPEv7Cuh8b9fue/Tco9CcehAV0adHwguadLAws
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't like adding new apis with no user.
>
> Perhaps Jack Ping will send it as a first patch of his series where he u=
tilizes
> this functionality. Would it be acceptable?

The proposed function can get wider application in a reasonable time frame
if a corresponding script for the semantic patch language (Coccinelle soft=
ware)
would perform an automatic source code conversion (for example)
according to your change acceptance.
How do you think about to support a bit more collateral software evolution=
?

Regards,
Markus
