Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66476C4360C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 02:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 02:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570414001;
	bh=QwA8GD4clcNdAkQ7L4x4JTIm7vxwhZ7LTUJI/UxYUak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cWWHiMoLCfORqf769Z7rdR433W6Z/vzpcXgacREmeAP/2msSBjdM082kShb/hCJXq
	 neM3UmipXDMHlCd9qAlaOOV/U51jYF8Ux5qdeSHhyPwqP59e0oZEqgpSGuAKeipkyf
	 Wb53K+UefllUIBL4gukBwV9dKZwXMrCPQECzCHv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfJGCGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 22:06:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40732 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJGCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 22:06:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so11867992ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qiUHylA1kcZKMZORFgPfl/Wwk8TxgMqTrPx6EUI34c=;
        b=SQ1klqasMPWiAPOUygJMVdAoW7sOImnFa+ky/otsy+obDuwpTyXXbJfsrm9ITmXxRc
         iFffZqz66qKnniup6bIqMecKZCOQ9QI2qE8ok/fmyCOPS8Z+F6Dbw0tviLzaoBA7V7uo
         4G6lDiYzHKNBbLSRX2ny8sOlnMYEJSsjOrb3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qiUHylA1kcZKMZORFgPfl/Wwk8TxgMqTrPx6EUI34c=;
        b=eRm6yVu8BllO2ihGmczNTCmZKkz8uq6xfv0SJTMKQ8N+J6N5BEHhW/M2UONQmRidms
         Ao2GSecMtLXWJdSRQPhVlWXO9528D0Ucys7vfX/OUDZoenWYmObdEb+XJo8S3fJbzt1r
         wYz7FgWAGmaVZDIldOdWbPxvvR3+TyCFgA5fm1d7oNbAspvlVcPOmarLloI4lgcazX0H
         XhVBm339q+D7J/ldBdxUyAdkRne8Cph6iFlmIO+PbZUki9nYNQndFEuwMW5b4JeV5faV
         RcM2vEk7nEDkQs20ozckbtmIbdCGRptiqaskbAxnGyr8VRMWciX6I82oI6tOB5CQ1jdM
         YfiA==
X-Gm-Message-State: APjAAAWeZoaanE4+Q+g/WbatrEc2P40yn82n8RBI06W5j2bFL+miqD9a
        B4U8RiXSqR3TDV+sJHOmMQJEuyigsM0=
X-Google-Smtp-Source: APXvYqyWfA2WXUTxkFuHi3/BMikt1e24suFLrz8IYYwJ+CJzci8XMRJ3agahVWAIKOIBiJbAWlSaUg==
X-Received: by 2002:a2e:9118:: with SMTP id m24mr16440643ljg.95.1570413997593;
        Sun, 06 Oct 2019 19:06:37 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y3sm2792866lji.53.2019.10.06.19.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 19:06:36 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y3so11875843ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 19:06:36 -0700 (PDT)
X-Received: by 2002:a2e:7611:: with SMTP id r17mr11961696ljc.133.1570413995847;
 Sun, 06 Oct 2019 19:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
In-Reply-To: <20191007012437.GK26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 19:06:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
Message-ID: <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
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

On Sun, Oct 6, 2019 at 6:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Ugh...  I wonder if it would be better to lift STAC/CLAC out of
> raw_copy_to_user(), rather than trying to reinvent its guts
> in readdir.c...

Yeah, I suspect that's the best option.

Do something like

 - lift STAC/CLAC out of raw_copy_to_user

 - rename it to unsafe_copy_to_user

 - create a new raw_copy_to_user that is just unsafe_copy_to_user()
with the STAC/CLAC around it.

and the end result would actually be cleanert than what we have now
(which duplicates that STAC/CLAC for each size case etc).

And then for the "architecture doesn't have user_access_begin/end()"
fallback case, we just do

   #define unsafe_copy_to_user raw_copy_to_user

and the only slight painpoint is that we need to deal with that
copy_user_generic() case too.

We'd have to mark it uaccess_safe in objtool (but we already have that
__memcpy_mcsafe and csum_partial_copy_generic, os it all makes sense),
and we'd have to make all the other copy_user_generic() cases then do
the CLAC/STAC dance too or something.

ANYWAY.  As mentioned, I'm not actually all that worried about this all.

I could easily also just see the filldir() copy do an extra

#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
    if (len && (1 & (uint_ptr_t)dst)) .. copy byte ..
    if (len > 1 && (2 & (uint_ptr_t)dst)) .. copy word ..
    if (len > 3 && (4 & (uint_ptr_t)dst) && sizeof(unsigned long) > 4)
.. copy dword ..
#endif

at the start to align the destination.

The filldir code is actually somewhat unusual in that it deals with
pretty small strings on average, so just doing this might be more
efficient anyway.

So that doesn't worry me. Multiple ways to solve that part.

The "uhhuh, unaligned accesses cause more than performance problems" -
that's what worries me.

            Linus
