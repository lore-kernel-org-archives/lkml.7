Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8DC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B3A218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MC5D54vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfJEOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:34:20 -0400
Received: from mout.web.de ([212.227.15.4]:33407 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJEOeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570286051;
        bh=WYm0ExzD4+g3J7ilVn+RO3bGcQYT/EY8d2+B0IWoDqM=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=MC5D54vbF5C8aK+YQIPhkTgstEKKXFfTndUA78vRxnM08ojw+a9saiEdq/pnr3w+X
         X0xw7daHMiAmhbEHEDVttnH1t1DqOpvw8xA3w/EPJT2HQVkxWMHkoGETFWArPTOPBW
         U16fEc5VEddvZBEcEXxYOAB7y5Za6SVs4dYiXfzM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnjAt-1hclMD3gGl-00hvWz; Sat, 05
 Oct 2019 16:34:11 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191004185847.14074-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] of: unittest: fix memory leak in unittest_data_add
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        devicetree@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <50421413-f535-a608-fa7d-1b337eeb95e5@web.de>
Date:   Sat, 5 Oct 2019 16:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004185847.14074-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uWtDbOaA3hU8XByNb1OgenmgIB0O3bj9fSjvvEH8SyypMYLLvzc
 jJOBQ7KO8ISe5uPO2GNyuOwHnyWOfhsuWN3thgB7Xi1rfG1e8bb39P7pz03IJ+et/3wuLgj
 +8bLRGxK/tff7uGbsCsOk5kd4S2ZEvw/NM0bh8fxCe25jCmwgCpmEgVU9kPtGYEN6WOH3cA
 gKpVWnaivHXeQTqJtqB6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpEBJYn+/CI=:0EOzG0iHQS7oCj9PHLwAHQ
 32oNCw9PhiicIwniw7HKC+gl4V0IscT1uk9yJ7E+eBnAKEj/XSuu3oCipcF0Jp5JC0vp+aikP
 tRD/E4CWm9iGKs1gV5g2JSzNura8tISunrWWa60YxqH8XDJgJFRF2dAXKsR0MJwuREVNP7KfP
 /+tl0PRY1K3stXZZaFoJklCcO0OWJZlWPFPXipN0Fno523NvCrK1ur4f00G5Cbonl5hHuZfui
 HWwjouppjhdz1Zzbalxmx7Yo7tZC32/GxkMb9gCmsbuOWRXURwlM66ADccaGQ+YHPXRXrzP8u
 Jlyfj01Ro5CY8EgTcUh7nkExkI+zj7wVBKxMYXbYRceLKKf9CCc53U1cACSN4w2TtHmw90Cjd
 Rc44RvEuCH4LH45mUyJrv6vctHFDzKcCoS4klaYksOTMUH3kHvtUO+7jI2YY9+1Z3Zew367nq
 F9i64gWFcqSoB9oflNSFO/Zrcjm+O5x4PXn1ZXsbh2ehJj862h9gzEMZiStHw7XK+NKYHv5A9
 l+JOOPk9tmxEjux5i0NHJwxGx1EyzHUdDeZb/MBHMH5RNncNToTg0RCWbGxIld1KBEmhk7Y5q
 7qqUF8WClwFJVA8yK/omrJCBz6jlnERcg1TCBSWe2k3MtB8OyDYPaYVFktb77LIA7Hzvbapxi
 X2COgkFDEiMKMuQc9iqA8K0R2SEd4+7F4G8IvcdnR6bwjTQmd4s4FMnRDeLxO3t8Fbg1a9Fla
 2TQgMkDd8RsMLEhoH7Uswn79AIvZyDZUObF6v/1mvsVcJhCcCYQUCtN+w/nSP902jYykAEE6s
 UoAAhGFgNaeHHrY7+pPECs67C6WjxBNdkKBRuHFNH6/pTJr/8e74KR2HF64xybWrKOf1ZrNVk
 ao+GDMQ7M3BZvx5zZlIpAcMoMfKI/z6sL329ArYpzYRHtFhqvyfd2FI2WcrZN5M192Lca7Btb
 M6/37idx3pOkoJ7pRao6ak3qeyvA740eo8zRN1RuvPgPUcf1bk21mdSuPM8PSO59kObSwuwht
 4Id5ZR+hcYfALWIPMZUbdhWf9YSHU0qabYNqDtg0GaGyxB8hY/9ITbOcNOeLx66gCIVlgqy8D
 /LJnZoSm095A8l4nuaiCNvCORNFg4/79HNsu3GojkMnpc/HO/bPC3gsRLE84lWLPj+gUHm2Fx
 Us2DD5ePQpoaMHK3V7KcAt5cUsAEJtn8u8+sN6fgLwEDBLN4u9FE62c4faYlygtr7tZLOFU+A
 YM3TsTlDekduJ9LnyomXo389hYwW6Q74cswW5gpz+W3yDLk6alUBmFKCbYiQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In unittest_data_add, a copy buffer is created via kmemdup. This buffer
> is leaked if of_fdt_unflatten_tree fails. The release for the
> unittest_data buffer is added.

Can a wording like the following be nicer for the change description?

  The buffer =E2=80=9C__dtb_testcases_begin=E2=80=9D will be duplicated to=
 the local
  variable =E2=80=9Cunittest_data=E2=80=9D. Release the corresponding memo=
ry
  after a call of the function =E2=80=9Cof_fdt_unflatten_tree=E2=80=9D fai=
led
  in the implementation of the function =E2=80=9Cunittest_data_add=E2=80=
=9D.


Regards,
Markus
