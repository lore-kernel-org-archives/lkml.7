Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72EBC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964E82189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CcCjVInE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH2Tan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:30:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32991 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Tan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:30:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so5050174qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=PHBiMQmUVz28Hd0px6+QdQ2QS/SD5yF5IycJ0vk3rnQ=;
        b=CcCjVInE6tr/YfESMZ/qf+EBEknG1VoEq53o6jx93gYc6HvyjOrLD/+H68DdR5fnDS
         djm79K9Oi3cKIVzFzjjt2mITg7EA5XJPscyiumkBTUogVUGFFRe9UdsZSnSL847Xn8Pj
         rNmjor0WHc5/sZMaoISQYU5ZxlF2AmMsOfOcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=PHBiMQmUVz28Hd0px6+QdQ2QS/SD5yF5IycJ0vk3rnQ=;
        b=AXHpquP+PQ+fPfSt+e9UrcBr2ce7hHCdV8nsJP6Bq4BUsJdy8MRyExTZTtKMprFiqs
         m3ZYqYfkjQ5H1t2CYHJgyyYODUWW0//+zosYW6PTmNQNlQFHI83yVd1JwbTDRbkdwWyQ
         rzHWp5hqdqJDmij8JjISk6FkWDOuRJIUJkshXu42lqA/hbla/hcAcf+Slg54W+P817dA
         HTaxDQlAEDOnknlFHGDNS6YP6LxzmWQdFPaeTgsW92R4D2TVik8jJZST6MYdTKnEer+c
         3FVbMSHSjqkC2x5PUiqO5ZF6EP7a4xgWIjU+qeQNWPFVjZCh6VNNvDDcAllYd0+iaXMn
         FBcw==
X-Gm-Message-State: APjAAAWFRloFsvkzcPkbBguXnRFsP09aDjrsGLsBoKrReAHy/fKVeNav
        /+97L9Cbb7ujZ6WA+jO01A64dQ==
X-Google-Smtp-Source: APXvYqyMp+ZGMSy0JYr3jnMPxQdfAgHwoet3wlf5bh40PdxAUu1IJ1iHGhD0mwj1MZdsruG+14T3pw==
X-Received: by 2002:ac8:1241:: with SMTP id g1mr11657678qtj.145.1567107042399;
        Thu, 29 Aug 2019 12:30:42 -0700 (PDT)
Received: from [192.168.0.116] (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id q42sm2314873qtc.52.2019.08.29.12.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 12:30:41 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:30:38 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20190829185901.GA4680@mark-All-Series>
References: <20190829054953.GA18328@mark-All-Series> <20190829064229.GA30423@kroah.com> <20190829135359.GB63638@google.com> <20190829152721.ttsyfwaeygmwmcu7@wittgenstein> <20190829185901.GA4680@mark-All-Series>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
To:     Peikan Tsai <peikantsai@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   joel@joelfernandes.org
Message-ID: <009FE4FC-E1C2-43A4-AE75-A1FFE9A57356@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 29, 2019 2:59:01 PM EDT, Peikan Tsai <peikantsai@gmail=2Ecom> wr=
ote:
>On Thu, Aug 29, 2019 at 05:27:22PM +0200, Christian Brauner wrote:
>> On Thu, Aug 29, 2019 at 09:53:59AM -0400, Joel Fernandes wrote:
>> > On Thu, Aug 29, 2019 at 08:42:29AM +0200, Greg KH wrote:
>> > > On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
>> > [snip]=20
>> > > > The allocated size for each binder_thread is 512 bytes by
>kzalloc=2E
>> > > > Because the size of binder_thread is fixed and it's only 304
>bytes=2E
>> > > > It will save 208 bytes per binder_thread when use create a
>kmem_cache
>> > > > for the binder_thread=2E
>> > >=20
>> > > Are you _sure_ it really will save that much memory?  You want to
>do
>> > > allocations based on a nice alignment for lots of good reasons,
>> > > especially for something that needs quick accesses=2E
>> >=20
>> > Alignment can be done for slab allocations, kmem_cache_create()
>takes an
>> > align argument=2E I am not sure what the default alignment of objects
>is
>> > though (probably no default alignment)=2E What is an optimal
>alignment in your
>> > view?
>>=20
>> Probably SLAB_HWCACHE_ALIGN would make most sense=2E
>>=20
>
>Agree=2E Thanks for yours comments and suggestions=2E
>I'll put SLAB_HWCACHE_ALIGN it in patch v2=2E
>
>> >=20
>> > > Did you test your change on a system that relies on binder and
>find any
>> > > speed improvement or decrease, and any actual memory savings?
>> > >=20
>> > > If so, can you post your results?
>> >=20
>> > That's certainly worth it and I thought of asking for the same, but
>spoke too
>> > soon!
>>=20
>> Yeah, it'd be interesting to see what difference this actually makes=2E
>
>>=20
>> Christian
>
>I tested this change on an Android device(arm) with AOSP kernel 4=2E19
>and
>observed
>memory usage of binder_thread=2E But I didn't do binder benchmark yet=2E
>
>On my platform the memory usage of binder_thread reduce about 90 KB as
>the
>following result=2E
>        nr obj          obj size        total
>	before: 624             512             319488 bytes
>	after:  728             312             227136 bytes

And add this to the changelog as well=2E Curious- why is nrobj higher with=
 the patch?

Please don't use my reviewed-by tag yet and I will review the new patch an=
d provide tag separately=2E

Thank you=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
