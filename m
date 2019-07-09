Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9EC2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pjptLYHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGIJx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:53:29 -0400
Received: from mout.web.de ([212.227.17.12]:34923 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGIJx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562665982;
        bh=bidYoeRS32p1lXoh+BfQW1GGcWr3R3/7DtLgQ9YWeU4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=pjptLYHtNMnFQQLuXow/ZTavIeAiKkAHc/A7XfePQRvJ/oLgj0lIdu/MLTUCy3T/D
         z0yPBEUG3AskbrCuGpABMCVVmSeKZoW/A8i/ZpkDHD6VTd2ZhqmpP+UXJ8LZmceoBi
         JQVhiGPOysg9WWA8z0r2rzO0iYo3FNUVMx7ttclQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.179.96]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2Mcy-1iaYTh3jPQ-00s4lo; Tue, 09
 Jul 2019 11:53:02 +0200
Subject: Re: Coccinelle: Handling of SmPL disjunctions
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
 <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
 <alpine.DEB.2.21.1905142146560.2612@hadrien>
 <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
 <alpine.DEB.2.21.1905150811310.2591@hadrien>
 <1794c3af-cec4-8b28-a299-400b857f0644@web.de>
 <alpine.DEB.2.21.1905150908550.2591@hadrien>
 <020c9629-fa44-170b-b2b0-baf3ba636a71@web.de>
 <alpine.DEB.2.20.1905151120370.3231@hadrien>
 <e59c77a0-f1d7-2f4e-fba1-c8ed11f93669@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f6bf9e46-26a6-2627-40a3-1f7eca61b84b@web.de>
Date:   Tue, 9 Jul 2019 11:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e59c77a0-f1d7-2f4e-fba1-c8ed11f93669@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mFDWrdOYxD9TUFbMvY9zYJPJMtc8lPNnygwMfq2F+iVqJHB3f0t
 qmQdYONmo/4o6eioWRj/QLHpGcFKF8Zj3KCwCoy8GaPU43VSwTvLOQO20zMjhF+zNo7lveG
 qczb5BZp8dxAubQLff84bUtIei/LdpgGPbgJWaLaft1b+LRoDp2uKtwvS1lWFoefWyaj0+3
 Y5kEzNknugMpqb/GX2iTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ww4SBNH4O/Y=:en7a+ZyolVIPdLmaRVoBCF
 NXNtFKZYeb+Kx54AuKDry0qp+pEmK01vmFE1pTRvLoAOc3iPvcQYCm0XiJ7CnSAHSudb1WNuW
 nRnu6Lo4lkys07YTkyhL/H2pbMllKiBvMkWmHYEgr2g8VlvDwykcWDehd2fUTRSfMS9T9dtRy
 3Xov41nfcCpkTIp0gdMIwBPdf3amjVa3BJOAOO5kr4+A2pVvGwbHjF735GRblmJR3G3o7QKKl
 lYR12mk+XaBF03L0X7/hVzS5/eiHs/KuBuL/JUC6E2LfENWqI5RmBsgG/pugaovlWZWiyC/rP
 zJOuBI0L9RvhzoKd6TMfQN3wUVzuADbu3XkkdaEYmMqwZ3bQ3aO1yeCqLZyxT77cR+IilSBVU
 FE70LWtXL7K2jNjRvmP7SVKCyNOg7pxp9puu4Ox5+ZW9Ifx71oBIQDZgsXiys+3TcPFIOCPbL
 EcE4Zf96n03dPP2ydXTTnRL3gnymmKGlDUXwB4RUZSUpWHEKES3ZVYN7VwKmZGGy8Lb2Kss21
 9CklLdJzEOwPe3IProMLjZ4ygnFJASmB7pH4+XevgVBcHgS8PcI7PgX4sObvYgILjaXhIDMSr
 WH7Y5T7DVucWHd1SbKeTYbnV0UArjYQy0ulyr2033tpi/4IAOUP0YRHixn99/EIWM075MBTeQ
 r47gf0ioae8TcaQ+3lmN1ROj42vokNYY7TihNDVRuatJSIRMo1EAkEacYH99CDC4ChBbfklAV
 q/3eQbcMXsPXMeAWrAkj6J0ALwyj6GBhuMliT7186QxnndhoY+m27MAG2/BV13dFprFMtBZvX
 C9xTLRdzJ9u8YaG/hhKKsR2WCwrLFZFpwq7T5OolHTRUuPa0RgdcsEWBJTkFKNWv35Ht5Wk3l
 KzeXjMSlXCZCVyQNkI+KqnplX3BiqJ969duMCzTbEyh0FRqkJgaLD38pYN+n+Pq7cAmYnK6em
 VgSjHUlI7mjS3aFBCZUX2Ivy1XWhZDkDeeHRCl6EADwiksum5+TMUQ+H8jZc5esb7Ph+Wk/O1
 yB9g8QO6l0BukxVUwVXf/y/R8JfDCZr112h5X48y3fE79JiLLIAdcTaTpY+DBlYuJbEUNbMP3
 wimvRdTLAxGBtwHB2oJh0+Tw/sSllPNQxSv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> How do you think about to increase the matching granularity
>>> for this functionality?
>>
>> No idea what this means.  Disjunctions are expanded up to the level of =
the
>> nodes in the control-flow graph.
>
> We have got different expectations for working with such nodes
> for possible (data flow) analysis.

Will the chances become better to clarify this functionality?

Which software components are involved so far?

Regards,
Markus
