Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB61C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F0521D56
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieeib4Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbfISNjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:39:31 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39512 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389222AbfISNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:39:31 -0400
Received: by mail-yb1-f194.google.com with SMTP id o80so1334139ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh9epQbPDXS45t0vdSz30/htyHlI6NEZom/dNuM2sGs=;
        b=ieeib4ApNmoMaWTclSUxdRd2KtnX6idLkHzrhFUwAyBClrQ4kku9aL9aTofkCcrasC
         ZVdU1AM4T84Jn4WW5X+mUslTzGyn2RP3kRs453/UtfKoxf7aAByCAWxuuthh01LEZ6XZ
         pa2A5qr/JT3myBWj7qNoSPvwZce6BFFBGJUfVmzcG83Ee9lzDFFcaYitb65MhoXKye0u
         jaDkWCeVgEXo2LZ293ZeUnm5tbaDTCqcwbCIsnX7gWIC6hBFMQZsGviDyV18ukHdh5dN
         1EvTQ5Aa67fcKxfzhixaPaBbmhZqa+B9X7+YgvKmNFY5gywNqog/UzNZug8NUfp+5eGc
         C1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh9epQbPDXS45t0vdSz30/htyHlI6NEZom/dNuM2sGs=;
        b=X8Lweb1o2laQeLZr1UPX9iCGddOTpfahheO067BoNrxUNnlQOFsp5RHwX6+sBHZb3B
         vvBciiFRCl8oQMTRpyRTipUfLlngloS/+BnrkC6d1VGKdTFVbSKfwr1vPT75VRqBGvwQ
         4wEyiCpyDOdzmUv4y5GUG1t31a+BPyWZlneLm9nUAZyBolfuKua0vBfv7TBvvoOiXfyd
         Y2vppkBAhizWMs+chOxIoQwHhGuQVHAen7Q7tc7dpdyDiEVJA4KjE8BNqF06PyCc+QSt
         h84AFJEzTkG/mbeQKQW03JASBiBIvtCRhcRq9aXV8h6m1KOWYa9Eu1ruga2c07iRQ3eG
         CrJg==
X-Gm-Message-State: APjAAAVaFWabIaeT6tCXZ3sy0kuS4UdW66U/Y7TlHLqA2sjYjrjUOylq
        ocdbNQgPSTt7mtgLpzxM5KcCKPCbVk6KdRz2Z/knqw==
X-Google-Smtp-Source: APXvYqyTTjYSC4/xvE4YiMCj3MA7ZD4bi7SRQ4CDsCuRNHidPBrDbCC1madTD9IMdduZjh/1UXDKHeEVxOBAWhjVCFA=
X-Received: by 2002:a25:ba8d:: with SMTP id s13mr6638491ybg.332.1568900370326;
 Thu, 19 Sep 2019 06:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190905214553.1643060-1-guro@fb.com>
In-Reply-To: <20190905214553.1643060-1-guro@fb.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Thu, 19 Sep 2019 22:39:18 +0900
Message-ID: <CABCjUKByipk2e1Hh1_PwC+p2Fig=6RMfd0zBeVQtyn5Y48gYXQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 6:57 AM Roman Gushchin <guro@fb.com> wrote:
> The patchset has been tested on a number of different workloads in our
> production. In all cases, it saved hefty amounts of memory:
> 1) web frontend, 650-700 Mb, ~42% of slab memory
> 2) database cache, 750-800 Mb, ~35% of slab memory
> 3) dns server, 700 Mb, ~36% of slab memory

Do these workloads cycle through a lot of different memcgs?

For workloads that don't, wouldn't this approach potentially use more
memory? For example, a workload where everything is in one or two
memcgs, and those memcgs last forever.

-- Suleiman
