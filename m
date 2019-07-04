Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34100C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0801A21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nYqcSrWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfGDG2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:28:44 -0400
Received: from mout.web.de ([212.227.17.11]:38663 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDG2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562221703;
        bh=MbtNPvoRrPuFTPRe6+pxo/0XtjQ94KUGUFi3SFMVjcU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nYqcSrWHNo+a6sFgEayjcz4PJp7N9AkU0Q1dxJ9R1DMgfBMoat7v6e1mTOalLGcHB
         dtgUajBX6Pj2Ufskjn7qblaUoUEpmIVhMjZVfFcIWt3sMT//AyrofgXoZrpZjFzk8e
         DocmfFlUiSFFKdxJG0JKTadcJf4ejBkeqxXbpIII=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.138.50]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSads-1i8JsY4Bgi-00Rbl1; Thu, 04
 Jul 2019 08:28:23 +0200
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <201907041103003504524@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cb490cf4-425b-ad33-935a-22c6f3bcc1d2@web.de>
Date:   Thu, 4 Jul 2019 08:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201907041103003504524@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:4vzGtNu0aMQBqWCg84JVzbwm0RsbOvQJ6nPp/XgA4k/llTJb7Jl
 xVvqooyMYKV4KM+8NX0aDO2gRc1NUXp1ZfyFN6H1DERXK5syHBakhJaPxAwY4A+ymr7Hk2+
 TcviAEy/DE0SF2hu9YS+QF14aYLVKNn3eUPpZNhjqv944tihjPFSN/jM3W1PGdTi+vAOD7q
 WPX7qPoxKulkh2Aod3RvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fFq3V7cdEB0=:tT88dkszW18PN05YKj02w7
 s/vDyHX6Y46LPJsVa8mtjAghzfgIoKj9+CF+8mkttX+8J21Fe1JbYyXDJWoyIk1XfhZTHbASg
 +dLN28q/GpG54Pphkdu20dAe1KguAWf28KDo+7U5ITkPMm8e8aSkTSqSL5SlFyw5C5Zsj3Q+X
 bijy+QHU8Id6mEOXyUi/6w/VMQz3MPnNxw8wX0PM3rob3+9yDGhzV8/ySBnu6JEewYvTXGxNk
 cLpqNLVKCJf/mWBmTnLdoIM2+/1l6OV++7cCBcqOtOGW7zavItPqB3rUsgakOx8Wcdwdbhea8
 kS5TJIRzfNOQLK9CgapO6xHxueos/LgBM0Jc+UfmdLxg2lWT9KvzAC7cY6YI6nTmjCfLQdqOs
 gRuKCpEkqhP1xyGPk+I0sRbfLNJamu2onnLJkdhqhql/ZmkZ38brAQa0DA9FtLTwD/JdKWwHd
 KT6MO8URWLDqEQ5DvRx8HuACUNK2nuh1Xm4+EdbPG402os6D+Y4HxGy8xmmBnLwER7St/u1EE
 gZoXXn/CI4i58OVJkMlA/7AHpM2+VXoAhz5yfuSgvc13PhVdr9OJu25emcUHUzVpNlsc5WtHl
 Hf2xLUs3C1GDo2gZ2MwuqOfAxSiys3JVQiBqA0+KNS/IodEPj5vw7UzOy7wSwzr7cs8euBUsS
 jQSkIrjKok4fF1Tga2lloSMLZb9nQfyoUen895ftSOzNDv6orqB+qaAU82OPr3TCXH4C1hhcJ
 eyj9E44AZlUOOtxk9CCkDkBJFLA5ZCDUhWzOBOElPeIub7teH0lNSht+Vod+gjA340X21GPqS
 tpanaYlGn+OMIapM/7rkcGGkt3onFoIOSMf/yB2bxiEx9tr2C/wpoVEc42iiYgnLKbDOK/k4S
 6NisZQcVoZ2vDXeuzstq5mNWe6dreyYpKTZNxelCEbRKWlot0+PzZBWhXdMT9zHJHQ7JDPqfz
 /PzEt1GAtI3NJxq4IAfFYj18cJNCPTmunRatQoldiErkSjAYXeuvVatIZgDYKSkNJOtmNvTwj
 R8eQvchrlyB9UkMPbNOGeGOVMnMZb3T8G/BvvI83OHO52VlyO09kFqlldzIiu79QYLOPDx1EF
 G226tORwUhpQ7b/Yeypt8QheDBYrpMd2uGC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We tested and found that both <...x...> and <+... x ...+> variants work fine.

Is the difference in the functionality from this SmPL construct clear already?


> We use <... x ...> instead of <+... x ...+> here to eliminate the following false positives:

Do we stumble on another software design challenge?

For which function parameter will the specified variable be required finally?


> 486 asd = v4l2_async_notifier_add_fwnode_subdev(
> 487 &camss->notifier, of_fwnode_handle(remote), ---> v4l2_async_notifier_add_fwnode_subdev will pass remote to camss->notifier.
> 488 sizeof(*csd));

Should any more special cases be taken better into account?

Regards,
Markus
