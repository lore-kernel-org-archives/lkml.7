Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF15C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4498C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QrCYqFTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEOJlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:41:25 -0400
Received: from mout.web.de ([212.227.17.12]:33915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557913248;
        bh=SnW6MHFbVnElrpFJkGau3byMgGf3XrMAbhx8BmLNVI8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=QrCYqFTZRIaTPiD2LL/EFK+9KA7ryJdh0OifWXgcry/wWT1nesNqMb+NH9Xgrd0+n
         IN0wpWCp3BNvoD9UuzdV+TeqSOZpVFN4ZY6vPRty/qOTbur+/FjTZFoQ8LHhKbZAK0
         gYvi7JBGOnMQdm/xkAGd/typbCPaKCF2bfLgdl2k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lm4lR-1grEbR1VT7-00ZeJ8; Wed, 15
 May 2019 11:40:48 +0200
Subject: Re: [3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <201905151043340243098@zte.com.cn>
 <alpine.DEB.2.21.1905150808180.2591@hadrien>
 <bfde9b91-0c5d-31a0-4b1b-5f675152b2f8@web.de>
 <alpine.DEB.2.20.1905151119070.3231@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <c53d5a80-7f80-535c-8394-a3289399feba@web.de>
Date:   Wed, 15 May 2019 11:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905151119070.3231@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLS67gG9i7Q5Pd7CRZhqUcevh68zMDS1AxI6yeNZ7p41vnQJsd/
 lumXBbcGiGjcrtnbtkJZ8z28u5MPdrpPZR+B+lIq1c9NzkaZIlWKP3X6f87nRInsKhwNaCi
 IvThKtvoiNqSCc9xa6S/o6Is6WUHGJ6X8XEKTznc//kgy9oAOEE/2wFf7G3hoj0+dL2x/lA
 oX7WOaFL1H3Lcy1THUmWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sn18qbKj4FU=:cbAaGbe5/ZzWFwsx7Osn0z
 zB6Uc/zJnYz/ippgFGW1Q9UzzL6GjAInKIEGVulBqfoKMaomms/AvFWTJVS1LPj0UEKvXBn6U
 dezwn77CR8GV1AiqMBKDVMUkJy4+MztDkUTdTVTI6G5dKc3Kwc0nU3rWONJboA/+iuzLVJKn2
 3JK+flECQYbVaHN6w4XC/GqTvaeCx1Et0e1voYfp8tuaPCvb6/K32NEFqO8XP/snitvKKPbwS
 QSPC+c6MzUbOab4SZjpF1VegtDY7BGNfrK1OfqR44scBcoBzdb3Z9pyFK3NdJCqXvMfHZtkto
 eAK9WJDwn6tD6EUGqKUy/eslmJpumabAppCmoHQPiEGQIq+9UUME9qFgQ7Wt+I95AoJQeZW8Z
 I338aP3FP7On3TszxlG/SzAMTI2tmnaMXyhvS/PH2q6XPDwHXNSW0nbCGVj4oPPML+V8YrtO3
 6iJEJypRKXS/YPiHXqFaw3+EjFovoovWzTTLnfqTPCdxKBk8/DIAsTUfP+rGFSw9u89Mm4lXu
 rwQ2d8Yys5u7uNo1O+h6V0H8Xb40i98WNpFESIMdaMF4vvG3Thi8W7hiV8O/9TlZzx4yOTtkK
 440gT/qDZru8V52JZeJp0F7AfKxkDbRqpJQgl7b68E5rhQzfcN9b+jXIlRrm93qwK1ZtOOm/8
 zmnhLr0g0OoNo4D1bVsT0dBsxQq/wyUYmyBOfxMV42JJwMZd4X87ZizfDdMBnh4fLo6Je/3cW
 gbb3jaQb0zrSAQhKviERKIf1iZqK0/epZQXCWSHSZV8mBKjVunr+wA5OQUL5gRbFWyX2QRBU9
 SAYlnwEgqgnZhe8FkCbGrey9hY/9+NLgkZ2wsgRqHhV9iTiVpVysWHIIE/HJInGJk0bCqIVur
 VIFKVkMPUVB9EWirMjqjy1Rs4xGrdeIyt4C2BK9yd1EHnS8pZ+v16uNj8lEsWYnUOOa7UL9NX
 ZaotS88HWzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On the other hand, I do care about causing false negatives.
>>
>> Do you find the missing warning after the addition of such an exclusion
>> specification interesting?
>
> I already suggested how to improve the code.

I find that the idea =E2=80=9Ce2->fld=E2=80=9D needs further clarification=
.
Such a SmPL specification will be resolved also to an expression,
won't it?

I guess that it can fit better to other analysis approaches.
Will any script variants become more interesting?

Is it still unclear which detail (besides the added SmPL filter)
will hinder the warning display for Wen's test case?

Regards,
Markus
