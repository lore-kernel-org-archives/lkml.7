Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6B4206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I9EGS0zY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFTTDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:03:25 -0400
Received: from mout.web.de ([212.227.15.4]:40767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfFTTDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561057372;
        bh=5Xwxjs0RUToH9qJFQEuzFSAmrjrpbM5RBcjKSRnTB0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I9EGS0zYxrEV1Lq/XuuF7JkjW0xy43tOoLGjcmbzoL12jhCb77ywzc8PPJezFJf6R
         +FeCUOp3dPt4kdyIzVse7dDlEMPIFnSoh2syzQREpbhX1437z5Y9DRWrxFOwV4Hq6s
         zHSRtINXMaQ4mfjSPxDMqxskylSwU7WYUgsmZRvo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.128.109]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYefK-1i8Eda1vda-00VTMw; Thu, 20
 Jun 2019 21:02:52 +0200
Subject: Re: Coccinelle: Add a SmPL script for the reconsideration of
 redundant dev_err() calls
To:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <alpine.DEB.2.21.1906202046550.3087@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <532ef0ea-9478-bc2a-c1c1-2ed5e1545879@web.de>
Date:   Thu, 20 Jun 2019 21:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906202046550.3087@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FwzKJAPdM90wf9P1+AUL4rGU32JO2MWkSSRBTTuHgqzI2fIvm6L
 hcxuorftp0fYzrD4uheAom9ovvvB753zHEQ5uPoLLXu3dpKvUpSPIGk8MU8A3MrQe14ODBU
 eoXl5f2Ns6tdoBqfHYCMCa8vG0mnnnUL9WZwSmUTjJc6dJMgluevBiBsHS2qQVkEIIn2+hF
 /HRyfgMf6RYvWss+1bYEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ivDt3DMEkbs=:yJGOYYQTCTHgjg0PML8qg1
 Y70nLz51SzDCh/COtFkH0jiJ7Qq7rVWk2djIStDiUDcGVAsc86WMGvq6TlhCVIU5h1buARXz3
 jxmdOT3clifk+Sa1h+Q0D4bajFvBKEHa1mpgzRs/n/wALh92rLMVp2D86g9v/w8eRZgIjXVrH
 llQbZZmV6Le2eIqnaKZP5Zkl1W4bNvYctQpz8XRLOVE9iFNbCNzKc+N5bt8dOjMCdlglIE52n
 9ZC3OkPZ4YIYnjQUyPz6CctbhtfLCZTGhAJqrxOjbC6/bzHw3NyPTY1VpWLgnUi5ng1h/9SvQ
 1/UGve+o9T7MICHYuOCoDOXnrl44b1qhizCTQMwIg/tdKJsu2W88wtKHORulf8bHGNmMRDarC
 3RDYuvbP/aKuCZYtoEMtME0C24+No0pU5TC5CEUZqZXIExSXcJUky1dda3Y+sMVdJc+C4aKGN
 HTSpzUEIX89yOwTsD4BAJqk+lXdM70/cBe0d1sobODjihjNr+CjSdh8jpi9Yy3kDEHp1r1Chn
 mlSV4iCmSOYYrgEozRhgkhQy7WE23YUosApdRnc9YFaVYhasdiVI/W13c5ZaLNEu3dyFinJ0d
 7mRmFifw0rvoRg/sm3ouSL+M3NEW7E5FMqb1bPLN3BC3mKBpiWyOrTS9CfatDmFZgtMgT4sWZ
 Zvaylcl2Y34e6I8MVM0UXeq/0sxPwPw5uTDawp2ybQABhztAtPIj3PE+CK+SSv9FsJUvpd0Fz
 aBYCDFZsMUcWOwEep3mPUfFdsnacGzqX9TreT+/owW7JPPBNEvkj4ocaOWyVpKNTbNyrn7IrN
 8iZOWf0JuFLFOd0O2EWtQ+nJOlxN3db6zqea7KkqTnjKh25FlSVrPqAUQSHZODJFVDbEtznyz
 BzM6sWbBr/0CthqwsSnLMgSfLdNY7hyQVGSKYEw0moVzkD3tEnVhEPZDzSu6vfrCLJ5Xu21rT
 xd9cP8blpxSj/PTpEzCFBSWek9Au0LwRZolVrphfWcpMhTEtc3im4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +@display depends on context@
>> +expression e;
>> +@@
>> + e =3D devm_ioremap_resource(...);
>> + if (IS_ERR(e))
>> + {
>> +*   dev_err(...);
>> +    return (...);
>> + }
>
> Why do you assume that there is exactly one dev_err and one return after
> the test?

I propose to start with the addition of a simple source code search patter=
n.
Would you prefer to clarify a more advanced approach?


>> +@script:python to_do depends on org@
>> +p << or.p;
>> +@@
>> +coccilib.org.print_todo(p[0],
>> +                        "WARNING: An error message is probably not nee=
ded here because the previously called function contains appropriate error=
 reporting.")
>
> "the previously called function" would be better as "devm_ioremap_resour=
ce".

Would you like to get the relevant function name dynamically determined?

Regards,
Markus
