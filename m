Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2360FC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9D02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EHT9JbHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEVEwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:52:01 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:43128 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfEVEwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:52:00 -0400
Received: by mail-vs1-f52.google.com with SMTP id d128so602121vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zM2tRxvUf7NSwKdxRr5bB44PMs0jXxiNemDXs7iz74s=;
        b=EHT9JbHp1/Wa9RK9jVA4OK5kq2Umqvo7DXotXmfDEtVX21PiUHOUZ7autAocu1Z3DI
         6ZRzqyXAzb53gUg4yp/9LcfDmApaECzDSf9bA/g+e11hacYU5wNPzj15Auf5iJplAEtJ
         wZeJSYFMKDpxZEjRnn6nJNQ1Slzdsq0eQQ8ufZoihNbert9VvIhORIZzgty3g3W+bE25
         T3DmsGv84wTy2AsU5rwySyDsgDziJjHHyl+mkLCG9iem3r/ql3ytMZslrTQPrdotdQ7p
         RY9dGGRkvsixSFKzdHePNcTAiXJOMlQXS6jGUd0Y6QcTaO76OQ0naSFaKcI1KonGInxP
         csKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zM2tRxvUf7NSwKdxRr5bB44PMs0jXxiNemDXs7iz74s=;
        b=OA+8tQJlPhdnxto6fml6qAr8zasj33ZF+VtSNyC87jjkTlgstWMVIN0vDBHR754YuA
         8CSavccolGJyfFVNgJFwjZCuAJAmpBEd2MDcQ5zvMeF/lP3Vecp+3qQz/amVk7QnhrnG
         XtrzosOQBUTHP1a0Cv2XDE9eNS1gBlUG4o8qT159nmzHCbmKR8OBjWgE25KJ6zjKunNi
         7M8a5pznSJOkC1l5D6VYjr5fnAgstZHSH/eIdFjric2dS16C39x9ahORaZWdhGBlclNj
         iSQe87EomI/QJVKGgoe0Xl4kR0xe7AaAPdeYjAM9pJd4bfOSj4LhHP5aAQyfPiSnMXE8
         dedQ==
X-Gm-Message-State: APjAAAVE83V6KD5omTmx3PceoOKOYo3HwwnZO1izTwjqKBzR1frzcHP9
        BzZOKaB/GjIkjNj/EF+XnZTUGoEtWPe2mVyldVJhbw==
X-Google-Smtp-Source: APXvYqzzpsKJ4iLQ7BqaYnxLEeUZsLQq9FfHMG3CB4djAfIFwCnnOLRgOAk2mwGbLwgnxYcQMlY4DKeohWMasNEvt+c=
X-Received: by 2002:a05:6102:247:: with SMTP id a7mr16894374vsq.229.1558500719859;
 Tue, 21 May 2019 21:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
 <1558445574-16471-2-git-send-email-sagar.kadam@sifive.com> <20190521135625.GN22024@lunn.ch>
In-Reply-To: <20190521135625.GN22024@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Wed, 22 May 2019 10:21:47 +0530
Message-ID: <CAARK3HmAYjnBH6Aa_R_uKQPs5JAdBAEt1=dvPz1mLmGaKKpP9w@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: i2c: extend existing opencore bindings.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, May 21, 2019 at 7:26 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  Required properties:
> > -- compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> > +- compatible      : "opencores,i2c-ocores",
> > +                 "aeroflexgaisler,i2cmst",
> > +                    "sifive,fu540-c000-i2c","sifive,i2c0".
> > +                 For Opencore based I2C IP block reimplemented in
>
> It looks like there are some tabs vs space issues here.

Ohh. It was not catched in checkpatch.pl. I will update it.

Thanks,
Sagar Kadam


>    Andrew
