Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1EDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22AE206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfJKOmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:42:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45B6C7E423
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:35:02 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id c17so4428096wro.18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMhlHZig+1RhiRk7V7Pz4VOZHaUmDl77u5gqUPus1Vw=;
        b=GCGa2PaK+1MpsCfLPct9Bbtpd9zTo629K47SJcJYAbTgoJJE/fz9De6OIoGnKEMir4
         oHdQnehokw7BAfALnDr6kTkyAjU0RBARQPUe8mo+7EzCo6KRRDzwxDZcYx4gvpYTRpNE
         pmrN/dAIwQhQcR2apafLdQKBALA7lk01zjrLoRkeH5nnTvP84ZpefvLbKL++nJ2Vr/Pc
         /L+2fsmhLMcT3pRDaVEXG+OlYneUOOa7kwRQW0IL92M/PAjDgHWt+eyS5ATl5m3YDvXs
         LsClV2KAWBkc+gHieBscIDw2xW/fg2KW14ULZxjKhJlwosCBTeP8dh7VGS4Vf7MVzEE3
         d4Aw==
X-Gm-Message-State: APjAAAXVXzXEz+LlM2UrKqkVqn/9ZKdUhJguIqnsEYXMYidMyRuKpvlw
        Amt3E/CxKNecbIcalnOK5nmoYiB9ZDPllx/ti9+8f7va6mIKjs5v9G5r4+DLFHtIJnr5pfB4ihY
        YttsU2N6HDUcTXmWCeCiZ3W1k
X-Received: by 2002:adf:dd88:: with SMTP id x8mr3048524wrl.140.1570804500916;
        Fri, 11 Oct 2019 07:35:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+Irj2vNmRio/nFmNCYUOj5zRQn/cFuQoq8tEJPRY6eLYwjr9hshihDbQlKDa3IF+n7XZANw==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr3048504wrl.140.1570804500699;
        Fri, 11 Oct 2019 07:35:00 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id g185sm12205685wme.10.2019.10.11.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:35:00 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:34:57 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] vsock: don't allow half-closed socket in the
 host transports
Message-ID: <20191011143457.4ujt3gg7oxco6gld@steredhat>
References: <20191011130758.22134-1-sgarzare@redhat.com>
 <20191011101408-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011101408-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:19:13AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 03:07:56PM +0200, Stefano Garzarella wrote:
> > We are implementing a test suite for the VSOCK sockets and we discovered
> > that vmci_transport never allowed half-closed socket on the host side.
> > 
> > As Jorgen explained [1] this is due to the implementation of VMCI.
> > 
> > Since we want to have the same behaviour across all transports, this
> > series adds a section in the "Implementation notes" to exaplain this
> > behaviour, and changes the vhost_transport to behave the same way.
> > 
> > [1] https://patchwork.ozlabs.org/cover/847998/#1831400
> 
> Half closed sockets are very useful, and lots of
> applications use tricks to swap a vsock for a tcp socket,
> which might as a result break.

Got it!

> 
> If VMCI really cares it can implement an ioctl to
> allow applications to detect that half closed sockets aren't supported.
> 
> It does not look like VMCI wants to bother (users do not read
> kernel implementation notes) so it does not really care.
> So why do we want to cripple other transports intentionally?

The main reason is that we are developing the test suite and we noticed
the miss match. Since we want to make sure that applications behave in
the same way on different transports, we thought we would solve it that
way.

But what you are saying (also in the reply of the patches) is actually
quite right. Not being publicized, applications do not expect this behavior,
so please discard this series.

My problem during the tests, was trying to figure out if half-closed
sockets were supported or not, so as you say adding an IOCTL or maybe
better a getsockopt() could solve the problem.

What do you think?

Thanks,
Stefano
