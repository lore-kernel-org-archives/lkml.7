Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B556BC76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5BA21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Yi1h9o2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbfGRQnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:43:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41778 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbfGRQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:43:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so30978008eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+W9Fu950QMsufBfCCPx+AFaKU8cPICx7xAobprqzZjM=;
        b=Yi1h9o2CQwbo6Qwnob3MkuqbT3GZvCeRMRmamE2v3Oszki45i8Qs9f/kn68w0M2+LQ
         Ff3szsQU67WdJ6ROZ8QobqIZAfnu5yM69u/ZsjYEguU7FSP3tT7h10tU7QCZmVv3VQWz
         3P9jA++wmEe1qRl4MmW6cB+kCHDIJVOm6KXYcujhMuT6knBHqhKSlNmGYJrFPQL06KRy
         T1P/te4/Q9JeLCfOxj6whZsaMQg9uK+eIFk1VXf9AF4mvFOoq/2gJarF0gL1FrBxHs8+
         gh0+Uec+7Heqi/fpINwOgeIWnXXsWOPhBE1CCM0kVhAYq9EF7UlRqhDeUelARzKrEG9L
         1TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W9Fu950QMsufBfCCPx+AFaKU8cPICx7xAobprqzZjM=;
        b=IeZdBZ8lt/XulAXXFlxwzq6Ehzp9JWu4i7auM/8yQP6YCPG7R26/Fnnb/352Isx+9Q
         mVLiM+zi+zMctW3ipDt2EwVhoIgjDE0a6uxZhj0BLvzpU9i0OwF3BfFrVAV4aOJVWYFM
         R8F99dIwSCZ595vK0j4ktOL1ZgwGzRvCo7jesW0J0AtynEpVjbi5wRQ26QId+IbiQiI7
         +ocW4pBt5YGsxYq17dlnZMCzwx52DceeOFPUTRDSi3DsyHUFmsnSVkdUYOcWdys2Rqzf
         AhyCDbv6aG0Z8c/TzKiPtVA2Rrls04Fvn+fJqw9w/g7j4EpPwWAoVmzNPWzKKtgU/evS
         dwXQ==
X-Gm-Message-State: APjAAAVORdMOmu1m8525JdjOZlsMnmDcjB4/M5tNDqGchllGLXmXuJeF
        whGNT1adP//8NOYY/r4cY95w2QYPoZgaauPxYsc=
X-Google-Smtp-Source: APXvYqxnrB4IiF1XWQJdXPRciWeUOMIOt0s4We1X1OrTsNZMGgvS6iWNLx4UmmepwkQUKKhdElmEUt7TKDRGSjXGvZQ=
X-Received: by 2002:aa7:c49a:: with SMTP id m26mr42805347edq.0.1563468224397;
 Thu, 18 Jul 2019 09:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190718024133.3873-1-leonardo@linux.ibm.com> <1563430353.3077.1.camel@suse.de>
 <0e67afe465cbbdf6ec9b122f596910cae77bc734.camel@linux.ibm.com>
 <20190718155704.GD30461@dhcp22.suse.cz> <CA+CK2bBU72owYSXH10LTU8NttvCASPNTNOqFfzA3XweXR3gOTw@mail.gmail.com>
 <20190718164043.GE30461@dhcp22.suse.cz>
In-Reply-To: <20190718164043.GE30461@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 18 Jul 2019 12:43:33 -0400
Message-ID: <CA+CK2bDG8xNAgn++8uTOP9OsuEzynm=-Gkb+oUj9DKB8sEudiA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in ZONE_MOVABLE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just trying to understand, if kernel parameters is the preferable
> > method, why do we even have
> >
> > MEMORY_HOTPLUG_DEFAULT_ONLINE
>
> I have some opinion on this one TBH. I have even tried to remove it. The
> config option has been added to workaround hotplug issues for some
> memory balloning usecases where it was believed that the memory consumed
> for the memory hotadd (struct pages) could get machine to OOM before
> userspace manages to online it. So I would be more than happy to remove
> it but there were some objections in the past. Maybe the work by Oscar
> to allocate memmaps from the hotplugged memory can finally put an end to
> this gross hack.

Makes sense, thank you for the background info.

Pasha
