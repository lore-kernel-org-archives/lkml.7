Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA02C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A621738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3N0rFL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfCQHoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 03:44:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 03:44:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so3056222ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qBlieml8JV5qXCvbnd2yHyjLyj5GfAx2T1af6JZYS4A=;
        b=O3N0rFL8vK+kPO8sqaolbYCCp2nG8348hMeHe3LEYlbQ2w5/dAe1lnHmKeXL6S6jVF
         1DQw1sw6192noKpm+jYlVdgO9yNnR19Fe9E/SSoqqduD2f9tQPx1mJ6iqnDoOe50TIya
         M2I7Nk451/hMkg2svR7zcqeANFED8FPvBc5rlhm/0D0ajseTFkUaH9lxCHFRwDFGdzbO
         teshJCUnfsRyFctEKOmgjS5KKdoxDfr6ClcA0VwAlbNGrEtIZXgnsE3oxPFm0k8xlQzW
         fbRoqRkQKR0RPIrUyTWEeVqsQPgNrOY3J6VSbeLF8A8osdS3O0XI5rkrP4HbnYd/uugG
         ve0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qBlieml8JV5qXCvbnd2yHyjLyj5GfAx2T1af6JZYS4A=;
        b=FeRTidujxaB5f9rNBYSYpm7b2d9cPcwbeakTqufLwiX9K4sLQ4qBbL0DzTD2ZwvlEN
         WZdWzmSIpPZhzCeMDVxbFjUfBlJK6TcGm844x1kLy4vy8Y3pV4UPicxOsvu1rzx3Si8e
         K8FZT33TIqm6y8WEjE7L1G305mgnAS4ITj+KSo9BmjtuDaqIjSGHgx60jRoja2JhPYnr
         O8YKpZ4BZ6PNPPpncmHi7postsD4Rt/30GsnWtw56lg1eR/y18V4pZVNLlM5sGWoI9gD
         de8ESdT/9i/WcTc59OO2Ok7D5Qo4UesmYSKinDQu1Z4r7w5Cj8KOape0kox01WZ/+/y+
         cN/A==
X-Gm-Message-State: APjAAAXKTSexv6Y4N7CWZvIftsREtMKYEfbpnyML/J2SgWa6h3fbcrop
        eCYW/MufMAnNVJrwVxCWaD1UoEY8M1kwO6Dsn78=
X-Google-Smtp-Source: APXvYqwu/oIAtp7zgDF8LKKfgwrdE2ZJg/6GFc8Ma3AAeCD93dRc10RFLlJ5eEK+2Px5+RO1Qee1F8e7ipb2U7gtUGA=
X-Received: by 2002:a2e:731a:: with SMTP id o26mr1815344ljc.69.1552808642231;
 Sun, 17 Mar 2019 00:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <20190301184816.784-3-mans@mansr.com>
 <CAHp75VfZUN0PVwveB9FM6QvyJicVE5WjCX3b5rfCGZOQs9hO8A@mail.gmail.com> <yw1xo96g2ix5.fsf@mansr.com>
In-Reply-To: <yw1xo96g2ix5.fsf@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 17 Mar 2019 08:43:51 +0100
Message-ID: <CANiq72mjLo94nK9i927FDgv3YzTQVBowMhb0EcDXKYKFh5tbkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 4:48 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wr=
ote:
>
> The current code unconditionally flashes the light once.  I though it
> best to keep that behaviour as default, even if it's not seen as ideal.

Sent into -next. If no one else says anything after a few days, I will
send the series for -rc2.

By the way, what about the other comment Andy mentioned? i.e.
"defined(_OFF)" (in case you missed to answer it).

Cheers,
Miguel
