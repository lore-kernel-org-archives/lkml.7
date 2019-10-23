Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08615CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2802173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571853556;
	bh=GVxu4ie3F6beXlleyG/nZFkxDDZ33fjhbpnxbt5ZrVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N9mtYlGk4ISV2zXQCqw1WBjioiUGmwqkLvPxapR79Nrkao9CJcuRCc/dp/8j1xIof
	 oc6SzFnNRPYRJxwHQc2wc0WPUexFMyu/0DH4FO8GTg5vrwekztsudRoRJbbvWntiAB
	 C95BA7FriO/9X1HQXroefhNsg6VzZB/DF6dMc4Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfJWR7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfJWR7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:59:15 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9B52086D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571853554;
        bh=GVxu4ie3F6beXlleyG/nZFkxDDZ33fjhbpnxbt5ZrVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V66bBzKehixlr0jPDg+nSIzXnNnH9cQiylvILvEawEAlOw0cbqKI1c5Nz4AKkcW0E
         ACZZEa+2w9jJjjeT43ADwbiA3Q3Jplc2CRVq+6d9RjxiwhYelcQ2IayhY1/HKM0XrQ
         wMXFKT4izUvKRgDXAsCkuGT7qtuslqabLZe2lliA=
Received: by mail-qt1-f171.google.com with SMTP id w14so33554098qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:59:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXQtHr6XUC2f0tmwzJlJoiMiIYQWc/4kCocJjbbzCNWLDtHUZQe
        +8/MK8/kmFH83ffs19thaO4B3j+1WzZ0NjRG/Q==
X-Google-Smtp-Source: APXvYqwgiCA3/HW7B9HdMyTBcuSF8WS4GaQJTs5HXdTu0a3ruOPx1ujAxcRIzhZ2LIxDxG0XTebd4N+mapW3qIEWKdQ=
X-Received: by 2002:a05:6214:1111:: with SMTP id e17mr6340426qvs.79.1571853553726;
 Wed, 23 Oct 2019 10:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191023120925.30668-1-tomeu.vizoso@collabora.com>
 <20191023122157.32067-1-tomeu.vizoso@collabora.com> <d87ff25e-52af-a467-d128-85fe18028e4c@arm.com>
In-Reply-To: <d87ff25e-52af-a467-d128-85fe18028e4c@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Oct 2019 12:58:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKT4f+Bp7Ajg=V-Ejaynp6BXXFUJKNuCxasU3U3LgepDg@mail.gmail.com>
Message-ID: <CAL_JsqKT4f+Bp7Ajg=V-Ejaynp6BXXFUJKNuCxasU3U3LgepDg@mail.gmail.com>
Subject: Re: [PATCH v2] panfrost: Properly undo pm_runtime_enable when
 deferring a probe
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:49 AM Steven Price <steven.price@arm.com> wrote:
>
> On 23/10/2019 13:21, Tomeu Vizoso wrote:
> > When deferring the probe because of a missing regulator, we were calling
> > pm_runtime_disable even if pm_runtime_enable wasn't called.
> >
> > Move the call to pm_runtime_disable to the right place.
> >
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Reported-by: Chen-Yu Tsai <wens@csie.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Fixes: f4a3c6a44b35 ("drm/panfrost: Disable PM on probe failure")
>
> As Robin pointed out this should be:
>
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
>
> But other than that,
>
> Reviewed-by: Steven Price <steven.price@arm.com>

Applied with Fixes fixed. Looks like we just missed this weeks fixes...

Rob
