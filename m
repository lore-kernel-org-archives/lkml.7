Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E9C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B3F2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNFnSWiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfF3Rtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 13:49:43 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45858 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF3Rtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:49:43 -0400
Received: by mail-vs1-f65.google.com with SMTP id h28so7339751vsl.12;
        Sun, 30 Jun 2019 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=17B2zXe7mWErKvffl58hVF0M6yuSwcH1GN4ut30B0Nk=;
        b=MNFnSWiKMn8jO8G7i7oL7Hl486oP3Ehp2H9FyE5KpDcKIUK/3TdZKmObHUAWEWEz4c
         +g9XDDeUTeTxXq8fRzysF9e0io/g1GS+/2Qc0kM5TMI/Dq1nQpwrbhHQB6Sq/RtlTmdQ
         5rM0kqMqCZWZy9vdcFdY737IrdQZNtGxx4sNk6oC05DHR4jLPfY3gAaBUW03qhGFNio0
         43Cc/rOOcbz+/VX9YLBINJJ+IilHtPkLR3duDlJZvOGxL96FFDRooNV7H0VRwQMglZaT
         5nke4XhUShEO1vYtqM24sYcO1MI1C90lHWHrpxPOgVx5I3hv13YUI5b0vpruP5JImo8Z
         oSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=17B2zXe7mWErKvffl58hVF0M6yuSwcH1GN4ut30B0Nk=;
        b=NZ+mXdb6XUCpvMJceMTNXescQd0CwJBl51CmqiA81OB9TIPGzEyyb0XVdh3g9dhCow
         6tfWno2a0U5A5PKF+Vph8tH6tfwPKRKjeG62KjiJh2dMBGU4b5dYNRk8KTfz8Ee6Ozv2
         KZuhz0v7DVXtWaPsp/+j4qO4+dO4HZ/OqhxhGG7/5xulWtQeQ30Pm/WDKvrkkmB1MJ+i
         3wx7d0CSJeE0JCRX8FkLkQd+1OxvBC/t5QvDWC1VNLLnelhzxiXHcQD5C7lxGcVD/oVP
         /RHoFXRsi+kxn+KouuqVDwQA5yH6w1ciR8fE1jM1HbYFfVadUTk7BeKwm8Pep9wucLIj
         Wl3g==
X-Gm-Message-State: APjAAAXSqV5766+1GQr7/6EE0o3KPGyWFbRYNsKDB2iYQbB4Lf/37BUx
        zaAkeWfzqLilewR1pp/ocg==
X-Google-Smtp-Source: APXvYqxcjdcwDLJLmmDwxK1z+CSMQpeosEqvygFh/x+Q9OX0DvHwixt3FxLFtSlUG+DBhACF8sm4ww==
X-Received: by 2002:a67:fd96:: with SMTP id k22mr12093110vsq.219.1561916981612;
        Sun, 30 Jun 2019 10:49:41 -0700 (PDT)
Received: from 960 ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id i68sm2632422vkg.15.2019.06.30.10.49.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 10:49:40 -0700 (PDT)
Message-ID: <1424c4198a6a8ba58951eaf4e075d9f17c8609b8.camel@gmail.com>
Subject: Re: [PATCH v2 0/8] platform/x86: Huawei WMI laptop extras driver
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 30 Jun 2019 13:49:38 -0400
In-Reply-To: <CAHp75Vd2oLkjYjh6k8a3fitAHDvQeu9zm2LpHM7fCXUWN9zaVQ@mail.gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
         <CAHp75Vd2oLkjYjh6k8a3fitAHDvQeu9zm2LpHM7fCXUWN9zaVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-29 at 17:27 +0300, Andy Shevchenko wrote:
> On Thu, Jun 13, 2019 at 6:04 AM Ayman Bagabas <
> ayman.bagabas@gmail.com> wrote:
> > Changes from v1:
> > * introducing debugfs
> > * code reformatting
> > 
> > This patch series introduce new features to the driver and also
> > moves the
> > driver from wmi_driver to platform_driver. This move is necessary
> > because the
> > driver is no longer only a hotkeys driver and platform_driver
> > offers easier
> > future extensibility.
> > 
> > The patch series introduces a WMI BIOS interface that brings on new
> > features
> > and enables controlling micmute LED through this interface on
> > supported models.
> > It also enables controlling battery charging thresholds and fn-lock 
> > state.
> > These features are controlled through the HWMI WMI device present
> > in most of
> > these laptops.
> > 
> > Currently, micmute LED is controlled through an ACPI method under
> > EC.
> > This method ("SPIN", "WPIN") is specific to some models and
> > wouldn't
> > work on all Huawei laptops. Controlling this LED through the
> > interface provides
> > a better unified method to control the LED on models that
> > implements this
> > feature.
> > 
> > The behavior of hotkeys is not the same among all models. Some
> > models
> > require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. Fn-
> > lock inverts the
> > behavior of the top row from special keys to F1-F12 keys.
> > 
> > A debugfs interface is also implemented to support unrepresented
> > features and to
> > provide debugging feedback from users.
> 
> You have sent few series regarding Huawei devices.
> And from the patch 1 this is not applicable.
> So, I dropped all your patches from patchwork queue and will wait for
> new versions in order they are applicable.

I've sent a newer version and rewrote commit messages and cover page.
I've also changed the tag to RFC.

Thank you,
Ayman

> 
> > Ayman Bagabas (8):
> >   platform/x86: huawei-wmi: move to platform driver
> >   platform/x86: huawei-wmi: implement WMI management interface
> >   platform/x86: huawei-wmi: use quirks and module parameters
> >   platform/x86: huawei-wmi: control micmute LED through WMI
> > interface
> >   platform/x86: huawei-wmi: add battery charging protection support
> >   platform/x86: huawei-wmi: add fn-lock support
> >   platform/x86: huawei-wmi: add sysfs interface support
> >   platform/x86: huawei-wmi: add debugfs files support
> > 
> >  drivers/platform/x86/huawei-wmi.c | 754
> > ++++++++++++++++++++++++++----
> >  1 file changed, 665 insertions(+), 89 deletions(-)
> > 
> > --
> > 2.20.1
> > 
> 
> 

