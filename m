Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDAF2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfCYSvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:51:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48687 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:51:01 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1h8UgV-0004Ma-JO
        for linux-kernel@vger.kernel.org; Mon, 25 Mar 2019 18:50:59 +0000
Received: by mail-wr1-f69.google.com with SMTP id h12so5778912wrx.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9r0jGrCDcv9BMohTYQe8tG94UpG+gRVwfqvwa4BxdJI=;
        b=C7qleENDTJfAd/LqY6EIYq6w8ObkZ1ZNPb262+cujQ5IOiBK6TY245Hsk3oSLesNKQ
         F6LQ3KPNK9O0GXQgw49W8y/08NgGuWA1K21jQi+F09NokRpqSBjdBEkW+fOr5AU4zXO2
         lORXODL1wLpu/ESQPh+AELZrxxULXmDAtvTJj7DWPr3MgbL6vKeXIrliYGQ3TOab1lg+
         7RUaXUyH1k7o7DCg4QgvjPVgQ5d5EN5opc9vBnyl9k1gKcgMzokAwlxA81YUAgtHV4cm
         Un7fDq/2vkac75W8N58cOy2uekDTqCU18ug+/X7V12TtJrhNM+SQkXs17Im5ZKR23w02
         5/wA==
X-Gm-Message-State: APjAAAU2Y0v8UBnmLDOw13AmDEbCITeL8M//JQmyz2zRADGWBIIYx0+V
        K4VJ0O73Wy4Hs3gjmJ7b+rLkyeYfiMVUVQxwLWBvTXiEAFNbSNutCn1r2m2pugSNv5cSUgrI0z9
        x16BS0km5KLGW31iQAW6gO8dc5NinHUpS8pD7ee13Jw==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr17471796wru.34.1553539859293;
        Mon, 25 Mar 2019 11:50:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhp4eQG6++Pvp7utaInJXRrXp+MXuslPCb0ablCVxWPs7SPzNkhpPeIsRVd73rJpYyoRvtLQ==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr17471781wru.34.1553539859035;
        Mon, 25 Mar 2019 11:50:59 -0700 (PDT)
Received: from gmail.com (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id f1sm13245817wmh.44.2019.03.25.11.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 11:50:58 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Mon, 25 Mar 2019 19:50:56 +0100
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: pidfd design
Message-ID: <20190325185055.oyqxztnbwrzmp5bm@gmail.com>
References: <20190320200702.GA27111@avx2>
 <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:04:35PM +0000, Michael Tirado wrote:
> On Wed, Mar 20, 2019 at 8:08 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > pidfd code should be backed out immediately. Forget about /proc.
> 
> Seems like Torvalds just merges this sort of "stuff" without reading
> it now, or there's something that auto accepted pull request to RC tree?

I don't mind controversy around patchsets but I'd appreciate it that
when they are started the Cc is not modified and main people who
maintain the code that is critized are removed. I'd like to be able to
respond without other people having to notify me that there's a
discussion going on I should be involved in.

Christian

> 
> > The pull request you sent on Tue,  5 Mar 2019 18:13:01 +0100:
> >
> >>  git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git tags/pidfd-v5.1-rc1
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/a9dce6679d736cb3d612af39bab9f31f8db66f9b
> >
> >Thank you!
