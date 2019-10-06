Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48666C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2081220867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Oi4e8X71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfJFFj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:39:59 -0400
Received: from mout.web.de ([217.72.192.78]:50077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJFFj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570340382;
        bh=chjYK08RR6AxiHYkrjky48ZSi1luxWhiDDLUG0S6AAw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Oi4e8X71MkbGDUtByNIACdVHhV6Vslt5qxSB+aeocv2h3+mzUKFL50JxFbe/50wI4
         2Fo26lZtXAUKXT71RFeRxgCSi4rJuQSOC/tiWf+yTXKvawtjA+KM0+o6z6ELi6IWWJ
         RW56SR4LJaZgtDlCFT60my5hKyycSzGXmVcY/Ta4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTyDl-1ih0c32pAv-00QknY; Sun, 06
 Oct 2019 07:39:42 +0200
Subject: Re: staging: vt6655: Fix memory leak in vt6655_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Forest Bond <forest@alittletooquiet.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Malcolm Priestley <tvboxspy@gmail.com>
References: <20191004200319.22394-1-navid.emamdoost@gmail.com>
 <1d0ba4c6-99ed-e2c9-48a2-ce34b0042876@web.de>
 <20191005184035.GA2062613@kroah.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ea5e4945-b48f-0955-ba52-071ef1bb0e57@web.de>
Date:   Sun, 6 Oct 2019 07:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191005184035.GA2062613@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MS5LoYsk0re4zTSfMNFDJwfffuXBsSK5DkOUYDYvvdOeEdsCxod
 2zYoPOE2D2XJAz/QAGadoYQwLW3UiRCc8sCALGdGICB90cRxB7khmtN1BpQB6uG7f7zus+c
 Bm3Trc198ixi1uoZIhUHax6dsrOo2R/fbfgTE+l5Gg5D+reYoJEXCIW6JmBJedOgRv4Wc97
 abjdn3Rhcckdid17d1DWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KOKh8ZOW0pk=:DAq9B+g6r2GmLz3evzN709
 8DnvTxv/sdciw3WCNpWqJ77vnTZ/l2qeJkBBAMWmL891rfzbn7wB9QCZea7lXq6E6hlAcDAaK
 +YFJ4C9qUeCRQig7TolRSizMbHm/ZHGsUlf34GObqcNxFt7ODfjeY8/2arqFbVUNSluaqe/Df
 Q0PSwyRAlVjzBE+MW6MXmDtWpyiZW3ZWOQ/AA1tmTteuY1vRBWur8yC6FM7hIJiUj6py9/yDF
 MA/GCN7HXaRuOmjZpU+hC9dsxZPIJ5X0hRXBSxZjUgp6ojc/S+Z4hdvJuw3byKFKDOb/OZaYQ
 i173Q5PxhsVINBB+4Sc9AIJA5tS7p1ZzLm2t4rq+p0rhKVZyjedhRYigHsH7W3DY/hvESKHBn
 aj1F30mU6xxDM7jBaw9yciri8/f7Q0PwlVG0shmpJxur8EbOMD5WaxRf0AEr9ZZySdAFSANLi
 UldS8Q1pkzwuWgvVsM+CsOBpdNmDyAqSr/BQqb4EurtMKztFFvn+mK2fVGFONOebPWxheyPGZ
 2a9y6NR/balX3U7/Dns2RB81AIj6m9fOPa9cDRM0EbdrOLDmtzaD1xIdDIPOCyUejE2TV1RYE
 GBSRcZIwt17iryeLVXe4VaeacXHTtM/2sOp3eieu4E1l3MxCtwzB1MUv/K5LFRUESci9ZV0Xf
 1a4dPOc6pe0v5sF7nIinBqOg7EGgfdrMZ2UvllTKEJcUw9gx9Qd8OKXgpIFB69WQi/iT0iLIH
 tsjCC4MypQ4oGE8aok/BOaB1MLVHezSJ4Ngi4jWNRKMgG/Cnu6uRHzTYhyPSS4f2ts8WseUNL
 dcDNOdMnXuwnFJrR+MkB0Y9ZYxq7igs0pmM55YmLw+4XQmaOxvmh6NokG0IiGD5wIW92Wuape
 ZIRiisWYbHZUwjijDkTzQnLPtMAZFLBMuQmlphp9jsXHJvErcmtKlYFErGN2ztlL30afCpoSW
 yTrqm2xvYg5HDp+sCIbuDMN6AXUfKIpsOtDh6aTN4uua6uJASZmQMxvRkLYq5N3gnZylRBhh4
 eUdHoaXOXVQeybBofMA3TtjJsKmflgQs2V6a1X3QztjkmQGw0M5EPXxITgkWX/fjVhy2Ba6V4
 QOeGtr0v39iyg3u3aYMtXK+iWpC1MkwBxoG9meSw55X4WmjRE012za2rU6uGQlk/IC+i9W2ut
 B8DA8Tb4kAzMPsqn+fcakaEFG702PoNEi+WJkBuxpiADtzWUDfMpQ4vcwN9x7XCpsNzqHUmeN
 Dl9vJC3j+gjT3URTfwS++buCIg5XpOGXfy81NsfUztjOSB8Ahw7eaLZff53M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> In vt6655_probe, if vnt_init() fails the cleanup code needs to be call=
ed
>>> like other error handling cases. The call to device_free_info() is
>>> added.
>>
>> Please improve this change description.
>
> It is fine as-is, please do not confuse people.

Would you like to clarify a known guideline once more?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D43b815c6a8e7dbccb5b8bd9c4b=
099c24bc22d135#n151
=E2=80=9C=E2=80=A6
Describe your changes in imperative mood,
=E2=80=A6=E2=80=9D

Regards,
Markus
