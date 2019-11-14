Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F118220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RcNSGWc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNTaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:30:02 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36687 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:30:01 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so6419882ilc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9I8Z4v8szG7Sk2RVim/tFozyJuElI2LAeZNFm3LQmo=;
        b=RcNSGWc9oIJ3wGGS7RicxqKlvRj2R4x+H9oboiSA1Cm0mBhmMmbgDqCWPxJChGth66
         ZFUKlnwNVHNplfw2KPwNZwhaYLIz5AGb92S2fHN2dV8xXaZTXPgKd4i/kLeZYKG9Gmsg
         838ibPi+oAkSKBSx2tsHkIl99sh6cUwcmQpco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9I8Z4v8szG7Sk2RVim/tFozyJuElI2LAeZNFm3LQmo=;
        b=QCFJSAVLCPLpQcM6s3P/RiTRiK4lDu/WT1Mhne8ZWrWFXlCygKL49UvL9jbGMXUZRL
         mCZblswnRLah9uqutBtSesrGU+7+93AAtaQGztcXlkymrX58QkGqrXcsDmGz174MMjC8
         QaNhKacurTzusLOhLxe6VRelo03u39HZD5eRrcsSVRVxKCXRQ2QAhAYRKKoSpUUP/+TO
         fXo90NfggThx5nNENFWPjGS0G96pGi+EZ42U2KWWAJmY26rNUUQOIfTcfecCxfgU/zkF
         nyUMa80h3Tcrih/LsBRwfPspvyx1Vvpn9FxmbbAfx69dztc1XhwNYFeMxVCNurcsT4JE
         iV4g==
X-Gm-Message-State: APjAAAUNwa8vR52icWYdrlon8n/mtPqFuQzczNjWNlrzFdYcuWw/k8Du
        a1qPc6wDZtsDICoj65tG7bZDy++KHE8=
X-Google-Smtp-Source: APXvYqwiGIy9Ai0m4WZsseUkb0hNGoWfmuyHRUfmk0KhOOQ6nHBn18Vt31k013qMZMRUt/04T3PE/A==
X-Received: by 2002:a92:9c16:: with SMTP id h22mr11403124ili.67.1573759800611;
        Thu, 14 Nov 2019 11:30:00 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id y5sm896893ilk.83.2019.11.14.11.29.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 11:29:59 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id p6so6425133ilp.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:29:59 -0800 (PST)
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr12281795ili.269.1573759799235;
 Thu, 14 Nov 2019 11:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
 <20191112230944.48716-5-abhishekpandit@chromium.org> <CAD=FV=UfGDAtePrDmsEsdCNsHQZwDkU8z6E=qzSu=opht7evpQ@mail.gmail.com>
 <CANFp7mWT2GwkSEcE5SkxRnfOebHq2aYLoLh6dmCZ-HktUe+mYQ@mail.gmail.com>
In-Reply-To: <CANFp7mWT2GwkSEcE5SkxRnfOebHq2aYLoLh6dmCZ-HktUe+mYQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Nov 2019 11:29:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XPK9YHBCRWnksgeqPQ3v8Tmm413oie-x6ESzpTFtezqQ@mail.gmail.com>
Message-ID: <CAD=FV=XPK9YHBCRWnksgeqPQ3v8Tmm413oie-x6ESzpTFtezqQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: net: broadcom-bluetooth: Add pcm config
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 14, 2019 at 11:20 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> > >  Example:
> > > @@ -40,5 +45,11 @@ Example:
> > >         bluetooth {
> > >                 compatible = "brcm,bcm43438-bt";
> > >                 max-speed = <921600>;
> > > +
> > > +               brcm,bt-sco-routing = [01];
> > > +               brcm,pcm-interface-rate = [02];
> > > +               brcm,pcm-frame-type = [00];
> > > +               brcm,pcm-sync-mode = [01];
> > > +               brcm,pcm-clock-mode = [01];
> >
> > I'm at least marginally curious why your example has a leading 0 for
> > all numbers.  It makes me think you intend them to be represented in
> > octal, though I don't know offhand if dtc uses that format for octal.
> > I guess it doesn't matter since all your numbers are between 0 and 5,
> > but it does seem strange.
>
> It's a bytestring with a length of 1. See bytestrings under
> https://devicetree-specification.readthedocs.io/en/latest/source-language.html#node-and-property-definitions

Oh, right!  ...except that now it's just one value and not an array of
values, just make it a normal number.  Don't worry about the fact that
it'll take up 4 bytes instead of 1--it's clearer for it to just be a
normal number.

...I would also note that the definition of the properties talks
nothing about them being a bytestring.  ;-)

-Doug
