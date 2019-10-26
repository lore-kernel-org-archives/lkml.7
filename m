Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4ED206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 14:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sYWbBDzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfJZONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 10:13:24 -0400
Received: from mout.web.de ([212.227.17.11]:48601 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZONX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 10:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572099178;
        bh=4TX9IoVt02UjctuLRVcYz2uZPBenhwfAGXWjWXCWIyY=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=sYWbBDzlH+FENo6oHworMEhP5RrV+NQt2IeFZXgtJRrcV1sImqp4V2CKhiNJ6ALeQ
         Q19GuZ1FybT3FkvblmwPBg+FGaHHQj3TlKpM6lxGXZa8hC+5KXJMb7RUgbLiwQMZ+y
         281D33a6dxZf4ihLPgOX+h+aUfr6IsvbaPuLaA/s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.128.16]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1hprL603IQ-00Zw3b; Sat, 26
 Oct 2019 16:12:58 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn>
Subject: Re: [PATCH v4] coccicheck: Support search for SmPL scripts within
 selected directory hierarchy
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Message-ID: <4905e8f0-6266-99b4-c3c4-9a9d29170bfc@web.de>
Date:   Sat, 26 Oct 2019 16:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:79BWvNPOg0pzpn3iMDrTDvfOhMnHcdEW2GsebM2qXprGG+vsMg+
 UUX95Ut6h5KlwXgJNvW3TvvxMgM4/utdnl3U49CzwazEQdjEhPZIbLF0Lmx0jFt0oX6VG8z
 6ERhLq7jzCf4cNBZnZGRVf0A9t381ptMkTF6siHfQtpPJwM2Nsbk/QLKs/UAAXWH86YKI58
 9CdoFVWGZSA+QPKwuWeKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yPG9bh0oOqo=:EmUCOy13dNt7nQ5dcyB7ta
 n3VS2+00Iui5+CScQG8TYYKtdLLQREsqzWCjL8SOKkRSGhRL2/trOBh5Wpd2e3kxoBzbpaTps
 FOdgeVkSMC27gN3DPHSMZyfEAqmljVfccrChh1ngHAxFRbF0C6BSKB3Pdecq8LUC96fRXfWTt
 SBighSYqyWA/TZ+b9VLKX4yUROpdnrBAia46UKY36crmcXuEm0fPz08lRHVfTy+TndDGBMuqr
 EvMAoiov3XYwX3+k5WYfXMTYOqKHy+6M4BwsD8Od1rVXLub61WhHm67zg4imi+ARxOIhGx+3y
 3AHwlGI232OpJABCwTkbnJ9/TF79+d9j1wX1SbDEKD37Ek7MZ7wtKI3MqDxuqp87Vc5hskOY0
 IwT3y7y804C8K6xK3jk3QOJXaf8ctiscPzs34NjMAmIHpJsmEwx0jvxqbpnJTTRUKWb9dAMtp
 PEvNXL/jRy7n9/gg3C/xyB7R/7gkReB0m5zYHtujGvgn0NPcVgy9ZSyXlwY24NaKeQYvLetWc
 Zr+xVPcWDsJEXU4poqIRj3HZrmxCY6clxVzN5NlcFirzbf7HcQdqU1bQvjd0nBux8wKUEaVZr
 eR8xpr22SmWw82M1cDKyzowat2yn6qH6mL9mPam5yXVyX7JyS/puKkGcH8BCb6OWfGye8zrol
 UcX5DGyTJVYF57ywAisfujdcs7TQw50lyt1qtj74JT7CB9Q6xwa5ktzGDHb+C4w31bjzcs8L7
 9Gui6xrx2iW1ZzxJ0pR63/yVuHRI90x+mDTayiasC+j4mHMqLLSfzWjutlcThBX5dxouAawrN
 E1prO5MNPThg+OHGJtGU6QvxohCSgmzfTbQCk34nsnNOU18mOZkhJSp/ezG2kAOCc5KSMAfW8
 w8L/3e+b9tBa2XHPJZN26eFJVpKg5sahhnIx9rzcsFdABnvOR9UB9zB/U6GxPCYa5gTA0t/Ok
 EDBG2PYvcj5OUoHBcEzV5nrTKhptiwPWVkFylJZ/iDULJ5Pz3MWAx2z8iJSsfVidBOJZtbXHC
 3Icvd70aJRvWtxBNQwXPxyn6KypoPn589uK4FBjtHE29qcn9X0z0He+PQ7BYr393u7FCoAgMc
 bMfdhgfMrNXiLp+HqzSTtui0a33lL8zXMi3UWIpwNAA7MRf11jSajLADGIu2o+mZPJC0/gXov
 zbJaaTjYcc9lPVdjyBzIWaZ4IUi/axUMfM0Hw1gCiakctrXULeyc7NpRvogd7+nj5vk+3K3Fo
 ftw6C2ifu549Hh28RpofUCXjfq9mGlVux8/p3lcf5nJmjKIdoDmA5t/fR1iI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Allow defining the environment variable =E2=80=9CCOCCI=E2=80=9D as a dir=
ectory
> to search SmPL scripts. Start a corresponding file determination
> if it contains an acceptable path.

Would the paragraph formatting be nicer as an enumeration
as I suggested it previously?


Would you like to update the provided software documentation together with
the small extension of this bash script?

Update candidates:
*

* https://bottest.wiki.kernel.org/coccicheck#controlling_which_files_are_p=
rocessed_by_coccinelle

Regards,
Markus
