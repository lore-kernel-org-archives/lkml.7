Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FF7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAD52080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYN49hoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfFTNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:14:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36976 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFTNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:14:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so2673408ljf.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qspgoBFCIto313vrlu1/vYF7ItkjbZkTOvgEc+TXu7k=;
        b=GYN49hoMnjjkcvRT46FngilNLFwBgB/jCAw3+MZgMgMr0Qu8xlw4qKIybRc5AgfUiu
         QZIAeiJbwwz9GGyL8+8S8f7s3o2CybaYrNQNujqLhohuEXURu0ZKJ334jLnvfiFjPHT7
         r3kfJsc3t9RjeBbNb49SYu3JPi1itkZHQqVgIEodNZduQppz34FHW0/BOUVbALWJOXSR
         WBrzK4ZMb8mbKmRQjiQtWh4aXW4fiVKUt5xVJOuH60sdnGznOGvMgORJT8cMHph43fcF
         7UHbP7m8mrix1ssQCQxdtLvekdUv1Pr2+/xV21sLOff4sLmqRFJVMpdLl5ur2m4XYFQY
         xwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qspgoBFCIto313vrlu1/vYF7ItkjbZkTOvgEc+TXu7k=;
        b=q0i504lOHNQ3P9SXyMiaCy2fQqcjweUh6y3HYqIA0s6Y3XZT6L4GMHNDoI9VVOvrs/
         H40iatgz62FpzE/L9MOmM5h9IT2lp3ZQNsLgmWW8896YhsTu6Dm3zkklr/wpO0kKRSy3
         4JVTSgofhrhH6trz30BbuDEht3KSlPcJVpHo6zBds7sl29TSueoYCNRaHG5Vngn2sifi
         jpggJyUupbrkp6X83bgzFSszz+BCICFzJ8De+0zeMMCVbEDgUINFdmHwHkD/wnOG5vd/
         Wc6cRb8tqfadciVSC77R5thacXwW0yvyn6qCy18dQfJXD6WOSxkTM2pfU5ejfgCBg2wU
         LVLw==
X-Gm-Message-State: APjAAAXKOlZLKd85+1NtX1BBI/J8DguDR+XC5YfHJRyMyklT1vutisOt
        X9payVltLMIgrGG8OOTL2f9iLQm3ZFDJsmiiZ8i9JZ0a1rc=
X-Google-Smtp-Source: APXvYqyrZXzjSaPpnnMLclfqXxrpzULgbBI9HIevVVGD2/JNz3SaC9PZi0HhSSMRT+IJ52GDF2CmCZZsGwLYBpL9bl0=
X-Received: by 2002:a2e:8741:: with SMTP id q1mr41532726ljj.144.1561036470965;
 Thu, 20 Jun 2019 06:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190619163843.26918-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190619163843.26918-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jun 2019 15:14:20 +0200
Message-ID: <CANiq72ko_4cdZOtXxAr3TcorE7Aio3erbNYnUk-JP1aKBpOvuQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kernel.h: Update comment about simple_strto<foo>() functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 6:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and in some rare cases they have a benefit
> on kstrto<foo>() ones.
>
> Update a comment to reduce confusing about special use cases.

I don't recall the discussions anymore... :-) But are we sure
simple_strtoul() etc. are not obsolete anymore and want to use them
again?

Cheers,
Miguel
