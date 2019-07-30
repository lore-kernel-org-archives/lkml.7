Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D86C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6420693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhKXb4Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfG3QAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:00:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45798 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfG3QAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:00:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so62524927lje.12;
        Tue, 30 Jul 2019 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbWP76mrhorJU5Gh42fiL/ClcaJsatH+/BvxqeOmpoo=;
        b=hhKXb4VbvWawrVLus06feXu5xMqfwssq2twQz4cKGdYaiRbVbenv6hWl6Pqdok8GOP
         cozW8PrNTLsuxjp8+E11PWJ75cPVTy22NNq3xlAyW+HBLdDXda/c/4ygemrH++iQZZBx
         6IPUT5qjjOBLh+D9TFtoiVQ1Vm+R6wc1IMx+bdaob/IKG/qucWZ+Alm2xxFcX5KOah65
         EELKjTF0A/rU/VLuPggyU5lRrKsXXxB8xTqIgTGll37n7jvvLuMS8yMP6xqs27gYUpaQ
         VEEHDHdwfLPlwCBhw09jTokIpnrWz8ME8SUpSFeTbFw8/FA0BfQBPzPyI5uBiNHjKwOb
         bEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbWP76mrhorJU5Gh42fiL/ClcaJsatH+/BvxqeOmpoo=;
        b=IpAyN5qhgj2/gUw7G4jHawaaeiWA+WBAMxmnUr/9KIYAP1ZlVfBxBUM5jpQwp8LlfY
         EA7lRCcDDThDfxmR9sNbUW5oQHGRDOqkve40DAp6ayvMQ/qPPaMJaMdGoom1PZn417Gj
         onC+npYIrclq2DgJDTQlBZpmGygeivxWqbnTGwZCx7yh2OPt7yQGFFza0AuZDH3a3EUr
         fEGwWX16bYp/8dyjAA3K7pIGlYLGT87MBZDZyppfCTjUHfLnmlvGYhFP4vZBsECjlOt1
         ZOS9egcNr+SXisS12RkAqK4LYErttVP9vxpKLBF5FNmW+1vDReAcfQURpl/W/wUnfGoL
         m1KQ==
X-Gm-Message-State: APjAAAW9nWnhiNpKJ3mKF7KTZKMxp6u13gFbRJ+T0OfpEHNIfkcnqMW5
        94B8ohXYrESeDQBzDxlwqAd0d45UIkqJZxZCC0I=
X-Google-Smtp-Source: APXvYqwoKwtYKco8BUfXu3fhhNLfUigpTR6OWIi4WPXK91dIOZ1Vmb9tPgwn8TOXDGj96mjfoE6Mhw4lIdCqQyDzD5s=
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr61634312lje.240.1564502399982;
 Tue, 30 Jul 2019 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190730150552.24927-1-lukma@denx.de> <CAOMZO5AxPHHobQQhq30fjLVeSroLdvdT0+GqCWi8it1ejhDONA@mail.gmail.com>
 <20190730175336.382d833c@jawa>
In-Reply-To: <20190730175336.382d833c@jawa>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 13:01:19 -0300
Message-ID: <CAOMZO5AoSCDCMRKpkWQ=0PwiFG-O9doGaA31FRhDCGmNr7Xefg@mail.gmail.com>
Subject: Re: [PATCH] ARM: DTS: vybrid: Update qspi node description for VF610
 BK4 board
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, Jul 30, 2019 at 12:53 PM Lukasz Majewski <lukma@denx.de> wrote:

> Shall I refer to the original commit (which added this DTS)? Or the
> original issue posted to linux-mtd [1] ?

You can add a Fixes tag like this:

Fixes: a67d2c52a82f ("ARM: dts: Add support for Liebherr's BK4 device
(vf610 based)")
