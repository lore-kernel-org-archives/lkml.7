Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96ADECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2D121848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570646442;
	bh=zszbWCsT4olebZC5fAmGt3V+UZkT0u8TZGE92g8jp80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T4hkshmiUkMtNkgeNWSP4CLJ2dQLqkzEMNQQy7Kvhy8mKHsS6mSWu8P8IITEfZe8D
	 WDgwhhgto74PDo/aBULJ+h1ClFppM2RcgXnKbA/9mAldCwT3n37OaCIVQaJbHEjKCb
	 +EiYe0kCa5GqE7goBthAEKeZZHa5ULnmsXTPFBMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfJISkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbfJISkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:40:41 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C679121920
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570646440;
        bh=zszbWCsT4olebZC5fAmGt3V+UZkT0u8TZGE92g8jp80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kA9F4odN2BKvjEfj+poT7re9ekv0Biizf5prdfyxa1t5opD1RqY7D61tXOJ0oGJFq
         uPzp7AtfhOPsfKvT632lrOmxzidwye8wqKMkPbBjzF7IOv5aKIXLtx4y0VczWdE7c9
         t73cPRFqpMq3IhqLu70XwZp2cGvhIGS4BA/t0AVU=
Received: by mail-qt1-f169.google.com with SMTP id m15so4897725qtq.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 11:40:40 -0700 (PDT)
X-Gm-Message-State: APjAAAWUp5ZlccLEwWgpBug/5S/7K7ZxDPg34OT0IQWhlfLtP7Und3m4
        vtYDdUIcDw3NAryF+5s3yVU4H1gAvyP1DACuww==
X-Google-Smtp-Source: APXvYqzG9tT6XNZvDA6vm+Sp9mNK5+JebOo9CJE9L9ORPqscv/GJAMrijcnXEq/tSUucm3w4QRxozt53Lls3zhtrUvI=
X-Received: by 2002:ad4:5044:: with SMTP id m4mr5384425qvq.85.1570646439943;
 Wed, 09 Oct 2019 11:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191004144413.42586-1-steven.price@arm.com>
In-Reply-To: <20191004144413.42586-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Oct 2019 13:40:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WveA27wtuHgW+AbAG69x3gEL4LNLtiqS48tCDyJuWJQ@mail.gmail.com>
Message-ID: <CAL_Jsq+WveA27wtuHgW+AbAG69x3gEL4LNLtiqS48tCDyJuWJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Remove NULL check for regulator
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 9:44 AM Steven Price <steven.price@arm.com> wrote:
>
> devm_regulator_get() is used to populate pfdev->regulator which ensures
> that this cannot be NULL (a dummy regulator will be returned if
> necessary). So remove the check in panfrost_devfreq_target().
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This looks like it was accidentally reintroduced by the merge from
> drm-next into drm-misc-next due to the duplication of "drm/panfrost: Add
> missing check for pfdev-regulator" (commits c90f30812a79 and
> 52282163dfa6).
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

Rob
