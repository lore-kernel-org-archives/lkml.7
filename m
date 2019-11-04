Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE45CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0652080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="V36MwZz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfKDPlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:41:09 -0500
Received: from mout.web.de ([212.227.17.12]:39771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDPlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572882038;
        bh=91uXF2MDnLTKRhI96RSE+7EJYA76bzEGXm7FVvuD+YA=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=V36MwZz/Ap60fCE79Da56ATF4ii4osWw4189bfFKZv+oIYyWoBsfdgdkS+BW1OH39
         BmhoI6VdzslOaOpptcgNg6JLF2YybbDr2eeSkajfGVWA1yQALW33/kc16kXTLWZQzm
         Q5fzsDScMegn5pJKC92o8Ez2Pc8qdhk14T+jUKr8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.71.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GN8-1ieKyW0J3e-00ClnW; Mon, 04
 Nov 2019 16:40:38 +0100
Cc:     linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1572838555-12101-1-git-send-email-zhong.shiqi@zte.com.cn>
Subject: Re: [PATCH v6] coccicheck: Support search for SmPL scripts within
 selected directory hierarchy
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <583d2524-6b29-487b-a000-9a764b5ecdec@web.de>
Date:   Mon, 4 Nov 2019 16:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1572838555-12101-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8JlTc+SZJgPY0NEDh3WeUVt1XReSBN3DjOC4N0agyj7iaslmFWl
 8iSDxJa6cdZQ6MtxSnrUJhgG2e4lKI2p+nbgKAy49gqMdCm0kBfGZh/J/9aTjMEkO5hC/h3
 WWL+vv43wTwpAbbg18ZvAoLWgrEvGAEuATQH2G+uw0voN2SYSbHducGrYJ92HcCclQhM8iK
 rapgngdI53CkA0O2vv78A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qd/Rta+2wDI=:gvCJCPLvmvhN7PCP1bDSwO
 PLCKZL0+FjGQQkjm8LwD7Zqs8GdyRH5pbdqkQ+lrDmH9iw76hg31H1S+Z0AUjzzIAWa3UcN4B
 ycu3U77i6UdSahvfcim8e0ZJ8a4dAaEOXgPXe0ujt7kwaQnl2I+Tk5O9P3NGOjImzsEtAwurF
 SnRBav5dTpS1iTHDehdY0LKShgNDUBnXagmIBnG9H3u8em7o/TCyZQfuZQrHX1gBy/+8XYaLl
 OkJpqSeUPtpkEoKAGTPa1kwHkVCX2WQhL3xJ9tp9q74B9jqQl4u4lCSxGevBFfSchxpFTsVkQ
 nlgP5QrhAam8QJoDKvI1saUZR+/XQXBHJpgDmscKgx8UXQDhODAWvT6TWFCxAUsx2WRCtvRUn
 WytUcNiq/Ly4uPK771Cg1qF3GBnospOYgmp9bSve+SMUyXq5kGaCtF55YESOaX2uSLgK6ygxW
 TklHU16eIwspNAmG/P6EA0ibsUXjI9v+7IZGI6d34TFHjN1En3WqvrG8EnZ5Xy/IrDLWixwft
 aut9YBYKnoJh4iT4xCaKN3QPFB38HwmA/cmwV7MAjRvvYGG2TPoTCpm0iTp+Lb2UKU7CFaJGt
 cruEdGxDfFVMRDng/Jq8S8f+Cs/RwCpqSoJLwa2c2CZgEvU3ivyMUf1So66L0l0jHNP+TkQTy
 KL4nnYwsdqjHj4wcolCRvgMwbTlHrN+bcog6ckcFORceb/Frn/fg+hwHAYNA47wYI8XlJ3fuv
 z1pk3mO0jvJLfTDPF2IdGVdWGYdfAtiLE9KqiAU33Ay2/8myXszmrsNuEGQb17kQcEozFeeHS
 Nzpy6J5Zz+R7BAwk1WdPih42WdBzh00O/e4ZO9oTJiyUpdbnTgU0X+qWUKqidLZLXjbLomK1L
 N7XFEcXdU0U8fbE9pWLach81fzDq1sEzO9Q94ElTemhZZql4zbiUX9gBUoUtk2MLItsngdvC9
 zQroxkvOIVlc9mPmxJgol78lH7noOU2YN8BIcjDASGsdrUVCmhyj/9JV0KU2P5urGtxMfQEbL
 GKa+a2pO11BZoH3inT1wOA90peP/wRXaWKHiMTNl63ZwLf8lbr69YvA5WxJ+oyv5bLRYwk/bP
 nUkuwzCrlzyECGl9CuNpZIf8NVkb0N6805iNxBRkB8D0Ua6ARxHyQ+WVex6j/b7FEoEhxpokh
 2jpc29yMD3kv0Y3Z6PGIt68I8rkzsI1Zhut0E0x+j+sq3hKwGMXYslbzYFkX6/BTQQPURZ8HW
 FcoBuFniqVNga1W3/cm+LUfTSayBJ6+8YjAvTMJSzM+ZwwTURy2D4Ng0qL7Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> *Allow defining the environment variable =E2=80=9CCOCCI=E2=80=9D as a di=
rectory to
> search SmPL scripts.
>
> *Start a corresponding file determination if it contains an acceptable
> path.
>
> *Update coccinelle.rst documents for use coccicheck with a directory
> selection

=E2=80=A3 Do you really insist to use an enumeration without alignment
  in your change description?

=E2=80=A3 Can the following third item be nicer?

  * Adjust software documentation for using coccicheck with
    a selected directory.


> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -100,8 +100,8 @@ Two other modes provide some common combinations of =
these modes.
=E2=80=A6
> +Using Coccinelle with defalut value

Why did you repeat a typo?

How do you think about to use the section title =E2=80=9CUsing Coccinelle
with the default configuration=E2=80=9D?


=E2=80=A6
> +semantic patch. In that case, the variable must be initialized with
> +the name of the semantic patch to apply.

I prefer an other wording.

=E2=80=A6, it should be set to the file name of the semantic patch to appl=
y.


=E2=80=A6
> +directory. In that case, the variable must be initialized with the name=
 of

=E2=80=A6, it should be set to the =E2=80=A6


Will the presented case distinction need another adjustment
for the document outline?


=E2=80=A6
>  Controlling Which Files are Processed by Coccinelle
=E2=80=A6

Did you overlook another update candidate (which I tried to point out befo=
re)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?id=3Da99d8080aaf358d5d23581244e5da23b=
35e340b9#n189
=E2=80=9C=E2=80=A6
COCCI variable may additionally be used to only apply a single
semantic patch as shown in the previous section.
=E2=80=A6=E2=80=9D


Regards,
Markus
