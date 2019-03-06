Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476C72087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551896932;
	bh=XEHYugALkOJ3sKhhnOtoGK27CFcxe+dVmOAZkm1QKFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gmF6xzkVjHVKdIpJNjntfU4sx2hHDt6O6+PaPl6Wu8aTi3UswHpoAFOcLYnD5RdFI
	 fsb/0CJat+aSubgSq4wu3+aCo7D384kzyEU/9JydyN6bl9pYPF8PPOvV1sYDMGchYw
	 RK2jZPbR8jYIlmc3kZHywcBwy2UWdo9jkwtZwYtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCFS2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:28:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35653 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfCFS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:28:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id t13so11827374lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAPCPOITO43YGfDKdOk4wuEOVP+2Ff3yYyXcE45vl6I=;
        b=QPokLT1Y0LDgpusJ6cKvBK095OS/xp8aCnFjY/2sYTLtB443SwnF88y7sdA2IVEgI9
         /bWXjbcDGCSJoZTjz5awdb2UfzXOWtmgM0vMI/3dnjHy49h5EhNU/HKDxQ7pQT162m0M
         gvlLazQ8JM4vcjpXt7TbakzzVulaPw4TbAvKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAPCPOITO43YGfDKdOk4wuEOVP+2Ff3yYyXcE45vl6I=;
        b=CZNXC5Hn8bBk23JV28CMNkFj0F77TIhocZ5/oIBx0GVO2MuAV/jRcxZYXxUlQPiu/Q
         xaHoyQDe6jbsSftOxCoRX2V/GeDJvBZd1MUk9LCt72npdqcKr6gQyUWSRzrh5UchQGDd
         Bqco0aJIa6STiyPd1N7E5m7OTPFy5/2ieHCaDn+yDaC7sVJfobtWw2U7NTN9145UHFGI
         iU4kB7lguGh4A7BSCQ3/HzFWvCx9e5HEorDVBnQlzRsCG5z3/1ujS8gHXVe9q8nk5ds/
         fokGMH3NaD2KfE4xdHmHXjmwPSokjIS9EOUYKimj3sUxFGrg+bm0y58NvDDG988C61Yj
         +5Vg==
X-Gm-Message-State: APjAAAUbHK4h6o+YO7M/t4ltum1NnxbwOtma6F+R0rt/BqjCyva0iHhs
        dheb6FhBFH3HB58dwAx8d1K7GYBCChU=
X-Google-Smtp-Source: APXvYqx54D3jVnzFz1kRF8MUJg5wYmsZThz7XhyOAlcz0RM6XA/pohStN460QiQ7g+JwAYMuiQkgIg==
X-Received: by 2002:a2e:5d59:: with SMTP id r86mr2852197ljb.158.1551896927397;
        Wed, 06 Mar 2019 10:28:47 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u18sm440922lfd.15.2019.03.06.10.28.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:28:46 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z20so11804915ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:28:46 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr3244950lji.125.1551896926079;
 Wed, 06 Mar 2019 10:28:46 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
 <CAHk-=wgdJKaDt=Dp_DS+LL3bzRZUo2VHHMZU_VUMukSPzRJPUw@mail.gmail.com> <20190306181557.fndmy5oks3sximeo@shell.armlinux.org.uk>
In-Reply-To: <20190306181557.fndmy5oks3sximeo@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 10:28:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGEzQXYoriCdx6MpdY86v5u+BfkHey9dKoU11A9F+Bdw@mail.gmail.com>
Message-ID: <CAHk-=wgGEzQXYoriCdx6MpdY86v5u+BfkHey9dKoU11A9F+Bdw@mail.gmail.com>
Subject: Re: [GIT PULL 3/6] ARM: SoC driver updates for 5.1
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:16 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Would it be worth splitting up mod_devicetable.h and having drivers
> include just the bus-specific device table header(s) that the driver
> requires?

That would certainly help rebuilds when it changes.

But maybe those changes are just not common enough to worry about, and
maybe it would result in more maintenance pain. Who knows?

I just wanted to mention it since it surprised me and I spent the few
minutes to figure out what the offending header file was, and see if
somebody feels motivated.

It does seem a bit pointless and wrong to have the core acpi.h header
file include this, and then cause files to be recompiled just because
some entirely unrelated device ID model changed.

So maybe it would indeed be better having each device type have its
own header file ("include/linux/acpi_devicetable.h"), and then for the
(few) cases that might want to handle _any_ type could include that
"mod_devicetable.h" that then just aggregates them?

But as mentioned, I'm not sure it's worth it, just throwing this issue
out to see what people think.

            Linus
