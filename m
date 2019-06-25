Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7960C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DAC2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfU+EkDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfFYQQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:16:57 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45420 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfFYQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:16:56 -0400
Received: by mail-vk1-f196.google.com with SMTP id e83so3569132vke.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bxHs3cMUSY/lcnTBaWC9lm65VMyS9xe/CNCPh9Pq+7Y=;
        b=lfU+EkDAWcPLRsWFZdyEfPOrokoZXTJOFAaKyF3r6LE750Q13wN0o6eV2p2X6/qNh3
         xlGQrTOAWphdM3tf5Q34V9WcKc5qb9CS3qnIXd4/GggBxU4ZWYv8/urgyGIE/WjwL9wu
         JBhXvzUzCj7LzikrH2PdogJbPcFyLBQSVovo2yg69817e8gHinU5WNLuBem3pzfcgKhm
         uwj1XNHUc/4wK7wKWvtPAIKoXhNIipBITpomNKuKYvub+6wZ7z9/OKSUdHzocg5uIVxn
         gjVsMiEuEbdySUgXhOjJfMxL6lLkNNocT19B5soH7h9dL3yAl4V0IUneDji3O4ZE3idz
         OLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bxHs3cMUSY/lcnTBaWC9lm65VMyS9xe/CNCPh9Pq+7Y=;
        b=jpjlm1yq2wXuTOrLqiOZLrW313QVhvn5WD9gsPb+YD1I8Xkuo2G6Le5rJP+iHjdM0D
         7g6yydhnmbk+oEaGHw/TJgUHovXoo8YOmeLrjQqs5A8CFY7DxJGcWa/GEmVC95zq8MEg
         d/U4qoAavEHyyxlA30HTOExo67rY87Rl2NLyRA/+2SjEbuQ1zXbKB9th1an2aQoNumr9
         XHpgQCL+2/83PYCtSwjAYWlH9JOhDoIGmU+1cFRKvZvrg9iFA++78lhA+OTJTEzM0aza
         CPulWcx6U8H1USp4bNN44TBn8OgKAPVWdUTwYASBJb3WQKa5scpej+9fs07FfL+U7d7A
         3FUg==
X-Gm-Message-State: APjAAAWHTbrsq5poAuy8vJZUJ8OxhcLCzTEBxyGYe6nke3gmx5OZ/SWt
        lnNsd7wqUB8cKkJs9rbvF/cD3PSO1outXsQaYMUHXA==
X-Google-Smtp-Source: APXvYqzpmnLCOXbPK1tWPjNlTXEyP5BOMbJ27cXAFZ8jzDcM35yx9cTomQz6y6wya6Cj0FLuD1+b0URocoD+vFFBtcY=
X-Received: by 2002:a1f:b0b:: with SMTP id 11mr6742950vkl.64.1561479415224;
 Tue, 25 Jun 2019 09:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <1561058881-9814-1-git-send-email-cai@lca.pw> <201906201812.8B49A36@keescook>
 <201906201818.6C90BC875@keescook> <1561121745.5154.37.camel@lca.pw>
In-Reply-To: <1561121745.5154.37.camel@lca.pw>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 25 Jun 2019 18:16:43 +0200
Message-ID: <CAG_fn=WuEL0ZGdmy3fhY9gW-nBw_qG9_yb3Ut1+17By3h=d0Jg@mail.gmail.com>
Subject: Re: [PATCH -next] slub: play init_on_free=1 well with SLAB_RED_ZONE
To:     Qian Cai <cai@lca.pw>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 2:55 PM Qian Cai <cai@lca.pw> wrote:
>
> On Thu, 2019-06-20 at 18:19 -0700, Kees Cook wrote:
> > On Thu, Jun 20, 2019 at 06:14:33PM -0700, Kees Cook wrote:
> > > On Thu, Jun 20, 2019 at 03:28:01PM -0400, Qian Cai wrote:
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index a384228ff6d3..787971d4fa36 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -1437,7 +1437,7 @@ static inline bool slab_free_freelist_hook(st=
ruct
> > > > kmem_cache *s,
> > > >           do {
> > > >                   object =3D next;
> > > >                   next =3D get_freepointer(s, object);
> > > > -                 memset(object, 0, s->size);
> > > > +                 memset(object, 0, s->object_size);
> > >
> > > I think this should be more dynamic -- we _do_ want to wipe all
> > > of object_size in the case where it's just alignment and padding
> > > adjustments. If redzones are enabled, let's remove that portion only.
> >
> > (Sorry, I meant: all of object's "size", not object_size.)
> >
>
> I suppose Alexander is going to revise the series anyway, so he can proba=
bly
> take care of the issue here in the new version as well. Something like th=
is,
>
> memset(object, 0, s->object_size);
> memset(object, 0, s->size - s->inuse);
Looks like we also need to account for the redzone size. I'm testing
the fix right now.


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
