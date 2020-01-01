Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C03C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DF7206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrBoXuSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgAASt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:49:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44330 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAASt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:49:27 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so36524864iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 10:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FAds/nsiVdqU+TOcoArvjovqXbkDOYHLSrAGmeNKWEg=;
        b=qrBoXuSLm0qdkNVd4qXYgZ6CrnJFBsfijsO+hs6Yzk4gt92kpW3+Zd4rExvHWcfXAZ
         AdRPuGNczNb4CW4Y5Q1xMcZvETlknBFkUfA59auTU4/s5pJgxle5BaQ6Xi4ApblfjeI6
         8KfXdY/k9DjToxZl1nZ8GcReMQy7pBbRWXzwH7wNwcAAi/K6XHYbkuEAz2PfFZSd902r
         tIPbPA9VV8eGjF0SKADy5nScWlmTGxlZk+L9LJvMmM+PSseUAF9Psn4UUbPCue8H2kvW
         nNbpvYngwOLZ8dKj1mFtXT9qZYtzbTTHrFr9v7ly1NEDuQN4FXCiM1VVu+0chyeH9l9/
         WdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FAds/nsiVdqU+TOcoArvjovqXbkDOYHLSrAGmeNKWEg=;
        b=YEPOiyQlnordmNQQZgAc9F4siPL5XkVR2oqxFlEo7+GGsl40PiDbKB6pmFbWCwF5J9
         g7xPSUNusiJWXYAGqgGE3J+uW24WmDhT8yMQQ+Ze05N99ocWGR3E457r8rVz6oFZE0JZ
         4aAyDwCIfMWQ6oZQ56P2HnfOv5CvGJuwPj/YSayNjIgP/LJv2epLhnLxrZPktwQBh678
         X7b5AtWQ5tQmT/pHckhxO3VRj6pKbuGNoL01poLyrnTju/+3/c1gvv8RJCOEPWcS7gGk
         rDdIeTCS2mrZeBtulEUsaESvEGv1l5rqZyWrP6Xpj/W8Bswj/yZhgpOGUhgO7Csz8B+a
         gn1A==
X-Gm-Message-State: APjAAAVQ21o4CGAkGtnLdKWIH5Ha6In9XoK8yUmA9asPGcvXhoaYHsC/
        83/yt+xnbz+zym1LfbZI0UbacG/kgBcGm+D5c4E=
X-Google-Smtp-Source: APXvYqxJVJjKpmGmBS+jYCTX4Y9/LxvovFbvCJQI+8raM4KkGE38EAPCK4LTfCa25cVP3NcliY9YNPoMi7dJDThB97k=
X-Received: by 2002:a02:3312:: with SMTP id c18mr60487810jae.24.1577904567105;
 Wed, 01 Jan 2020 10:49:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Wed, 1 Jan 2020 10:49:26 -0800 (PST)
In-Reply-To: <20200101184237.GA43049@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan> <20200101104313.GA666771@light.dominikbrodowski.net>
 <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
 <20200101175931.GA183871@rani.riverdale.lan> <20200101184237.GA43049@light.dominikbrodowski.net>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 2 Jan 2020 02:49:26 +0800
Message-ID: <CAOzgRdYZB+-zNDbE8kUBoW89RdXFuTP-1JeDY1BvD-nM5Rx1vQ@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of course, test this revert patch, no the system/bin/sh warning.

2020-01-02 2:42 GMT+08:00, Dominik Brodowski <linux@dominikbrodowski.net>:
> On Wed, Jan 01, 2020 at 12:59:32PM -0500, Arvind Sankar wrote:
>> On Wed, Jan 01, 2020 at 09:27:27PM +0800, youling 257 wrote:
>> > Unfortunately, test this patch still no help, has system/bin/sh
>> > warning.
>> >
>>
>> Just to confirm, the only change needed to make the warning go away is
>> reverting the single commit 8243186f0cc7 ("fs: remove ksys_dup()")?
>
> That's what he reported, yes.
>
> Thanks,
> 	Dominik
>
