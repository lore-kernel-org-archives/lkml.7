Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF9D218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CGyXpFGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfGYHqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:46:12 -0400
Received: from mout.web.de ([212.227.15.3]:57661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388187AbfGYHqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564040763;
        bh=5qVdSDLMF8CcV9pfWX2CvLF3o3XuTByWM9mgJIGzG44=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=CGyXpFGoDhHPm8Yvk663DUuJjqGuyZ8fuPXWQpezOymcpKPZWoD8BBphpytsznXoX
         6VHI4vBvReH3rs8TD8oG7vE8Tn63AflM0O2x0yMPWfO2gUD5I2icV7Ypy3BFYqiCLL
         of71nf8UYkaDDoNLPwfgYvswnfa2SpyRO/8lj5lA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.39.22]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lir9R-1iOVHz3eX7-00d1JA; Thu, 25
 Jul 2019 09:46:03 +0200
Cc:     linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
References: <alpine.DEB.2.21.1907242040490.10108@hadrien>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e3a37d93-0353-ebed-948a-991add184616@web.de>
Date:   Thu, 25 Jul 2019 09:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907242040490.10108@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dw8S05x+JUlV7gYHj+3H1BNLJkcyRYi+sMmvwKM4TeN3wUyRIA9
 jbPbOFhV1kseEevPOle0Bv3nVfzYR/x1aRzwkHIHpVHNW9ZwIuyJh7vZVBRm69xans+ubaQ
 lDWZ1byBtdBmClPMS/RMTE9r+rzaij6cPGNSwhxc0PVXGdjj4uMHAb1uFa1bnqNIstMa89A
 pseQsUxGbHdQBA7NtWYlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EcFKwtP120c=:2lL/tdvXWxNLuFmI6dMByZ
 xybnEYmLrz7lH5SGMClO4b20cXlTet+erxklxWijzPVpHp0qNemUz5Z2sIiSsIvjRLPcv+vWD
 gyqPNplozt3GL+VFkSDT2dcwgX+9KCQNH/NPzt6BGbDMmr7+AyEgCIX9LlETQLqC7B/LT9AcL
 iy9mN1723WRVxHIRcTSqy/SsrCOfiJdZ1SZupb8e0gDT28SyJYcHFx3VQ1jUpEBICNCR6t1nt
 CpGEvC5uiop+5WBp+tk9n0Y7gty2KO1AK8TE5yBqki100PsPh6fgsNXMd6tOtABsUakQg3Pf5
 39INThxnWghEXjSE9qHh+0et/G3Z4C7KBrvOkgJqp9HmdZaK9kilCDoK4+Lvbf1ASWCfhA6Tc
 J4sQNn+L+Azf/ndfWUb6tildrPMgFprcf/XnYaAfn8J07xFwG01thVBKuISY2OJs/hRoXKpAE
 5H2DrtqHIP7NknBmn5IfDdk2aR7AaoOBtlQ//ziaHx24qF7j6Fobl1nbyPxtf0u12bQlSjoCF
 YFbSw4zVtuW4D7QO9qevZD+pGPKhLfWwLjlu0J841injdQgUVc3MfPB6TnY9SfF9+ih2VpCyp
 jxr9TtEW0t9pJe00LnRwTI1KAFKGjFDraRqaQciGAP9Z1HtwC6P0JKipOvMRFJr2x1QU6eA45
 RxetyY7gYDWXXSWny0LMPzxEjDd1IXJGeWspmzu5H0L2okLISNbI93ZaDfN8r6cuG8unl7xEE
 xmrJjQtsLigX4PN/+AAF6NKI8RhHZ4U7hYFdiW+NVYNrJKWVdNISpEv630i0VrPEhLaKmfa2k
 N1gUGlQVVtfi9Kx3lxyg9oeAzLbEgj1Lu6oDnxUW+EDZHeeB6IiErri0xPtrI7Uuk4jh9lJjk
 kBpUYZY+wROWHT5GdzdzysqW1LqZ7vGQjFYGOyG7ZsXqdemI2RRYk3UaPCfNwCxHjsB3hWo16
 KXdicNBIYa6s10fdcchkdBfBts4e7FLCcBLZLKnNysBZhzIbtp5YY5YzDiaIU+dWUV6OxE/qh
 HCqt4OiyTzKLgujTInqsvblp3Sj7IXkCr4ubE4UAwensgLZz0GSvkWYgj4ktqZgcMWCxZzAnA
 fyb1rHK4+zw8E0g6xS/PF576PzW1U8CRcuP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> New version.  I check for non-use of the return value of strlcpy and
> address some issues that affected the matching of the case where the fir=
st
> argument involves a pointer dereference.

I suggest to take another look at corresponding implementation details
of the shown SmPL script.


> \(strscpy\|strlcpy\)(e1.f, e2, i2)@p

Can the data access operator =E2=80=9C->=E2=80=9D (arrow) matter also here=
?


> @@
> identifier r.i1,r.i2;
> type T;
> @@
> struct i1 { ... T i1[i2]; ... }

Will an additional SmPL rule name be helpful for this part?


> @@
> (
> -x =3D strlcpy
> +stracpy
>   (e1.f, e2
> -    , i2
>   )@p;
>   ... when !=3D x
>
> |

I wonder about the deletion of the assignment target.
Should the setting of such a variable be usually preserved?

Regards,
Markus
