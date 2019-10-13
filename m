Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F6C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 20:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151C620663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570998066;
	bh=rz8lfW8M0nAm7u1LgOB2YxZBb0h1KOcI/wcFrZYldvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fDBYmKT5/qAlE6On5hi/WNub7pmCNfbwbN2AiErD8HcscMktSbUCoom/bXtNamyEi
	 5ZQRnC7mw3Se50VLJv/vWm62kWkCA1W8qpk69h4C/oRFGNPTPWa2kexvUAjdqe5DbI
	 TBwIa7zN6U9djqbTGb/VTJEVHyN0STU5eahfnnNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfJMUU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 16:20:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39954 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJMUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 16:20:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so14561479ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJmSPxWD5/TkHbFJUcVPXh6iFR/S6K/PI1RETNfV6+Q=;
        b=F06ZA8X2/ZCMYGLX0R+bf2JXirE2mkKo7IKs4CYOx5tLbue+pdhZGlAlH+MMsJTsSI
         JJhOLZ3SHIGQ5/J8Vp7sV6c23/uIAr/0wnjI+wmnPX+pGWhBIOqPiagnxJJBrXOmjf7F
         atW5/J+N+Y2hPd11tAYDnE+8xGz6Q+ljHks94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJmSPxWD5/TkHbFJUcVPXh6iFR/S6K/PI1RETNfV6+Q=;
        b=DxCHxqWnqZPTpAOM6mkmli1RP4dW1oebJiGyjJPZZwH8E840OqU7n7rxeWIUM1lefB
         KHlpY+OdsGtWS4w+vmZzTGnhuy8T9E1t9UWODU4Za9lp0NYdUmPdPLS3z/rkmydHmO5H
         1GwNKNz1znG2nvOThCPgQXlewN3MQqxKwltHa6j0PyTz3Ze7Zf1ND18w5b8bRsb4HjwR
         eoV1bEkbeXwSwW4jTpBoKL7zTIoEn+WTwvSPCkkKoZI8ZmnfbSTCz05Mnm03S1RC6WX+
         24Gf7913KbMqq7KPi26rIZPTTQlppyO0J05gFeVUAlyuq/RZaRNaaQeUu0QbFGbiGq+8
         69xg==
X-Gm-Message-State: APjAAAVsfcfEFyDS8DiUCX1D+EdXlwMdWKGLv/oJo5eFXVIhv9CVlOjO
        XqvDf4uTcQunDiLMGkFz3WAYZHD0A0w=
X-Google-Smtp-Source: APXvYqw7FcGLDF/8m+8VJym1NaGc26T0sqpHKpLqMiR9UhS8tA51J9+Ya3Oxpy1m3l6fDPOfMV/rjg==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr16272664lji.66.1570998055408;
        Sun, 13 Oct 2019 13:20:55 -0700 (PDT)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com. [2a00:1450:4864:20::135])
        by smtp.gmail.com with ESMTPSA id j7sm3677932lfc.16.2019.10.13.13.20.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 13:20:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r2so10322911lfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 13:20:55 -0700 (PDT)
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr15490954lfo.61.1570998050112;
 Sun, 13 Oct 2019 13:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk>
In-Reply-To: <20191013195949.GM26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Oct 2019 13:20:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO1EW5qVuy7=sc9Kua98-afMx75gaeX4FHKf3+wPLmkw@mail.gmail.com>
Message-ID: <CAHk-=wgO1EW5qVuy7=sc9Kua98-afMx75gaeX4FHKf3+wPLmkw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Re plotting: how strongly would you object against passing the range to
> user_access_end()?  Powerpc folks have a very close analogue of stac/clac,
> currently buried inside their __get_user()/__put_user()/etc. - the same
> places where x86 does, including futex.h and friends.
>
> And there it's even costlier than on x86.  It would obviously be nice
> to lift it at least out of unsafe_get_user()/unsafe_put_user() and
> move into user_access_begin()/user_access_end(); unfortunately, in
> one subarchitecture they really want it the range on the user_access_end()
> side as well.

Hmm. I'm ok with that.

Do they want the actual range, or would it prefer some kind of opaque
cookie that user_access_begin() returns (where 0 would mean "failure"
of course)?

I'm thinking like a local_irq_save/restore thing, which might be the
case on yet other architectures.

         Linus
