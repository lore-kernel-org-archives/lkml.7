Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94463C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6473020840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8oCCPGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfFGWUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:20:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46962 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731151AbfFGWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:20:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id m15so2999714ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQG5fZ3EhYRq8CYdObUVFyj6seF2R8nq3JkVzFb/lxA=;
        b=J8oCCPGNMQU5rDGmeyVTZPHkWL9+Vc3T20HBnIQsBN/psbfksQVafp9kuniapFnd9p
         ACZqYf29QTVDX3vNf/GeJ+C6SzG9RRzuaNdi7Odo6sI+fOHmjBlRCd8oN2ZfmoLK+yVW
         Z4ijFNknrQ679mE38Nn9tFfqwmhPjVcPgN3CEI1ODVHLd67dZWr89t/5PRBA/eaDKeNz
         imVCpLxet79CIeJKx/Lh38ZyzAatFK0W0vjcsPjXkCGoUOYqKW4hNg+KHhIE7ODa2w80
         vFgRB3icM0W8MLppUf36C40m++FpW5cdTrEZKh9qGz3T7b6fCuVUnjuxS/9bejthZ/14
         6Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQG5fZ3EhYRq8CYdObUVFyj6seF2R8nq3JkVzFb/lxA=;
        b=rjHpcbARLvKqMGOGFF0gFECgMOowLhx+Tbi1OJtlAYlkfl3dvPjCzbcqr/449bz06H
         eFrGMT6q73usHG8mLIJkRBN/JYgMom/+qDYIyEaPjiX2T7/YEc60bxtUXmsVgHfbjyQg
         BpWRC01xkhQfdW70eMHjNICjiXl8jL45gqhuCfTC7t6LKvUxujThAHr3MzW0WHUBed2g
         t6JthVN3mk4mnMXJRAJasJT9p/hL3QoIyDAXuGLjnf+LJoLM4RgS49X8i6t1qTZ8RfZz
         p3ioX3GVYxCMHIppbU/7bP/OtsscmvLioJk+7tHn1PmovUVJAPOpElgYJJeIxP2d5iVG
         GWcA==
X-Gm-Message-State: APjAAAUQk3i9KmQOr+CdhvGoNq8H26n2K48qeJ9U+snAqTDZaKeVqEy6
        gBbYHfz7wi0kOCFRGWrPyOUiKK0EmBZ8IT56YjrThc+z
X-Google-Smtp-Source: APXvYqwtFn9ujhL1bNosuQYXIjXabGQeb/hX4swI0JpPVUh1sm9eQAptKaHUcU43LzWRCdPzHPmmw6b84I+/1LdT4jQ=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr5402543ljj.113.1559946020389;
 Fri, 07 Jun 2019 15:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190604072001.9288-1-bjorn.andersson@linaro.org> <20190604072001.9288-4-bjorn.andersson@linaro.org>
In-Reply-To: <20190604072001.9288-4-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:20:12 +0200
Message-ID: <CACRpkdZETzjw2hOz7y15sUFa+s2Ki3UaMh-Qcor4cEopZrf03Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS
 device-reset GPIO
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:20 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Specify the UFS device-reset gpio, so that the controller will issue a
> reset of the UFS device.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
