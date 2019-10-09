Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB3BECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB65206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pojyrmQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfJIQnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:43:23 -0400
Received: from mout.web.de ([212.227.17.11]:46435 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfJIQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570639359;
        bh=smGGKIWjcKK40LfxXzxyDhqfpPN20hSlgYA0gpL/sBQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pojyrmQPFLUMc40gISVqiGxIQWADfuj/T13jAiJbBOBrt4aSF/lt6gxHGzaDVjZ/J
         JWr4uyTCkuoRF2Se6xcoEYgPlbMnUr0m23aYgN8pE5J0/PcCX1Qf4qRmkARgcOufej
         otcf0S7tHY/J46/LJyPKzb9ggULH8JaHx3qKb2ko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.177.35]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McFPX-1iYWyW2Nrb-00Jdlz; Wed, 09
 Oct 2019 18:42:39 +0200
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <074dfd38-dc1d-3795-ab75-a17c24b36844@web.de>
Date:   Wed, 9 Oct 2019 18:42:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:tYsVpNEli7z3lMZv4vatBbZYvPfhxXoaH+ONehvlip+PITKHyXz
 1Orn+6oP9PafpB1iRD7GQIpjUSXIYuX3FbQMaKWqUmXDuGqBX5wVWww8IyyOEGA9fZUDfSg
 yFJ5Q8l+KZmRECHgqUXzaXX3tqUqp9i/lxuLwUElNhX9dS2EybwvKCtSOML0lhX7uA+1zgX
 3c9Oaq4X7ESvUmoULFhsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mqMEwAOJrio=:PeLMaIyql1VA9Jln58WY18
 9H0BbX5r4pf4Dbcmke8iUPQc0YxpGzyagYMVBxmt/5KWTzKciYutL1YMnoIG2oLbslqrZeHIP
 BRu2BZaZ6IYW4xjbg9A7GvsBvsKozlbU1a54j7Yf4UAC/uzvwvG5fJzdosbLOMC/NgH69gZvx
 wNs67/sEmfN0yjemekLhNj4qUWz/Vha0Ew3KvHPPsTS8l7hEub0XOAPIT58n80K4pnyPQbOTU
 GMVvD6hYw0Q/Ima4JA2ip28L2THJ5465/9NdxwmoWSV/2sfqEMTL+JissFi1wvbM7loo/f/M1
 WJslpZlT2PimkNJvUFAJvJmfCgxs/xYUD1CltSnUFiHoQpRNpmgOq+3BjzhKns+Ek9xsgV+u4
 3yzbt+cRINNtC+E+jaEDu+qCg3GKSouUcB/1Rnb1bjt2QWesljw6To/zbeF4UpoblYnxbWbHL
 DLruZur1/aTKmLehrY4SuFz7hX8BeY5SnWUBrLhFsDxJvcl+KD5/QuVRXUb0Huwj7O3JyM4sD
 w5OvwBJE8p2VVT67Viye0e5Rz0wYSkEAy/z2j/509CXbdR2bjDrUq0H6s5CtmZf6hDFIqT1r9
 KnSYW4f47l6x4M0XcCYTy8ABtVCB2MejnD82Tn3tWU64OoANPCGhPcTXDgDJ5INpRtT7kJ3at
 czHgUIn9MtAbq8IAIsg9XNkBtpAfGE9N2HfeEFDVdEb79gceuihkmjv39P57muAT5mQuBD6Ny
 1uMDZy+li+BXxzhge0K6u4jd2UaCmfRQ4d2uhV7lxq7vhjZKxU8Lcb03bLO52StIby22kS52G
 J3G3XxEu7nO3KvTimGRS4cRhOOWwslif0BGkA9sKoyd363BTkVExMjVRry5tWShHHR8iRF2o5
 TcwCp9YxZZP9VIVXnPuml4dZJ8JXZyTtgFi1DFNz1m3vVC+GcCMS8hSPr9KHgHRD5e6n4l52R
 dKYM1BMQGuEzHnhroyc+NBg4A45dDqIdXHThOZu7tuuCJi8QXQnsg34m0Z928R+rE+LizJoOt
 OqI7fUKeYBmXYtsjtlZdqqmCrD24Q7YjrNTWx/SRtScbZpe/+zZYd6lkgnioytPwxdigJ+zAb
 e8FL3eAO7kyDowzGhDmgTgHPxwXpr+SXDalFnZ9/ref2NHTfWIjUl0Wq2t1nodaUHVsU9AHaC
 LNxm2M2BXBJbwM/DVXAT+Xu+1uYCnJ5MdcOiEeE5QwZ/AwamcSNDHhp99DGe3bBpAc9kfcLU0
 URqsTV0O29/iD0vkqgtKVdvQ5VV5vPsiW8jzpopXuOXU6FXhzTRgX//15P0o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You're also not consistent - strlen() is not annotated.

Would you like to integrate any additional function annotations?


> And, for the standard C functions, -Wall already seems to warn about
> an unused call:

This detail is nice, isn't it?


> a.c:5:2: warning: statement with no effect [-Wunused-value]
>   strlen(s);

Are there any differences to consider for the Linux function variant?


> The problem is the __must_check does not mean that the
> return value must be followed by a comparison to NULL and bailing out
> (that can't really be checked), it simply ensures the return value is
> assigned somewhere or used in an if(). So foo->bar = kstrdup() not
> followed by a check of foo->bar won't warn. So one would essentially
> only catch instant-leaks.

How do you think about to improve the source code analysis support
any further?

Regards,
Markus
