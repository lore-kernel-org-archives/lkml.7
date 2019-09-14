Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3B6C49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 06:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB420717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 06:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="D99ocGeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfINGZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 02:25:04 -0400
Received: from mout.web.de ([212.227.15.3]:57855 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfINGZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 02:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568442286;
        bh=iYJH6TTzLjHF96psQwp66Ddq9KYnshTlAY+QaU6iTl0=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=D99ocGeIQ/HwB/beUCG08U0SnwP4W5ieFhJ0rbA0X2higkBMG2wFldlKvs2YP659L
         HnyRpdg5vP4eIXUy/1nvgkyOidz1uXZalbf46lwJk/RzQXLEHb+4KUay1V0WlufL/h
         pD8V23a4NMkeUBmHJScS8aDFJDpVc3nmw2efww28=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.59.51]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWeGR-1hcyZC3YT5-00Xqiu; Sat, 14
 Sep 2019 08:24:45 +0200
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190913171134.GA10301@SD>
Subject: Re: omfs: make use of kmemdup
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4fd20946-b991-0c0f-975e-ef79b433912b@web.de>
Date:   Sat, 14 Sep 2019 08:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190913171134.GA10301@SD>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:o82TtcJ74WSm9Qvs9vwddyV/R3gnUP3kWuV7E6q3IW6KBiwMo7n
 PLLS0z9jWtb1pmq/wGSttQAKJkUaeVXLT/GafmwzdVBvdADZ/3HVHvlyjowCJHji0OfHRl0
 om37iFA1XSWIw+5w3wRT8ijrc3Ve389UR/7Qm7BzzpPIT3a5a211l9kOp1Hm1wC1hHGUraC
 E+veJB84M9NGYC8lwBFAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7JEQxfGtMAU=:5WFtQ47YX18bFGC++7DCMB
 M1CGNR6kDCnNNWJPMDbx6Nc3d4rb1ct+riwC8YkbQ1va4p61WQT0S/29fXl98p3Sg4eF0hGtp
 tsTknxPA/EhgLwNSn0SKVEnoPyjK/eK3YoKEwjZEyZBAPN/oXtiflekbQis8MGBlW31u0M5zn
 ZX1KlIPjIiNr/pYGORECFm0UqOxZEaeMgEzcCY+dKbrqV4lS/VLkqtScHF+9SjYTIY83uyhTe
 je0ZyHjqIt4iw3GsoVNyiyNgcZUkhgjRkQY+fN3gWLbDobAIfLjquxQBMZ5/rbF4DusduPvVT
 4XtNY/B6MXjwDOIzAwPynMWOgfFoNkOiMaIteQFjjdJaGqQDccIclgFYfROP4mlvKimhXU9Ew
 TTHRHTOJLhSxuJKhlEBjkG0Ss4j3sP7AHhY6xpifWBdWdfIJf4EtmC+lUPLyH2XelNxQ6LZY3
 cLujOZAwpGHWBcN+AHYce4fgpxHiK/6onQu0igFj7YUEr6+Y4nVnpxjerp0UgLv+bdwPxGEyX
 JlAiWM7PYcexKuRHLWjM9+mb3TYurmkjbRQArONtmoLd3FRejz82IuXpGfPQcF/taS3mxEGak
 Jif9u/ySifoATpGaaHGUsrBI3lwbjUKEv6aeaeggcNM8jeYnw6AaTe/t0PBtJZlj6IP8VMmQ3
 Flb8zymQ4SIWCWYURV/7sI5zo8y3edMJ4UCokl27gRBIzwCorTlPxVToUpqGNhQ6pQVbw9HEU
 HLd/DeoEMQRMQTkrJrWyZFdyAr6xNeW705kwKgO2Bm5PztRfaQBLmGXFoSvwHmJBCuNsm75aU
 yzYoIAtle4WzoGEQDwD2xEki3qQ0NbRlXXOJl6SBvgyxSUeiZeZW7GlsLHGoFvBuDwT9gVAbD
 wWRyOGdBuWA6dKiLKfr0vNEclfOSVepPPXrU+ZLefzxGOmDdHYdODrXgFgS9PQoqkMxUHlzDS
 MpV1Ke7lQI5P3EljmHJ4t5P0TXYik7fUSTPgXSwEjW/biDSLtURseaiN+LINkWXBgZXuTPqCu
 aUNtNt3CJ47Ien3g+ScC8EnxmorDRwa3kSv7uo1VcwGcir8P2G7p29WkVx5YDeGIBki6JLB+D
 kIMsaZTM3TR8evYmPkVNKbMntbxwfjOHCWEuTq3NsFcKUaBrLp2hpcz6mF0+PrGuCEQjOYi7k
 O0PMPBvLrCHQkNx25u6AxkIaC5JB+iZv6fs0SZRA0F5BXIkBrxFYrseYxcmkIjuFrGXiStoZB
 E7i/CiZstcf91WYOhlqWH1+iSMXVtVx8ZbkagxPTvag1rxsLKjd0yk2gqv8I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Replace call to kmalloc followed by memcpy with a direct call
> to kmemdup to achieve same functionality.

I suggest to take another look at a similar patch.

fs/omfs: make use of kmemdup
https://lore.kernel.org/r/20190721112326.GA5927@hari-Inspiron-1545/
https://lore.kernel.org/patchwork/patch/1102482/
https://lkml.org/lkml/2019/7/21/40

Regards,
Markus
