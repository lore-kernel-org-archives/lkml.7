Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0903BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C438320721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QkH5cjkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgAIP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:26:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37172 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgAIP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:26:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so5488026lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r1uJPrM0722ZAZdZD1u7i67ETXd5iMwmhJ8SByCEg8Q=;
        b=QkH5cjkVO7FpbMG2bfUzb8x1AZjOT2LDKNRt1iYpstFP8gUzLBKRESPSqn/ha9K9rR
         JOSETySTRT7ryhQi3ZyUyl/JvGTJaNae2voy1zpGnB3o6hh1/PpcvaYKOjA46WUwRyJf
         taHKHJmA7H9yiuOKeBphYdCm9VfSw8XtLWj9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r1uJPrM0722ZAZdZD1u7i67ETXd5iMwmhJ8SByCEg8Q=;
        b=tJHYDVmzskzRK8cBMqa/AMJc9Ift0prI8mUzKycE3+nzS8NLViEmKv6UO4JfXYObop
         EPtHqds+Q79Rg5E4fs81WdNCzteEe3Qvb2Gh7xagjahV/o8d8wpc8vyf4sDRfqu/4V1e
         t+jFxDd5TOzt5Ifgy/46ZZWVRirt6X39PpSm5HGCwYZ+aEpcSjDu9xl4xphmBf/ZT9sf
         xGWcV/oZC5BVnTePUVxmaueBjq/FA4C1WEBsC6/8z6jmpKVQ9AT/izauz/B1rEswRhse
         YVFn+M5vSDh1rRZg9Gip+MxzaVHM3dCfqeYE95B4jx7K3diKG9AyQFtThy0XjB2elI+c
         OI8Q==
X-Gm-Message-State: APjAAAVMjuu665fRCfZFjsTkYotOaGmrauhjl/1Jl6HGRuxYMByySWzL
        awIYXnf4i4tyq4nO/NFpdE3qVh9+RMHiQxOGC/we9Q==
X-Google-Smtp-Source: APXvYqwwOamAUbWQafZjbxgWWXcTW3PPbJ8ulX5mxUsqtl+iH4nMzWdI4AcYLvYxseXTYeLufsUD7OEGLwm6EDxW1pc=
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr6511455lfq.176.1578583595493;
 Thu, 09 Jan 2020 07:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20191021193343.41320-1-kdasu.kdev@gmail.com> <20191105200344.1e8c3eab@xps13>
 <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at> <20200109160352.6080e1e5@xps13>
In-Reply-To: <20200109160352.6080e1e5@xps13>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Thu, 9 Jan 2020 10:25:59 -0500
Message-ID: <CAKekbeucdjZgttQfHeiXH6S92He2qkKGsQcEqz_4_okHzDK16A@mail.gmail.com>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel,

Yes the issue is still open. I was trying to understand the suggestion
and did not get a reply on the question I had

Richard wrote :
"So the right fix would be setting the parent's oops_panic_write in
mtd_panic_write().
Then we don't have to touch mtdpart.c"

How do I get access to the parts parent in the core ?. Maybe I am
missing something.

Kamal

On Thu, Jan 9, 2020 at 10:03 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hello,
>
> Richard Weinberger <richard@nod.at> wrote on Wed, 6 Nov 2019 00:03:42
> +0100 (CET):
>
> > ----- Urspr=C3=BCngliche Mail -----
> > > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > > An: "Kamal Dasu" <kdasu.kdev@gmail.com>
> > > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "bcm-kernel-feedback=
-list" <bcm-kernel-feedback-list@broadcom.com>,
> > > "linux-kernel" <linux-kernel@vger.kernel.org>, "David Woodhouse" <dwm=
w2@infradead.org>, "Brian Norris"
> > > <computersforpeace@gmail.com>, "Marek Vasut" <marek.vasut@gmail.com>,=
 "richard" <richard@nod.at>, "Vignesh Raghavendra"
> > > <vigneshr@ti.com>
> > > Gesendet: Dienstag, 5. November 2019 20:03:44
> > > Betreff: Re: [PATCH] mtd: set mtd partition panic write flag
> >
> > > Hi Kamal,
> > >
> > > Richard, something to look into below :)
> >
> > I'm still recovering from a bad cold. So my brain is not fully working =
;)
> >
> > > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 21 Oct 2019 15:32:52
> > > -0400:
> > >
> > >> Check mtd panic write flag and set the mtd partition panic
> > >> write flag so that low level drivers can use it to take
> > >> required action to ensure oops data gets written to assigned
> > >> mtd partition.
> > >
> > > I feel there is something wrong with the current implementation
> > > regarding partitions but I am not sure this is the right fix. Is this
> > > something you detected with some kind of static checker or did you
> > > actually experience an issue?
> > >
> > > In the commit log you say "check mtd (I suppose you mean the
> > > master) panic write flag and set the mtd partition panic write flag"
> > > which makes sense, but in reality my understanding is that you do the
> > > opposite: you check mtd->oops_panic_write which is the partitions'
> > > structure, and set part->parent->oops_panic_write which is the master=
's
> > > flag.
> >
> > IIUC the problem happens when you run mtdoops on a mtd partition.
> > The the flag is only set for the partition instead for the master.
> >
> > So the right fix would be setting the parent's oops_panic_write in
> > mtd_panic_write().
> > Then we don't have to touch mtdpart.c
> >
>
> This issue is still open, right? Kamal can you send an updated version?
>
>
> Thanks,
> Miqu=C3=A8l
