Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29335C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D0F20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQGCU0kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCHJoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:44:25 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:39012 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:44:25 -0500
Received: by mail-ua1-f51.google.com with SMTP id s15so11190752uap.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=blsyaIXLwtfe7LSdqYBQJf73IisErnVRXrLmDlzM+vE=;
        b=PQGCU0kIznEKO1hFbRGbBJH3Rptk7l+Z+re/nzQ3nRF27s6N1BEGttZ+Kn3lTUTYSE
         rJcnsQW9C/FmoB1/RsSeiFyY1fu4NKOvDB1KG0CAyHh7sNJ5S6EAhB6/eMSSxTyLN21S
         +FZTpRIQ6EK69agkofRO9MIjWIdZN9nx03Z3fRVO2vQXxIm1QxHJofZOmjzsdLTRrH8k
         8gr0KA3wPBTcxUYWO7ZWz2HpfF9GWHvY6MWgvKocINdz7lWHZ3AtYzCqeU8n1pCmcIDC
         JdqSR9kykZvpXJTEGAQ9Vu24yWbn9N97g0gR5x0fZy4lneIdgsZ36Rw3aI366ME4468+
         nlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blsyaIXLwtfe7LSdqYBQJf73IisErnVRXrLmDlzM+vE=;
        b=p0vd8tLytansh15LE1xqvdfUzmUEuV24aiqUUoWTOgoWRYby7Imlqg9npMTZVc7Hsz
         RWL1x1ZGxf+1wh5lki3x2C0Wr3Y7tO8GXSSj018b/KX4bo12lZSqqWNsGs15AAaI51Ya
         1q0EKLCJboYaK9zDJ97JUqOkv+LsXEXAJW2hNfHM4qyOJvtaQcwnSlXXnhHvb6HVVB8i
         MIafTR5xuL0Lwee5Pw21Go/ks/Q7KkWlEdYSxuaCKogfSVGTRc7gCYte9x3fzUVVYZrN
         fo1r/HCHsaE1+I2hIXIMawgugsNMolA/zl4PkSfzMZPgAlBsVSTejjL9CZdWSvPN5zZd
         3N8A==
X-Gm-Message-State: APjAAAVPOdQEKxI58/sjfwrN9rkW1xG0IsgoTp8uCgu2IrikY8GBzvxi
        jYw/7gPQKrbIn9ajodSNpicpGM6l8WBJSGKnhc0fHQ==
X-Google-Smtp-Source: APXvYqypaSmmbxnAMWnQKKoILWzbw3js07yXjXA8JwwWEmTUZM5igb7Bz5hV2tvV22PF2hr+sIw+M6FXx6lSTVh9hvA=
X-Received: by 2002:ab0:6016:: with SMTP id j22mr8644917ual.119.1552038264149;
 Fri, 08 Mar 2019 01:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20190212072528.13167-1-hch@lst.de> <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
 <20190308091853.GA14021@lst.de>
In-Reply-To: <20190308091853.GA14021@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Mar 2019 10:43:48 +0100
Message-ID: <CAPDyKFrKkmzrH++g88JLxbLkJh3iTUXfjjuxysr0iEigjYA5ig@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 10:18, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Feb 25, 2019 at 02:54:13PM +0100, Ulf Hansson wrote:
> > This looks good to me, however the lack of feedback/tests worries me a
> > bit. So, unless you think it's a bad idea, I intend to apply this when
> > v5.1 rc1 is out, which allows a lengthy test period in linux-next.
>
> Please don't rush to merge this.  Based on a talk to some folks I
> have an idea for a sg iterator that can hide the kmapping from
> the drivers, which should allow for some less scary driver code and
> clean this up a bit further.

Okay, I see. Thanks for letting me know!

Kind regards
Uffe
