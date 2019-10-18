Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25207CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12BF21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571439552;
	bh=wCVTmBgf5c4jVxww8TvCfvyTukrERwLtaIMwlveCTSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S+S81J9mSkuyhTXXFk5vnZ3UbAkA6U8lFW63i5x5WR9yZppaOc0qC0OtP99hqZfA3
	 fzXukjInXQOlXzC7zvYXV6WskFQEkv8MU1w8kPCY6yoLw7+jvuOiO6c14EMihKKI6o
	 jIBbFTzNFnY3KeWVYB+vDxTreYN0QcASmfESmWfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfJRW7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:59:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40485 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfJRW7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:59:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so7749286ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=56iSMhhG7ekX9RZHanfAlc6yl43r/bP0XtTomC1do6A=;
        b=H8MiVGBa8DC99Jm+KUzGtf63KZiFijjH3Wq+PjqfMj7UP9c8xGvRhotOUMDvCfXeRb
         J8Vrtx/OsrcSiLpO/uGz3LA24NRi3Y6KkDK0nDrELSzvsqbbRU03atpeCOYb2E7zh4pc
         Avso8P6lnTiOWgAzrdtzj++kUr217s9IQ9UMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=56iSMhhG7ekX9RZHanfAlc6yl43r/bP0XtTomC1do6A=;
        b=CgNnw3MAg06y13kItkKQCf8E61xqiQyNy6hJtHx+9PnXQuF/1Fjaip2EzyUhEdc18z
         dKoqQS/B8Ycza1kbwcThut0pKD0fKX+7/TFoPZL2lKQlOFMPiwY37MwmBa+mceppzuRi
         r7B3VWGBbuGCqgGFMixKNRHyjuzKhOm5N+ojd4PB8YxFimz/b7X+iACi248rVwUCdga7
         AyN8+S54w7jP/CBiZ9Aj68M0KZNe5ikmQDdMT6v6Ei0MK90HhmsAd/s9z2RrrmlFXaW3
         ID8WFq61BlPifX2YODyMjM17lB5ChM9HnjTL7h1WK5/mGjWnosBomQvOEgeppCorZ7l/
         aUQw==
X-Gm-Message-State: APjAAAWKMAjalhU9bLJ1xxFpoeg5vr9dOMeUvNr8mmoLgKxf4/IF06tP
        DBn2G9LUCyoWATIqhMb0Oa5v+m/J+5Y=
X-Google-Smtp-Source: APXvYqz/7pDAkvKT00Hg1VVPOab4amtzvlH/Ssv7awnYPyWgkwIgDobhmiBJ1mAsYl7J0L/ErmcWfQ==
X-Received: by 2002:a2e:658f:: with SMTP id e15mr7707565ljf.254.1571439547777;
        Fri, 18 Oct 2019 15:59:07 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t27sm4136279lfl.54.2019.10.18.15.59.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 15:59:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id q28so2585090lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 15:59:06 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr7567834lfe.106.1571439546567;
 Fri, 18 Oct 2019 15:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191018203704.GC31027@cork> <20191018204220.GD31027@cork>
In-Reply-To: <20191018204220.GD31027@cork>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Oct 2019 18:58:50 -0400
X-Gmail-Original-Message-ID: <CAHk-=wip91atX54zCEo5_OwEjyCkOb7_OUvn8P7o_39tMJSe7A@mail.gmail.com>
Message-ID: <CAHk-=wip91atX54zCEo5_OwEjyCkOb7_OUvn8P7o_39tMJSe7A@mail.gmail.com>
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
To:     =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 4:42 PM J=C3=B6rn Engel <joern@purestorage.com> wro=
te:
>
> Sorry for coming late to the discussion.  I generally like the approach
> in try_to_generate_entropy(), but I think we can do a little better
> still.  Would something like this work?

Hmm. I'm not convinced that the register set is all that random in
general if you have attackers (or - in the absence of an attack - if
it hits in the idle loop a lot), but I do like it for this particular
use where we have that timeout while doing entropy work.

So I think this is potentially a good way to at least improve on the
situation when there is no TSC. Which would remove one worry about
getrandom() on other platforms than the usual development ones.

I'm on a plane at 38,933 ft right now according to the flight tracker,
and about to lose internet access again, but I like it and will take
another look when I'm on the ground and at a hotel.

              Linus
