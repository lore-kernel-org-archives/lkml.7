Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA06C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA3E2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnW95Nc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF0PbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:31:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40046 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0PbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:31:06 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so5657965ioc.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=nnW95Nc4Sck+SCyLDWb6ekZqtVJR9gFDsyfjGL4qdTmxCKqSDzLNB+q6JY04BCTCox
         rNzxKwwVKDRt6j/nSCWITR4woKO3Bg6Pi4yh4DIx201Y7mmDE2vv9BJlTOgg0nWuLodi
         hRrheHz1Qb7gI7AH1/e+uD16A64/DMlbPbvG0GMFSoHN4QgrKWYC61U11c2JmgwNL4fd
         57IHFuNC5SRqpkx1wImVnhsWW7VQAb4Gj74fRFKt/WKH/hZHSXsN2VBtrqFRwm0yMHvP
         qISmxHrhDrDGrXqYK7CvD9tSjcj8q5EF7ls1Z6zh/pEeXldbhUMy3yPshERw4SLH5ZjI
         zL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=k5OWqBx/Ibm3lXrscmzW6eSr3jLU0xIThgNEX/jtu7FlxnssUGMBKKPVo5OAyTpvZ+
         kU55F+ZugxUBSTc1plv798Tbb2jyknMS0d7udxthYg8BoZIv2JNluO6jlHbKBelhNaz9
         uR9X+WFKhfc4Ua5rD8ingeBZgLFGyTQvmuxZvRSvbjvUpFsV0nXkf7V9XedABBEpNk4V
         8XEWQpOB3nscTnyglONEOm5McHfn6EucyMHn9QraeRX/AR4SMgUM4HILgbskYNGM6oKs
         lpLDRSSLyxyS00aCAmaCbKa5pqanjNEp6wG6aKBZk4a4rS4bWBgslWVoHDT1M3xebkJy
         SUuA==
X-Gm-Message-State: APjAAAWCotCuBvgU3gYkbsLvrtU3jv2d6Q3MuEwy/aP9MWqnPKngCn/A
        PRDu3OOBh6IAhLYH+cHcNSW3sM0lPP969EzqZ1jGMA==
X-Google-Smtp-Source: APXvYqyWPoDVGM4Ciu+xqxjJUuhEI0J//jkhx4KineosYbAyIwLnim/WCO6ZIrIBAhMlWt7aE44OwKUSv/DF3heQ9b4=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr5109103iof.64.1561649464641;
 Thu, 27 Jun 2019 08:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-20-matthewgarrett@google.com> <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 08:30:52 -0700
Message-ID: <CACdnJuuUJShbsDt+oV+2nPOX_pQikOPumtMaB-mas6FLVeZ87A@mail.gmail.com>
Subject: Re: [PATCH V34 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     Daniel Axtens <dja@axtens.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 6:49 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> writes:
> > +     if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> > +         security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> > +             return false;
> > +     return true;
> >  }
>
> Should this test occur before tainting the kernel?

Seems reasonable.
