Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA37C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E7220857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dxQLY/1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfCHUS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:18:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43921 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfCHUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:18:27 -0500
Received: by mail-io1-f66.google.com with SMTP id y6so17759113ioq.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 12:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHSiMek86yXwWdaVcEeGbUAL9PJkh0g9flzp0W7Ja24=;
        b=dxQLY/1bQT8ddcXspeaisGYpi1dgQ1Xnn0+wn/Zl2MZ7jrfdqhST1Zh5LWed6qnIEJ
         MrM0IrmSs8i/5cpBJuSpe+ekmW6dFzYcLkNqY8OLRG5FEtAnwglJ0i+qdfdGEjjNZREf
         DppSoEM+uYLEqsoQl4DYSth0c6qzxNm6QVAe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHSiMek86yXwWdaVcEeGbUAL9PJkh0g9flzp0W7Ja24=;
        b=GrZVXQop+bQ5J5OkwrFX4W+1+WNlJQl661vHX2N8nJRxa592juZQBHs2Nn3Gb2DyfF
         +2ABYJbqHB7YI7xD+kMwDFtj7IM6eW5UW9WWk7u3JFYxs51MjrI1jMHKpGxY2ovvcMpN
         IfT0CRsBsQDSrQUpnK6n3ewaG2C1ebWtg0tDgi9u/nXjXRNRUa0VxcRVm1p1pQP9PWBD
         UQPyxpXuqYMpSLdnXt1GF3Jh5afjYa16ObV21Dqt5BhwxrHljsIXnOmIDFEMIpr6Lj66
         WMjKZI/MgMCYNQ4cOP5mzTFUi4KO0ilS1P1x9yxF1n4/QIYxy0R9EHvMjbJfQebMsyYK
         +QRw==
X-Gm-Message-State: APjAAAX3MeDu3TQI+KtJOyNZVIwZmq3ffNq5dfA7ue6aCjUWa+8Pf0Wn
        ZelSFpz2MWTjJeUEw9i9t2iK0qgmVFILFgMNQBvyZw==
X-Google-Smtp-Source: APXvYqxgtgVBOCcysY1S7r7ORsxbYgPX4ggH6Sdt5bm+5iuS8y9ms/7pYlDBAXEeqzNnjtoaAaT8FwbP6Za4vLSlD7w=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr11144483ios.267.1552076307041;
 Fri, 08 Mar 2019 12:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20190212204109.3528-1-jagan@amarulasolutions.com>
 <20190212204109.3528-2-jagan@amarulasolutions.com> <CAMty3ZA401nRh+nqFUcVMOv+or8NWoYU+y72gUPONy7ovyqgSw@mail.gmail.com>
 <20190218202705.GA19088@ravnborg.org> <CAMty3ZCQY+BSAFe=8Z0X29nK9tRz+7s3BFTiAmQ7CD_eNTL-LQ@mail.gmail.com>
In-Reply-To: <CAMty3ZCQY+BSAFe=8Z0X29nK9tRz+7s3BFTiAmQ7CD_eNTL-LQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 9 Mar 2019 01:48:15 +0530
Message-ID: <CAMty3ZCo7ZEaPqUc=O=4N6XDBe+6tAE7AzH258U=hw8uvj-F_g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 28, 2019 at 11:02 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Thierry,
>
> On Tue, Feb 19, 2019 at 1:57 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Thierry
> >
> > > Pleas let me know if you any further comments on this?
> > No further comments from my side, and I consider it
> > ready to apply.
>
> Would you please pick this?

Gentle ping.
