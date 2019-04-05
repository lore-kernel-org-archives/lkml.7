Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86797C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D7A21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYVGZvUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDEWMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:12:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39041 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDEWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so910013otb.6;
        Fri, 05 Apr 2019 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Cdv3udnHTbwrtk9vqEb69MgsYgkHtzDeDmyyoDKTZg=;
        b=mYVGZvUPhp+bI21EMynGSP67s8HjwnHaEj8QWtKZH3zKRrwWnBJYQ+34nNk9HspsF5
         CRfo2DDYD96K8ImZ8+RVoHIWW3bw9NLYAstAOQ9TfVpgraVfb2xtsccwp4IErOXG1Kag
         40kc49y++0whSon6Meu0kjupEuoU82QQcNg8e6qg1jNabX5c8Uh+GvO+YxlORQxISgL1
         jN45P8wgVIoU3icYBhFW3Y3VPmSpBmKMJ+4U4xoXHWJLlUBUcX/Vi7e2HOS3Y9oLVaua
         S/4zGpP/rwhJGIW/yJnXgCg4mE/4u4sFAsRD11WHjZy7fLjzgcl/W4YPH4mDrq5g4myE
         9gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Cdv3udnHTbwrtk9vqEb69MgsYgkHtzDeDmyyoDKTZg=;
        b=MbDvdUM4wBOyTIubeoCwu77f21LgT2C9vEwQWwq6d7MhrXaJnXTtSBLUhtmJCR8c3J
         /SGUKStcnXo9m4jgMNzEsEj5m4s6bqtfnnk9GmVjWPO/PfZOjVNTFts1nBoxY1sHagVC
         6v/wQDXaTjWITN1V1HNgxyqqjQMo91zcuOAhJ4LrY12AIntT1DAu3wn/Rp+/EQS7BH5f
         vyeO+GB9HFDVMSET6CjPaSaZ1bsd7jh3L42hYkz+/PJnczE+mYgx6PiPeyoTnVOUYq7W
         CHwVI7H02GIskFSirlGKipKjmdy8S64ukwu3QERkK6oBRWheWtrasm5yzLhjEP/Abqyo
         3LlA==
X-Gm-Message-State: APjAAAXm7EgV4JZtTcMKgrRu/0NfC6T6fsBTM5v7gtLixPfE2x4O0l8D
        rreTr/F3SwaAP31ZcXZlM0DHtvBOTlJkdHilwX4=
X-Google-Smtp-Source: APXvYqwuDUvPNAPYZpk9BPpkCPkqXJhfjn6T7TIihrjVcahtd9OqyGWRl5cnUO13FkeWyxC0EnNdl2Rt+ZgFy5A7o6k=
X-Received: by 2002:a05:6830:10c5:: with SMTP id z5mr10371161oto.107.1554502338956;
 Fri, 05 Apr 2019 15:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-8-tomli@tomli.me>
 <20190331190801.hxl57om56jskku5s@debian> <20190401174103.GF15736@localhost.localdomain>
 <CGME20190402211010epcas2p3721fd8da621ee64c2b1a373d41cc89e7@epcas2p3.samsung.com>
 <CADVatmPtQAfSC=UkYWHKUx98JK=PMcSZB29ULeQKTBLD9iPnkw@mail.gmail.com> <9c99beba-813d-e82a-6ce5-fd1ffec45022@samsung.com>
In-Reply-To: <9c99beba-813d-e82a-6ce5-fd1ffec45022@samsung.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 5 Apr 2019 23:11:42 +0100
Message-ID: <CADVatmMH+cLTCeQDbeR-K_sLFTbE6y_FwwF5B8Fnom7jLuQdhA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Tom Li <tomli@tomli.me>, Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LFBDEV <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 2:53 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 04/02/2019 11:09 PM, Sudip Mukherjee wrote:
> > On Mon, Apr 1, 2019 at 6:41 PM Tom Li <tomli@tomli.me> wrote:
> >>
> >> On Sun, Mar 31, 2019 at 08:08:01PM +0100, Sudip Mukherjee wrote:
> >>> Technically I donot have any problem with this, you seem to know more
> >>> about SM712 than I know. But Teddy Wang is also an existing maintainer
> >>> and I think there should be an ack from him before this is accepted.
> >>
> >> Okay, I'll write a personal mail to Teddy. I think it could be a separate
> >> patch to allow more time for communication, but the problem is that, if
>
> The first version of the patchset was posted on 2nd February and
> Teddy was on Cc:. Unless there is an explicit NACK (with valid
> rationale) from him lets assume that he is fine with having another
> co-maintainer.
>
> >> the MAINTAINERS and the new changes are not merged at the same time, users
> >> who have problems may unable to see my name and E-mail address for reporting
> >> problems.
> >
> > git will not forget that you have done the changes. :)
> > So anyone who has a problem only needs to do a "git blame" to see who
> > has done it and the user will get your name and email to contact you.
> > If that is the only reason you think your name is added as a
>
> The original patch description suggests that there is more than
> that:
>
> "I have working on the sm712fb driver for a while and have some
> familiarity with this hardware, I'll be helping working on and
> testing problems of this driver, so add myself to the MAINTAINERS
> file."
>
> > maintainer then I guess that is not a valid concern and then in that
> > case I am not seeing any need to add your name in maintainer.
> >
> > Bartlomiej can you advise please.
>
> 2D acceleration seems to be an important contribution to the driver
> (functionality wise and code wise -> it grows the driver source code
> by ~25%) and it shows that Yifeng knows the driver well.
>
> He has also access to SM720 (you have SM712 only) to verify potential
> issues with the future driver changes (I assume that he don't mind
> getting Cc:ed on all driver related patches, not that there should be
> much of them).


Agreed with all the points.


-- 
Regards
Sudip
