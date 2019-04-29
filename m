Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B0EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F5F215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ofZYrEPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfD2XRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:17:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50578 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfD2XRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:17:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so1422849wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYx/PpUETf62rnmWyBuVYJne6sL4Sppeoe68UBu+C48=;
        b=ofZYrEPWt3bOdtLGI4gwtxKCfg1DysFTX6WH2zp9NWFz4iSq/7S8g6I5rFTdm5lBTp
         olAIovsqhJvbvwceg95f+xrWfROSL61Q2fMufVhSmYbZEJbpAXHkWNXebH9MmbE9yXqK
         FARDvfWDj9MT//C1OTJ/dGMi5pWW61L6WcYx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYx/PpUETf62rnmWyBuVYJne6sL4Sppeoe68UBu+C48=;
        b=My0L/xXC1BFZf//YsQVj+WRl9WS/FOP9t8595RsROCOO/nHC9hesHXyHU5EuVfNHGE
         0VEgp5j3uPlWVaH+xkE7WipWKJ2qufzzKug8nGJsKI00jPDP8ToFgmSKEEy0nzdvyCJ8
         8QTaY/QojrIuQ88aCbQW5A5ojH9mFFTNmYIRb2K2KIyY4NH4vyCd0Lna9Pt1JoMszWD8
         a35OhVqPoGICIih+vGsXRj8e8j4ubaoWoQQCVpFiBsM6nGj1tciUffKd4fv1PyOhANYt
         DT0YTJA//5N9ghO7ljBTH2JYuliSvnf0Wv7kkk1TmsXDNSq83ycStVqCt1TeGba36nMR
         t2EA==
X-Gm-Message-State: APjAAAXxF/RhnxSQJd1kGDsQYrisjX0O21jvTao2HNIvmHXYNdIYOqAM
        Al5RQc4AiXzC54PazxG9uYXra0wNUYs=
X-Google-Smtp-Source: APXvYqwWNE+lo2Lmp4qExHW5Coy5MDuwao1zLqsY/frUnjQhkdUMLFonDKJe9juMWfTUs9n51gbhVQ==
X-Received: by 2002:a1c:3cc2:: with SMTP id j185mr982553wma.26.1556579825704;
        Mon, 29 Apr 2019 16:17:05 -0700 (PDT)
Received: from andrea (ip-93-97.sn2.clouditalia.com. [83.211.93.97])
        by smtp.gmail.com with ESMTPSA id z11sm848336wmf.12.2019.04.29.16.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 16:17:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 01:16:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
Message-ID: <20190429231657.GA2733@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

> >This barrier only applies to the read-modify-write operations; in
> >particular, it does not apply to the atomic_read() primitive.
> >
> >Replace the barrier with an smp_mb().
> 
> This is one of a couple of barrier issues that we are currently looking into.
> 
> See:
> 
> [PATCH for-next 6/9] IB/rdmavt: Add new completion inline
> 
> We will take a look at this one as well.

Thank you for the reference and for looking into this,

  Andrea
