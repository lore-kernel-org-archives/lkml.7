Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4822C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C521848
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUPJMxAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfGQRFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:05:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45803 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGQRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:05:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so11127324pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=fYV+fepeQ0ut57YEoowE+nVKv8kU6uG/qBPZ8Arc53M=;
        b=AUPJMxAaz4xxn77CluYPNvJUG0dIZv8FP9ZJbMWhp8CKw9y7bbXzsqBP6U5PaLID7L
         3MtFin9tTXVY6DmHpWR4tqNF16S6LFBj49uCwyELe4Do8GJOZ8Y8Bw1ZCRqgngFuP7pE
         QOpKaJofZcIqo7wQrEoj8mD1iRa3zq7xCp/UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=fYV+fepeQ0ut57YEoowE+nVKv8kU6uG/qBPZ8Arc53M=;
        b=tSzmVqDjoO1lUFiOIvB0CB+PBhzfSBZB6WRC/8oGOiV3Fu8pjDkoXyy2hEns1Nqg4V
         qmpFQGj5sZ1Mq21N5HfhHv6x3Sb84rX1vtVVUDysHoq32SdlbCWxG7ywymIb8qbmqDYI
         1LKLFtgys5nIhBGLpB77giF3w/fGwj2FBSjylPqLD7HNX8cnBFO3Wk7T5UMVPNnCF5m5
         qMvZ6mqQqyKWy9iRi7pXriALPVwN6OeGvPdJMNB3cjvgzwpflbMs3i8ifc0LEFiiLQxN
         FmNXijSzhwwdhBpfaYLxPWjJuzJeedOBbo/KsOjmygdhMmrFKCC0Bfgbo5xu72Yt2avY
         E/+w==
X-Gm-Message-State: APjAAAUlJmhrxOpoyWNM96Efj+2/7cEDEuHKpFElNMJbkB+6XKAGOYHQ
        TQEMwuo7T6xtAe43IDMhTW1bjQ==
X-Google-Smtp-Source: APXvYqysdX0HE/KWln1kVenPjeUUiyo4WoUNUrNNS5VQzb/sZEEIdqdfjhABQOJtIU+PAMNWEkHlhA==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr45804808pjg.57.1563383153472;
        Wed, 17 Jul 2019 10:05:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a3sm13997715pfc.70.2019.07.17.10.05.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:05:52 -0700 (PDT)
Message-ID: <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717165628.GJ12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca> <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com> <20190717165628.GJ12119@ziepe.ca>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 10:05:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 09:56:28)
> On Wed, Jul 17, 2019 at 09:49:42AM -0700, Stephen Boyd wrote:
> > Quoting Jason Gunthorpe (2019-07-17 05:25:58)
> > > On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> > > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > >=20
> > > But overall, it might be better to just double link the little helper:
> > >=20
> > > obj-$(CONFIG_TCG_CR50_SPI) +=3D cr50.o cr50_spi.o
> > > obj-$(CONFIG_TCG_CR50_I2C) +=3D cr50.o cr50_i2c.o
> > >=20
> > > As we don't actually ever expect to load both modules into the same
> > > system
> > >=20
> >=20
> > Sometimes we have both drivers built-in. To maintain the tiny space
> > savings I'd prefer to just leave this as helpless and tristate.
>=20
> If it is builtin you only get one copy of cr50.o anyhow. The only
> differences is for modules, then the two modules will both be a bit
> bigger instead of a 3rd module being created
>=20

Yes. The space savings comes from having the extra module 'cr50.ko' that
holds almost nothing at all when the two drivers are modules.

