Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F2C32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9542720B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565338534;
	bh=vnY7oAsY1586ACxhjBeo4HzooGDvWg/bO7dlEEDQ6lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kpwWxtOwRCWdBcVf7imzbr9GMkWR92UAmLiPzNLIS/5bABq946BNt2puxjwPqcNr6
	 HYr5K65g0fElxnBHNbwDOm3I0LdQwx1JZK7les6f/phIrjRpLnqPlkYuVcanibCEWC
	 ew4HmBBU0HBPGg9Ta8tFY6drZaE37z98fIgKfmIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405938AbfHIIPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:15:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37793 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfHIIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:15:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so63989493otp.4;
        Fri, 09 Aug 2019 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnY7oAsY1586ACxhjBeo4HzooGDvWg/bO7dlEEDQ6lw=;
        b=W4xi6YfwcjwWKsSEIGkzW3famA2I1TNwh6HCniGiDvW077yhXA4k6xl9h8/mQaKcsL
         3mmzgR+TOJ0dXpZXR6rt0zfIMfEGlWcSqXbU/kjHNqhtAFnW5O8bvvjEPOAQeHQ4Bu2m
         UeNzXSW2cJ0REzRndKE3/ytB4zBH9ONmm3OAIHd0ZpbRUVE7UfuVQM6Efu25Im6U8M0F
         VHI+TTmGyuciNeYowtyBKREtz75ZZUfCMBGXVCuLDIEYE4Web8LWYCOUxqIhdd+JVpsT
         VKrvTng3y4SU1B4IlJmFMcXOMu2bh9t49zeUfWB2GBOgkNW/KRccPIgzhvvgdNFEqwEn
         RT6w==
X-Gm-Message-State: APjAAAWxtF5kuat+woIuTVcB3meuf0kCe4mey5yiHQfY/CwlC+fb5kft
        xCk0wO08LGSOq9etxcLGHAhUmmB9uimVO8tLRoA=
X-Google-Smtp-Source: APXvYqxD5CZq8T4kQd204KLi1aG86Z1J38p4cBHVivVKXkMRm7iLcJLySC1n4t0d2NHxSE2hatpOs10CBonmjZQMous=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr15636164oto.167.1565338532516;
 Fri, 09 Aug 2019 01:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <1717835.1Yz4jNODO2@kreacher> <20190808111941.GJ30120@smile.fi.intel.com>
In-Reply-To: <20190808111941.GJ30120@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Aug 2019 10:15:21 +0200
Message-ID: <CAJZ5v0h+iHWMkS-vVHUHwd6AmYE2UR_CCoUjhBJH_-ik_jbVQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] intel-hid: intel-vbtn: Suspend-related fix and update
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 1:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 08, 2019 at 10:40:19AM +0200, Rafael J. Wysocki wrote:
> > Hi,
> >
> > These two patches fix a minor issue related to system suspend in the intel-hid
> > and intel-vbtn drivers and update the suspend/resume handling in intel-hid to
> > reduce special-casing in it somewhat.
> >
>
> AFAIR the original patches go via other than PDx86 tree.

That's correct.

> Thus, while patches are looking good to me,
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!
