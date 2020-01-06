Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA78C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0A52075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE/Il/my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFQBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:01:24 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35988 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:01:24 -0500
Received: by mail-ua1-f66.google.com with SMTP id y3so13390519uae.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHKvj+lR2oxOoJDYfB6OF+P0g9s4Fqqs9QyHOmAvNmo=;
        b=hE/Il/myONgZlPpM8dlP5hw/oNFkwGoIN4KZ+UY30BclcbEOUqUAWhMT9MwU5gZBxx
         gptw9QRBG10TwkwJAciBTr1c1//qBZB0PU3e3vyxhViKR94ANuJYmDclsBnmg+T+HU7v
         uFM//nFhAhfWR826oCEUpvKst94HTwOj9F64CfMr+aUEcftPvMW/9wEQ6FZkpDgk9UNh
         Nh++Q8b7giwiQpWsElAsGunOQGXVyNGxgfM2sST2pxro7mLwJiYKOZ3znx05Q10QH7QO
         ZSro9EN6Hzy2bT4uIfk7dmHuTXXR2CZJK/OuLFjHNnB4fqMlOe3Z3idimGPjERQKqMvv
         EChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHKvj+lR2oxOoJDYfB6OF+P0g9s4Fqqs9QyHOmAvNmo=;
        b=Xamje/unqzSAwEKqgUDOMaK93XOj4PlavTXVvZLI2RkMsIETiWU/EI0J0JezTOEOO3
         LRGR7xDwmCfU8phKBTF9OfmO7kjdfw/Xq64cJuoszpUW1BccqzS/Mhyi4wGZBFyA7UUF
         Nt/jHyJDgoHmknB9/dr8uhQ0JJNfcSekqdQ8/XFZuO7XpC09Qe3LEkCR6dlfcn1uiJ7Z
         3aCNxFUMtFeO12yK3up9xBgQ+OkGJ+glB0vg2eBEezkZqIppRiuJqeIi1wrJIhT1UQ6b
         ccMJ41u93bqFE4Y+bG+izz+zCMLtQlKpSx0n28M/n+CORdlGzpi5fD7pwHpAD0VZ8Qrm
         H+7w==
X-Gm-Message-State: APjAAAWH65Kueb0oK/N3vXjhBQXACHgqcPuGpPpG5HcBEqqSE8zWwnN6
        k7uh5eIr8/6stx1MqTmTpVRg2+t3bnvuXYyfjjrjpBmOEK0=
X-Google-Smtp-Source: APXvYqyanrUg5kMh1Y7eIxZ0CnYSMUXd/hQcoQkIbAMWiOWbPfnrcHCsktMDMB1gAMN1jTUdSGTJGPI1aMc5afzrAXM=
X-Received: by 2002:ab0:4aca:: with SMTP id t10mr57253605uae.89.1578326483419;
 Mon, 06 Jan 2020 08:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20200106151655.311413-1-christian.gmeiner@gmail.com> <20200106153643.GA8535@ravnborg.org>
In-Reply-To: <20200106153643.GA8535@ravnborg.org>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 6 Jan 2020 17:01:11 +0100
Message-ID: <CAH9NwWd7C+DzAKe97kURm=sGjDH+KQJOif3j=w6K+99xmYGncQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] update hwdw for gc400
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> For future patches can you please incldue a small changelog
> within each patch.
>
> Something like
>
> v2:
>   - Drop redundant newlines (Lucas)
>
> This serves several purposes:
> - It explains what was changed since last version
> - It allow the reader to focus on changed parts
> - It attributes who requested a specific change
> - It gives a good idea of the history of a patch
>
> In the DRM sub-subsystem the idea is that if it is written it
> should be visible in git too. So include the changelog part in the
> normal commit-message.
>

To be honest.. I forgot the change log thing this time - sorry. So the rule
is to have the change log in the normal commit message?
Funny - Lucas told me something different:

"Please move those changelogs below the 3 dashes, so they don't end up
in the commit message. They don't really add any value to the
persistent kernel history."
https://lkml.org/lkml/2019/9/13/107

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
