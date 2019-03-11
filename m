Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E35F206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3CyCkzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfCKSsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:48:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44869 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:48:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id a81so4520051oii.11;
        Mon, 11 Mar 2019 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9aBFyECQDqLE8kcWcrFTaNk6b19WS2DWEH1/8Z/ri4=;
        b=E3CyCkzOEUn59R3BNajWY/zfmMNPByDSokd+5eP+vb7mg2PgIp94ATtYrj0ugTS6WY
         LlSWC7yzhsKZzjuwh+Mo5nZHfdWLNNLvuZdPEPgexqucsexTwLTX7BLRchqpR59/xwOs
         FC9kRZJsIEu2ouSZp9yIhlqEB8H8rY5Mlo3RcbICOyHTGns3N8uuxQZBoR3umWK9miaW
         vlbTPIYlaccfWQMD9Gg2QFdfECGGLRQDuZb9ABHptzNACEtBLeKwbyepiDf5+hphl/Oy
         llrcAAzCnVlkJM7Eiy17JTvYJMl34IKg8F+LDynOG4BsjNl/6Tyq10vdPQdHf9jwDh1l
         gjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9aBFyECQDqLE8kcWcrFTaNk6b19WS2DWEH1/8Z/ri4=;
        b=FuwiJByBiJOogbHedZxCBnRlp9X19eVX0nFavRHgls2A6HrQNyf4I9l4RM7fipNLda
         jzL2q6ET9CfddB2VI9MOWei1LNDz5GGtOcQSpKBSvsnZwCKKpc52OEBO44NqaLHpBvaQ
         i5sD96++XY39Bp37DiK5mWxzyfoqYJFpXWK90A1WZds9VOmcEt+cZamESlK5/nGsNjDU
         8ledlIcPdisMHeFrnjbZRbMG55bdM9SY0+UrWQp7xbnfO6mvSHeOjEwXme0Mf8kJebN+
         fpt1tcQ0CbWomZr40oZCg3hXaA22qpxYjQNwfY1TaAH5dh/0JKomLC1XmBU7N2KnV/pF
         zWEg==
X-Gm-Message-State: APjAAAWT/PCdy5QF+BbplsHBhgCsmFuNMsFoWwfCcH0BlndAApsxSKaC
        ndoOoc41Iswyug95QjJFVqaG0aj2D7eiO9vABxI=
X-Google-Smtp-Source: APXvYqwPO/t1MO/iIkpZ8udFipCCs0ZyEZ4duBAfeCUcCWrOB32St950yWYE+HJBKD+rPtKjeqrL2W7o/Wvtz9V7cVk=
X-Received: by 2002:aca:e6d5:: with SMTP id d204mr149970oih.77.1552330090324;
 Mon, 11 Mar 2019 11:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190310193246.31761-1-TheSven73@gmail.com> <20190311180042.GA17880@arch>
 <fe70de0a-9134-8942-c729-e014807d101b@axentia.se>
In-Reply-To: <fe70de0a-9134-8942-c729-e014807d101b@axentia.se>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Mar 2019 14:47:59 -0400
Message-ID: <CAGngYiXyEksuMDBkrasiwwge4fgoHKKecsSHB6q0GQyEoiZXxw@mail.gmail.com>
Subject: Re: [PATCH] iio: envelope-detector: fix use-after-free on device remove
To:     Peter Rosin <peda@axentia.se>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Mar 11, 2019 at 2:41 PM Peter Rosin <peda@axentia.se> wrote:
>
> This is false positive, AFAICT. The delayed work must have
> finished while envelope_detector_read_raw() holds the read_lock
> mutex, and it would be highly surprising if the device can go
> away while it is handling an IIO ->read_raw call. (THAT would be
> an interesting bug...)

Quite right. I had completely overlooked the fact that wait_for_completion()
cannot finish unless explicitly completed. Unlike
wait_for_completion_interruptible().

So yes, this looks like a false positive. My apologies.

Sven
