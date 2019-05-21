Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71595C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gl/VhcZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfEUW57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 18:57:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42431 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEUW57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:57:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so204054pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rucfmk6PQ+2b/65f5JoM4xkSIs4QXvUCkcZfbiU0v90=;
        b=Gl/VhcZFOBivxkiKw6dBnjOHFfkQn7ndyD/yixWgkgIiArp2I/BASUN8QxBl0aSeex
         RhDowpMU4HPLr4kEzwplUClGeUx/WiwtxsjnWjvvhBDXXyhE903aTpqlc8e9GRDY9G63
         iI1/xwka4FG01ivpWKjGXouiFHP1oapXaaupJXDbTtfFWlP9S6Q3pe09P1gaBaq4Avm3
         l70WtW/znfdzLDgSy0PW1CoxAiMS1f3+2XJIJ8QNmIG64Booan14UuJGgVC1MqmYIhR5
         nSmG2EtCSTxLOz2QbkS/dnVu9V2m1LZwup2Zw6a/W1Fxt0VF8uj16h/grNsuW6bigTRS
         je7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rucfmk6PQ+2b/65f5JoM4xkSIs4QXvUCkcZfbiU0v90=;
        b=jmzTS1CpQiJZSBH2XU5oprcL3MEU4NqfS6deRoXSz2/mQo6xdAk75L+xjPHMzJIjLW
         kGj+Dq2VNRZG6vQ1a0exuznoeNjfAXEyaZDPosceAB3/K4VlN0S6zGE44pQ+paeGZFpx
         1vaUoeQxCpIx/OoA8hzu4rKFp/qbibrYbv9WIEdf9NlBDqQTob3XyNCb07/SSdDCbKOA
         aUKWm93Yxh2b137YnhAXE7Apd8PtK43eQO+ZZ7W4orQvx25ICbKbBVFR3g9PnGXASnCW
         36fZgDZAG2szb0HXBqFxqiWKcAZH5D3pucLsYNR/A7BWbHjsHUWyL9ywd0qLFcoQIZZ5
         BYYA==
X-Gm-Message-State: APjAAAUjvaPoo9rbTS6oE6bMKy8o9xbskpaxm/m3Z3rf9OeoayVAK6La
        7NsWFCHr8amD4xB/EZtvdCSZ69G2JXWK3NeFk6Crpg==
X-Google-Smtp-Source: APXvYqwxGSrs8uXEi1pQFu8Gcuy8B0mZUnnb4Oe/zWZjSl2FAodQnq6jQIaD+xkJYbuz+M7NzU3HxrxsspYTM6uMgIY=
X-Received: by 2002:a62:2b94:: with SMTP id r142mr549906pfr.184.1558479477850;
 Tue, 21 May 2019 15:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190521174221.124459-1-natechancellor@gmail.com> <CAKwvOdmgpx0+d905PdRqUFeg8Fj8zf3mrWVOho_dajvEWvam9w@mail.gmail.com>
In-Reply-To: <CAKwvOdmgpx0+d905PdRqUFeg8Fj8zf3mrWVOho_dajvEWvam9w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 May 2019 15:57:46 -0700
Message-ID: <CAKwvOdmpHOMwVM+d_W3eeu3xC+nZqBTO_hx9Wf1z10yivxSe7A@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: Remove an unnecessary NULL check
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Richard Smith <richardsmith@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Richard for real this time.

On Tue, May 21, 2019 at 3:53 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, May 21, 2019 at 10:42 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:47: warning:
> > address of array 'param->u.wpa_ie.data' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >             (param->u.wpa_ie.len && !param->u.wpa_ie.data))
> >                                     ~~~~~~~~~~~~~~~~~^~~~
> >
> > This was exposed by commit deabe03523a7 ("Staging: rtl8192u: ieee80211:
> > Use !x in place of NULL comparisons") because we disable the warning
> > that would have pointed out the comparison against NULL is also false:
> >
> > drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:46: warning:
> > comparison of array 'param->u.wpa_ie.data' equal to a null pointer is
> > always false [-Wtautological-pointer-compare]
> >             (param->u.wpa_ie.len && param->u.wpa_ie.data == NULL))
> >                                     ~~~~~~~~~~~~~~~~^~~~    ~~~~
> >
> > Remove it so clang no longer warns.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/487
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > index f38f9d8b78bb..e0da0900a4f7 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > @@ -2659,8 +2659,7 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
> >  {
> >         u8 *buf;
> >
> > -       if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
> > -           (param->u.wpa_ie.len && !param->u.wpa_ie.data))
>
> Right so, the types in this expression:
>
> param: struct ieee_param*
> param->u: *anonymous union*
> param->u.wpa_ie: *anonymous struct*
> param->u.wpa_ie.len: u32
> param->u.wpa_ie.data: u8 [0]
> as defined in drivers/staging/rtl8192u/ieee80211/ieee80211.h#L295
> https://github.com/ClangBuiltLinux/linux/blob/9c7db5004280767566e91a33445bf93aa479ef02/drivers/staging/rtl8192u/ieee80211/ieee80211.h#L295-L322
>
> so this is a tricky case, because in general array members can never
> themselves be NULL, and usually I trust -Wpointer-bool-conversion, but
> this is a special case because of the flexible array member:
> https://en.wikipedia.org/wiki/Flexible_array_member. (It seems that
> having the 0 in the length explicitly was pre-c99 GNU extension:
> https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html). I wonder if
> -Wtautological-pointer-compare applies to Flexible Array Members or
> not (Richard, do you know)?  In general, you'd be setting
> param->u.wpa_ie to the return value of a dynamic memory allocation,
> not param->u.wpa_ie.data, so this check is fishy to me.
>
> > +       if (param->u.wpa_ie.len > MAX_WPA_IE_LEN)
> >                 return -EINVAL;
> >
> >         if (param->u.wpa_ie.len) {
> > --
> > 2.22.0.rc1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
