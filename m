Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EDFC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474432087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBZAHqGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfG1KH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 06:07:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42349 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfG1KH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 06:07:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so39976607lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PdnB4+DVETsuhtxt6ZrOFlXGwuc4dLlLuSMGN0xrw8=;
        b=SBZAHqGUVpiWTwyGhjgib6Ba8GdoI75a+L56oQjr43fm4qV2BFxftfLsMlqrqFn+EZ
         5mdVWAT+B+VByU2CkAVFlJxxvpHFN2tm/Cpiyr9ulZVBOMGyg4Mud8P9Q1qJhxDA5erJ
         ESRpyTBSFLBBgNZ8EmdPLcw7TcmuZ5dWXuz3D3WsZtikm9kKl6/8RjhBaq1cCXWLwNJC
         0oeXcRF5K2vATaK9Ugac2PfqhBrPYXrWIHUet/CE+Vr5nKOkPJa6boOi9BLeiUzq1aHR
         kRgfRj8FD4OEp9TxabCKtDhHabREwEel8ghVMku29geSLkfmp0y7XUSxiDDx3g46Hsz+
         5YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PdnB4+DVETsuhtxt6ZrOFlXGwuc4dLlLuSMGN0xrw8=;
        b=JJb/bj1AcTIU3lPZGx0gk4aTexB4+ga9bLAnydSUobVrzFOvGvCSADe7j7aN2rbTJ+
         BOy06VAodQ3NHxfDcxwpLaF+kx300bPD1hABnQDXE6glzdRlVyWfPnhIKu9wedUlsE8G
         v+Ozm6AohLDmZJ3+CvpLFq6glXmLdHWqFVd/h3Lf34ntoIL78oU+Hr+lCAmZet6PdlmY
         etuQBXS/wqtzO+f1HsvEoD4OJC3ylcvxCwB0FK7R3w71Z8TbIjiYHrM8EOaitMROXeku
         Lt3E1HrWuLhqrcY5x5T4S3KoqTtCK7D9yOJ9xAn92CgcBVVR4I/PZNw7uXFKpiySQitQ
         RZ9w==
X-Gm-Message-State: APjAAAXz4UIytts5FP/82Ux4gLP2DXP8VIRq1ZFAiNYAOXSABNG4VDbT
        /7EAwYkZ6Lfcw9y0LCVkrUlYkGQG+SrUPNlXUlCXAg==
X-Google-Smtp-Source: APXvYqzSNjt1lYKjURaRXuVncVRWOToNmhOfLXFnEo7r8V/3u9q15MPobypEm+Fc3TnK08e+rNVdVXdF65GrsXrVICo=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr50180412lfc.60.1564308476044;
 Sun, 28 Jul 2019 03:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
 <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
 <4C901747-1657-47AD-A9D7-10E41AFB35CB@goldelico.com> <20190728085010.36040cb2@archlinux>
In-Reply-To: <20190728085010.36040cb2@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 Jul 2019 12:07:44 +0200
Message-ID: <CACRpkdb1-d3mzJAs2AVdz3n8vWGy-cgajiTP4k=cJSqTsbgpeQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 9:50 AM Jonathan Cameron <jic23@kernel.org> wrote:

> Given the comments that 'need' any response are fairly minor, I've just
> taken the view that the perfect is the enemy of the good and applied
> it to the togreg branch of iio.git with some really small tweaks.

Oh that works, too :) whoever is most annoyed will get to fix any
remaining offenders.

The quality of documentation really depends on perspective.
This weekend I read some old UNIX System V manuals
and this was "extremly professional" documentation at one
point. It wasn't very good. I think we're pretty well off with what
we have here.

Yours,
Linus Walleij
