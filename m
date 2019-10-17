Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A4CA9EB3
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1646E21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbobrowski-org.20150623.gappssmtp.com header.i=@mbobrowski-org.20150623.gappssmtp.com header.b="P9ne7A9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441716AbfJQXIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 19:08:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44405 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441702AbfJQXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 19:08:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so2201381pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98GpYLRwSkTQW+31mE56KMoWjsDPbX3fOPDTfwNIEJY=;
        b=P9ne7A9VWvIgJ2CO0Eq3g3Kuwsg77OIPUU+GUMXqFkhK5opoPq3Il7YFz+76EO/J+t
         7QHE4Aa6cQMU7X2JhpLe3yAyTAaLF5dtPVAkZa0M2g4Ixr6Usjl5mItPREAGWevki8rq
         ngIG77OZuG6GQMqfLAtfu/F/e9wekmOYLZQWeo38NfDgj/NkBIO4ScpZr00AYYlcZZC5
         OKtHkwEQDctGBeSTwEH9caCaMmriRHAgWvOHonl9dKWoOkGJwRoKWfM4geEtbeDP/Ico
         tCrVeZ/0+dk1GqzmjU9kl/zbuu3nmGqOiLdOxNzZH49j0tNMfIHi9qcb5fo8To4wJQHP
         xRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98GpYLRwSkTQW+31mE56KMoWjsDPbX3fOPDTfwNIEJY=;
        b=M/iXwADY9PBpx1yBCpcEWERAzrvuxZe5rqyknLE7J+e21G+z5LK5LkIQhnQ1B/97AK
         sgWpMdvMjhHky8qWurdM15rQ4l/eATB66ajaZxSo5ZloNz/KKDfpVWwc/zlYIuy6z8F6
         12NsVBoRFdkxgjSK6d/lzuv9daDnuaP4ofg5UruqC15pajZa6rxPdgPWmu005eQsPoY0
         +aO67WbLmFFVAaYlL/zvZdNwtBN8/SRjbk7X2pSdijYgTqyYMWO0AYZj4MZpW00xarWj
         W9NE4mZVc3jfItQibynDtNGLMIRkd/kyS9YLfmI1PubWTMZIJBrj7N9BngozQ/MsqC97
         maJA==
X-Gm-Message-State: APjAAAVDIoo6jzIXKi56IiDd9d+y5oksXCE0tWmwCEKzJXsP287ziBay
        2FkxVdmy5G7gkZLEze8l2n3I
X-Google-Smtp-Source: APXvYqyYF3m9FhGnMdMs4e2xcow7BtBbKNzso2k1mf749r04JEdi6TI4LKrua9x0eLSiK5Xnypurvw==
X-Received: by 2002:a63:41c7:: with SMTP id o190mr6771050pga.6.1571353701420;
        Thu, 17 Oct 2019 16:08:21 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id t11sm3418848pjy.10.2019.10.17.16.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:08:20 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:08:14 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 01/14] iomap: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191017230814.GB31874@bobrowski>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-2-hch@lst.de>
 <20191017183917.GL13108@magnolia>
 <20191017215613.GN16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017215613.GN16973@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 08:56:13AM +1100, Dave Chinner wrote:
> On Thu, Oct 17, 2019 at 11:39:17AM -0700, Darrick J. Wong wrote:
> > On Thu, Oct 17, 2019 at 07:56:11PM +0200, Christoph Hellwig wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > When doing a direct IO that spans the current EOF, and there are
> > > written blocks beyond EOF that extend beyond the current write, the
> > > only metadata update that needs to be done is a file size extension.
> > > 
> > > However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> > > there is IO completion metadata updates required, and hence we may
> > > fail to correctly sync file size extensions made in IO completion
> > > when O_DSYNC writes are being used and the hardware supports FUA.
> > > 
> > > Hence when setting IOMAP_F_DIRTY, we need to also take into account
> > > whether the iomap spans the current EOF. If it does, then we need to
> > > mark it dirty so that IO completion will call generic_write_sync()
> > > to flush the inode size update to stable storage correctly.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Looks ok, but need fixes tag.  Also, might it be wise to split off the
> > ext4 section into a separate patch so that it can be backported
> > separately?
> 
> I 've done a bit more digging on this, and the ext4 part is not
> needed for DAX as IOMAP_F_DIRTY is only used in the page fault path
> and hence can't change the file size. As such, this only affects
> direct IO. Hence the ext4 hunk can be added to the ext4 iomap-dio
> patchset that is being developed rather than being in this patch.

Noted, thanks Dave. I've incorporated the ext4 related change into my patch
series.

--<M>--
