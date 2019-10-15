Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86617ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1DF21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itmfcmkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJOLYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:24:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55955 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOLYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:24:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so20419213wma.5;
        Tue, 15 Oct 2019 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8A7Og6YrsNa6Jz4NPh/sr2qSneIY/eo7oy9Kxx1XwyI=;
        b=itmfcmkP98PF2cuksSleUiSre0o4GC8cxVqb/B0PXO5YN8dxgloXDcSxtIPzcdEyPC
         3k6N7do6sEFPNYQ+sL4CUR54wqrfEvxnFBtBGDV/IZQpc9cEi3dInpn/2cHLrs4QZIAw
         2dr91MVvoxnp6yAyazvqfez8Q92Y+EouYXfP78a5QjP/VILyXJG0pX1rjwjGn48A0g1c
         v61fproDxAuc4EZw66LQpGZ5/aDHjZFqjN3cv7iPLj2QljTswdfTJHDqYQk/NRquovjI
         mqEdRT1DA+NgtIDfo+D35Pm39yoXCdvHAu2JOKIggc6JgodnE+VOHk5LXlymQApGUr18
         1R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8A7Og6YrsNa6Jz4NPh/sr2qSneIY/eo7oy9Kxx1XwyI=;
        b=dzXtGyJCmd16FAWF9NRyPnvJq7RKKf5RaYHMgvO9ED+YBjTmaES66kM61oJpEiYh98
         W86hv1Nqa7l5jnJ5XLfuQ8+PkGeLHoF2YqvHj0LErUjfyZ/bKNchcKwj1dN3E2iVBVnE
         0XyYnI/y3WLQmC2tF7XD8hRVAy9ydVQEPj/JtAsQqaU5Ly5RdxdsLW994bnrt0VYFRho
         4/62dy1r4OzGzpxDASBdwpYxUyYIR8wbMo6m1NuzZ3P8qC+K0rGxKhgzlU7MfW4BM9LA
         PAz7U3HEIqxixUQnWVavpLnhoKVfugTqD0mXHi7RLvLu0a9+rJNvynvkpWcGnDVZ8sTP
         NZkg==
X-Gm-Message-State: APjAAAXkpWugYzjoOb8NiuFmb3CsetT4pNcqPKQNOFVfkF/IjKVhRBHg
        rZxR3Iy+hq7gDImnPPA0tIF10D3hHtM=
X-Google-Smtp-Source: APXvYqwgKFVoBdR2vB6WfkTcUeVjwLe+r3you6uJEglg0KqmHpyWY6/964F9b3P1HHYuj+ZjHn71VA==
X-Received: by 2002:a7b:c773:: with SMTP id x19mr18460344wmk.157.1571138692413;
        Tue, 15 Oct 2019 04:24:52 -0700 (PDT)
Received: from AlexGordeev-DPT-VI0092 ([213.86.25.46])
        by smtp.gmail.com with ESMTPSA id t6sm38301036wmf.8.2019.10.15.04.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 04:24:51 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:24:50 +0200
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191015112449.GA28852@AlexGordeev-DPT-VI0092>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191009121441.GM25098@kadam>
 <20191009145811.GA3823@AlexGordeev-DPT-VI0092>
 <20191009185323.GG13286@kadam>
 <20191010085144.GA14197@AlexGordeev-DPT-VI0092>
 <20191010113034.GN13286@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113034.GN13286@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:30:34PM +0300, Dan Carpenter wrote:
> On Thu, Oct 10, 2019 at 10:51:45AM +0200, Alexander Gordeev wrote:
> > On Wed, Oct 09, 2019 at 09:53:23PM +0300, Dan Carpenter wrote:
> > > > > > +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> > > > > > +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
> > > > > > +	struct avalon_dma_desc *desc;
> > > > > > +	struct virt_dma_desc *vdesc;
> > > > > > +	bool rd_done;
> > > > > > +	bool wr_done;
> > > > > > +
> > > > > > +	spin_lock(lock);

[*]

> > > > > > +
> > > > > > +	rd_done = (hw->h2d_last_id < 0);
> > > > > > +	wr_done = (hw->d2h_last_id < 0);
> > > > > > +
> > > > > > +	if (rd_done && wr_done) {
> > > > > > +		spin_unlock(lock);
> > > > > > +		return IRQ_NONE;
> > > > > > +	}
> > > > > > +
> > > > > > +	do {
> > > > > > +		if (!rd_done && rd_flags[hw->h2d_last_id])
> > > > > > +			rd_done = true;
> > > > > > +
> > > > > > +		if (!wr_done && wr_flags[hw->d2h_last_id])
> > > > > > +			wr_done = true;
> > > > > > +	} while (!rd_done || !wr_done);
> > > > > 
> > > > > This loop is very strange.  It feels like the last_id indexes needs
> > > > > to atomic or protected from racing somehow so we don't do an out of
> > > > > bounds read.
> > 
> > [...]
> > 
> > > You're missing my point.  When we set
> > > hw->d2h_last_id = 1;
> > [1]
> > > ...
> > > hw->d2h_last_id = 2;
> > [2]
> > 
> > > There is a tiny moment where ->d2h_last_id is transitioning from 1 to 2
> > > where its value is unknown.  We're in a busy loop here so we have a
> > > decent chance of hitting that 1/1000,000th of a second.  If we happen to
> > > hit it at exactly the right time then we're reading from a random
> > > address and it will cause an oops.
> > > 
> > > We have to use atomic_t types or something to handle race conditions.
> > 
> > Err.. I am still missing the point :( In your example I do see a chance
> > for a reader to read out 1 at point in time [2] - because of SMP race.
> > But what could it be other than 1 or 2?
> > 
> 
> The 1 to 2 transition was a poorly chosen example, but a -1 to 1
> trasition is better.  The cpu could write a byte at a time.  So maybe
> it only wrote the two highest bytes so now it's 0xffff.  It's not -1 and
> it's not 1 and it's not a valid index.
> 
> > Anyways, all code paths dealing with h2d_last_id and d2h_last_id indexes
> > are protected with a spinlock.
> 
> You have to protect both the writer and the reader.  (That's why this
> bug is so easy to spot).  https://lwn.net/Articles/793253/

I struggle to realize how the spinlock I use (see [*] above) does not
protect the reader.

I am going to post updated version shortly, hopefully it will make more
sense.

> regards,
> dan carpenter
> 
