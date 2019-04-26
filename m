Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CB1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D536E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JelVN6Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfDZOlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:41:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46485 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:41:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so4726652wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wz/vk4VU0P+AZaAcYN2OYniYGEe4LFUaLCl1asmAd74=;
        b=JelVN6DzG4YD8MMRFJOEZm3vJwLKpq8z1Z0q6mbXZvHkoKJvV0CaBso4P5wo5jeba4
         Vwx92C4dUzfSN7jEuRP8wyA6flAXePFEN2M8Nhu5Q4NDV0Y0NVvILyj6qyjQby4gOJwZ
         fZjsrOmqz1mIs6Gmb+4pcgUPIkrmxXDNYGafo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wz/vk4VU0P+AZaAcYN2OYniYGEe4LFUaLCl1asmAd74=;
        b=K8wkVr2170x0RTJqaw107v+TFmK/DRurGeyoScud1VxJHXUl+HPQR5sR1T91zCOCqp
         AlsvPaqwg2Z5J5B5Rpmya7J1LPvfyygv/dWdZOdR7rtNSCPsm7zsZNkw7zauOyRp+bIl
         AWO4SWXincRhZmlBIx5CkX8XcriRD/PBDhl9hl3l7MdNqWGeAPPUCoJPWAA+Zdlfc8FQ
         hdExC/hmEw+O3T5oYtnpBqKI6S3yAbKZ1ZNsLS6c3G9WRuHB41t+/LEVteCWN3hvGRBT
         IYdihLX+KB8kSCm05sY72e0sD0xa3TMBxgnWyH1F1oRrur8DL5J1XSAL9z+kcfEeD+44
         cXiA==
X-Gm-Message-State: APjAAAWfSY1/X70ZxbXfeijguWI6yNveHQEB7YS1rYaaklzW1ZkO8rUj
        68qtj7ia0iIZKcv8CvguuTbZ/A==
X-Google-Smtp-Source: APXvYqyEAsXC/6lk0UKIFVojjWFgXEYVvPez6o0I1zD1p5bt09IjeQPCSHe1t3Z44Y5fi33Q3jQSpw==
X-Received: by 2002:a05:6000:10cc:: with SMTP id b12mr5619400wrx.182.1556289675536;
        Fri, 26 Apr 2019 07:41:15 -0700 (PDT)
Received: from andrea (host116-65-dynamic.49-79-r.retail.telecomitalia.it. [79.49.65.116])
        by smtp.gmail.com with ESMTPSA id n17sm22129950wrw.77.2019.04.26.07.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 07:41:14 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:41:08 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Add data-race detection
Message-ID: <20190426144108.GA6235@andrea>
References: <Pine.LNX.4.44L0.1904221214370.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904221214370.1384-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 12:18:09PM -0400, Alan Stern wrote:
> This patch adds data-race detection to the Linux-Kernel Memory Model.
> As part of this effort, support is added for:
> 
> 	compiler barriers (the barrier() function), and
> 
> 	a new Preserved Program Order term: (addr ; [Plain] ; wmb)
> 
> Data races are marked with a special Flag warning in herd.  It is
> not guaranteed that the model will provide accurate predictions when a
> data race is present.
> 
> The patch does not include documentation for the data-race detection
> facility.  The basic design has been explained in various emails, and
> a separate documentation patch will be submitted later.
> 
> This work is based on an earlier formulation of data races for the
> LKMM by Andrea Parri.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

For the entire series,

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Thanks,
  Andrea
