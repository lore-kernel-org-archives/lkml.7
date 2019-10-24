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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3422FC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ABE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="i7KO94cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfJXJMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:12:13 -0400
Received: from mout.web.de ([212.227.17.11]:37381 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfJXJMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571908311;
        bh=4aEBGqmXtNfrjTb5SLh0zecOIGH45CLcQdOp+NHVv9U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=i7KO94cGmUUMCtkJHL53lF/PzqYZ/YxgtCquNdW1MJC4enOpj949sur2Z+SPHashG
         skdEqBXNZsHufzhOt4fZJyGOHmjK74OMDxr6FOJyWDmrThDhi2YK+ajJXpDjaLC2nQ
         lJSj6TING9vGSvz1wOfZM3FolUG5wfA2nMYAxeHc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.110.199]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbyUk-1igkQz2oli-00JNJB; Thu, 24
 Oct 2019 11:11:51 +0200
Subject: Re: [v2] coccicheck: support $COCCI being defined as a directory
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
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
 <37ad0bcd-941d-e02e-ae99-e89f2ce98ff0@web.de>
 <alpine.DEB.2.21.1910240956450.4479@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9807ba7a-5ab7-10ac-5e6e-5279b51c423b@web.de>
Date:   Thu, 24 Oct 2019 11:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910240956450.4479@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YjMjHfRCn8uPyLLm6l7pf9seQPAKH6Tv0jyG0saoEzz1D2dsClk
 25eHOJ6cCeeMyBA+ibTFugdQrYbi8PYUSmm7h/VLQRTehb1nkx+r6gGbW6Km9T9Gk00rzqh
 2w31FiscFs2/PLZCVX4EGdpJnoYlliC9tcOn8EFNWeEamRMutxwPZOuChEiKFd6DNS04UWu
 Qj0A0ElB9Sm06R/vQ1JQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ov9cTATaU4=:hYl2OJ2Y+/rztRaSMv2Tca
 kue2bqHPpzQYDAYdie2NC7wWUVgREnf9jnSxaFhlEkmRBeVpryvLBbw78IyGgfY40uhKsOrBx
 94PleYmTufSkRMwMNh0xiPZdyLkWeLVtEloAW82QCDGLQLwjRzPps3e7+HREVTT0qiUn9e59r
 V6qdpITvU1aIE9vD+sm7t10IRlNVQ1ZmjrIbAj+EBBuL2bH/K+4w0YzsdaOsh9CK7/PX5rvG0
 Nk4tTPcv87ssaHfcxLgXT5DatQoAdm+RvEQdK8Z3gZRUZuAc05awdkYhIuMVrSSgBojPSPf9u
 aBX+EniQkrgiUsnS8aFiNfmBBlKa7NJ84X+WpJMPIsPhbKIcbbyXRVE81Gfy1IyW05HK7wgj1
 E7XCQqfUFc2iC7O64t7sywuYpTOpyzkhDv/HnIY84eOftWborXZVX5S+jbAdeqoXm34c7jVmp
 CljfyFcqH4CMllRlVVX3UuiRWlDyUmDUxOPlQN/Wj5bvhHyfzPMjh+CBkBdDjUPQamiwqpanO
 Tq9nBLw3RAW94+eRk/T69bVZBJ5k/bxYd3xruQSdxMOa5tHQZd+rZiuNk3wro7oPyTh/ATcur
 q49mTpzWLTgZqUQYUyKD6IvbWdaL7jiV5aabbY+KIkniI9MG2NOKRIRpOQYWWmGtiHM6bi6Ai
 stT41Owz5JMbGBZbh7Rk683j5R5Z7P/yInzKhOOq3WOtIN8t4ZwVrhifUHTri7GOTwpBjpruF
 cPQFaMtjN3cAeHvFW5qZvqIb1CsWsVR1BodDgVOdrlKf81fjGR3DS0fcour4CM9U5cQx3yeeE
 heJ2zvwYI5sm/V51tAFvAq7Ci9M/sal14KzuY/1FrfSYR+0sG0wi6MIGuuXzE+rWDJ21iXVLv
 do001p/ESARlzWvhQhN75iKABzoN6BPO8c90E4hKCDKq50l3H7tNw//GtKPIydpHyGXJPrMFr
 0bt1fpxbl/riszvys9vIQ9MmURNuK5vkCUbg2YVylL/nczuex+SlYAcfX0tsuHts3Rb/7X4jI
 qn1H14kslGdgBhUZxLFfVc56H7IVUYEcQNUKY99AFZwgsPtBIYlKqT9vDWZQsz4O+l+5EPdWx
 8frrii6wDUx2yP2aVxijFJSR8RWklGuontrnhLjLwqM8uQAM+kmG3SunQ/lUEl0Ed62qZuI4p
 hSZu7QpQyN2zr0JRisoJ4qh7PzDL/TZBqp+jnmt3aBbPGMHRWqZj/RlkPFM4E7V36/tAWysZc
 4YdjrWnDnce1WXsUjs4sT7LnAHIwIaD8MYZS50ChyytAJrWGshHgZbwyxq6s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D13b86bc4cd648eae69fdcf3=
d04b2750c76350053#n656
>
> Huh?  I was talking about the log message, not the subject line.

Thanks for this clarification.


> With that degree of orientation, I think one can look at the code
> and figure out what the intent is.

The intention should become clear by reading the commit message
(combination of a subject and change description) alone already,
shouldn't it?

Regards,
Markus
