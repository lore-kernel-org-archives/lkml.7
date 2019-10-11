Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6181C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF272190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsY32sCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfJKIqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:46:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbfJKIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570783570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYPIO03shV+P+sxqA/4qvsSAkBuzvgJfmGU8SjoHytI=;
        b=gsY32sCs84n/Ob5++x6zz4xUoREmUjlR/b/5ZCAcgrwJRu0Hw2ANnrCmM/80t3qLcE7nv/
        Py/EF1/PcVjrj6dQGXuo8Q7XcfnaEIHSAp/1m4Q8PgoaLRT+6uoSTujT/32Eb0Qyc3BNzn
        t8mhiMjzIu4yXmE02yOVwTMrMNFfJ0s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-5x3FV8OsPsyyl0mt4cKTnw-1; Fri, 11 Oct 2019 04:46:06 -0400
Received: by mail-qk1-f197.google.com with SMTP id x62so8257089qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VRAZ7diPNl4wX1L2Hk0ypm69MfBO+1cdDDHrGu25L0=;
        b=Go55tm5FW/QC+C0eegZHnV/lil0vPNX5jv46dRIXigojbh47hJoeMNKGkOiKUe6PN/
         ZiYdy4ZmPkM/B67LlrkVQIhDYx7/rLJDbADQI69UH2u/a1L8qkWjwPwPvEroPBGjtYfu
         3I9lcNR/fQk/hTKXJ/Kh7HgJQbQjVDbhQA/vuMc0JdVPrhAV6pyoOA35X7Iy6vYSq2pz
         E+xhY0LpTLtCpd9C71SyvChaWjfOtiqSYlv/MUwd7Myf/qTodpRI7DgRMhRXymvbpg8E
         ma9XBDRb2YBKkydSfngrY/+NQgxQnQhWdrMetFxxUAHuQLNTpz0Fb9DFFLSy4L3kQAvh
         o+NQ==
X-Gm-Message-State: APjAAAUsPH3apy4VQt0JKpH/5xKyB/iNcndzCM+halbnbF7U3EQmg0J9
        AqBz7rcYhYPttoswcfz1wEI9d90NSPVGmNfw7ywA8tQRH9yYKfTHCxME+5mBiThee6QKSmR3B2V
        3vrvvuVReUDkpLg2x235vhOd3dBl0wNbvCGXMcjxV
X-Received: by 2002:ac8:550d:: with SMTP id j13mr15381830qtq.260.1570783565910;
        Fri, 11 Oct 2019 01:46:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjtfvRG7GFheWo+CweicVfgOPfA0SeN5cp01ikB+VpMf9Zv2sGIFkWi4UJb2ggtweD1FESl/PfyDKU859NFQ4=
X-Received: by 2002:ac8:550d:: with SMTP id j13mr15381812qtq.260.1570783565674;
 Fri, 11 Oct 2019 01:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <jCmT1QOunDmSu59iO1T1xj2-WfFeGhMn_i5knEWTCoph9VH1oxjpYf3Q6CWH7BRrq1NTVYBsAVJcIgu8azAEmFZJA8PzLfH3bHBcWNbFqeY=@protonmail.com>
 <CAO-hwJ+AMmNUOhas+vq6K4sRcCspyJuAefKO8oomAH4=CDHoJw@mail.gmail.com>
In-Reply-To: <CAO-hwJ+AMmNUOhas+vq6K4sRcCspyJuAefKO8oomAH4=CDHoJw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Oct 2019 10:45:54 +0200
Message-ID: <CAO-hwJLAwodSXpz-_T0nGqnjHY3cVAu9GYjvp8SW8grTXX+VYg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] HID: logitech: Add feature 0x0001: FeatureSet
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
X-MC-Unique: 5x3FV8OsPsyyl0mt4cKTnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:33 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Fri, Oct 11, 2019 at 2:57 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
> >
> > On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com>=
 wrote:
> >
> > > This patch adds support for the 0x0001 (FeatureSet) feature. This fea=
ture
> > > is used to look up the feature ID of a feature index on a device and =
list
> > > the total count of features on the device.
> > >
> > > I also added the hidpp20_get_features function which iterates through=
 all
> > > feature indexes on the device and stores a map of them in features an
> > > hidpp_device struct. This function runs when an HID++ 2.0 device is p=
robed.
> >
> > Changes in the version:
> >  - Renamed hidpp20_featureset_get_feature to
> >    hidpp20_featureset_get_feature_id.
> >
> >  - Re-ordered hidpp20_featureset_get_count and
> >    hidpp20_featureset_get_feature_id based on their command IDs.
> >
> >  - Made feature_count initialize to 0 before running hidpp20_get_featur=
es.
>
> I still need to decide whether or not we need to take this one. We
> historically did not do this to mimic the Windows driver at the time.
> However, the driver is full of quirks that could be detected instead
> of hardcoded thanks to this functions. So we might want to switch to
> auto-detection of those quirks so we can keep 'quirks' for actual
> defects that can't be auto-detected.
>
> But, if we want to go this route, we need to actually make use of it.
> So this patch should be part of a series where we use it, not added by
> its own.
>
> Can you drop it from the series?
> And maybe possibly work on a cleanup of some of the auto detection,
> like the HIDPP_QUIRK_HI_RES_SCROLL_X2121 which you can easily test?
> But this would need to happen in a second series, once this one gets
> merged in.

While reviewing 4/4, I realized why you need this one.
See my comments in 4/4, I still believe the case is not strong enough
to spend some time to enable the feature for barely no gain.

Cheers,
Benjamin

