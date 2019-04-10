Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0C02075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554867818;
	bh=pwYW5LDpYufYVBWlHVyuyKFi32Ot9rugHxniUv/K4bE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TwCcx6Tmo3irFjJLjkZIK2jL4YTourP4k1eKsjxVNK9qhplOb/2UWEoeUQTTg1vUh
	 osHwMdHvrbLeBVXiv/qP5Hf16Vix07rz275aOPSjwcRzLcEvzoRaAyNrN2y6BR1ap8
	 s1orZHWaJULUh6o7lat0duZTZRGkK60b4VAksbcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDJDnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:43:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32970 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDJDng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:43:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so740328ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2TY6+WDFY0M+O7zE/xS5KsETwIiGHgXd+XLHr+An+E=;
        b=DLU/vV5jjcXtx8wcFNtEF351Eqm+MTzENyAlOX8192y7r1PtpqynGUInvU1h4FklWQ
         +TlavDjtW31ZEW5ekepXPUI3FNy5e5vdnCI+QabNoFC07tK5Adcqy6UVRiEa95oQLv7K
         kdihWXxYUqabZkH+dlthFq/OAeynYwN6suYNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2TY6+WDFY0M+O7zE/xS5KsETwIiGHgXd+XLHr+An+E=;
        b=NsO4w81Ck8cWC4iBZ5Gr6tHT9DmGiX0PR6n60N5oQgAkC8eCCsoCfYGal2IQEiBko5
         VrMifMiintw2MFsxjITdnhUy3YhW2ExqW61DbEmYQWxo8mxPjqEVl5jsPEk8MttNKr0R
         5kXxdya9tX6OxgnWAX9k1iySrAA5yLOer9xd0Ksn3+r7YfzX6GbAQDDBnYnibxKX3hXP
         wiE441nevp9NWLbCc3HT0fn204gkV+WIzO9QtixMoS1ubUUTTsctfW0OboHPaYq9+eab
         rovc71eOjuV4/1qwmHEqaBw8VGX9ees9RfYHHEGvEDQ33ok7+2x33XtWEsx/UPG2Pn1F
         n0gw==
X-Gm-Message-State: APjAAAXBDBRmK/lNNM15quvsSthBSUbXGygYCOEx6Jvqu6gusv6OSXos
        hiD8gOL+TECA31RDw3LEsGk8R1B5v+k=
X-Google-Smtp-Source: APXvYqxUTkvW+HkEzAqawx/fq0smYM3dfWjLOfurB1hyJ+BUbacOvTQW4k8EM127oW1ln8fF1ZiPEA==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr18600633ljj.146.1554867813275;
        Tue, 09 Apr 2019 20:43:33 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n2sm6793258lfe.71.2019.04.09.20.43.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:43:32 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f23so740279ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:43:31 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr15716867ljh.111.1554867811666;
 Tue, 09 Apr 2019 20:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
 <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com> <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
In-Reply-To: <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Apr 2019 17:43:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
Message-ID: <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Brian Norris <briannorris@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 5:26 PM Brian Norris <briannorris@chromium.org> wrote:
>
> So, I think the problem is still potentially present no matter when we
> request the IRQ. The "uninitialized" state of the hardware (or,
> firmware) just exposes the issue extremely clearly.

Well, I think that as long as you don't request the irq, and it's not
shared with anything else, the bogus state of the irq line simply
doesn't matter. So the NOAUTOEN shouldn't matter if the irq is
requested properly late.

Either it's edge-triggered and you'll get one possibly spurious
interrupt for an old issue, or it's level-triggered and setting up the
hw should bring the irq line inactive and you'll be ok.

But I've applied your patch for now simply because it seems to be a
smaller change.

But I think you should look into whether it can be fixed by just
requesting the irq once the hardware is really up (which may indeed be
as late as open time).

                   Linus
