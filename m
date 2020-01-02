Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F20C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843C217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FSGhkyHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgABWDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:03:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36875 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:03:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so7344093oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Qm+6s5MAO8n13CG6+uytEx5y7oyEZvgzhXp8vcmVdw=;
        b=FSGhkyHMKw5phVrORIUvJbWA+TZtwIAmw8b5i2QtckbwfTgeLU+HloQhQ7edZHSTtK
         p+Bng3Frnsio6Vcg8kcEJoWKz0KVIpKUfG4C3EUbmRd0BKbkAp935sb10GlX2VdVQ2VE
         +lbmxMYPYTR0EiPWTGumhbJralABOuYFno94I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Qm+6s5MAO8n13CG6+uytEx5y7oyEZvgzhXp8vcmVdw=;
        b=bR1rX/XpZNUr1ipJS152nY6OQhXCiDPSQ8Ww4nEraVnmUwcBGA5Y3sZeCzZbaWINH/
         V4EAeuQ6Pa2XKiqcOshCp86MuCmo1MH4YrLe37O8LICj02YInqhQwGa58invWSjI3BP1
         H6xphQIyVm3HDpelUu9rfmRaV1dYi8Jk465rqZjtdiVLmOzzbSj4eC+inqqaffSf+Nel
         Hq7+/4qBIbUtJn2niiXL6cXuZD1JqtrE6f1YiHMzf8uwLpypxgdFbH55ZI/lMjL1DebJ
         yBpRGrd6yTkGCgFKGy/QipEj+UfQopU57rsUjdDh1RkVC1Hj1gqw+AxjgxN8buTWpzcB
         71RA==
X-Gm-Message-State: APjAAAVxfgjmWcdxh9mVAYovYYjGCSGbS49Ziqp6dKtl1ChmLJ+2KNIP
        KjMKJVEMIY0lOVJ9hPhYbskwPTfmOdM=
X-Google-Smtp-Source: APXvYqyXpRK/YLaavwGgi+rWEbsdy9vO+zOvvNUPbNPch97AS+9BjtLc4Z2tRTmUs/DzRoDvxU7yHA==
X-Received: by 2002:aca:ed57:: with SMTP id l84mr3198908oih.8.1578002585732;
        Thu, 02 Jan 2020 14:03:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm15499278otj.1.2020.01.02.14.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 14:03:04 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:03:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH v1 1/1] lkdtm/stackleak: Make the stack erasing test more
 verbose
Message-ID: <202001021402.EDBC5114D@keescook>
References: <20191219145416.435508-1-alex.popov@linux.com>
 <201912301034.5C04DC89@keescook>
 <5bde4de0-875c-536b-67ec-eafebb8b9ab1@linux.com>
 <201912301443.9B8F6CA6@keescook>
 <aae20dfa-4a55-9aaf-d2f9-3c83ed905f2e@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae20dfa-4a55-9aaf-d2f9-3c83ed905f2e@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 02:26:39AM +0300, Alexander Popov wrote:
> On 31.12.2019 01:46, Kees Cook wrote:
> > On Tue, Dec 31, 2019 at 01:20:24AM +0300, Alexander Popov wrote:
> >> On 30.12.2019 21:37, Kees Cook wrote:
> >>> Hi! I try to keep the "success" conditions for LKDTM tests to be a
> >>> system exception, so doing "BUG" on a failure is actually against the
> >>> design. So, really, a test harness needs to know to check dmesg for the
> >>> results here. It almost looks like this check shouldn't live in LKDTM,
> >>> but since it feels like other LKDTM tests, I'm happy to keep it there
> >>> for now.
> >>
> >> Do you mean that you will apply this patch?
> > 
> > Sorry for my confusing reply! I meant that I don't want to apply the
> > patch, but I'm find to leave the stackleak check in LKDTM.
> 
> Kees, I think I see a solution.
> 
> Would you agree if I use dump_stack() instead of BUG() in case of test failure?
> That would provide enough info for debugging and would NOT break your design.

I would be fine with that, yes! :)

-- 
Kees Cook
