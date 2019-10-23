Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB3CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F92173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="C8s7W56T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404721AbfJWNUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:20:54 -0400
Received: from mout.web.de ([212.227.17.12]:60533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732590AbfJWNUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571836836;
        bh=ErIr9RScqShyiJEIAF3ABEg69VIQugqYj1z3/hLTiWg=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=C8s7W56T+rB/9N4hymgEcwoRD5OkYP/rh2AI21121Avx6QEFVYTOuo1TANQPmaIQZ
         jwkcYQ1cekRMgfVHce0iMZMOAC5KwY/7GiOg5hpDfv+HDFVvhcayIbllnHboTZQxsz
         A1kQqp96MjW2VeIIC9yqY4r/WEJTNEbcTtVDp/v8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.140.249]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzKEH-1hspNN01C5-014SNL; Wed, 23
 Oct 2019 15:20:36 +0200
To:     zhongshiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
References: <1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn>
Subject: Re: [PATCH] coccicheck: Configuring COCCI parameter for supporting a
 directory search
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6cab41a2-b775-7127-9d71-9b08f27111c3@web.de>
Date:   Wed, 23 Oct 2019 15:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:an81rpUiMJMcO3jfixL+FL5vUut7susHPFbN4OCI7l56++IkQn1
 HHosAZ+vJHFkpBCuUby0LDJHgig2rcE2VkDO95ncTy/X2CAb+lbVi6a3iA3jhdOpl2R4iOT
 IlE2p0cnKwbDZphkWf+WZhg8qAQdwoEMuVrd1UsN4BEhoVdGCqyi1egiPS+ABgXvqDFcsHs
 GMh3//u3VRoo5B4Ou8MMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dHeIP7dgmMU=:vhyq7teClmIrPqNX+fB9uX
 NswgIPvdf9clNZVoTWxu0ln8yoEqsaKRGFNewXWEEKHXlDtzRjrDSW8AxWz1yt+M2VpRByDgK
 D0NbBJllMvqnZEVVQu8/5NcIjG070ZDF5pW5tSDTjNPU5OKUcdOqQ3Yv7RW2FYybzBz4fsZmg
 KXsIz/sypAj71BOhwg69vg+1pKImryTqO0srllZv3ar6OKYhaG0m9yVOPDWeBImH2qN72Zrnq
 YbLZ+OqlmbyQjyTZs52AOxTM4kPCaAgZ0KoBZtUeQqg4cdHPkC35tecoF/v38SK5ElzOW4Esd
 +oI1N7a+ZeP63dlMPH5tOoNFsBQIcLJEwz7ZzY3AOu11kbL1JZOZeIlm+vXsjKy34qKq/bZYG
 fW/tIVXPBsemNo3D5fQC5P8G27w1BrZ7VPoh61L6+xwKivXYHgX0UTYv/tYrJfAoxVV9d2c29
 crcSlls5C4TF1vITqGcIWbBDInzuFcIWuYeY8NBttx834znCsXR1XVkGMI56r/eLzE6qUWQIF
 DmHYU5IEvDRS1EYkkDl0HJARz7oruR/00Ff4FcqzHfhYKYooL/+GLB+Qe29Slc/fVt2gajOJA
 LTNid3u6F5WHiogrLBVyl49J5ZhwBy3efrSZTsLqXiDasCHDaqBkVoTmXvFfZaOBG/FgtHQws
 PriIL8yMtftNg63S7O5R5fp0j2upLR4e/sB2aHj8UZDtRgEniiiYEiQqP7qloF4uY0v6pPoFG
 NS//ttT5+Ig5R+wp1a8DVVKpd0MnY1CYJMhG/ew1RZbilYCZqn3tq1f89zj1QJIvXOD36Yi2i
 0+xGnqY5L5Qb+JjuyLLxQDZVCtBl5b7OsiTRX4qUlDqmz2CMuy4nDdNh9rAsOfsMoFtGkhPGJ
 7YVTp9R3SyZr4sSrI2Q57KAnQfQyqVkMyGZm1nC0D1nOwydJk2z/TL985k0Q05V1ICt+qhiNj
 kIZBgWLcaHk0EkljiBj7kE3dO5FQlGCxE+uvXcZmBCuSPuhq2n3dBlDRVYQB/ZJDZ5AXNBbac
 sDo26Wz+4RIW+1gFEficubMYsZq+ilmGaeCFIwer5ojZlkhNziqWo9VGG8oFHKvqDtzXxGA9N
 4A8QS3TaQo13Vy/1gDCD0hiEDkOL50nmo7czphZejI0Uvn6af7FW8XZXGXMyu3qvhuxXKPrUi
 ZAruB0OkYjQ/OjXA7aWcFFqPK4tQLBlN70EZCxqhLgNtZf8m1bWstbV21gMQ1MYST/4B8zGTO
 E8sJWpHI2tAA2beuzPBM5sp3ymhSZlNLsxbrT+vx+bTfcQEUz3QBbEKa0Txg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch puts a modification in scripts/coccicheck which supports user=
s
> in configuring COCCI parameter as a directory to traverse files in direc=
tory.

* I suggest to improve this change description according to a recommended
  =E2=80=9Cimperative mood=E2=80=9D.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D13b86bc4cd648eae69fdcf3d=
04b2750c76350053#n151

* Please fix your patch subject.

Regards,
Markus
