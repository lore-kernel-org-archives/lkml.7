Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A0C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E483204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg7QIORM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHBPKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:10:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40125 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHBPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:10:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so72646209eds.7;
        Fri, 02 Aug 2019 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XeZdACcLsfRamGTD+0ui/3XFAY1UUrho8HNdY4Rv0tE=;
        b=dg7QIORMgbnys+sXltzvNGkxyJMd8mOTaIgtojDmJ5RuN7VgwYYPXTSZJvCGrtQGy2
         VfIlIT6ItQ/8ELE0EEepDt6yj2FY1YF2jT0k3YxF3cON6pS9kZ+DvTPb08Ti+YzKuFSM
         7LnTwRp0qh7lSeh3nmRJHwtJX1EQRdz4oJhDC3iXk9hNIYnDp9iyO3tMLgy4F0Qc1Geu
         ntpLQ/HQnWCsk7jQnyHyUZdHZ2sSWOKY06USYW6W+lvmQ9LKRFScNWTG0Bf1m9T0YgLO
         UEAmf/JE01tsDoC3qGFykarEltjBY5dphLnqH2WJaxa9w+0qghAbvDMsUpNiMxOTWL6D
         fl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XeZdACcLsfRamGTD+0ui/3XFAY1UUrho8HNdY4Rv0tE=;
        b=cn5Fh+PxWwas/Ep5/s5nIiMXITfHXPVMvZ46FW+i8+1qohVQ+FwFfHREUM8wf1eRGg
         ScpIrDnId5nhUvxAqp2wEDlm6JQynvcRztoR19CP75DytnHnEojbGbFeoP+Vwe+EKls0
         gmGDjZcOfC2k3NTs3kVv4s7lFX5flPvGPnTDFIA/krINh57QtQW9b8ei5qSSRws22WN0
         vd4RrluuXpB/gGyHCr7Zru5W6hf4oqI17LfwMyyGm6PkeJDXUptPZPUG3WmGguJ+ioaj
         5EMpnpgf6Qxev3Ag3r0s/fAUMkEAu81V1HKpDCv4x2zUirrVRJ/W8cdeDlLvpMemiK9X
         5AOg==
X-Gm-Message-State: APjAAAXUOVi2mioj4VWWxKQPtQ/XD2CRVPP6JutvhGBBN1yeNQmrLchs
        bth+Whh5KgIvO56g5VN1BHzBdHyOaaDUKbXsjhw=
X-Google-Smtp-Source: APXvYqyK40SUeClnUHk6JAONwLoqSLsnGxGS47N9L2gWHfz2JkgGUyeaF0bcnPuaCRdhOjOkqko2qtAeL/efxI/u81U=
X-Received: by 2002:a50:b66f:: with SMTP id c44mr119857205ede.171.1564758650295;
 Fri, 02 Aug 2019 08:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190802083541.12602-1-hslester96@gmail.com> <CA+FuTSc8WBx2PCUhn-sLtYHQR-OROXm2pUN9SDj7P-Bd8432UQ@mail.gmail.com>
 <CANhBUQ2TRr4RuSmjaRYPXHZpVw_-2awXvWNjjdvV_z1yoGdkXA@mail.gmail.com> <CAF=yD-+3tzufyOnK4suJnovrhX_=4sPqWOsjOcETGG3cA9+MdA@mail.gmail.com>
In-Reply-To: <CAF=yD-+3tzufyOnK4suJnovrhX_=4sPqWOsjOcETGG3cA9+MdA@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 2 Aug 2019 23:10:39 +0800
Message-ID: <CANhBUQ2C3OfkC6qDL9=hhXq=C-OMHUwaL7EaMbagVRTt=rc00A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cxgb4: sched: Use refcount_t for refcount
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2019=E5=B9=B48=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:53=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Fri, Aug 2, 2019 at 10:27 AM Chuhong Yuan <hslester96@gmail.com> wrote=
:
> >
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2019=E5=B9=
=B48=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:40=E5=86=99=
=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Aug 2, 2019 at 4:36 AM Chuhong Yuan <hslester96@gmail.com> wr=
ote:
> > > >
> > > > refcount_t is better for reference counters since its
> > > > implementation can prevent overflows.
> > > > So convert atomic_t ref counters to refcount_t.
> > > >
> > > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Convert refcount from 0-base to 1-base.
> > >
> > > This changes the initial value from 0 to 1, but does not change the
> > > release condition. So this introduces an accounting bug?
> >
> > I have noticed this problem and have checked other files which use refc=
ount_t.
> > I find although the refcounts are 1-based, they still use
> > refcount_dec_and_test()
> > to check whether the resource should be released.
> > One example is drivers/char/mspec.c.
> > Therefore I think this is okay and do not change the release condition.
>
> Indeed it is fine to use refcount_t with a model where the initial
> allocation already accounts for the first reference and thus
> initializes with refcount_set(.., 1).
>
> But it is not correct to just change a previously zero initialization
> to one. As now an extra refcount_dec will be needed to release state.
> But the rest of the code has not changed, so this extra decrement will
> not happen.
>
> For a correct conversion, see for instance commits
>
>   commit db5bce32fbe19f0c7482fb5a40a33178bbe7b11b
>   net: prepare (struct ubuf_info)->refcnt conversion
>
> and
>
>   commit c1d1b437816f0afa99202be3cb650c9d174667bc
>   net: convert (struct ubuf_info)->refcnt to refcount_t
>
> The second makes a search-and-replace style API change like your
> patches (though also notice the additional required #include).
>

Thanks for your examples!
I will fix the #include in those no base changed patches.

> But the other patch is needed first to change both the initial
> atomic_set *and* at least one atomic_inc, to maintain the same
> reference count over the object's lifetime.
>
> That change requires understanding of the object's lifecycle, so I
> suggest only making those changes when aware of that whole data path.

I think I had better focus on the 1-based cases first.
