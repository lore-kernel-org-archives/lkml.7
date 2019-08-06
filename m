Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077BCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 20:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7265214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565122032;
	bh=kHsnvNvTVEeBnqmn4w4RA+tgsK4XbSrY86eIYVgnNBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NsEXQ6GMdLHJyL4FeC2YDTkgBeFTnBdokFgOwFjJ375WfUpOx5ZRHSpLkgkvJ8ZbZ
	 5xtXJ5iPLYSnzpnJdt0JQtIDe1JKmWvl0d36URNlzzRGvJnvgUMuzzZFriGEP7Rtab
	 qaZRQKh0px2whku63NRjLaw099ieM+slWbKkDRUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfHFUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 16:07:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHFUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 16:07:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so38322931plt.1;
        Tue, 06 Aug 2019 13:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3lnYdbWOBA6dA1vSTeMR5gZWomXsRJ4E1lTXIOz1Z5U=;
        b=nIT8GaohLPRf9a4CpudSfss8J/uYq3fHL2y0z3z5It2yywOpvzbAcSnwHjo+nWx/Gn
         80YeoDvXTlIUn9bZorUPK8fLRTTn89pOT7eMGNahFNERadisVXoAd9RjA9A6JrAiSHUu
         9JjVIrTfOm5OMGrppO5zTW7LL9kEcSFkSLeQzgHS8Z+hTG2JywMPdgF06aHOhakkxotX
         5zDNNf7TJ/nh+YI5MNMr2fhbDNAhiGScnWJyU31A2quhgDWil1L5DxlbRlPNjte7yBau
         jI6lzqdGwwCAUCb6FpZSMoDCT4Q4UmpKw6FcnpkMWRFiWa3VOoE1/jydrDzZOXFyzVc4
         Ov0A==
X-Gm-Message-State: APjAAAUE1Hl23XfWj6lccVtNAQmg8yKZt2B4DJ8UbSr2bdQ/+m3uZwgK
        PNdlFTIiLTgxMTDFKsmBs1A=
X-Google-Smtp-Source: APXvYqxx5a2IVFilbFs0bVFe6JoYxYxIny7e7YtcwdzL7abFcKoSAW5uPmhhL2D/ZNw1BMCOkbOF1A==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr4733619pld.112.1565122030074;
        Tue, 06 Aug 2019 13:07:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 11sm88459493pfw.33.2019.08.06.13.07.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 13:07:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7B8DA4025E; Tue,  6 Aug 2019 20:07:07 +0000 (UTC)
Date:   Tue, 6 Aug 2019 20:07:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kinky Nekoboi <kinky_nekoboi@nekoboi.moe>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: XFS segementation fault with new linux 4.19.63
Message-ID: <20190806200707.GV30113@42.do-not-panic.com>
References: <e0ca189e-2f96-6599-40ce-a4fc8866d8d1@nekoboi.moe>
 <20190806070806.GA13112@infradead.org>
 <cbe57554-ed5f-6163-d48c-9069aa2dcc7b@nekoboi.moe>
 <20190806092318.GE7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806092318.GE7777@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:23:18PM +1000, Dave Chinner wrote:
> On Tue, Aug 06, 2019 at 09:10:57AM +0200, Kinky Nekoboi wrote:
> > Addional info:
> > 
> > this only occurs if kernel is compiled with:
> > 
> > CONFIG_XFS_DEBUG=y
> > 
> > running 4.19.64 without xfs debugging works fine
> 
> I'm guessing 4.19 doesn't have commit c08768977b9a ("xfs: finobt AG
> reserves don't consider last AG can be a runt")....

It does not. Kinky, can you confirm if cherry picking it fixes your
crash? If so I can queue it up for the next batch of fixes for v4.19.

  Luis
