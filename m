Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C319FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E14320850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfEHNK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:10:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37159 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfEHNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:10:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id y5so3200610wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 06:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGCGUpJEQoNfvEbD1fSHxBYCNGGKXcKxyrb1HER/Hww=;
        b=tG2Ng5KUJujY4/qKC/STi5emvQXJq0LQp4el/xrdiRDK2kiwxPy279ajhch8Ts6052
         ObX4RP5Zh2laPXQWzBi2oAM2UkJAa9MpvudVs5ajCd1EjzB1z3BLDO2IGsAyLmeOAVZ3
         s4hu9sQDxeqQ6jW2CEpVw+dxL6GYT7hLx8SnrEhfZ5uGKbvHe0NxtcFbQ451v4kHj+uM
         z6PEPgSXf6bk3Lo7EUvqPxZNJhLwUEHloYchaJ9do9pEuE4zeowaTvwlrOsmpzbUh7en
         K1XOWDKLjEp7N3ctKC1GoTzLKd57pxOQRsd/ervlO4c4PalsAJ4j9C21A/9HurU/MUht
         l73w==
X-Gm-Message-State: APjAAAU/JGPZd+hG2kJ4AmCxhbicpwv6FRLtUpfMLOTjREbWGuUitIGu
        IxqJFYXB3ZDdGwax2wiBlujxVg==
X-Google-Smtp-Source: APXvYqxKLgJWfZ6CUXsJxJ1CoDxkm/R+XyNfDo+jCSYBBCTLxTF9t0ki/gmgrEY3OBnmwMm7k1Tf5w==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr3167876wme.116.1557321022640;
        Wed, 08 May 2019 06:10:22 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id e16sm10789869wrw.24.2019.05.08.06.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 06:10:21 -0700 (PDT)
Date:   Wed, 8 May 2019 15:10:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 4/6] sched/dl: Improve capacity-aware wakeup
Message-ID: <20190508131018.GJ6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-5-luca.abeni@santannapisa.it>
 <20190508090855.GG6551@localhost.localdomain>
 <20190508112437.74661fa8@nowhere>
 <20190508120526.GI6551@localhost.localdomain>
 <20190508144716.5cc8445d@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508144716.5cc8445d@nowhere>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/19 14:47, luca abeni wrote:

[...]

> Notice that all this logic is used only to select one of the idle cores
> (instead of picking the first idle core, we select the less powerful
> core on which the task "fits").
> 
> So, running_bw does not provide any useful information, in this case;
> maybe this_bw can be more useful.

Ah, indeed.

However, what happens when cores are all busy? Can load balancing
decisions based on deadline values only break capacity awareness?  (I
understand this is an RFC, so a "yes, something we need to look at" is
OK :-)
