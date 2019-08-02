Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B9A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfHBOD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:03:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44063 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbfHBOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:03:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so42933962qtg.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WV2Ae/gfauZPjPhFYOLLqagCyB4HyL2HjQauKn3bqsM=;
        b=BN6ppvMHZ6rHkQNZt5Sm+ugGAhv8x9ZVCZArmAvG+lQ6Ah6y/+5lbsyAKPaDic66un
         9IGSwNh3+5n45W57wA2nzzVrT3gdm8h3M1YfReFJMJLPfb/9+YtYOPSOzwDqMsMSKg6i
         3h3Zo38BLrfNNSW5b9upZdllVhxVdKmhNO8vFOqMEkDzJnoUxNFVvM5+CtPPpFw4qPJ3
         zLm2lrDiB5Lx9Nbmuo8G7Di4mNeoesU+UtXCOgCtG7O3ICXRKc1rUjoEQVOBCTEcGPqy
         nrXo/w4rq9gprbZ+ewQsfZ9Qdx9/6cs604i4qXbSmcy0e6a5iL7Jsz/Pvad/LizLt9S+
         mhPA==
X-Gm-Message-State: APjAAAWOPEXrfvOIXylJeInfOpu3TljOtnD87lG1EL5ssTWSKw9d1nl9
        uqv8hKmXMsk9/97phEZ+AjW8pg==
X-Google-Smtp-Source: APXvYqxqWV5TMaysY1q7/YjNkaoGeUmT+T8Aja0Ppx3ngtfg+CGh7SDzsuYF2FJmZ32u93WwxfAAKw==
X-Received: by 2002:ac8:2b49:: with SMTP id 9mr99459163qtv.343.1564754637929;
        Fri, 02 Aug 2019 07:03:57 -0700 (PDT)
Received: from redhat.com ([147.234.38.1])
        by smtp.gmail.com with ESMTPSA id v4sm30651268qtq.15.2019.08.02.07.03.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 07:03:56 -0700 (PDT)
Date:   Fri, 2 Aug 2019 10:03:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190802094331-mutt-send-email-mst@kernel.org>
References: <20190731084655.7024-1-jasowang@redhat.com>
 <20190731084655.7024-8-jasowang@redhat.com>
 <20190731123935.GC3946@ziepe.ca>
 <7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
 <20190731193057.GG3946@ziepe.ca>
 <a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
 <20190801141512.GB23899@ziepe.ca>
 <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:40:07PM +0800, Jason Wang wrote:
> Btw, I come up another idea, that is to disable preemption when vhost thread
> need to access the memory. Then register preempt notifier and if vhost
> thread is preempted, we're sure no one will access the memory and can do the
> cleanup.

Great, more notifiers :(

Maybe can live with
1- disable preemption while using the cached pointer
2- teach vhost to recover from memory access failures,
   by switching to regular from/to user path

So if you want to try that, fine since it's a step in
the right direction.

But I think fundamentally it's not what we want to do long term.

It's always been a fundamental problem with this patch series that only
metadata is accessed through a direct pointer.

The difference in ways you handle metadata and data is what is
now coming and messing everything up.

So if continuing the direct map approach,
what is needed is a cache of mapped VM memory, then on a cache miss
we'd queue work along the lines of 1-2 above.

That's one direction to take. Another one is to give up on that and
write our own version of uaccess macros.  Add a "high security" flag to
the vhost module and if not active use these for userspace memory
access.


-- 
MST
