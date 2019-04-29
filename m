Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E20C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2492320652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCqhTFYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfD2OBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:01:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33817 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:01:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so8380246oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zg2VAolSWzBmZVcirDH3khecUOsjD3mkWFIZwaOymBE=;
        b=VCqhTFYVsxxfua3Q01y1hYgUTno3LKljw5SVUdYSQzm64SsxKFEf2VXgAMkp9PWzvP
         JH7mhmYd8fwzrPFyaha/aWCVr2nO12a29yq6zchS7QqcAAwKN9SFPRSlD0HhwuGVrxBZ
         c4+B+S04RuWdwYPP1qAUmq/bfZvk3oyoydWU9jr9CsQ4ij3oNUqTLJ11MshTQ7QhvrUD
         0+Y504OZgIxDafwfDgfGM8UhyyOnllsrYpZP5oN3wxi6vQBKNJ7D83xoXhJ4fD3/Nf3t
         doEiU3TJevoMdMHC+0hmAjktiSjR+s7QUATbdVkjfebXZs1SghX7sIT9ZFbQu4bgq+RT
         9Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zg2VAolSWzBmZVcirDH3khecUOsjD3mkWFIZwaOymBE=;
        b=TYJpUsa5I4xOX0WG2s1JC+v/va6a86u0k1UzCQz7XW81SeKP7LS/JayXbNcZ5o6fRx
         HywctXiKhn9T+G3StTUENt/sG1j32gkVVosaRpGcFHzOLUyIVPcVdhhqA6MeZSHgExNk
         ZRYL3zlqYRtPb28VfCplFx0BayxfEhy5OJn+naqm50w3/HB2JHDbBPX+fNERC4vRsvaP
         sLY7rRpSRWFnCsCPPfXK3/UaJVPYuiWmJ7PNVrV5MLDKay4ZT0rM8irNobbegpR+Vhm3
         sn7oJBlxj0ct6ALykgOj+KJnxQgT8rzDliXd8Ms/ulgWp9jCfcHEdy9fZxaNA/tutfT+
         eqag==
X-Gm-Message-State: APjAAAUyn6RCDCVBzJvVCsoTNoHZT9qEtdfitMSHW/ZFR3M7odmvFv5b
        4CemT01eaZvsS+9KlSF5ksABpt/hBKdZExt3io4=
X-Google-Smtp-Source: APXvYqz7suEbKwldpa5GjY9BmF02z+nTtQeeRp3CY1mnkeyloRMWO/cKQ8l/njepEzIzUu8Xfqz3sTkCfwOa8nwLQfM=
X-Received: by 2002:aca:4202:: with SMTP id p2mr14825606oia.169.1556546508930;
 Mon, 29 Apr 2019 07:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org> <1556517940-13725-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556517940-13725-2-git-send-email-hofrat@osadl.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 29 Apr 2019 10:01:37 -0400
Message-ID: <CAGngYiUMbw9c6060vKy=KWe3xzkhKV+H+hFqCt2=VOa0hn1zNQ@mail.gmail.com>
Subject: Re: [PATCH V3] staging: fieldbus: anybus-s: consolidate
 wait_for_completion_timeout return handling
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 2:11 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> wait_for_completion_timeout() returns unsigned long (0 on timeout or
> remaining jiffies) not int - so this type error allows for a
> theoretically int overflow - though not in this case where TIMEOUT is
> only HZ*2). To fix this type inconsistency the completion is wrapped
> into the if() rather than introducing an additional unsigned long
> variable.
>
> Along with fixing this type inconsistency the fall-through if is
> consolidated to a single if-block.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---

Queued to https://gitlab.com/TheSven73/linux branch: fieldbus-dev-testing,
with my Reviewed-by tag, and the following fix-ups applied:
- tweaked commit subject and message slightly (less is more)
- removed spurious newline

Thank you Nicholas, I really appreciate it !
Sven
