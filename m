Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6333EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C542171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WqnDtaZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfHOAAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:00:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42238 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHOAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:00:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so604977qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQcEycbJpYwq03WKUHr1Col8h+hbyHngyQSZBqVtuao=;
        b=WqnDtaZOeGzmOCMQPC4We4PRD3RuiO/IALjyCYVZuuWQ7X8TuNS1arQXC7EG5H/WMM
         QoTLuRO+le+M6rRKQ+g/kpY4oRBlm26psPwlaph+NfO/QHkvqy5y7xLVn5asu5icHcX8
         4+cgO8/3DW0QOxaqqU3N1R3jkqcGn2CA/nu/llYZ7KTrYBM7rhgO5bNv15Mwl/qhHkFr
         xLgkDtM4ecYPJZGJaT+5ygz3Mtzt1oLeN40DNq1h3PCmx2kj0py9uxQtJ3zyBZMMMiMa
         2sMtpruVKWC3ihvALp2SoFVQLWI2B85dMUSqBzp9DgYpURT4u2F3Usbhyj4KoRDhvXLf
         XwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQcEycbJpYwq03WKUHr1Col8h+hbyHngyQSZBqVtuao=;
        b=L5fq2OaiKYswCjQMovvv9kqisKuKoGeekt1YfPseiZfE34H9ojD70D6HbO8WeibXHR
         SjrCSQJLbeH3U9msBk7MMLjboHXwOQ3mO8Fp7km0I6G9Ylgo1bsA+x93TAh0rDRFxo9p
         jdXmydIUvZwBnJmfDPfz8E1zf9EBRD2alJ5aYOY2bS0ZZfppRhp7fHMNZrOEd9nmlTl+
         Yea36RV509BRIvpFjPy4UTZtOcbaqraHTrVyBEm7Egou5OuiQHp9HL8LpEk46nqmHxjW
         uPzti1SOaDnMY6RLjmLrJ1+N5DVEzq0agU1Wta/g6Qm+jLbn1ka7B8CDHL2kMOGDQpb7
         EbzQ==
X-Gm-Message-State: APjAAAVrsem6GB3xdIOU871iQpAmCjp8AD0hokJw8EIsA/rDP+J+yHJ5
        zF/1gscnkeNHe9baNn6SEv6sqg==
X-Google-Smtp-Source: APXvYqwowo9TRatjr9x+Z0wkhKzzctBv0bQD6WAaHI7YUR2Bla8hl5jGs4NuJx4xbIBRiBZ2H9DzbA==
X-Received: by 2002:ac8:5315:: with SMTP id t21mr1735710qtn.66.1565827231022;
        Wed, 14 Aug 2019 17:00:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u126sm637456qkf.132.2019.08.14.17.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 17:00:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hy3Bt-0003UN-MJ; Wed, 14 Aug 2019 21:00:29 -0300
Date:   Wed, 14 Aug 2019 21:00:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/5] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190815000029.GC11200@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814202027.18735-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:20:25PM +0200, Daniel Vetter wrote:
> We need to make sure implementations don't cheat and don't have a
> possible schedule/blocking point deeply burried where review can't
> catch it.
> 
> I'm not sure whether this is the best way to make sure all the
> might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> But it gets the job done.
> 
> Inspired by an i915 patch series which did exactly that, because the
> rules haven't been entirely clear to us.

I thought lockdep already was able to detect:

 spin_lock()
 might_sleep();
 spin_unlock()

Am I mistaken? If yes, couldn't this patch just inject a dummy lockdep
spinlock?

Jason
