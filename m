Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB4C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B21820879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VInmJ/2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfEWGtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:49:39 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:35251 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:49:38 -0400
Received: by mail-it1-f182.google.com with SMTP id u186so6950138ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jltpASykzdU6htyNAFi8yet91P2ld9Xm5d16qO9Qr/I=;
        b=VInmJ/2Xpp4UaA+qhfOrs+cGQh1HHqfQDXnCmrQ7JrsiLtQQPezecPfRB/nPQFGDbF
         RQVzq4nw8rR+628WmC7/gnimTwaSMDxzkI+fnEo4DUOE8F5dXSbX+2HDEffYAqd9EzN9
         T2DYbSSXKsq1FYbdiiDjGTmpUZ+kkrA1NLMZrCLufzwli6tocJDNzBmhb0qXQSg3uJIm
         KCaXsTQCP9XwCDW9XbNuycqybZ08f5jyZP9aOL/5panh0mwJJRYouxtQtcqGL15jwmBJ
         b+p//qs57aTdASmqXAP0AjkwZSmTAKG7ryYx6Ytwpu1YSdjk0/3/GWsOeQUjBJa5ptGW
         iP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jltpASykzdU6htyNAFi8yet91P2ld9Xm5d16qO9Qr/I=;
        b=t9c8qYir6c/qBYGEtipYdANjQtr9A+GkqWkU3y58DziXHdH1iZO1GmMpxlKeLMOGxk
         S7RUi+VYKpqM31vXJqtzRYpdENLKLohzK4qcMKVNZ0Xw22QQArf/YmpZarCsRkJ68e5x
         EiTebRDE2rKa+XbIHf4zg4tLEdegXeBNqDwL5PmewHrRDeDnxbkhLfEWbs/xQsfb41Xw
         9AFrKQCr2I8FXOT3mBjExDlKY9oQvygOx/j/j2ISKkNTmzh74ZSZFI+heU3BRhPUs6fe
         lC0hUX6wnBvq02A99iKuYdF5bjY0IvVHipv3oF86RRzzdy/ifjX/OZxJ4bAi3PmUxqAb
         1yig==
X-Gm-Message-State: APjAAAXqbeOea6n2J6vic6MwLkWhtOrM/JtsAv5DuNYFgYb5UpsnI3so
        fGXM0BDJEPrT9YGkTZwkR2GDc6dRjowiNgYXkHyI4w==
X-Google-Smtp-Source: APXvYqxh9Tn+M4JYpzw6xDNDhjGnXu7+KTF2kmiR8oZXPHg1vEwPSozEsr4gJhWk/jaUSj/DTk6oRJT7/84TgQBQOmE=
X-Received: by 2002:a02:412:: with SMTP id 18mr24066471jab.82.1558594177480;
 Wed, 22 May 2019 23:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
 <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
 <CACT4Y+a_wLnB_f1bfNy_HAipF4iHFiyraogMHWdK285oxgJr+g@mail.gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF97726E9E@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF97726E9E@USCULXMSG01.am.sony.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 May 2019 08:49:26 +0200
Message-ID: <CACT4Y+asvDxDunUYmABecnnxAVz0zGZ87XY=5pwy6F-ULsmMSw@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Tim Bird <Tim.Bird@sony.com>
Cc:     Tim Bird <tbird20d@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 2:08 AM <Tim.Bird@sony.com> wrote:
> > From: Dmitry Vyukov
> > On Fri, Apr 26, 2019 at 11:03 PM Tim Bird <tbird20d@gmail.com> wrote:
> > >
> > > I'm in the process now of planning Automated Testing Summit 2019,
> > > which is tentatively planned for Lyon, France on October 31.  This is
> >
> > This is _November_ 1, right?
> No.  Thursday, October 31, 2019.  Is there some conflict on Thursday?

Ah, no, sorry. It's just me incapable of reading numbers.
