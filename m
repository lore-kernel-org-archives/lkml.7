Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD43C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D51206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sIrcJv4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLXL24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:28:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41782 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:28:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so17701948eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 03:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yaa4+iEZ46im79+sodnyaIwi0xim0AIqzXbOWPR6HKg=;
        b=sIrcJv4TUYAe5BHQg2t71AAnx6Nx94wYr993rP4u32UoTOgjy3LEDQ3fDxVI+G7AHK
         q+sWW3GX1SAXlPCCrPXm+Ws7/5w6Bd2hhYhLv5JGLqnOj6hcUij5REcUN7+DSPz8Pp5t
         Yhv5GTY5XZzc4Mr9gNU4jpakCj1sn9ItanhF0MU43kVy+hd0g8wpaFGq9kZSQ4EvzfeU
         Wf0meWFnOAL2fyNrs4I4u9OyAmncTZvIIfMzDlSsFfrG0YwsvX4mEdIlQQDcKqk4STgI
         QLYaGp6Dtm0ekk3Y2seHZbvCuLFJyZKaGXwGK3SZCpwHzwzoRNU1bZ0jeCvdseMJ9zHJ
         9VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yaa4+iEZ46im79+sodnyaIwi0xim0AIqzXbOWPR6HKg=;
        b=W5Kp1bZSJKFm9UG5Qd55MMFf9Hzx4SNXo2FTWMpZZFtzDrlsevwSv/hzrgO+ZSPSe8
         sIgrDUuLIOpK4xdTM3G07llc29KaAUPvlvQdWACtqwXcnBbuRX//3gl29zjHqBifrQlV
         nBRSKZfQCSsmYkZaB1c3gEBX0hxo8cWtcSEVgagzf44PBD+a/BqZqpWIvNXRVvlRMygR
         5a6Ng334hq8w0LFePuVRV1TWoRs9g5j1daxlzG/cz9nY20jgPLKxal4wbtNw2xpa3uYI
         2oN9Dz7vEuXWDlFa0+qXiPDTADy0CQ5o+Aa1hurlKSLuB5f/SLlEjhBB6FmM9JmAeKhR
         PKvA==
X-Gm-Message-State: APjAAAV+5Z93q/SCnlb2p1ahh+7ZAGc9kukrKLKhnnzIuvGivbdzrKQi
        T37KnjBpFqxB4fY9gytF5b1HK5LdUb/+W5vvwnc=
X-Google-Smtp-Source: APXvYqz4kTKGwv6SPDwKOT61Zb8NcQu1uqXgs9fWzT9X8E/7hDxnWyW00OC7RSCNm35l0R9eR3N23za84e9iE4u9E04=
X-Received: by 2002:a17:906:260b:: with SMTP id h11mr37038328ejc.327.1577186932440;
 Tue, 24 Dec 2019 03:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com> <20191216154803.GA3921@kevin>
In-Reply-To: <20191216154803.GA3921@kevin>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Dec 2019 12:28:41 +0100
Message-ID: <CAFBinCCDmCHQW+nBHzsodz0R=GKoqv1EEzB=UY=ypFs4Q6MFmQ@mail.gmail.com>
Subject: Re: [RFC v1 0/1] drm: lima: devfreq and cooling device support
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     yuq825@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, tomeu.vizoso@collabora.com,
        robh@kernel.org, steven.price@arm.com,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alyssa,

On Mon, Dec 16, 2019 at 4:48 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> If so much code is being duplicated over, I'm wondering if it makes
> sense for us to move some of the common devfreq code to core DRM
> helpers?
if you have any recommendation where to put it then please let me know
(I am not familiar with the DRM subsystem at all)

my initial idea was that the devfreq logic needs the same information
that the scheduler needs (whether we're submitting something to be
executed, there was a timeout, ...).
however, looking at drivers/gpu/drm/scheduler/ this seems pretty
stand-alone so I'm not sure it should go there
also the Mali-4x0 GPUs have some "PMU" which *may* be used instead of
polling the statistics internally
so this is where I realize that with my current knowledge I don't know
enough about lima, panfrost, DRM or the devfreq subsystem to get a
good idea where to put the code.


Martin
