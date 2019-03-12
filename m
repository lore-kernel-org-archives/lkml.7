Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A8EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6DF2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVEgVJoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCLPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:16:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:16:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id w2so3102937wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D89ASbsipjWEiD0UV7rTdbb3kdy/vCbyG8qJ2GIAAKs=;
        b=uVEgVJoBG32TgrnreJ6SciaRc1z547c2qWrYau7H17UhcfWGoOu6wcobdSzV8Pt2dV
         opCvRtiVf3GH6h0+g7bqBZKlQ4VrYvwz7yss9o0mScdpqC50p+tna7RX6hxk19R5Zw8O
         VRCtP269IcrCalJZDF2c2/t3SCNoFHWJisvIdlaBvUuSoAlSBcuf8D+fw+TNhGxRlxcW
         l0Ziz1UIK+tJwXVuMAgv//JVrX4ruol2DTjArJDBS22VbjhvXnONRqfwMhvE2Uc8rvEn
         b5sp3c2ul6DG1wESCnqI0TyXfmfwiAquabYYefX84NoCwG5Kim+As53WavidKrv7YKz1
         uy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D89ASbsipjWEiD0UV7rTdbb3kdy/vCbyG8qJ2GIAAKs=;
        b=HiNHt6f+5z5NsAO6xQe62J+LdNm68edWdLOqycRAa+D990QaPysCYwAkb3qxYGAL2D
         ILH249zda17PMJyHuDhOJvL0kB8fQFBdZnd0A4Lx44Oft+n7sFqehgr7D2WHyoYnR1K9
         ZG06Tkn25Yz2pd15OmWl5wbuh+wbOid/sxL7bc6LZBMvEIVgBCTmm3MNcCVcfj4WFFuq
         m0zYQIKDWuyxR14URr/WHV9pLcxQsMWssioWb3LYUXL8VUlteQDLGLearexT3PHhUmFn
         V8FXzwyMtedvafDtd3CGmh7h+RSQrvflBCHDpvMulU/NWIItmoJeU5y1znJ5zLijWsWF
         cjJw==
X-Gm-Message-State: APjAAAUziRZM4nTgRJ35tjisE0BhVuanmFdmPSw/3FvEdItWuKPo+DDR
        PvqBYrYwJUrrZHS1NVr6Rqvpugmk+T3F9anS7/0=
X-Google-Smtp-Source: APXvYqzuqSd8BtiFoOe74hP/1tKvw03YyB6rsBfZuDmLnbMYWXryqgb42Fqeam+lY1ccjrhTGiY9c/q1UrOmzrcJkIg=
X-Received: by 2002:adf:f14f:: with SMTP id y15mr8791428wro.223.1552403758361;
 Tue, 12 Mar 2019 08:15:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:65c4:0:0:0:0:0 with HTTP; Tue, 12 Mar 2019 08:15:57
 -0700 (PDT)
In-Reply-To: <20190312151034.GA2202@kadam>
References: <20190312143914.4471-1-gui.mspace@gmail.com> <20190312151034.GA2202@kadam>
From:   Guilherme M <gui.mspace@gmail.com>
Date:   Tue, 12 Mar 2019 12:15:57 -0300
Message-ID: <CACJVDvcXhyRJqBO-Jx7APhOVN+C1WO4qBjnrQNjsY6pSWt+nrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Staging: rtl8723bs: os_dep: Fix several coding style errors
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Guilherme T Maeoka <gui.maeoka@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem. In a previous patch I had one for each item, but I thought
it could be packed in a single one - and avoid '[PATCH n/m]'.

Thanks.

On 3/12/19, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Mar 12, 2019 at 11:39:13AM -0300, Guilherme T Maeoka wrote:
>> From: Guilherme T Maeoka <gui.maeoka@gmail.com>
>>
>> Fix coding style errors and warns complained by checkpatck.pl. To list:
>>
>> 	- remove braces for single statements blocks,
>> 	- add space required around operators,
>> 	- replace spaces with tabs to indent,
>> 	- add blank line after declarations,
>> 	- fix braces and 'else' poistions in selection statements.
>>
>
> I'm sorry you're going to have to break this up into multiple patches.
> Probably one for each item on your list.
>
> regards,
> dan carpenter
>
>
