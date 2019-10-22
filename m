Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A80CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD220679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSrwysvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfJVRWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:22:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731730AbfJVRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571764943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYe7sXZbkW6x0+4z45DRiC8jJviu2jpg3kuxyxWl3ng=;
        b=KSrwysvhmEKzaleMyo/ZP3JSUxdJUaFIcHqcev1I/bJAcU/Rn98TcjTdztwvm4tcgb8qgs
        zjWKkJUBn2m/4vLrmB0y333PQ2rcr8N5FqZxqJI2KC+QM1DE3AMLGAu8a6q6KGUqTzkgJV
        /yB46Fn+SwIQA8LvXUaIw9Y4zu55bwU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-vt7zFo_1Ol2CweukfxJpXg-1; Tue, 22 Oct 2019 13:22:22 -0400
Received: by mail-qk1-f200.google.com with SMTP id v143so17274807qka.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=aPRxFMkNB6srnlFX1YYoFjkf1pH9LbIq1Eh01At/K7g=;
        b=LwY0XLSh0nQ4ghFb0zTANWHZ7H47kpymH9tmPkzZv1EWsalgW/BXMU6Srp7bVGNFKF
         tCjOXDR+8fV4B/UWrwNJ6gIC6uhd/mxK1zfEeOwjQrZrKfmVRbfO6rlP0ARnMnHCkAbj
         rJwexeBQyxKZVoTiNs0oS2lDd3BQup0/ojXuPb90a74bX/2hjKjaII3sY6xHAnbtzeCh
         7UpU1Lfypn2546WlNYYupKu05xDGr5waNP9MUous/bihyX7NHYB4/9c+O70LRv6MYjRJ
         PHLXNnCepeip7QM75gwhW46Uk2Tv8RQzQa8sMSmwLA0To0HnjPCmOREhNvWXX+/FvGZZ
         Wpsw==
X-Gm-Message-State: APjAAAWqRHbmMBEsJ+Oy51HcvrvAD11GhmbkMA/zhcrdFfqHouCzbzKB
        RE+rRBX9thskDUSSG3hr2n2b+MoVq3G4mirUs2FE0qg5lHjIV7JKWv7cqT1/rtYssvVfs5wAanE
        isQPx9Sr60uoYUUMJWOZPRoCr
X-Received: by 2002:a05:6214:2a4:: with SMTP id m4mr63219qvv.165.1571764942124;
        Tue, 22 Oct 2019 10:22:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5uvybGj0e1kNUfWhUC24F1OoT5sVrZih1f+cM/euoSjPZxd6/saXn/ubK0+Vz/yya6hB0mw==
X-Received: by 2002:a05:6214:2a4:: with SMTP id m4mr63188qvv.165.1571764941783;
        Tue, 22 Oct 2019 10:22:21 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id 81sm12662041qkd.73.2019.10.22.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:22:21 -0700 (PDT)
Message-ID: <f1043a5f770b290b02e17b3114d80ce7f83a58a1.camel@redhat.com>
Subject: Re: [RFC] kasan: include the hashed pointer for an object's location
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 22 Oct 2019 13:22:19 -0400
In-Reply-To: <CACT4Y+YQf-aje4jqSMop24af_GO8G_oPMfrJ9B7oo5_EudwHow@mail.gmail.com>
References: <20191022021810.3216-1-lyude@redhat.com>
         <CACT4Y+YQf-aje4jqSMop24af_GO8G_oPMfrJ9B7oo5_EudwHow@mail.gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: vt7zFo_1Ol2CweukfxJpXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-22 at 04:27 +0200, Dmitry Vyukov wrote:
> On Tue, Oct 22, 2019 at 4:19 AM Lyude Paul <lyude@redhat.com> wrote:
> > The vast majority of the kernel that needs to print out pointers as a
> > way to keep track of a specific object in the kernel for debugging
> > purposes does so using hashed pointers, since these are "good enough".
> > Ironically, the one place we don't do this is within kasan. While
> > simply printing a hashed version of where an out of bounds memory acces=
s
> > occurred isn't too useful, printing out the hashed address of the objec=
t
> > in question usually is since that's the format most of the kernel is
> > likely to be using in debugging output.
> >=20
> > Of course this isn't perfect though-having the object's originating
> > address doesn't help users at all that need to do things like printing
> > the address of a struct which is embedded within another struct, but
> > it's certainly better then not printing any hashed addresses. And users
> > which need to handle less trivial cases like that can simply fall back
> > to careful usage of %px.
> >=20
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: kasan-dev@googlegroups.com
> > ---
> >  mm/kasan/report.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 621782100eaa..0a5663fee1f7 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -128,8 +128,9 @@ static void describe_object_addr(struct kmem_cache
> > *cache, void *object,
> >         int rel_bytes;
> >=20
> >         pr_err("The buggy address belongs to the object at %px\n"
> > -              " which belongs to the cache %s of size %d\n",
> > -               object, cache->name, cache->object_size);
> > +              " (aka %p) which belongs to the cache\n"
> > +              " %s of size %d\n",
> > +              object, object, cache->name, cache->object_size);
>=20
> Hi Lyude,
>=20
> This only prints hashed address for heap objects, but
> print_address_description() has 4 different code paths for different
> types of addresses (heap, global, stack, page). Plus there is a case
> for address without shadow.
> Should we print the hashed address at least for all cases in
> print_address_description()?

Yep-this is probably a good idea. Will send a respin in a little bit
>=20
>=20
> >         if (!addr)
> >                 return;
> > --
> > 2.21.0
> >=20
--=20
Cheers,
=09Lyude Paul

