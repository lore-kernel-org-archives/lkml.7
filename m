Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF1CC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5421A206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wa+2PEDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfILJ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:57:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38643 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:57:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id c12so18830052lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2riQYjdYJYpTusYyd81I617wQxn19uT6YXDHRH2PAKQ=;
        b=Wa+2PEDukS5xcIvafDhQDAUFe/6aib6sQO4rzmCZBV2shVTZUYc1Choz82sk5OFlY4
         Bo9nnua++u8b1NHvGuy4ZyRHUTqiv9yNQ1Le+4c+DDg4LxYvMeWN1vZkPO6DSyKALmST
         JQs+2L9fU4+gJB0XEjgm4wEZV3/VG5yPx/tvHUAvcCMR4rb+u0ahVsRi2iD5rOB7D0Dw
         itytXqdFtRF0c1+O4/P/hZnw2nBp0lFAIDf3Vk2ld8q4WPhesgOwyBilOa3+QFL7dE1C
         +zU8XCekX19X9mjOhiBsdEgbze9BbOuoD6q50i0dwt+3KPh8tABZkoemY8ChK4cIGYgE
         IaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2riQYjdYJYpTusYyd81I617wQxn19uT6YXDHRH2PAKQ=;
        b=p4sfwBDHqXlqUWJ2gInnfOHxvBk5SGhMcjvPLsCtlz2FEkuvTXKBg4Dhkc2K0R+vZt
         RiDm4BRg9WIzuKiQV+omwWH+P4zcCWeXBNzmjYNDxjJf35ZxW+2tYfG9IDCjx0PZSghw
         +iciygojrFvwshNRxVhZQBZP+PR6w5xR6FKGPYDNOGqYcHsbBfhJKY3vbR7fQgAUYZyw
         3nNPUlteIjUuVoKIqSi3v9zwB/fCinmItC0EO2MnCVq2iFscBSoirYsRL724h+aYN/lU
         0Eg+MV1KLOQJTAlKY/dUaQpIeH3CR2jjs0uYcRXbJUHfcPDbX5cSX24D0ENGLWZoimsf
         E0fw==
X-Gm-Message-State: APjAAAXLNHN7D3IvODF67PCBQweHFg/mUay9NzvTBH995dNop4MEtSer
        a8LnSPQ2X4YMbVtOMAAXmaLmkywpVza7tCVK+sYr57cTCDSw3Q==
X-Google-Smtp-Source: APXvYqyuzJ6eZWaK28dmU7yeuYfU71UXRJhDCit17aW8lgp5kYPE3UpXMIT+KK4butOImbh6RmOSQqr8crN9DXph8zE=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr27613759lfp.61.1568282253045;
 Thu, 12 Sep 2019 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
 <1567054348-19685-2-git-send-email-srinath.mannam@broadcom.com>
 <CACRpkdZe2btC-vjRq1rPaHA9pXUi8N_cZT-RQ5m=PxjmkASieA@mail.gmail.com> <535f7569-70d0-1a7c-e15d-b77301867629@broadcom.com>
In-Reply-To: <535f7569-70d0-1a7c-e15d-b77301867629@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:57:21 +0100
Message-ID: <CACRpkdajpxFM+2VNdOiKk3a=dYfeAOud6C_SXBdL+3L0uYqHcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: iproc-gpio: Fix incorrect pinconf configurations
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Jin <li.jin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 5:55 PM Ray Jui <ray.jui@broadcom.com> wrote:

> These patches were actually all internally reviewed by Broadcom
> maintainers before sending out to the mailing list.
>
> Obviously you wouldn't know about that, :)
>
> One of us should have explicitly given our ACK, sorry...

It's fine, the process is not perfect.

Thanks!
Linus Walleij
