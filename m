Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB0FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3D121A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG8kkB/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfJPR6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:58:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34968 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJPR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:58:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so3759018wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nFz4T0vFX9I/roldji38Wknwl/JNJ6KhqR7kFUGrr+8=;
        b=MG8kkB/maSXdkwrwZNVgc+Xt3j8g2HWexcftmSC0vzdBO837oFQKzV2Hlniy6PE0yH
         WI40Q0LAOwT9M9yDnx6e0NCvpSy4g4fh8iUCaLzH/ciRPfS9YHMPj6bgX234D+yhGdse
         ZYMPpMe5M3HTAg6sMw0/Jw/gVWMTJCypdNTDrqjnLixFJIQT3uvbrEfcWCHPxuFfMcwi
         kRwt4w2lZLppVnDv6jcrUjfbaaRIZFEqlJj/qA0AazdcIEf8bOsvGhUCdpB2RRrexIMC
         PlRL465867YiyQtZ8NfvBTsriVq6F11OzW1hvwIB/JKliHP5V8RHHXIpJjyolospeWtQ
         r9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nFz4T0vFX9I/roldji38Wknwl/JNJ6KhqR7kFUGrr+8=;
        b=aeK4g1hRebGXezNzwDvxZvhkGo+rOJG3gQrlHhzECBDD0EzhsBMpvV/T7EKDnwgkFF
         yBRAZKWz3JR7gMsdhxguRet4W2X9mnGfTbiV3cNB7X0gpQKPQDcIDKNEtB59meCquI9d
         1pLdM2rMrbTTv7Nn2hode140a9rhGj0UZ8PRXYTVtzYiIMJPDsei7/l255mqd0rIZpNv
         KNADfAILtRYtoEQgs0MZ33UFumuR7lx4/OJbPbJ0Z/Z8UW7ia5Z8Z4PS+VG6ezcZIe/r
         snCf1GJkayprAiP8TkqtPD1h8HXk8Q7MjAVj5scKM6QSnnhRUwKyPZbolOhBVj9S+QPy
         NHkA==
X-Gm-Message-State: APjAAAWdGEFKPqsfpwrPKZxU3Vmbk+yPQEotKr+gYhw2Or51WrBDHvOW
        dQUxuhFk3CuYSu3k4TZk7w==
X-Google-Smtp-Source: APXvYqzhSei8ojosNKz5bE95s1ODgdjfle9rj/9SqQgQEUrQ7Cy8VxXIGgT84Tsi1e8CY5tQ6SuylQ==
X-Received: by 2002:a1c:e455:: with SMTP id b82mr4444588wmh.41.1571248687904;
        Wed, 16 Oct 2019 10:58:07 -0700 (PDT)
Received: from ninjabhubz.org (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.gmail.com with ESMTPSA id 143sm4430952wmb.33.2019.10.16.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:58:06 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Wed, 16 Oct 2019 18:57:42 +0100 (BST)
To:     Julia Lawall <julia.lawall@lip6.fr>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, eric@anholt.net,
        wahrenst@gmx.net, gregkh@linuxfoundation.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: vc04_services: fix line over
 80 characters checks warning
In-Reply-To: <alpine.DEB.2.21.1910160713140.2732@hadrien>
Message-ID: <alpine.LFD.2.21.1910161855320.8071@ninjahub.org>
References: <20191015225716.10563-1-jbi.octave@gmail.com> <alpine.DEB.2.21.1910160713140.2732@hadrien>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Oct 2019, Julia Lawall wrote:

> >  #ifndef VCHI_BULK_GRANULARITY
> >  #   if __VCCOREVER__ >= 0x04000000
> > -#       define VCHI_BULK_GRANULARITY 32 // Allows for the need to do cache cleans
> > +#	define VCHI_BULK_GRANULARITY 32 // Allows for the need of cache cleans
> >  #   else
> >  #       define VCHI_BULK_GRANULARITY 16
> >  #   endif
> 
> The branches should be indented to the same degree.
> 
> julia
> 
> -- 

Thanks, I have just  updated. 
