Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F856C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3957420811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj84dd3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfC0HrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:47:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38616 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfC0HrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:47:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so2921080plb.5;
        Wed, 27 Mar 2019 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HNsvt5Nj5ckdm3kBhHYU61/FYQreOrJv2teGnLqpoYs=;
        b=fj84dd3HZkjvacl7koQVj+OwwvHXAY4lFRIu9+NNon/E8ThzCqXW4lBViVwo+JD/OA
         BSSn8f4a/RS+iCNwVZ9C02d+9tlaNORZvsiZW1pFId+jI7xT1ygoff86dzOCpxtn5w1d
         xjEaRHbxpSMUMO5nViNspqw6FyoGDHlSHvjBO/JCP1VhK5amM5dqHv0p+RmLFxAAZOTB
         gtg+seUAYdHzhACeJvxNAWL9z4vLwHAY88khqoDvMM8umDfwghJNDKEqWVEGo2iE0YD+
         bqcP0ALug0XmcoBNv+w7YaiNnHXklX41wRMEspfCImvlAfZ1UQPOmwJ5Dci5HtyW2Tjq
         cR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HNsvt5Nj5ckdm3kBhHYU61/FYQreOrJv2teGnLqpoYs=;
        b=OuiV+z7nD2okx7WupazRR668MFueAZFJS+k+dPczXpwUw/kC3wJTvHNyDaAzvvWYEg
         IIRjVdb9xdENk1hB0Heaz6ROQuD9viimm8rdchHUSUbBbdfxe3pNIS2TqTlDadBDjL4r
         4CI4PCGzcbDiedk7e2dPVo7g5Dc1jjLvpTlCFOZroB8jOzW0PQNLNAkI7J5Z9Rvi7qWq
         CeM+yx/UTNGaqWQ6I+a0a9/mJQe5WwXEE7qDjGdAYEfr/BUWCLxc2bAIJBXglOV7kB4i
         m3jUYxLZrQJl0BkhTSl/ivjU3Ue+0mpS2fYMDcp6Si5d1lFNhDh9BGG0tum47yCYylIv
         vnSA==
X-Gm-Message-State: APjAAAXtf4rnubs3AQ0xMz5Wq+kFPLh2hFbepWduEEiZXBjPqQtI4Dbu
        AsHq5Uo6EJJLAWxVC2dxA3CO2eCdL7BxqFvAUy4=
X-Google-Smtp-Source: APXvYqyAZuJf6Xi3RpvC9kJShks4N9LfyPPCfvZ6XwHfubvnVrgBZCA2GjUeA6NVzCU5T2B9w/dzlWgmDfT7olB4GjM=
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr15741020pls.311.1553672820090;
 Wed, 27 Mar 2019 00:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190327014807.7472-1-ronald@innovation.ch> <20190327014807.7472-3-ronald@innovation.ch>
In-Reply-To: <20190327014807.7472-3-ronald@innovation.ch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Mar 2019 09:46:48 +0200
Message-ID: <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] lib/hexdump.c: factor out generic hexdump
 formatting for reuse.
To:     =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 3:49 AM Ronald Tschal=C3=A4r <ronald@innovation.ch>=
 wrote:
>
> This introduces print_hex_dump_to_cb() which contains all the hexdump
> formatting minus the actual printk() call, allowing an arbitrary print
> function to be supplied instead. And print_hex_dump() is re-implemented
> using print_hex_dump_to_cb().
>
> This allows other hex-dump logging functions to be provided which call
> printk() differently or even log the hexdump somewhere entirely
> different.

No Sign-off?

In any case, don't do it like this. smaller non-recursive printf() is
better than one big receursive call.
When it looks like an optimization, it's actually a regression.

And yes, debugfs idea is not bad.

P.S. Also check %*ph specifier.

--=20
With Best Regards,
Andy Shevchenko
