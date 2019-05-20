Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2563C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A002B214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibAfEYKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfETSfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:35:23 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41384 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfETSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:35:23 -0400
Received: by mail-oi1-f172.google.com with SMTP id y10so10764558oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2JqRW+pG/F6bPOhjbmAMkWQoXlDeA9p8vcg6LbBMCc=;
        b=ibAfEYKuxZUxiHNRrfU/fFnIC8PBn9XEK3phRre1SLzLIT25B7E3Mvl1OoDPeFHVe6
         VWFPyF/z99AlOg1BJdnlJ6z322M+QUV1zlQLVrZbgw3OIhxF4bBERF1HW7w82UAUkBMz
         BEJ/+2R+RAVE+M9hQ8c8Dg9lUVjy0dle4Q5Z+3mu/HmjMYgSiWd+uhPYhEqeCx+sBPiD
         NrDQT4GSiNTJYwZBwHbE1AoX9vHNveTMN0cpWXDOg/2W6fWwIQBIKFFH/EZLCtygb1cn
         Im8lqpnw4YgeCBiGlqBhsYZ3+een+koAK5Z4UUIuv23y0EpYM5j2TYwTrcka5QwZqp5I
         N4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2JqRW+pG/F6bPOhjbmAMkWQoXlDeA9p8vcg6LbBMCc=;
        b=RRk7Bvnvp2NrhLN3fvvqAk50eYJ6K7kLKPTQfWnXLdjEsOW50ijKMXyxS9ZGj2iPOU
         K+Mx8Jb9SRelXN795/q9W3a3wokST+qd6X3qzQYRA3i1B5hdQ7JPrZgI9edNOBY/OukG
         BL+zN4XzmEi5uKELytKQJYrSZMb0kroGBpbo9Dniq4YUUsSWz0VdLncaymUcEIfeeIZ1
         NiT6T4rweGATEY/vFJ3zwQUyvMqFeDZzXNqme1fduajeZ3HBtO8epe8uEkHlwXE6n/L4
         xN3Y/5fjGkBzYyF/Vi1SN3j4SRA8z7oAQjCorhWjHnmqYCFugqGGXkvq/qWkTDX0Tpwd
         EDZQ==
X-Gm-Message-State: APjAAAWL4fdTl6HTQAnsxi/WGN6+aPuLFtMoqQWTUEsIArW0V7IZxW+u
        VFO9N+6kIYhH4GR1ZlhSeA/wQfRYBNtekEXhuNE=
X-Google-Smtp-Source: APXvYqyRKT7MfTWY2+NhQ62iwNx9MnmMnvVhEyanVDSfe3Q2GM9qXaFhLE4XbFdslqm8Dwsdoo2RU6OLSoJJ05m3K/0=
X-Received: by 2002:aca:7250:: with SMTP id p77mr383079oic.103.1558377322098;
 Mon, 20 May 2019 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
In-Reply-To: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 20 May 2019 14:35:09 -0400
Message-ID: <CAGngYiUZmfnuj5WUnwk18szijmsQjF27j=OxQfJtp5bNORppRQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar, thank you for your contribution! I have a question, see inline.

On Fri, May 17, 2019 at 1:50 PM Oscar Gomez Fuente
<oscargomezf@gmail.com> wrote:
>
> These changes solve a warning realated to an incorrect type inilizer in the function
> fieldbus_poll.
>

Where is this warning generated? Could you provide some brief instructions on
how to reproduce this warning?

Thanks,
Sven
