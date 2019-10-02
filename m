Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A2FC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AA420700
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYNiWUnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfJBKYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:24:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35391 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfJBKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:24:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so19027439wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+hcgVLMwxs2OkjmvbvoX9zdHxPsFqiVek5U1Sq91Og=;
        b=WYNiWUnrV3gtv/lZGZljpHNjOVvPMo/JfitKNRVoIB3e5+h6TMaXrdudYBeDJeACEh
         Gf6wtVTgc5Rr7LI47jxMg8NGGY4k/W+FstCSBorFGU1NQvGf83wuho34gwbRrnIFukDO
         X1tmnGQWh0oSFYUlYzGH8FhXB3517L921pERboLpQoXOPh3SGk3RskVJ2zS17nK9tcZu
         aeiQuI7c+k3lqFqyrwE9XyC+lWqUHquIbxwLPi0FR8aKgIyL+sNM8xi9GiHpjlGdBMnA
         78XOETjsuQ3p/Hm8EqynB8le6VQTmsccJhusHW4j/424yzkFYo7VYuYzAU/VzCJxzDn8
         SQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+hcgVLMwxs2OkjmvbvoX9zdHxPsFqiVek5U1Sq91Og=;
        b=Pc3rNbLrtVdkW49XqThkGQ7iHLYV3IIlsctlJPN2gDMvNOS17eEQ4Z3cVCXzTRw9lQ
         ErH9dS7xxul1LMt9w7L/ujjLXyezl4nuIpm+bHpUhdzLtkHAmXw3dndujXazKthvetEB
         c5gUNWcV+hQRYG8KrrCap4unSMQoWpO84MiF/aMOYqaZZK7V/QZR02TxZgyhB4QvOZeM
         DZpufVRcfot+k8SBoTMGyXUankhbI7RVFqarALsPFw/1ZcyuTCpchow84lkZCKNOYJpA
         0kLSzLbiV3JrOuxy5bBZy+5cGziSIUEEf0lF6+rgSWVLuJ453MBbWF9NMvJJ9AWNkj3F
         gmFg==
X-Gm-Message-State: APjAAAUtRafRnQsNaElM91btJU98ObUzLVpSRxoVdg8rYpda+es7Sum4
        Fv0ZCywj2leqOANfGnDocHe03Q==
X-Google-Smtp-Source: APXvYqzm4psWhT/qwxM+0DfcvNeW2kmFiBOtLH8/d0NySfTutKmqsAhdzKbtpHa3rlFDATSCfi8SFw==
X-Received: by 2002:adf:f20e:: with SMTP id p14mr1973496wro.212.1570011871281;
        Wed, 02 Oct 2019 03:24:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t4sm20164065wrm.13.2019.10.02.03.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 03:24:30 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:24:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mat King <mathewk@google.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191002102428.zaid63hp6wpd7w34@holly.lan>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h84rbile.fsf@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> > Resending in plain text mode
> >
> > I have been looking into adding Linux support for electronic privacy
> > screens which is a feature on some new laptops which is built into the
> > display and allows users to turn it on instead of needing to use a
> > physical privacy filter. In discussions with my colleagues the idea of
> > using either /sys/class/backlight or /sys/class/leds but this new
> > feature does not seem to quite fit into either of those classes.
> >
> > I am proposing adding a class called "privacy_screen" to interface
> > with these devices. The initial API would be simple just a single
> > property called "privacy_state" which when set to 1 would mean that
> > privacy is enabled and 0 when privacy is disabled.
> >
> > Current known use cases will use ACPI _DSM in order to interface with
> > the privacy screens, but this class would allow device driver authors
> > to use other interfaces as well.
> >
> > Example:
> >
> > # get privacy screen state
> > cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
> > enabled 0: privacy disabled
> >
> > # set privacy enabled
> > echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
> >
> >  Does this approach seem to be reasonable?
> 
> What part of the userspace would be managing the privacy screen? Should
> there be a connection between the display and the privacy screen that
> covers the display? How would the userspace make that connection if it's
> a sysfs interface?
> 
> I don't know how the privacy screen operates, but if it draws any power,
> you'll want to disable it when you switch off the display it covers.
> 
> If the privacy screen control was part of the graphics subsystem (say, a
> DRM connector property, which feels somewhat natural), I think it would
> make it easier for userspace to have policies such as enabling the
> privacy screen automatically depending on the content you're viewing,
> but only if the content is on the display that has a privacy screen.

Connectors versus sysfs came up on a backlight thread recently.

Daniel Vetter wrote an excellent summary on why it has been (and still
is) difficult to migrate backlight controls towards the DRM connector
interface:
https://lkml.org/lkml/2019/8/20/752

Many of the backlight legacy problems do not apply to privacy screens
but I do suggest reading this post and some of the neighbouring parts
of the thread. In particular the ACPI driver versus real driver issues
Daniel mentioned could occur again. Hopefully not though, I mean how
wrong can a 1-bit control go? (actually no... don't answer that).

It would definitely be a shame to build up an unnecessary sysfs legacy
for privacy screens so definitely worth seeing if this can use DRM
connector properties.


Daniel.
