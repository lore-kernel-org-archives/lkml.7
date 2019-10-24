Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CEACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D9E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RPHIAGcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408757AbfJXHzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:55:54 -0400
Received: from mout.web.de ([212.227.17.12]:45255 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733188AbfJXHzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571903738;
        bh=UNnIzf/ltfSLiUOFsj1CvrPkRnY3Y2FSP+wrE2VuWIo=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=RPHIAGcM84CLVk0uOn/n1CnlC0HydePX2L8bY2x6i6xR30RbVLCMDXvjQ3f3RdJLa
         IqidaDWI0RLsKxhbz/Z9eobm86iRUzk5ImxHVOWtTC01Y7BT2GCfd66UBeHSe+oKsD
         7t3WJgOJkTqjN2lZ7EKix2IisJvx9vqxh+hPJ3eE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.110.199]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8c5-1hgYEm3WY1-00jaIj; Thu, 24
 Oct 2019 09:55:37 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Zhong Shiqi <zhong.shiqi@zte.com.cn>
References: <alpine.DEB.2.21.1910240816040.2771@hadrien>
Subject: Re: [PATCH v2] coccicheck: support $COCCI being defined as a
 directory
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <37ad0bcd-941d-e02e-ae99-e89f2ce98ff0@web.de>
Date:   Thu, 24 Oct 2019 09:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910240816040.2771@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZolS6zwkpF+4aKEe96dbsBuAYIh+Otb7VlxxcraA79fGrm+QamX
 W+zsbVHeGvlAtWQznFK+SvO3dbHp5vhq8hLAcooYIncmmIIjVqKE9sFicEb5DXbiwAUyJed
 22rEjVhQaSloYgqs7Y0ieCTZeF8ksbUR0Vj1DafIF6Djz6uSvDWHpmeDBu2DuzkakyPF2FG
 1S0o+oBipZwt6VSbB3MlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7EUnImWhkE8=:AJyNbj8ZXvISOqgDREIltj
 PIJOpXPdOv/qADDj/FlWhGmNSK80VgnDsyZJWk89nzUfrZLpmbIwlpyb/IFA/SMlB1Idp8n+g
 1tRd367wrWJf7mYdN35/GHZIXACSqtnL6U2WQDApYT//Y9MWkQSf4qgm27IY/LyolnaMtq6kA
 84gYq9TrQ2bXWJZWXt4zKt9Ag/cv95dKDGnx7tAU7hYJZ4BlrD4fsMKqLCEDzPO2VARMy0C3k
 TN+ZzPtEjMRfQJHl6mqQg1XcfFvJtbWy4PmsEPJwpPLktUDBnnd5/yro2FTtZ8B6/vUDtiwNS
 ftgv85e99jQqxIF114u0levL2gvcUK/tkOefgWRRC9/5fJkuFjTOvifLFuN/W3gQulZnwef7r
 2x6jUBiRkxddVnyfA9UVqgvcFmQIBA9Wv2J7IV0qJpmQrzmT8n87vr+l3LTJeHRbOhcIZuuph
 bJXDOEnRT4UweupR/v6UaxuEiOtYBFMLSj9Xrzoa2IkH1oD4RdwXeE6o0ySD+AcZN0Ll6g1yi
 HoOEH512dOsBY0U/bWdQekO+6+y+u+qCkuowed0VtNPDczhLfcXJoup9nbU8Mwb31brq4ikdV
 vKpfv4wOl4IqzGeS0qBy8pwzivrgT4kr2mGPFc4L9k7uouxmWqjTGWGsdppgFVbbbvDjfHB6B
 hQs3uSHvjDUoPr1ySRAHbF1ec6PuCrlFZiwbNxTHGSAU6CHZc3o82oC/54IKZpQeoYUUedhKv
 bl/1QeecdGBvGFxdYY0MaynXXxBZhT61BgEjyu8FB/eVpIutgQz3+FN1wEb1cYJ3maRFnkctA
 gBCZP0vP5uzzTyVMOQa/h50xeh83ebYkzoWy8yHgAsCcF+0AdgC7M2lTZi4QAD66o87jM9B+N
 Gkm3ndN4YBwwGD9FZWvhh0kyXE+qm2GWBte9Ojs42ExK6cdn3egFhwSo6XWs/5W7d9ecBvTw6
 1VKze28qWQgM+t4adQcYm1nfc4y8KBDptywNf+CoktmjcCqBWkyn8TVLY6wdBUgggte5rJhnt
 dA5fWLxVkDnbfSY+m372Vti+lRahJ9lccm2hG1ANyz137A8E9qoKOLhuZPOq5HXsaS3k48LWh
 66D3M2uxXJzUnG4NEM0QjFnXEuMnfF+6O8cVMQltkHrg6BxbwVznmkx8gFcvgaFAY+/CS0Qxs
 2lNtNDbRcdMzenCNmeq7jAKIwz4wAKzSYR71Kft3VRppILCtcwD0cLyhRTwGTT+R7+Cn/uTUJ
 yLe7ESOVVJd9EoCcfSN4CS3gLLHJ0y8IfrDq390a9rvtD8Kxi66W6tFqBPYs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Second the commit log could be more concise as:

I like your desire for choosing a more appropriate commit message.


> Allow defining COCCI as a directory that contains .cocci files.

I would prefer to concentrate the patch subject on other information.


> In general, at least in simple cases, it is not necessary to mention the
> name of the file you are modifying in the comit log, because one can see
> that just below from looking at the diffstat and the patch.

This view can be reasonable. - How does it fit to the usual requirement
for the specification of a =E2=80=9Csubsystem=E2=80=9D (or =E2=80=9Cprefix=
=E2=80=9D) according to the
canonical patch format?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D13b86bc4cd648eae69fdcf3d04=
b2750c76350053#n656

Regards,
Markus
