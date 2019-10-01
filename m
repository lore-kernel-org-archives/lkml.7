Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE8C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2A21920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1mD/BsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfJANbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:31:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45344 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfJANbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569936682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KorGO3/zt+fwbdt/ZEhjTUWoi53sFfxZoLftxHGs9Z4=;
        b=D1mD/BsELLCYTJTKJ8PDE4WoshkCaTnrZJwi+/stcdIC8T/F7/Qu8IPNjBjZ+fDPkRz5ZF
        +QqscD2x8TUtFmuDsTR5w56/zVhwSogxFB66hiv+vBWez5xHOBBI6C2/9fOLLK5+Uwl1W+
        DvVtifBawoG9soLYm0LpIB+2XztOgIg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-E0z3Tq1OM3-wcPlGo49m6w-1; Tue, 01 Oct 2019 09:31:19 -0400
Received: by mail-wr1-f71.google.com with SMTP id t11so6014909wrq.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KorGO3/zt+fwbdt/ZEhjTUWoi53sFfxZoLftxHGs9Z4=;
        b=iH0H0blzDmwFUCWlWKWqdUJucbmp75I8U0sggOlR12sm0TKNd2f3JeEli/QWEVg/It
         pkNxiuvqnVmeJvAwvnjYavc3CJN5U4uqJl3i+HFsPWLQAY34yDGEo7Zsvc7Qz3pNR3q+
         F9kGCwnx2YNCi/4a2nI52fZ8cDduYr/Faa1lt8TICLBE7AIi/fvh8ES2roTwwSSOjQuL
         tEVQVtuUJ54/ZPUPi+IKfYjg9CgFtYD2yMxHXAOQ/lJTiF2lar6K/HcQ6tqF9T9FukhW
         e7mgbb7KuOtiqe9SubPlRbDFvg45fHEiXs3yxmCVHYDq3hFhjvFJpO9JYlz22aQ1dv7r
         kZWg==
X-Gm-Message-State: APjAAAV1sY7nWBwJTAfdRfdmEja9vRWC9lHTFZegUtSe6jzZH6af6cqq
        Wje4BRmeKMiqidvKPcYSmOhtztvL5Mxf5fQhwENK9DfjpOSgM47KceyF1u9wVYwygjH52YscVdI
        9IRk+hhdKBIHibeRGs3zh1W8W
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr17677605wru.190.1569936678471;
        Tue, 01 Oct 2019 06:31:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMq1gs5+tTkwVxPJSNX7tFUGYkmIfQHbLYzUUn4Dh1gi0aI91buvk1r+Hg5iwYRUrQmHj12Q==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr17677578wru.190.1569936678216;
        Tue, 01 Oct 2019 06:31:18 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id t14sm17350431wrs.6.2019.10.01.06.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 06:31:17 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:31:15 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/4] sched/fair: Active balancer RT/DL preemption fix
Message-ID: <20191001133115.GC6481@localhost.localdomain>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
 <b442e1b5-a800-5dde-2e42-e4981089edf4@arm.com>
MIME-Version: 1.0
In-Reply-To: <b442e1b5-a800-5dde-2e42-e4981089edf4@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-MC-Unique: E0z3Tq1OM3-wcPlGo49m6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 01/10/19 11:29, Valentin Schneider wrote:
> (expanded the Cc list)
> RT/DL folks, any thought on the thing?

Even if I like your idea and it looks theoretically the right thing to
do, I'm not sure we want it in practice if it adds complexity to CFS.

I personally never noticed this kind of interference from CFS, but, at
the same time, for RT we usually like more to be safe than sorry.
However, since this doesn't seem to be bullet-proof (as you also say), I
guess it all boils down again to complexity vs. practical benefits.

Best,

Juri

