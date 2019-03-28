Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E7220823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMUPz6JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfC1SbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:31:05 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:46008 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1SbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:31:05 -0400
Received: by mail-io1-f52.google.com with SMTP id s7so18054510iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuoDoE27aCvvgTv07QgoMgpiETbkC3kgRDZDoyuN6DI=;
        b=MMUPz6JNT1zX2O65vTd9Nwq2h4OBuGV0tiLxJc4Gpyk4/jCxkq5Chf4GRpUqt9GTQh
         kaWtL5Xf37vT2rB1ItaokV37O6PdCF4qjF3+8cvLmLKun4UG/GkwS5tygrWY72joqc+S
         C0dZi1rKK18gwWP2GblrF1Yh0cbal8FnrQn2yHc5lMYo7zvxeWw0OWN+9/m0jRgGdBan
         k/HA9XJ6UCCQj4ZTB95kxJv8eC9Mj/yMg8AIAggHlqf3G1tOuBDTUMs5c9iMc3hP1f54
         f+uZ0TgwuUhlrqLb/gpd5GVmJOgTspAg4+zOAZ7SA7mDaHqIbtTwFS5dLGmJYHI06KGM
         K+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuoDoE27aCvvgTv07QgoMgpiETbkC3kgRDZDoyuN6DI=;
        b=KFgPtHbi8UZFfsIAssazrK410LQOyM+/a2/KIZWBGpgDriOVBRTopFVrSpw9s1PR3z
         7umQcOUUOhaI9iEjdQf2ENwQ23EySQXiv522QLXQZNITwVr3A7trNJfOYbP6N+EFKZvR
         caZZFTbwdtHvNZL9kktZlJV3OTjitceW+Hl76eWlG6/mq+Plb7hq715W4fRqVejCy7Wm
         csMmIzZdHo+rZfsxb/DjMPXbSp02HCFBQ+Q3g7Gj3NcuUT9jy5YSG6dlLSDnmuDxwBbc
         IO5HWnyhNrhqaCrRrI7EhR9qeLS8OMZb4uyfnx34kVETUJwugR6aW1FwX7asZ3oWemYZ
         c0xg==
X-Gm-Message-State: APjAAAU0TTYtIed4dJ+QWEG2E7xkNlxJ+9KkliuPBitl6Gx2h6YYUFNV
        tLwwu/u+hFwvWbiyxB6Ltn5zjjzqHu1W4XrAJQJe4w==
X-Google-Smtp-Source: APXvYqzhcdDEgeM653Ixvtf+OXCdpts2w5Vq2OR+j4O/He4Ftd1d6d+A5FS/6HShkrFS3KDYWfWzIPROgGYsRF7T3gg=
X-Received: by 2002:a6b:3f86:: with SMTP id m128mr13534331ioa.275.1553797864243;
 Thu, 28 Mar 2019 11:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKdAkRQj=bSSL2Cw3gAqi5f12yP3+KsvtrMvU4Lcfta_JYxMYQ@mail.gmail.com>
 <20190328180503.GA16249@mail.hallyn.com>
In-Reply-To: <20190328180503.GA16249@mail.hallyn.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 28 Mar 2019 11:30:52 -0700
Message-ID: <CAKdAkRRf+7UkmwbWNEnR3cNhc2t-kspRQNy4uOYRdcwBofXwtA@mail.gmail.com>
Subject: Re: Allowing mapping supplemental groups in user namespace?
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Thu, Mar 28, 2019 at 11:05 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Thu, Feb 28, 2019 at 11:27:38AM -0800, Dmitry Torokhov wrote:
> > Hi Eric,
> >
> > Currently, unless caller has CAP_SETGID in parent namespace, we can
> > only map effective group id in the new user namespace. Would it be
> > possible to relax this rule to also allow mapping of supplemental
> > groups (1:1) of the caller?
> >
> > Thanks.
> >
> > --
> > Dmitry
>
> Hi,
>
> Is there a use case where adding those to /etc/subgid is onerous?
> (There probably is, just would like to see yours)

We on Chrome OS limit number of suid binaries installed on the system,
so newgidmap does not have necessary privileges to carry out this
operation. Also we are looking for a solution that we can use with our
minijail package where spawning additional binary is challenging even
if it was suid.

Thanks.

-- 
Dmitry




-- 
Dmitry
