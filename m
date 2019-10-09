Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F48DECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E940D20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FW0PIz9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbfJIR2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:28:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40480 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbfJIR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:28:50 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so6811931iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6N0xkl4bTPUi6zGcRxZ0oIYFX/fveTjl+e6ocsFVkI=;
        b=FW0PIz9QpEJNdQumuiaUalMyaj2SzMhIDhra6dX9NJb4a5Laxke+fDfxJBtD/etYOr
         w4jxzvQnZ27rB/wkJMbsqX6XfuqANFpnb7FoaCJegpZLlaXI+p5vU0X2V9REcsVm3F79
         NLP9UYGd300jIkFcrZZaDZLF+ymWhQ+VxPBlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6N0xkl4bTPUi6zGcRxZ0oIYFX/fveTjl+e6ocsFVkI=;
        b=GMcXKFdlhjFnFX6vrlULmbt5QHlkTM4z11SwESChui1kr1vUZz81/vSNIHbs7C5l5E
         pqIDJnrkxvPUORp8XeeIdqMacwwW3a7h76x8XWXrFkEhrqD03SycsFMxlJLi9BeMAMNE
         hjz1G9kntkIRNda4klTf2hX+gxtKUDHZom0MJYGf1zAd0rGfkHJn7wFauSkRzrBie74X
         MrFqLeBNWDnb/arlwsGXlcOMmQzSBPTas7T/M+fSxWXtTLsm1GyU38Mwic+ZCxUMb2tT
         6CYDYPmvrQ5EPafhISxb/N6P5S/tYpdan6RDVqDN18zHwzvZzF576w7jJC36fAurx3NX
         1onA==
X-Gm-Message-State: APjAAAW8Nm8SApNhevXiHdbsAPRgIHhxNlG27i9cPziwkYqwMpYNCjoH
        y92nOg4htWfNAFzABbFId9+X7qGpyGg=
X-Google-Smtp-Source: APXvYqwrcUt7pMigPuIvCDduTSoNVEnXXQ/YztN50v7FFgTAhqUISFz7tZhb9cV5W5HtrEJcKvQMHA==
X-Received: by 2002:a5e:8e05:: with SMTP id a5mr295885ion.125.1570642129272;
        Wed, 09 Oct 2019 10:28:49 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id x11sm1612000ioa.4.2019.10.09.10.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:28:48 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id b19so6852478iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:28:48 -0700 (PDT)
X-Received: by 2002:a5d:9386:: with SMTP id c6mr4649645iol.269.1570642128135;
 Wed, 09 Oct 2019 10:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
 <20191008132043.7966-4-daniel.thompson@linaro.org> <CAD=FV=W9Tdh2hPekzgSYnCqoTX_ms1GY-FXgnxd-uEW0SWbyuw@mail.gmail.com>
 <20191009093049.tnz442bo54bzmzmz@holly.lan>
In-Reply-To: <20191009093049.tnz442bo54bzmzmz@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Oct 2019 10:28:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UuLYPpkJBWbkWoJzv97A6jxRFa4QmmD-0chSrsuT_bPg@mail.gmail.com>
Message-ID: <CAD=FV=UuLYPpkJBWbkWoJzv97A6jxRFa4QmmD-0chSrsuT_bPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kdb: Remove special case logic from kdb_read()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 9, 2019 at 2:30 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> > > @@ -183,17 +186,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
> > >   *     function.  It is not reentrant - it relies on the fact
> > >   *     that while kdb is running on only one "master debug" cpu.
> > >   * Remarks:
> > > - *
> > > - * The buffer size must be >= 2.  A buffer size of 2 means that the caller only
> > > - * wants a single key.
> >
> > By removing this you broke "BTAPROMPT".  So doing:
> >
> > set BTAPROMPT=1
> > bta
> >
> > It's now impossible to quit out.  Not that I've ever used BTAPROMPT,
> > but seems like we should either get rid of it or keep it working.
>
> Thanks. Just to check I got exactly what you meant I assume this could
> also have been phrased as "it looks like you forgot to convert the
> kdb_getstr() in kdb_bt1() over to use the new kdb_getchar() function"?

Right.  Sorry for wording it in a confusing way.  ;-)


> > > @@ -741,7 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> > >
> > >         /* check for having reached the LINES number of printed lines */
> > >         if (kdb_nextline >= linecount) {
> > > -               char buf1[16] = "";
> > > +               char ch;
> >
> > The type of "ch" should be the same as returned by kdb_getchar()?
> > Either "int" if you're keeping it "int" or "unsigned char"?
>
> Probably... although the assumption that kdb strings are char * is burnt
> in a lot of places so there will still be further tidy up needed.

True.  It doesn't matter a whole lot so if you think it's easier to
keep it as char that's OK too.

-Doug
