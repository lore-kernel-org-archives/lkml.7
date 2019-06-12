Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6788C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A818221721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rmjuNjK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbfFLU4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:56:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41379 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbfFLU4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:56:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id 33so11916159qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hgV/CiEIlJWIILSVW8jGibEn5u8thvNr5+oTjP3VnLs=;
        b=rmjuNjK0kAMRgu4iGfKElp1iP70egkIDMeoEaW616528yzFiFG3EdzeeUe7kjDvXJA
         X0bs7jyf9WAQoVf5xFcdstrX3iEguGZylSrOztxFP4VxIxhDYRLd9SP7lAkeofgoOSCk
         h1n3AR5yvNLBJgXCi0QVBQPvj3zkuUqym0vbzuZQhV7WUNZkXj5MWXMVVENx6WbhntQj
         l7Wq+E/SWQoG+FwKOH4Zl3OQUk3Xn8IgzCCn7xCUbgubL9diM6UThxhEn7M06D97c2VG
         d4xRMTBwtu1O0J7tn4hjn4ot+n1BG7cr0AQqpoKEeBneZOvnM2xygoE+bleodUYfQwpP
         Z2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hgV/CiEIlJWIILSVW8jGibEn5u8thvNr5+oTjP3VnLs=;
        b=hf2QDw5Oa0ZKVPzMGFt77C8UEFqVPrGmJojk6NcqIvhHXMHqdIHQj0NHXtNFYafzbz
         Qz4Pz/y6NL+uLlgLnP59wdS0jkapyU4GTfCNcRd2Wb0reChG8GO2ggXtMCzKSfW1c/j+
         4iGLhSB0GckqAsZ+yAEQLpG4SIhvW+GH+lzkWs4OfGt1scokUNPhIGhI/+DisyOSdGiB
         dn6+FBm2Hua+fArPJ9t9FKst7GftXKI7XK0H2cC3xm88SpA+gmE4gMQrnGRYtuZoUrcK
         ugcuxpFi8twXi1XMAaqZmRFC2k75di3lLmseKU4dEa0iRPs7iHtXX5W0QKoI7laKfCdo
         hBrQ==
X-Gm-Message-State: APjAAAXTOGe7FxhrVQR63msHwvRb8cum5HZBJ5F8Kgzekt1yLeSwDTql
        p5eZGZcUaou4WUiR7pmITI43uA==
X-Google-Smtp-Source: APXvYqxn/XEHvdG1GlmscEu1eACbjgspPlvlp9HH6r9+L1p+oqOBIhAX4GodoEY9Y4dilUDJedQL4g==
X-Received: by 2002:a0c:b036:: with SMTP id k51mr437829qvc.103.1560372991976;
        Wed, 12 Jun 2019 13:56:31 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t67sm385964qkf.34.2019.06.12.13.56.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 13:56:31 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:56:27 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        peterz@infradead.org
Cc:     Network Development <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH] locking/static_key: always define
 static_branch_deferred_inc
Message-ID: <20190612135627.5eac995d@cakuba.netronome.com>
In-Reply-To: <CAF=yD-JAZfEG5JoNEQn60gnucJB1gsrFeT38DieG12NQb9DFnQ@mail.gmail.com>
References: <20190612194409.197461-1-willemdebruijn.kernel@gmail.com>
        <20190612125911.509d79f2@cakuba.netronome.com>
        <CAF=yD-JAZfEG5JoNEQn60gnucJB1gsrFeT38DieG12NQb9DFnQ@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 16:25:16 -0400, Willem de Bruijn wrote:
> On Wed, Jun 12, 2019 at 3:59 PM Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
> >
> > On Wed, 12 Jun 2019 15:44:09 -0400, Willem de Bruijn wrote:  
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > This interface is currently only defined if CONFIG_JUMP_LABEL. Make it
> > > available also when jump labels are disabled.
> > >
> > > Fixes: ad282a8117d50 ("locking/static_key: Add support for deferred static branches")
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > >
> > > ---
> > >
> > > The original patch went into 5.2-rc1, but this interface is not yet
> > > used, so this could target either 5.2 or 5.3.  
> >
> > Can we drop the Fixes tag?  It's an ugly omission but not a bug fix.
> >
> > Are you planning to switch clean_acked_data_enable() to the helper once
> > merged?  
> 
> Definitely, can do.
> 
> Perhaps it's easiest to send both as a single patch set through net-next, then?

I'd think so too, perhaps we can get a blessing from Peter for that :)
