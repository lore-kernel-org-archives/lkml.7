Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B4C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E9A22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIDKhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfIDKhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:37:22 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5837D8F4FD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 10:37:21 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id b1so394730qtj.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 03:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3U+t4+2zJKbuXz99iZtKQog9/vhKyWkpmsxRg7JGQDE=;
        b=c3PfjT9hMCfsgATxGdsji6kyZbweI+DsU54Japl5Cxm4mjuiO1AQgO1oN/cqLywc0O
         lpU9BVo5YYXFko++hIxCCixrSjOuAcqGS2ft8z1werhjDYxpzuVOBBJTiKE0k80af2oy
         cYge7hPOdGesAZYvVPB+NP4rD8dsDmunLfs1wMfpM0SHivj1LWrGuXIAZewEB/8iLJWZ
         x0OJ6OzLF9m9hzFb38x4XT83hKUiuLEaZLnf432/11iKmT7twhDVfVaDC5hFRSEFfXKp
         Rk6xMQTLftBaAI72xlj+Asf2AJ0ouUha30aUUlr2U9bbiS6IzCrhDOcbftPIYfwGab7F
         nX9Q==
X-Gm-Message-State: APjAAAVML++R03lP4njekHJV58zv6RLS6jyx7+zmZOxr9tN+EV5zwPXT
        q1W13TtVyvOZrUI5GnvWF55aVG5wQtYQf0vtY1YVpkUYNexk3O6Os+QoP1J4skI5yaK0/OgxMnO
        KzJLCMWcRKKW7N23fAFOSqrWH
X-Received: by 2002:a37:4a88:: with SMTP id x130mr39287227qka.501.1567593440685;
        Wed, 04 Sep 2019 03:37:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzddU8SouAdok0NmEiOpSZh4ZsJm0UIpWp7Qa5JYWIOzRtEyne94p1wCOaQIiKI9ZMVFqLQg==
X-Received: by 2002:a37:4a88:: with SMTP id x130mr39287214qka.501.1567593440533;
        Wed, 04 Sep 2019 03:37:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id e7sm4085888qto.43.2019.09.04.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 03:37:19 -0700 (PDT)
Date:   Wed, 4 Sep 2019 06:37:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/balloon_compaction: suppress allocation warnings
Message-ID: <20190904063703-mutt-send-email-mst@kernel.org>
References: <20190820091646.29642-1-namit@vmware.com>
 <ba01ec8c-19c3-847c-a315-2f70f4b1fe31@redhat.com>
 <5BBC6CB3-2DCD-4A95-90C9-7C23482F9B32@vmware.com>
 <85c72875-278f-fbab-69c9-92dc1873d407@redhat.com>
 <FC42B62F-167F-4D7D-ADC5-926B36347E82@vmware.com>
 <2aa52636-4ca7-0d47-c5bf-42408af3ea0f@redhat.com>
 <D4105FF4-5DF3-4DB5-9325-855B63CD9AAD@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D4105FF4-5DF3-4DB5-9325-855B63CD9AAD@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 07:44:33PM +0000, Nadav Amit wrote:
> > On Aug 21, 2019, at 12:13 PM, David Hildenbrand <david@redhat.com> wrote:
> > 
> > On 21.08.19 18:34, Nadav Amit wrote:
> >>> On Aug 21, 2019, at 9:29 AM, David Hildenbrand <david@redhat.com> wrote:
> >>> 
> >>> On 21.08.19 18:23, Nadav Amit wrote:
> >>>>> On Aug 21, 2019, at 9:05 AM, David Hildenbrand <david@redhat.com> wrote:
> >>>>> 
> >>>>> On 20.08.19 11:16, Nadav Amit wrote:
> >>>>>> There is no reason to print warnings when balloon page allocation fails,
> >>>>>> as they are expected and can be handled gracefully.  Since VMware
> >>>>>> balloon now uses balloon-compaction infrastructure, and suppressed these
> >>>>>> warnings before, it is also beneficial to suppress these warnings to
> >>>>>> keep the same behavior that the balloon had before.
> >>>>> 
> >>>>> I am not sure if that's a good idea. The allocation warnings are usually
> >>>>> the only trace of "the user/admin did something bad because he/she tried
> >>>>> to inflate the balloon to an unsafe value". Believe me, I processed a
> >>>>> couple of such bugreports related to virtio-balloon and the warning were
> >>>>> very helpful for that.
> >>>> 
> >>>> Ok, so a message is needed, but does it have to be a generic frightening
> >>>> warning?
> >>>> 
> >>>> How about using __GFP_NOWARN, and if allocation do something like:
> >>>> 
> >>>> pr_warn(“Balloon memory allocation failed”);
> >>>> 
> >>>> Or even something more informative? This would surely be less intimidating
> >>>> for common users.
> >>> 
> >>> ratelimit would make sense :)
> >>> 
> >>> And yes, this would certainly be nicer.
> >> 
> >> Thanks. I will post v2 of the patch.
> > 
> > As discussed in v2, we already print a warning in virtio-balloon, so I
> > am fine with this patch.
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Michael,
> 
> If it is possible to get it to 5.3, to avoid behavioral change for VMware
> balloon users, it would be great.
> 
> Thanks,
> Nadav

Just back from vacation, I'll try.

