Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF94ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427F420862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCaLLOHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfJFQsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:48:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44564 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:48:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so5658271pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=TxLT9bpNl4jFVPAGhPpjPn1KDoP3vrxyC3V+3rCVHuM=;
        b=GCaLLOHABMVDzUOh3ZA+xjsSzoVnMe1OSpprvlXKbr3FidW133qVKYOkb5FIceNKPQ
         KHhGro4dl3fmL0QQgtMMhd1SRJuyWdL4b+DvJoTt3w+PgN2TNUg6wKYwvtQljvsSvTX+
         a9JGo1FzYyiUJpewUjM7DGB6A/K63HuuJywazIzk6RwHxuUldu3Z7NftG8FGsWMjylMR
         QD7wgrgxUP2OrnU60tW2CAlbjcUtBPr5N3Op+7EcZrL4s0mcrzwJvlQuoSvl7TFaN1bS
         411vNbPX7EZ9NkFNpKzsRMq5VLeHv+Vw77dlAZnGXIps6/nwZRNi/mO+jjHLTxt450TN
         ++BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=TxLT9bpNl4jFVPAGhPpjPn1KDoP3vrxyC3V+3rCVHuM=;
        b=jPif5b1bwPmIewJFp3OimaNzp7OgLaJKtFDrZgmgAiryA1t/dlcczC1dOPtN8nUfMl
         Kg4AAEp7BGb/4VE30F4D63Wce730T6w94m1TDgbsJtPgVHNeWt8iWJTEbCrg38kQPjCG
         rANuAWM7oktEgiMm7H1ZQp4/+NoYna7Zf2juvWe9AzBFIKHJAbkxkXU3cnV84cpoQRSD
         zb8vEdxQaWW0BPPIGKHr+KZuQyks5A2cWLtpo4CMqIhJaxjCJXZZrG7W9Ob4Jz081RLN
         Olq5bm3BNnZU9Cqhh0KjAcMeADDh4Wh3+BVA14U8vPLh6SWlnM+Hkgz8FYxyaDxi8vVZ
         VHcw==
X-Gm-Message-State: APjAAAV9UM8jBOK3mehqHCYU/d8OSqa+qAiihsaEsi1lo2G2dBb4Vza8
        Mws7ib1Y8N2kHlQ4K+JZo3o=
X-Google-Smtp-Source: APXvYqzmjl+mcprCJRZxez82R7Yc8QkQNXYtyYVkQIbk7eqcboNITANQlLm+Tif+J1GnDnyYzSmYPg==
X-Received: by 2002:a17:902:563:: with SMTP id 90mr24478184plf.13.1570380518616;
        Sun, 06 Oct 2019 09:48:38 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id h2sm20378814pfq.108.2019.10.06.09.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 09:48:37 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Pavel Machek <pavel@denx.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "alex@alexanderweb.de" <alex@alexanderweb.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mat King <mathewk@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: New sysfs interface for privacy screens
Thread-Topic: New sysfs interface for privacy screens
Thread-Index: AXdoTmVTBb+NyICdEDRjYqdq56nWEjUwLjQwZmZpcml2Y2w1MDUyNTEwse7NLzw=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sun, 6 Oct 2019 16:48:31 +0000
Message-ID: <SL2P216MB01055AE2F23BB2546DC93708AA980@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191002094650.3fc06a85@lwn.net>
 <87muei9r7i.fsf@intel.com>
 <20191003102254.dmwl6qimdca3dbrv@holly.lan>
 <20191006110455.GC24605@amd>
In-Reply-To: <20191006110455.GC24605@amd>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 10/6/19, 7:04 AM, Pavel Machek wrote:
>
> Hi!
>
> > > >> I have been looking into adding Linux support for electronic priva=
cy
> > > >> screens which is a feature on some new laptops which is built into=
 the
> > > >> display and allows users to turn it on instead of needing to use a
> > > >> physical privacy filter. In discussions with my colleagues the ide=
a of
> > > >> using either /sys/class/backlight or /sys/class/leds but this new
> > > >> feature does not seem to quite fit into either of those classes.
> > > >
> > > > FWIW, it seems that you're not alone in this; 5.4 got some support =
for
> > > > such screens if I understand things correctly:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D110ea1d833ad
> > >=20
> > > Oh, I didn't realize it got merged already, I thought this was
> > > related...
> > >=20
> > > So we've already replicated the backlight sysfs interface problem for
> > > privacy screens. :(
> >=20
> > I guess... although the Thinkpad code hasn't added any standard
> > interfaces (no other laptop should be placing controls for a privacy
> > screen in /proc/acpi/ibm/... ). Maybe its not too late.
>
> There's new interface for controlling privacyguard... but perhaps we
> need better solution than what went in 5.4. Perhaps it should be
> reconsidered?

I agree with your opinion. I also think that better solution can be conside=
red,
although there is already something in 5.4.

Best regards,
Jingoo Han

>
> Best regards,
>									Pavel
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
