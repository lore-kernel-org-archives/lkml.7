Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E244C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4570120C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nc3ULfAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfHFNke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:40:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34487 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHFNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:40:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so62861478qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNzsOgLAi4DpECpGRrewtthquhRyGxeGVQXq8haedDU=;
        b=nc3ULfAxivmoeOVWtx4pEkcKqWu7gMWhZ1T9c67WVWKwR/tqg4tjz06IHSiy7/T1mM
         1Q9OgN3SKGqoN0fTofviJhtk+Y8Fnu6Rb9wlYk2j8XzfT49iKaQgZskM/1nQuoKXVyrg
         x7tKm90nh5lvD0if38GgDipFfBZn9HvMJg3lzYCC5JZp61ytJWsdqe/KqqgbJCT1alsH
         YRrG5mFigDCgWFVNUPK0RWvRiPVQp4r15i+HE+vsy+0UofzeByMFI318I8OMNMaejIys
         JaRCTgreBgdiEAQrQGSv5kop0m94iD49e5Xbjmt0OHKcuev72yVdTxaI38Rng+Q3PBaC
         NvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNzsOgLAi4DpECpGRrewtthquhRyGxeGVQXq8haedDU=;
        b=QpAn2DiF9FN0bFDwNskosaUBU+Em1H83GtP/vELUqujD7fYQ6CNhQRwwsxg8r97pkB
         8lQ/p0EPeYeQfqWZW5ga5nt8pRhElfuihCRMLpGHBaOIYYXFMzIllRDAX6tCkeaPpZQT
         /dQJsz8mEA/rGCoSkgKwmhf+fxxp/UxjRppizzilg2ablHHr8yFgrRPEEBTE5QodWksh
         pTYGRnQ0ILdSBWOd+zYZvCDzntTrdMDjJoDb3FCF1e5FmI5tDCzJSH25Fr9cQGQSzV1x
         vTr8DLockqQYt3ZCbG64ld3WSizYDmt35irH7oHoSk+qczrLJMLsBKT6TTA97L0GKrwu
         A+xQ==
X-Gm-Message-State: APjAAAVBsJjxI25yy6VhdYFI1GwvrUV3chRDQr4s+NXR9qJmwgPd0XxO
        lrD1x2DA1Ky9bVR4QdDsINOQyg==
X-Google-Smtp-Source: APXvYqxMfwBB47axCWNEJctHilcnayHipqGXZY261+EFRwNZ/6dzvsnkK6i+idF6ma2zmUwEOo/rBA==
X-Received: by 2002:a05:620a:31b:: with SMTP id s27mr3219001qkm.264.1565098832774;
        Tue, 06 Aug 2019 06:40:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u18sm36087109qkj.98.2019.08.06.06.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 06:40:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1huzhW-0004zI-Ru; Tue, 06 Aug 2019 10:40:30 -0300
Date:   Tue, 6 Aug 2019 10:40:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190806134030.GD11627@ziepe.ca>
References: <20190801141512.GB23899@ziepe.ca>
 <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
 <20190802124613.GA11245@ziepe.ca>
 <20190802100414-mutt-send-email-mst@kernel.org>
 <20190802172418.GB11245@ziepe.ca>
 <20190803172944-mutt-send-email-mst@kernel.org>
 <20190804001400.GA25543@ziepe.ca>
 <20190804040034-mutt-send-email-mst@kernel.org>
 <20190806115317.GA11627@ziepe.ca>
 <20190806093633-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806093633-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:36:58AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 06, 2019 at 08:53:17AM -0300, Jason Gunthorpe wrote:
> > On Sun, Aug 04, 2019 at 04:07:17AM -0400, Michael S. Tsirkin wrote:
> > > > > > Also, why can't this just permanently GUP the pages? In fact, where
> > > > > > does it put_page them anyhow? Worrying that 7f466 adds a get_user page
> > > > > > but does not add a put_page??
> > > > 
> > > > You didn't answer this.. Why not just use GUP?
> > > > 
> > > > Jason
> > > 
> > > Sorry I misunderstood the question. Permanent GUP breaks lots of
> > > functionality we need such as THP and numa balancing.
> > 
> > Really? It doesn't look like that many pages are involved..
> > 
> > Jason
> 
> Yea. But they just might happen to be heavily accessed ones....

Maybe you can solve the numa balance problem some other way and use
normal GUP..

Jason 
