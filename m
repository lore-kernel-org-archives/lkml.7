Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49E8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774B621734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hSCKpJkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfKAIVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:21:25 -0400
Received: from mout.web.de ([217.72.192.78]:33023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbfKAIVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572596464;
        bh=k9tnTJpGbMxipo6RsuXTHHH0wyRaU9ryBJY5u2rpwxE=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=hSCKpJkY/m14bAQ6B3QDlqLeQxKbBs5IUAiNNttVjC3bBCGV0NxDcCA+POAiwB1xS
         LSvQ5DzReCTD6351GZPPmaKR6ADsTn/py6kr+hZIsc1Wpj9d5EMJ5y4IobaBN70/8G
         J3SF76UiRSN8qseBavJsDCR6Gce6IG7dhPFVb8Kk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.35.66]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1i8vSh0Y11-00syJk; Fri, 01
 Nov 2019 09:21:04 +0100
Subject: Re: [v4] coccicheck: Support search for SmPL scripts within selected
 directory hierarchy
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <201911011049160582771@zte.com.cn>
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <10550a03-3cb1-9c50-7370-f1919529ef9a@web.de>
Date:   Fri, 1 Nov 2019 09:20:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <201911011049160582771@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E44h+rcJlW2o3YsncLj2IIpHQd4hFagwTH+8lRPV0hfH2wsvNsp
 v4M+Kf3LQPiwYSRYDLvMTFzTgdY7PgzrMy7WY9cc5wCpnrX7CcdYAmqZYafcybuLacqKe4h
 hSlKOI+7zd8JR0iWE+3bt+cElk0si62OBGURlK9iD5Nd9hd3YvHYNJuBe2v2LmyG8KKqPek
 w2FBWEeqMhCyduS0E2vOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IcJ0sWeaoLM=:3toT6yG8YW8YXsfzmNMZbR
 scHZcrhJNXl1w146wvAoYiNPikZFWMyiUORDBu9PbwY5ZQELfZshOpUAOtpqnYRcNGBZJBfIK
 hnjFbbPyVb/L1pSKkHgiaUgyo2KoVvTLI3VuS4XBZQFLMpotricmhCPPxDBaZZSsWimanOMK6
 HKmFutfLC8wEXar1yXarNYDxNXC+doVJvFg+O8o51xvYpND9NHmYg+D1w7vAC+cLzaRT7Aw4/
 cekbcHXstFuXWfdcYotHqAofjQmvwpa+sFR1CV7aAzzeJ7a5EG9u0/Q0kLXmPmvAeueWuTrV0
 rowixbpYZ3tQLc0DrqKKtDiwZhbB4O7wmW8IwhBqo/NsRzkHwvyUq3yQaG/oz8bag4x9iInJP
 i7xd/6w4kLq2WGFQlxXy2LP8eSs3zK2wxZwlA5Gxlrigy/62pnXmVoCQ2iUaIgxgK4VGsNyQ7
 G2QTJ5nzm6mu26vwmvSk7xmpr/xhhT0a2aIF2CnVjsRJGd/GSkBhXupUXCGvGNwCU10JGAJFv
 vKZhSXlCPIIx5RJBgyKaGbsz0Y5DmeVkoE/eefyRWN3O6BS/Eqdj0J7t+dr+IPsX0pT7bMr1c
 ohMCjk6P7eGEx9TS/8azwOJ0CL7/3EH9fNblE44o0HKhVvD2QscW7PoNLp36GKJGtHnQSkrJQ
 vSYPWVgJrOs6PpyqtiX+x2Yyxqxx4l+o5o3mdzimEx5bO7Ub0rTqAKc7TaE3ELGT+3iKyXa0R
 Dq97XYRzw2nwQ8CC4bA4GQk2HfFb6BsHv0H8hmiuSZ9+Z0SjO410or9znujf4Af88oDrcVWVY
 hHX2BRUhoYLlqNLx+WEEDkoOwuaa8Mo8uWw0sAATNe5Zc3ggDJD33FIlNXjFzvbx2lEXc/8GW
 Bj+npjdNbqL+zZLh1t0h5ahA+6/uO3gPbgIV/k9ynCZss6s639ALHgkp1pDxeSHNlo6mgpxIv
 ndRDGjADrXVX8wLM6QxTBfHQNKVawekwPOwHKYullAqaPdyBkPFnGSjZHA7xyQB1QZOdWTLjg
 relkqhlDW8yZoAOqjJHYCsA5o8ou5Y/+ThowHV3x0X20o4uQpihDQqNT6KF4GPpKqFRxAfGLp
 4jDWsBEzeiqWsKk9kFm/jKkKjfuW5ovlwySde2+KaxiyF0JnlsMU3RibACDWs1yqd4J4Z431u
 JMIpVmiW4Vjg28lfWsRiss+pZ5TTS77fYht5AqTKty0WN2jyf2Y8SVeY9mC61TNt3TGo4og1j
 QDncro1e0zwINsxXhTgPqQjIGq/kg2dklxFBmll6JFxxL23FJl3pNFcLAXsA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Defalut value

* Default value


> * Directory selection
> * Single file selection
>
> Would it be better?

Partly, yes.

Regards,
Markus
