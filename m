Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30725C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F365921734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/YPSKpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfD3PnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:43:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36006 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3PnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:43:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id x78so5847563vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxw3hN1YSm26ISg+LOrlcUFUk2/ynydw3TOb8ZPeF0s=;
        b=O/YPSKpdJNfI7U6oIOgur+JBh6lLTX26M/YLxxTMTTbCOdPzII6OA9QsPMywPziiVG
         zpbQJz5mB/J7NdHufCTiy3vXfHvVklhiXXTRr5MFYctmmoM/5ysemaK2nE9o2A82LpFE
         EkHyne5+Jcq6bx5DKtAGx12ur+JpsGrBj8JHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxw3hN1YSm26ISg+LOrlcUFUk2/ynydw3TOb8ZPeF0s=;
        b=FC3RJQjsTc16tVzXv9DEzO7Gz+ct1l0WI+b//T8OyIPTwnWmNJ6Nyh2vv+lgUhVQXl
         OVaJoN7bEs9oB5vzyHB3hTiKQKHgGbgbcDENaugpizFjgkwaTxixTWEjePDI0kwADT/L
         NALsoSYjbNtOHLdb27OXVEbqGlWpWjUXJdTqEXI/monAYNKmb1q8zo5r7vkbQlFVQw9J
         WaSxiLkOJU7de7rmPjYdzMzT773KlpnfnI8yYE/Jbxl+PRHolJXRj0h4rq1je8ewjiC+
         TpGZu5u8fiVAlsp7xQ0xcOh4CbvizAJtcPgpOoLdXkJ0sgiU97lSC7+xjFQ5F9+Gd2pO
         ArPg==
X-Gm-Message-State: APjAAAUyQ2+/FRE+kQEjBceigXKj91NnszCY1ScN0Z1sT9CRDj2clq58
        xMpuGdp4iSHv2/S3dFE7Y5fPaGsu1R0=
X-Google-Smtp-Source: APXvYqyL0dmlO05ciEfV9jAndFvNTh1CXO5ZeV4jFGVVEiedFwLJ1FqyghUD2TebO9h89TzNBTGqVg==
X-Received: by 2002:a67:a446:: with SMTP id p6mr36133665vsh.198.1556638979956;
        Tue, 30 Apr 2019 08:42:59 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id v124sm8640444vke.42.2019.04.30.08.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:42:55 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id g127so8272416vsd.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:42:54 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr36496756vsp.66.1556638973924;
 Tue, 30 Apr 2019 08:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com> <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
In-Reply-To: <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 08:42:42 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
Message-ID: <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > Add a const int array containing the most commonly used values,
> > some macros to refer more easily to the correct array member,
> > and use them instead of creating a local one for every object file.
> >
>
> Ok it seems that this simply can't be done, because there are at least
> two points where extra1,2 are set to a non const struct:
> in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> and a struct net.

Why can't these be converted to const also? I don't see the pointer
changing anywhere. They're created in one place and never changed.

If it's only a couple places, it seems like it'd be nice to get these fixed.

-- 
Kees Cook
