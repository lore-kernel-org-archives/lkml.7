Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF0C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A34207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569285911;
	bh=jUOVPpZS0x/8ppptq3CkH489ohfvKfn6jyaaqEc/zBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HmN1tg8wTecIyjFV5/f/hhBFQ3+fSW0S4uDk08w+CTi5Wp/2745Ae0uMB56NaYz59
	 Ua23CeYF8fQE+h/mmTEZvqHoSBapS+CZ32+GzWkKlX47R8T5gLGXrd0xoqSMyEM3kr
	 UP9CvSQbf/belmD307N4H4GninpZ6RFCKYcpLgNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503675AbfIXApK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:45:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32776 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIXApK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:45:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so15433lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/64PPB5d/u2+0Z5QEyaFUQb1FXYalWwnZUF4/RRNz2Y=;
        b=Jek3G9kVUtkQOqQMOKqOrV9gVq5lSipvNe1iluOEV7QCIIEX8CSTzqF5gfy5LKWl2J
         kqpKIiiZkZaEJHYhdRCKUm9aQzXs6yqjFUmlSpKajn5B07EYRrME+BaMwsXVcHP0tQlt
         o5pN+77AupV1rOKlfhXo2xpkgOn6wGfpwSHPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/64PPB5d/u2+0Z5QEyaFUQb1FXYalWwnZUF4/RRNz2Y=;
        b=iIuPwyOZZDzZEWBE4yXhKaS4v6s2p7o4EYO1FAfy7iFlbGxNK1jgvsfJVwGlHjTryf
         yEBSdZfKZ7QdhpUgU2bKYqAi60BTNpvEkmB0v2ttyqedZ4I8DnLw9fOAbzbI29yspeXT
         YuLwhWhFxp9Nk3XBifMdjGy4kr85zxXJvpFUJIwzI5ao+L839AZvYjIEM33DULcf/njX
         icpJm8nWpKC9ADgFawWZoQARCQ1aiZ+zazGUx/Wou8u3ToKcvncerwLDIOvQcVEHYaRa
         N5ogncXwV/ODpg3Ov1ChJpFJ/A82she7wEc7h7K35F2iYKkf5lebwsa8LIpU1wyv0v1x
         0HMA==
X-Gm-Message-State: APjAAAX8fY4a4w1fKZj4kgABeOiBaFycf3wR4fmO/wMi79kU1H+6nUMv
        zgEiw+FOmYhG78JSNRSsSWpC59laeZI=
X-Google-Smtp-Source: APXvYqywZeN64i9d5UdDeHWCiDju86JV3NFfhonDH4e7lIbUK4fjqBC3YGpn0VRsnyKu+DuieJwYiA==
X-Received: by 2002:a19:da01:: with SMTP id r1mr2432lfg.150.1569285907164;
        Mon, 23 Sep 2019 17:45:07 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n3sm53296lfl.62.2019.09.23.17.45.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:45:06 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a22so73446ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:45:06 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr37660ljj.72.1569285905710;
 Mon, 23 Sep 2019 17:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com> <20190923233038.GE7828@paulmck-ThinkPad-P72>
In-Reply-To: <20190923233038.GE7828@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 17:44:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFhZfpdoMrVDprBMvuuKPH7jFKY=sjN0dWj6Kz9eAtsg@mail.gmail.com>
Message-ID: <CAHk-=wjFhZfpdoMrVDprBMvuuKPH7jFKY=sjN0dWj6Kz9eAtsg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:30 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> I pushed some (untested) commits out to the dev branch of -rcu, the
> overall effect of which is shown in the patch below.  The series
> adds a new rcu_replace() to avoid confusion with swap(), replaces
> uses of rcu_swap_protected() with rcu_replace(), and finally removes
> rcu_swap_protected().
>
> Is this what you had in mind?
>
> Unless you tell me otherwise, I will assume that this change is important
> but not violently urgent.  (As in not for the current merge window.)

Ack, looks good to me,

               Linus
