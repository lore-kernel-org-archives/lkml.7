Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D4C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4EC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569369682;
	bh=c5PTFvLlwq03XonOVNTFwC02c5MEAUsgWYmZ6IdQfrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F+tKGib+qXI0MZoG5MnZMdAdqqeYNH2nhGGmNjHRnfqA8CW7HZ4h6FOnRvS4b8cV4
	 +e1fSZ+VewKuEJohTZbjUdziGX8l93g9Caetcva4omIkabNegh17IGow7VzTV+6gac
	 QxneZ78SOLKQiq1Utc07GV/VJAlFGgU9beAm+Iag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411100AbfIYABV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:01:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45919 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406767AbfIYABV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:01:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so3679738ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=++qndXxQzk8QL7IV0eU1iWhcJ9dy+lGYkj8qx8Wm+tA=;
        b=b5yrqjyPSrb9d7vVYvfXzo7GJ/ogJAqMywZdTGzH9H0mcbCVu1toedqiNQjiDQlo/m
         Vh45x8MMdIXBXq0Oc3i15on95S7ixogPZMZQdlx4/BxEkjT5ueaJKfbQ2ORCv4h0EJng
         JyEw0v1uhgFQjxEiZb0vWjKt1fS8yJOtAXUvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=++qndXxQzk8QL7IV0eU1iWhcJ9dy+lGYkj8qx8Wm+tA=;
        b=CY2GCERi36hVWn5zWX4tpZIb/rCcMK9ubSs9eY+oJNSvmckbdPkmnY+RX588vsALxo
         WPxAUsXk5wHUa2t2XLVRB96WQ/H/JLbWrbDEiHiw2+xwELPJ7ZM+/LyuL0o8+DtObDgS
         ZnWT97piTaUD7tL1WkG3ZcU/ThDF2Xkfv7Rvjocum5R6fqqjBxoFIWCr/wQybmwybvCg
         sMI5hkmLeIJZRq335L+yxlDH9teQcXAV3Gs87nodX40zAAvvtASmUuYzhX0IzVZh3MUC
         FSlDebj1qlvL6WR54dmiBFWSBFeXOCmJFzCUofcTiQyJJVlTxS/fufoyw5SDWaJAy7SH
         IIVg==
X-Gm-Message-State: APjAAAU/JK5kZy41X4M9zqyE+ZnkhhH2yJUh8MijObQIHKFTJi7/OC2T
        RaiRWCJccmRnw4sK24YHRO+ZBlgCDH8=
X-Google-Smtp-Source: APXvYqzTRoaeGBO78r4J4LXpa3aMNAbGhxVQ62CxhKN6pbdiZpXVsJKlLWXdR9nqoF4u+5jm9ONmWA==
X-Received: by 2002:a2e:b60b:: with SMTP id r11mr3827025ljn.117.1569369677156;
        Tue, 24 Sep 2019 17:01:17 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t24sm836988ljc.23.2019.09.24.17.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 17:01:16 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f5so3687991ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 17:01:15 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr3694229lje.90.1569369675432;
 Tue, 24 Sep 2019 17:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190924193054.GA2215@kunai>
In-Reply-To: <20190924193054.GA2215@kunai>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Sep 2019 17:00:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1WroG_uZ44au_KdEcujkCvcwz+d05EDR_=6vHb8xQaw@mail.gmail.com>
Message-ID: <CAHk-=wi1WroG_uZ44au_KdEcujkCvcwz+d05EDR_=6vHb8xQaw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 5.4
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> - new driver for ICY, an Amiga Zorro card :)

Christ. Will that thing _never_ die?

But the reason I'm actually replying is not to comment on the apparent
death-defying Amiga hardware scene, but to point out that you should
try to fix your email configuration:

> Bj??rn Ard?? (2):
>       i2c-eeprom_slave: Add support for more eeprom models
>       i2c: slave-eeprom: Add comment about address handling

This is all fine in the git repo, being proper utf-8 "Bj=C3=B6rn Ard=C3=B6"=
.

But your mutt setup doesn't seem to be using a proper utf-8 locale and
instead uses

  Content-Type: text/plain; charset=3Dus-ascii
  Content-Disposition: inline

like it was the last century.

I don't know what the proper mutt incantation is to make it join the
modern world, but I'm sure one exists, and then your emails would get
names right too. Even if they are some funky Swedish ones with =C3=A5=C3=A4=
=C3=B6.

(And no, don't use Latin1 - it may cover Swedish and German etc, but
you really want to go with proper utf-8 and be able to handle true
complex character sets, not just the Western European ones).

            Linus
