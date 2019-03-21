Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F6B218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GVVrpzln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfCUPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:40:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32887 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfCUPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:40:14 -0400
Received: by mail-io1-f68.google.com with SMTP id b6so5631487iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/rP30qae+c6bSHaVrK4mLSxBRk9fRh6YZC+PfgjPC5g=;
        b=GVVrpzlnU6BYkaW65uvgqSj9iMnpZAT6H8v+qSXufg/BU9Y1L5HML4fbLu0UWXKPQP
         KyNQYs1HUtVNpDIxlE8mqd1UDUXwAlEavXfb0IXvY76urnvV/9NQETOhv5N3qawwIO0I
         rEPuj8yK5D3JBksHVzF3GhXBbSQwXSJZTDma3BmEvlWsbzIY4/ffJJThKw7dk04Pz+b1
         iDLkr3WW8xsOAImMOxyuyZOBmmCGyJWO5HCrXS0iSLC7X79kYEnhvQ4QwJv5HHOiYkBO
         GyfErthmB60U9o908jFRZQo9bSd69r0QmE9XxlRJYssqQgSAyB1e2AxJvs0I7QEdhnjo
         XQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/rP30qae+c6bSHaVrK4mLSxBRk9fRh6YZC+PfgjPC5g=;
        b=YayxP0IYEhk0RndC2a3gKromQlSeyrwSvngWtMXQFU/TPMwVS7Zd0kcogLcaajnkL7
         dzsW34zW/XuGWGuTDUwYUpBNpP0XuV4zxxNWDtuH7ljydpfzlXX2ojBQBCMm1Tysdvts
         nmugyZH8R73TrdK+JPLujczw9LvkO+4d6aUXva4rTOscd+vVlL6dHjwDDvYIJu6b6iYS
         5K7WRYk3QB5XEPipVrjgSVn3IXN7so77682pcgAXJZps6idHl83WpzQSi/TxTpsTRIxm
         yhS0++QYCoLHHT8X9dW+IjpSt3QR8wYxdN6l5VQqmhe0FPV+0KJx8ZmAqekP3P9Zuzi6
         gWGA==
X-Gm-Message-State: APjAAAUB8JHHFMTvgmIapZWSGVrkYKx+IAM4DFh8q7xce+3buUoCR9hb
        Fm0YPuR3/4D1oheaa/Nw/ToUzPVtTn/K8JHSIaILsQ==
X-Google-Smtp-Source: APXvYqzj6+enPVpSxbq5Hk/KnHml7LM5ecBMOV0Jp4UyYuMW8OyOPDbQu46EbRb4NllXvVDc1Kojwh0X+3ynssUUA0Y=
X-Received: by 2002:a6b:6e0f:: with SMTP id d15mr3412120ioh.111.1553182813502;
 Thu, 21 Mar 2019 08:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190321141010.19612-1-brgl@bgdev.pl> <e4d51b63-bc07-c595-9d73-c4b09eb11341@lechnology.com>
In-Reply-To: <e4d51b63-bc07-c595-9d73-c4b09eb11341@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 21 Mar 2019 16:40:02 +0100
Message-ID: <CAMRc=MespSLpsknVrMwYVorv0NxAsSL+U9R049Fw_Wqe1_gqkw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: da850: enable cpufreq in DT mode
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 21 mar 2019 o 16:29 David Lechner <david@lechnology.com> napisa=C5=82=
(a):
>
> On 3/21/19 9:10 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series adds cpufreq-dt operating points for da850 boards supported
> > with device tree (da850-lcdk, da850-lego-ev3, da850-evm) and also
> > includes a fix for the da850-evm boardfile which checks an unset variab=
le
> > to determine the highest available frequency for cpufreq.
>
>
> I can't find any old threads about this, but I recall that there was a
> problem with the USB OHCI controller breaking when switching frequencies.
> It didn't happen all of the time, but often enough that it made using
> cpufreq unusable for me. Is this still a problem?
>

Yes, it's still a problem, but it's bug-compatible with the legacy BSP
from TI (project arago). I've spent some time trying to figure out the
culprit at the time you were working on the clock driver, but
eventually gave up. I think it's some kind of a HW issue. The
controller would simple die after a couple transitions.

Bart

> Also, a big-picture question. On boards with fixed regulators, what is
> the benefit of enabling frequency scaling? The power savings aspect
> seems negligible (< 1% in my tests) since the voltage cannot be changed.
