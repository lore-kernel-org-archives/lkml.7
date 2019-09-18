Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A4C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17F0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFYeROA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfIRHRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:17:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41068 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIRHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:17:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so3758253pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5rx1DuXZfGgKinG2MFWUdyT0o9wzkIrbhzDAvs2r9s=;
        b=cFYeROA04xpWpcArEgAVMKRQHegH+4glKQBS9W8PzJjUNtZwR8ExhUuC6y7lzX6y2o
         fevCdpgV+tTeJYYZyFYk/d1j1Copbyq06fqc+nDAFYXsRS4Xsgprl3vEfCE/euXCDsnR
         IbtDi3tjQuAlA6RYBo6u4uZ37tu0pGwpUIPb8LhN9FgAdVXXsRhZS628ZxeqLsuQ3Hl2
         9ZUJKIJA3OzmsqDKO76Fi5GXhm0MoLE0ybNJdwNkeNOVLubCEsvzW9J+fVsfiR3ddR9u
         gXvyP+l0Y2GwWvqJIuBGRNNwINmc3j5EwVC0jFyElXJ14s+NmPerubEayFS4iebkNlgg
         SiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5rx1DuXZfGgKinG2MFWUdyT0o9wzkIrbhzDAvs2r9s=;
        b=kq11AW0vzC8Vl08hgrH/SiJxcX7aCX0gnWPItIdD0YEd0chjh/ax+CJjnQcZsqhCtW
         viGQz2MPRV+mbL7wPmjfvCh8Hxbck2GmPxPvVhEv3QHagOKS7Zkv7qqM3ODbXJ3kktB7
         eIPknsaSBUFeImRE4prchY/wudbWwMDwK1u0InWZocDq+xqBWjQE9roKSkjxjhofmp/j
         BJmayS656G7fHNeXmKq9rc57lL2xQsygLnhOsR/l+8yMfmPRb3uvERMfdy2c6O6/e9Lu
         TsmLpCxFcRxxGA8zBMZiEP0epxqqevkYgM35FWZxsZmZaNmpCGQOhaostfTFoiGAQmMr
         F63g==
X-Gm-Message-State: APjAAAWqHs6UhVny9TdNFQqy/vrtzHLuv47axgJxDalu7o2tkqbNQPFp
        mtqXCOmSweXttzV2q7IJ/TSrRVIv41LBloScl2s=
X-Google-Smtp-Source: APXvYqzWOyHi+F/N6aCOnYVhBlCm5YF1Y6pS7QzSnBSLqrb5zc8fpOL9EfMeEgJrayXPmiERdcjW/zZxtROkxliAblw=
X-Received: by 2002:aa7:811a:: with SMTP id b26mr2668049pfi.151.1568791033505;
 Wed, 18 Sep 2019 00:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211536.29646-1-jekhor@gmail.com> <20190916211536.29646-2-jekhor@gmail.com>
 <20190917111322.GD2680@smile.fi.intel.com> <20190917132547.GA4226@jeknote.loshitsa1.net>
In-Reply-To: <20190917132547.GA4226@jeknote.loshitsa1.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Sep 2019 10:17:01 +0300
Message-ID: <CAHp75VeRBW4W0vEr+KZzdJWMf5ANQP_LEAXXK8SPC8BC+97Yyg@mail.gmail.com>
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 2:04 AM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> On Tue, Sep 17, 2019 at 02:13:22PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 17, 2019 at 12:15:36AM +0300, Yauhen Kharuzhy wrote:
> > > Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> > > PMIC at driver probing for further charger detection. This causes reset of
> > > USB data sessions and removing all devices from bus. If system was
> > > booted from Live CD or USB dongle, this makes system unusable.
> > >
> > > Check if USB ID pin is floating and re-route data lines in this case
> > > only, don't touch otherwise.
> >
> > > +   ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> > > +   if (ret) {
> > > +           dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> > > +           goto disable_sw_control;
> > > +   }
> > > +
> > > +   id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> >
> > We have second implementation of this. Would it make sense to split to some
> > helper?
>
> Do you mean the combination of regmap_read(...CHT_WC_PWRSRC_STS,
> &pwrsrc_sts) with cht_wc_extcon_get_id()?

Yes.

> In the cht_wc_extcon_pwrsrc_event() function the pwrsrc_sts is checked
> for other bits also, so separation of PWRSRC_STS read and id calculation
> to one routine will cause non-clear function calls like as
> get_powersrc_and_check_id(..., &powersrc_sts, &id) which is not looks
> better than current code duplication.

I see. Thanks for answer.

> Or we need to spend some time for
> refactoring and testing of cht_wc_extcon_pwrsrc_event() code.

Perhaps, In any case I'm not objecting of the current approach.

-- 
With Best Regards,
Andy Shevchenko
