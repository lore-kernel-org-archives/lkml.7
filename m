Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EC120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZbVoMDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCDK0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:26:20 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35479 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfCDK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:26:20 -0500
Received: by mail-ua1-f65.google.com with SMTP id f88so3932806uaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTw7L0fnMFp2Y8lkElz3yp4GbnOY8YOrbvevswJJoXo=;
        b=FZbVoMDsBiaSSFFUNFg9CbWSDShmIoQiS9IwYrbbK4y9ei3fb6BZ0zN2g+tdMF4l2U
         7m53pmc1pqaG90vi7Um3yBz9yYdjGxPAPenDAXBB6ZQzYmi+Cd5xa8zGfhbiVvATOgnR
         v2zDnF81fsk9XzfB+TUwA1SvG79Jv75Usn1GtVhlcQQ1bZCXDaj96mG1SXNODkd3dBtH
         E/uXqV3URC/Z5Aay3TOFeX+NlnmfscGkRpBR8TVSdgMHUdr+oPiK3d3xzHNILo7XQ+H/
         UbbqygKIwqF69Km3RlinLV4lj/xMOUG37MsAshjG24yXkgCFPiws9WEV6M7nHL9NKEaO
         ZyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTw7L0fnMFp2Y8lkElz3yp4GbnOY8YOrbvevswJJoXo=;
        b=jiQBI8vT+YyXO9gXWGKJlz8sUUQ6Tu7ZZAMy8o0hO+ihzA+ONOnShU5IfwT3iWYTH7
         oWFOBQZG0PT+SAEXG8lDduc8zerC8ofGEqy3f91hBIB7GJI4SzN0GFkWcuVCRou9Oo5A
         NhuyTLqDG+R2wUhccsS9NQJfF66tkrlTh96511lZFf4/C/9w1CUj6Whh2Miw6b8cAv5+
         b1feEOHnTMvO9FGCnx2yaDrbpTEcmR65VTIco7uP+ngqnS10j+lKlgNdihkfEaJK2Vrx
         BRAnYJrMtq/S4xxc4+EWokQ57LCWb6Fq1++sSFYwLyiwXUM1HmI2+7iUWG3ENwRTOIUw
         jXuQ==
X-Gm-Message-State: APjAAAUntWhKvKjzASkO9RDX1Hti4P934SsOZsI/kg2twajWgX2P5u74
        kSO4rEcKaEqkrXzetqR/32+9JLElpiC8OJTbJ7yObA==
X-Google-Smtp-Source: APXvYqzji7TJLy0NUOjf3+i3E08MamQNt+qKvwkXOIjf5VXx088vadPfzje1z3KH8dTy7mchVGs7efGFrtRJeFs7L3Y=
X-Received: by 2002:a67:7e84:: with SMTP id z126mr9280239vsc.165.1551695179392;
 Mon, 04 Mar 2019 02:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-8-ulf.hansson@linaro.org>
 <155146129938.16805.4528027710288083607@swboyd.mtv.corp.google.com>
In-Reply-To: <155146129938.16805.4528027710288083607@swboyd.mtv.corp.google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Mar 2019 11:25:43 +0100
Message-ID: <CAPDyKFodEYc+9UoROhH-wWYYZPBnMTu1ZhkCM9gSHDrYTq=MFA@mail.gmail.com>
Subject: Re: [PATCH 7/7] drivers: firmware: psci: Announce support for OS
 initiated suspend mode
To:     Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 at 18:28, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ulf Hansson (2019-02-28 05:59:19)
> > PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
> > Platform Coordinated mode, which is the default and mandatory mode, while
> > support for the OS initiated (OSI) mode is optional.
> >
> > In some cases it's interesting for the user/developer to know if the OSI
> > mode is supported by the PSCI FW. Therefore, let's print a message to the
> > log, if that is the case.
>
> I don't see anything wrong with the patch besides the potential for the
> logs to wrap and the informational message to be lost, but would it be
> possible to express the PSCI features that are supported in sysfs at
> /sys/firmware/psci/ somehow? It may be useful for a user to know that
> their firmware has PSCI support and that it has a certain set of
> features available, like OSI vs. PC, or both. I don't know of any use
> that userspace would have though, besides maybe the CPU state residency
> counters being used by some sort of statistics collecting program or
> just plain knowing that certain PSCI features are present, so perhaps it
> could just be done in debugfs for now until a real user exists.

Having a sysfs interface for PSCI, allowing users to know a little bit
more about what the FW supports/version/etc sound like a great idea to
me.

There is already quite some prints being made by psci during boot, so
perhaps having sysfs allows us to drop some of these.

Mark, what do you think? Is it something you think we should do? I can
offer my help to implement this, if you think it's a good idea.

Stephen, thanks for reviewing!

Kind regards
Uffe
