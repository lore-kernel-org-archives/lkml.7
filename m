Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA680C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B454F20449
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UZ6sTNwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfEGUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:45:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33202 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfEGUpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:45:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so20010258edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EaOdVV7Yd/+L1XOy7Z0nNvigje4s3+cRNqN85h7uhfI=;
        b=UZ6sTNwhEP7+8f/4vKTLT8O3A8lo4CpjpF6NIYtmpMUTdMqw5055c6rMUMFleF7TKY
         boIr6f/ysDM96K1uD+kDJhLY7m1+Mgo87eOa8/BNzkPDoQao4xIfPenTj2U83OmdCONO
         CdqFu5NrcQgw1V+M5eAZeQ2vFoVAGQO4ObgUSiZPpSSRMoTo7U2tBlfY5G9w98IX1PWU
         4R0mmeeM7Jwx2H/DljpThXEBZIvlgLTeYXSlILdu30H02iv/MojkvEuqTdzBf9irHx9R
         MKIP2ueY6x4mw3vh/54eSqqx/j2JuPocOGuEJUKdG6BVKwu5lHYhBF0wT6mNx6GGhqi8
         wl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EaOdVV7Yd/+L1XOy7Z0nNvigje4s3+cRNqN85h7uhfI=;
        b=bfir3a2EPEEZmSwJTD7OFZU7qbwadHQQ/HGkz/FFMySrqlv0oYk+tMt+xV4/GKaPKN
         zzaqh7IBvSaG6W0LLGlW/DJjh34xnuyjzX9XK4BmK/HxrFvN4bpltxEVIXNxku96/YL/
         BIXC91F1u8OtgBFoJzJrGfji6U5z6H5catTElDUZ8eQbW3gCuKcEmVBdzDLs7JgM95rg
         ++hS7qW7gxJOivonbJCBvprWy9Z/42nYd69E+e571bLqb6EQUeGHdaP7nQzQl23693An
         96g+6r9q84bJKm4HEWki/bhFe0wg+HkVUtlkqIItboEdnD4A6HFRw5xbBiIkjvH55UoS
         VUmg==
X-Gm-Message-State: APjAAAV7Urb0+WoiqaQfx5dTFiX33HBfz/1x9wfw7cq4WvNLFGB4qM+1
        aTBZUL1nV5Y9Gu987PieTKQivSSpnn3jeA==
X-Google-Smtp-Source: APXvYqxsS9dM2a3mUjYyws2m1fAIISIvZsySVldtjAP+6xAFLvn+qPF6C5QAEY101es2VUdUASXg+Q==
X-Received: by 2002:a50:c201:: with SMTP id n1mr35211228edf.244.1557261928410;
        Tue, 07 May 2019 13:45:28 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id g8sm668441ejf.20.2019.05.07.13.45.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 13:45:27 -0700 (PDT)
Date:   Tue, 7 May 2019 22:45:27 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] pidfd patches for v5.2-rc1
Message-ID: <20190507204526.zkx64vrt4jxfwamz@brauner.io>
References: <20190506123659.23591-1-christian@brauner.io>
 <CAHk-=wh692HhZ+s=WWCw81mWFvXEGpXKccHcmpRUrO9p3KKD=w@mail.gmail.com>
 <20190507204034.kgwqkgw6lc3hzukd@brauner.io>
 <CAHk-=wjWdJyGnsiBFXA0_3Utey3=JP831X4gPYKx2wEcGFKNAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWdJyGnsiBFXA0_3Utey3=JP831X4gPYKx2wEcGFKNAg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:42:47PM -0700, Linus Torvalds wrote:
> On Tue, May 7, 2019 at 1:40 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Oh, sorry. You want me to send a follow-up that fixes it?
> 
> Yes, but no hurry. If you add it to the queue of fixup patches, that
> would be good.
> 
> And if it ends up being the *only* such patch by the end of the merge
> window, that's fine and you can just send it as a patch (or git pull),
> but if there are other fixes just send it together with those.
> 
> Ok?

Yep, will do. I'll wait until mid next week then in case we see any
issues that need fixing!

Christian
