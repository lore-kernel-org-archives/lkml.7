Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C017C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3F2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro0dwDhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEITQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:16:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38422 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEITQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:16:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so1696089pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dCjJw/na5CXc5Q7VmihmkFQY0cVqesjTapigdI+UM0g=;
        b=Ro0dwDhTlBCaQgyZTqsSv5mR+AGvMLj4LjdmJehXtkcoEdj83UTNtDMm812HjEgFgG
         WtkOxcg/0Al+n5Ga+/0p8P1bExpE5DPnXo/7jHMQ6nd4kAWbCup/Zv9xvF6WtWRR0Lnp
         oruX0gqjPwHseld0MGgOVFHurgf4h5h3nTSPK3rFEUC9ys0WuAISLh6LuzStL0JumwKQ
         W2zIUqcaIhuoTPE9Pp60lLQTeUR10KOviNKN6Ales4vSwdLDM3uBaZ5uxZLK0j2idyFg
         HjdCnyK1X8w3isQaVfK1cHujb3BWoAOnUdEUqRmLOsu6clZixIbeQke+iYmw61FU1+63
         f65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dCjJw/na5CXc5Q7VmihmkFQY0cVqesjTapigdI+UM0g=;
        b=FKcLowibnrNwOa7ITKEk/93746uOxTcr5zvGJ8lhNvV4aAGoCy8vzyU5pAD7WHjKgf
         vACqUevBYLzbWXWKe0/QlNVcts8ygMX9Sjgf5sie/oTn8/SDRNHd+WtZFqvj9GkmzkN0
         +iWF3XYlN9Y7YMa5C/TqW24+vF04zn3eY+RK93CTW93/5c24Jm3ZVJWlFWGDxDKEJGQj
         pPn6y9ur7fGiUuBzZ5JdI4yUaDcW6yM8Vm/0RuUhuyyLOJlpkVJkY/HsFV0+FOmrrCno
         2FbF1nex0QM5vURpJtNYhSPJNTVwBkqQU9G6fRaxDZVxpgvgJkDfI/3jheht5PCknv0Z
         pTHg==
X-Gm-Message-State: APjAAAXACbzMuJ3gR4f/f+G4ILOxhiGJ0ys5N2mCnr4TumE2pa7otOm2
        AaIO6kfGIv+zfzoWmCEQH78=
X-Google-Smtp-Source: APXvYqwZFedSgKIUTu7ZNPnnQUX8hU7MXGQXIWKdjmj28oyrKlAJvzFrqKt1HsL3cu0EZlzLizIrNA==
X-Received: by 2002:a63:4006:: with SMTP id n6mr8009418pga.424.1557429397325;
        Thu, 09 May 2019 12:16:37 -0700 (PDT)
Received: from [192.168.20.7] (c-73-19-52-228.hsd1.wa.comcast.net. [73.19.52.228])
        by smtp.gmail.com with ESMTPSA id y14sm3539772pga.54.2019.05.09.12.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:16:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Danish FreeBSD Developer hates jews collectively
From:   Enji Cooper <yaneurabeya@gmail.com>
In-Reply-To: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it>
Date:   Thu, 9 May 2019 12:16:35 -0700
Cc:     linux-kernel@vger.kernel.org, misc@openbsd.org,
        freebsd-current@freebsd.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5AFBB386-6841-4E96-A6CB-5540BC188357@gmail.com>
References: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it>
To:     ossobserver@redchan.it
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 9, 2019, at 11:03 AM, ossobserver@redchan.it wrote:

This is the only reply I=E2=80=99m going to give to this thread that =
seems like obvious troll bait.

As a native English speaker who often gets into debates about =
controversial issues with respect to concepts like classism, LGBTIQ =
issues, race issues, etc, the argument phk@ made wasn=E2=80=99t =
necessary in favor of anti-semitism from the perspective of hating =
Jewish people or their culture/religion; it was more or less commentary =
about policy issues with Israelis vs Palestine, apartheid, the Gaza =
strip occupation and the fact that some of the Israeli people aren=E2=80=99=
t acting out against the issues between both parties in an attempt to =
end the conflict. With this in mind, it was a poorly worded response =
which led to a slippery slope in a discussion, done on a social medium =
(Twitter) that seems to get blown out of proportion really quickly =
(trolls and misinterpretation abound).

This kind of reasoning presented sounds a lot like cognitive dissonance =
employed by the far-right in America vs individuals like Rep. Ilhan =
Omar, etc, where they play the victim in order to make leftist groups =
look like they tolerate hate against certain groups (in this case Jewish =
people). Does that mean that the left has anti-Semites? Yes, it can =
happen, regardless of one=E2=80=99s political allegiance if one is to =
believe the left vs right dichotomy (which I think is largely poppycock, =
meant to separate groups via tribalism, etc). However, I think a number =
of people are reading between the tea leaves in this thread.

Do I think phk@ and others should potentially take a step back from the =
discussion and avoid digging a larger hole than has already been dug? =
Yes. It=E2=80=99s not my business to make people do that though, since =
I=E2=80=99m not in a leadership/policy making position.

Please leave this discussion on Twitter instead of flooding these =
mailing lists. Linux/OpenBSD should not be exposed to this unnecessary =
drama, and FreeBSD-CURRENT is the wrong mailing list for this (try =
freebsd-chat@ if you are so inclined).

-Enji

PS I am not representing the FreeBSD project; I am only representing my =
personal opinion.=
