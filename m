Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC62206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfJMNjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 09:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbfJMNjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 09:39:11 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C85C9859FC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 13:39:10 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id w7so14248985qkf.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 06:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXBZT+KuCy4M5CNTs9dJ7Gfn83TIs8hw++O0P5w+0dg=;
        b=NcqnHTF7RgY6SVmqvwCxyoSwlmxcrhXVGET/oGsZYI0wGcKO6bE7NPFXIn592frJfn
         sVHFP9KXedD32DZPtKnqtZGxeIhmC9nmnxa+0ZNRYzNw7puEewpinVK+UtgoaaL/sxAa
         NIDkP6RBJIG6AmS6lT55tuNdIllHIvGzgWH9njIJSjFnOOqcv5UiRpbhyzbNfi1ntZzI
         8yCdGBoR4GvN5dM1GHDAklj3w/YXlqdEK1wtwqRu/OfozoiYbgMiOXNf8Xn0v7DyXN/a
         QbbdF7azNTHkGApaZIx/7RX38hATuubA5Gq6UENxjXHeo/RVoYq5+5h+AAijCaZWS5Il
         +uKg==
X-Gm-Message-State: APjAAAV0pn3Kbpsz2KHVoMJAhNHrK9hilPpycbobZ/JQCj+TZPibS4iP
        5LeHXh1epBbRm9FlULg0SdY6jXJ7Vcg8Y1olz07OGehKWe43aQfJ1Koh7GhTkOh/Sov3Yn1Gjca
        HGyChaUeSxxHi3B7dhvOOt4J4
X-Received: by 2002:a37:8b03:: with SMTP id n3mr25557173qkd.493.1570973949760;
        Sun, 13 Oct 2019 06:39:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5WF3wXokXVKUTg2nwOQe8Mt902ONvM0nGoT3IhiJAEnCmxpugGwOSneWWqPK9EJJ85g4ciw==
X-Received: by 2002:a37:8b03:: with SMTP id n3mr25557159qkd.493.1570973949553;
        Sun, 13 Oct 2019 06:39:09 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id z13sm6416308qkj.34.2019.10.13.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 06:39:08 -0700 (PDT)
Date:   Sun, 13 Oct 2019 09:39:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Fix build
Message-ID: <20191013093844-mutt-send-email-mst@kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
 <20191013075107-mutt-send-email-mst@kernel.org>
 <08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
 <20191013081541-mutt-send-email-mst@kernel.org>
 <eacb6818-fe3e-f983-9946-e172f0077d4b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacb6818-fe3e-f983-9946-e172f0077d4b@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 03:29:34PM +0200, Jan Kiszka wrote:
> On 13.10.19 14:20, Michael S. Tsirkin wrote:
> > On Sun, Oct 13, 2019 at 02:01:03PM +0200, Jan Kiszka wrote:
> >> On 13.10.19 13:52, Michael S. Tsirkin wrote:
> >>> On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> Various changes in the recent kernel versions broke the build due to
> >>>> missing function and header stubs.
> >>>>
> >>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> Thanks!
> >>> I think it's already fixes in the vhost tree.
> >>> That tree also includes a bugfix for the test.
> >>> Can you pls give it a spin and report?
> >>
> >> Mostly fixed: the xen_domain stup is missing.
> >>
> >> Jan
> >
> > That's in xen/xen.h. Do you still see any build errors?
> 
> ca16cf7b30ca79eeca4d612af121e664ee7d8737 lacks this - forgot to add to
> some commit?
> 
> Jan

Oh, you are right.
Should be fixed now.
Thanks!
-- 
MST
