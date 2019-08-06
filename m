Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC1DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE3E20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfHFNhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:37:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46802 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:37:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id r4so62758583qkm.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EmwYezlru/6l1RGke6OfmjMerhgmwmHntHPbq6+2AE=;
        b=X9jivODWgvbrVW3YnABVDFkAgfLbnFTLsljL+72r/VTHs+S38Gtw2F650AAzjbuoep
         uoU5VEZHCt6dVtI3isF4NZKv0ebdWx57yeO4hbg5cjPulpMsNw4jCECVl3F//4kgCsaS
         r69yCb44T5QnAzO18neujO8CYh14nl+wKhkAfuA01Uvj23tn8jghxvzhK/tQBDUqjeDK
         inZTz2+ivmrMmDcrXMkN4TNSQBb8RfbygyON6V5TNQqArE8me2M+FlekHrNH+odaHZS2
         S8myt5DTVgV76eXKKFsmlt1tn0Vgi9y2ecp8LoXxLttwc2wmvMm7MxHQriyLXxD/088H
         vR5g==
X-Gm-Message-State: APjAAAWly5YGNwEherX3bE0KAU6ifUUVW86E8riHlbS/Fz+GTdAEOSDd
        RWMCvNz0JxPXPkYS1SpX5wEoJQ==
X-Google-Smtp-Source: APXvYqwQogResfBtEcBuAcFTuCtTWGzeNFF/0eeIOxkxJPkA8JpnI8WBDTcUIzFbb3AvBDILVnFfYQ==
X-Received: by 2002:ae9:efc6:: with SMTP id d189mr2946499qkg.323.1565098625407;
        Tue, 06 Aug 2019 06:37:05 -0700 (PDT)
Received: from redhat.com ([147.234.38.1])
        by smtp.gmail.com with ESMTPSA id q73sm24068906qke.90.2019.08.06.06.37.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:37:04 -0700 (PDT)
Date:   Tue, 6 Aug 2019 09:36:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190806093633-mutt-send-email-mst@kernel.org>
References: <a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
 <20190801141512.GB23899@ziepe.ca>
 <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
 <20190802124613.GA11245@ziepe.ca>
 <20190802100414-mutt-send-email-mst@kernel.org>
 <20190802172418.GB11245@ziepe.ca>
 <20190803172944-mutt-send-email-mst@kernel.org>
 <20190804001400.GA25543@ziepe.ca>
 <20190804040034-mutt-send-email-mst@kernel.org>
 <20190806115317.GA11627@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806115317.GA11627@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:53:17AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 04, 2019 at 04:07:17AM -0400, Michael S. Tsirkin wrote:
> > > > > Also, why can't this just permanently GUP the pages? In fact, where
> > > > > does it put_page them anyhow? Worrying that 7f466 adds a get_user page
> > > > > but does not add a put_page??
> > > 
> > > You didn't answer this.. Why not just use GUP?
> > > 
> > > Jason
> > 
> > Sorry I misunderstood the question. Permanent GUP breaks lots of
> > functionality we need such as THP and numa balancing.
> 
> Really? It doesn't look like that many pages are involved..
> 
> Jason

Yea. But they just might happen to be heavily accessed ones....

-- 
MST
