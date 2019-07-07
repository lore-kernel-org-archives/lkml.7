Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95364C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DC920850
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 07:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IJVmwvEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfGGHKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 03:10:00 -0400
Received: from mout.web.de ([212.227.15.3]:35787 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGGHKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 03:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562483379;
        bh=XSMFNbxwcUUjaqnLXLNLuupd+m4AR1AsDTADaM1wKE4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IJVmwvEHKxxNi40r0ztcDwxJ0B+6IE0KEpqOdac2DM5CRsL8fsSu39BKT5Iqn+syB
         CCe1XXdldxC17Z6peY7eXlZsKby81u+nLPufmFvZabfTh0+fNmhYHfl8OKW/cWCPTd
         CkIeayATMmQ46hxZeFxI6Su1cetwh+cPV89C6xLA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.61.32]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxw8-1iAJYx2o3k-00iEPd; Sun, 07
 Jul 2019 09:09:39 +0200
Subject: Re: ipc/sem: Three function calls less in do_semtimedop()
To:     Colin Ian King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Mathieu Malaterre <malat@debian.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ba328a83-63ac-c3a3-cbc0-81059012c555@web.de>
 <3c5d5941-63bf-5576-e6eb-17ca02a6a8a3@canonical.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4013bfa0-4369-3e29-b205-7d7059e68e5a@web.de>
Date:   Sun, 7 Jul 2019 09:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3c5d5941-63bf-5576-e6eb-17ca02a6a8a3@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IY6r6+1D9+RFtRjQ3GrK4S/RkU5TrT7TjRj+ke01NXmoaAbDAxs
 B19vZCVwZ0ZXUIqcFmc6Uu8c/ye8wLL2B4310hQGzhcb2jP+IiojH5ISNIrVrJCE7ogX9Ug
 MpLgHb2uRP7yA6otmgXy1i6u9vMyZZskCM0yb4XgqkpseiJMEFMUmhwMDM3C+gRy9oR+8dY
 /fvaGWdUGtyMIaJXBlSQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rV2CTJktOuA=:z5S8ixstnYDD5x/szesXfk
 Wk+ScDxnuXjqzuzJw3x7uvMLXTycCG99USUNr4ZVE3fHhIIqK/28xazoPIw3kklulfWcuTYGp
 Tufr5YTSLUfoZm7MBLkY56jLgEoIgNIb92Wrb6yS1dyitodOvu4+zJUXZ/TXTrlCFf/BxOZQi
 amat6gvC83OdnqXun+pLRIvxDqxUQqSf3mUoYA/uQFbppG/rYjVuGxG7tr76PdqG/PlBxXswS
 bGMM0LewDGebiY1HySJ5ywB/TWWw9psVtnxQmuZJpwhWbtO4RypY50zsVqfGlOju3MvnTWPbM
 UIOtOjcYXGHrPusdPthvsU/ly+v5VvtbYN0JWMgp9PSzo1WXUQvNaVSqmW5MLCD7FFLUF5g25
 IO8ZrcO0r2sfCgzWKQqkyMys8qNjMbkyNxSUjHBE6+NtxletqBDl+7I7cjULZCGyRFEocg3sI
 ItWU25ImiEJZM4qnxTraUb3Lh6Z1TbGtIn6rg9TYnn3iOf5qp2yviKEyJ+I7t2jrN3NurOjAr
 UxEJ0mUf1RWw1Co4VxTts5HLJ+0CLLH24EQ65VAkPqtvvfHQzo3D3VIjLnRGcAam9OjTi2+Dh
 g5zRy/Zy0M7XUg5alIaxQ4lavKUKXgE5hlQIy+1nBSc2VBGso4KGloMxUS1bG2Xj8X3T3iy/u
 NcvAePHHFRJT1Wx9yWyG+RkjXGvcbNqpkNU0/cBdgIAjfsZKXR4QuzyYesnk5YkpJnRJpGuo+
 MiCdLurHpZRzwhGhNE1NGjm/zCj8fXiCvwSRw/BqLgPV56VG02g8t3ZTW57kaEeh6rXic8F/6
 NIxCEow69z3pCgZ3bNYiFQ+yfUbavvMg75AOJT9xSFbISUlDc0Wrv00qBJ0kRjFrdgEInfHWq
 Muca5gEPznP3ub8+xffJNgKB1KRfm3EwxUhZgcmRFuiY08fiz0vEZ0CbxqiDPVRB8a3bDpSbD
 KgQxAWqH/jmw93oUfpEJe8kftn6+cO5dCctiMcnCgojsknCIWyeWeAGpyZnxbe/oJbpVTBtZl
 AorM6wwt8SqoQwEmDliwdtN9Lmh/ojXd+tB3R86RoKOfmiNajAX/8ucRYbjzNpEukSMJPJ/WO
 4B/g5AHubwol59WlvFZJErBKMEUwp7PQN48
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +		list_add_tail(&queue.list,
>> +			      alter
>> +			      ? (sma->complex_count
>> +				? &sma->pending_alter
>> +				: &curr->pending_alter)
>> +			      : &curr->pending_const);
>
> Just no. This is making the code harder to comprehend

This can be according to your current view.


> with no advantage.

I propose to take additional aspects into account for the interpretation
of such source code.
The shown design direction can provide benefits which might get
a lower value for the software development attention so far.


>> +		list_add_tail(&queue.list,
>> +			      alter ? &sma->pending_alter : &sma->pending_const);

Can this code variant look more succinct?

Regards,
Markus
