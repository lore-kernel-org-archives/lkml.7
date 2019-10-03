Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ACC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1F921783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570091977;
	bh=CGS17e/sJHPecy4McwsfU+3XcXYeoZrnNJIhi8gCwtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uHCKiYxzNtXDfXArl5JrlifsSRU+uv9lKwbgZUZ3gGg9vc6yykmsUIPk2a+zD/prJ
	 tpIBQk79iJNmGL7ykJ3x2Xx+h9qrRKDAikWNow4FEvVrfYBu8NLnUCavTVy8wELKLp
	 XaZv7PdnswT+FGk/6eJukjhmQcAknHjEASIaxnEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfJCIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:39:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41716 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJCIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:39:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id g13so1552841otp.8;
        Thu, 03 Oct 2019 01:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGS17e/sJHPecy4McwsfU+3XcXYeoZrnNJIhi8gCwtc=;
        b=Di/gKMRVcX8wcatzimNmDoKw9xo4Sa6M5vciLmjBjuCwc7Unq/Ap8VgB+fGvHOh5fa
         +QK1FWTOFoV5TQINpruElkO2WkcF358Xr7x0WDAHPPsl6PvdYeMFJWJn3ax33MZkGZTd
         AT+fl6OgO7dVk289hb1EOzUEMqdRq7bVZkN/vsIAp/92pQxZcGdk9HhLKzYbHIGPrdhe
         JP7JMTHhkPpltR59ffYj+910mISdFDBaD55SLFXPuvZIbf0+rpBeSJxbWTwS3focf/Ap
         ABle5dAcaAI/6GxTvAU0agwsufnLvd1CsUdPlOV/D1cygz/9d/nF3eC9TYlfsjowrIut
         jTGQ==
X-Gm-Message-State: APjAAAVkiOalJIPIAcHiZ8LeAWJ0aClzNeWZlN6Noeg1uFLOQgJtW1Eq
        eAJxBHoiHtpuCdo5afXl+Kgoem66B4hK/9t/nUw=
X-Google-Smtp-Source: APXvYqxHLhCyLM3XP3x+V9PAlN2EIVZgZVON4Mw9o3+uu4a/vd4uSkAqII+8k9ZkApijMnoBhg4QidvwtIKvtG1TBJ0=
X-Received: by 2002:a9d:664:: with SMTP id 91mr5673717otn.189.1570091975427;
 Thu, 03 Oct 2019 01:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com> <20191003003227.GA246700@dtor-ws>
In-Reply-To: <20191003003227.GA246700@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Oct 2019 10:39:24 +0200
Message-ID: <CAJZ5v0jF5vafYFSJ=p3ew_tCbj1T1zRznZDoPTL47Pdj9-rrCg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] software node: add support for reference properties
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:32 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rafael,
>
> On Tue, Sep 10, 2019 at 10:12:17PM -0700, Dmitry Torokhov wrote:
> > These series implement "references" properties for software nodes as true
> > properties, instead of managing them completely separately.
> >
> > The first 10 patches are generic cleanups and consolidation and unification
> > of the existing code; patch #11 implements PROPERTY_EMTRY_REF() and friends;
> > patch #12 converts the user of references to the property syntax, and patch
> > #13 removes the remains of references as entities that are managed
> > separately.
>
> Now that merge window is over could you please take a look at the
> series?

I will.

It would help to resend the whole series with a CC to linux-acpi, though.

Thanks!
