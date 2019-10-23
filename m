Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E57CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D772084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twcPcqGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbfJWJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:25:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41720 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJWJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:25:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id g81so16765442oib.8;
        Wed, 23 Oct 2019 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOZIycxZoqDAGz7KsgdDi2o13zCj8SvRA6Ip/qqhkN4=;
        b=twcPcqGtCkg8qT8yn47hunfOfw+d+KpXEL4mUyrwplPziE14jeztgY4tPCwGjUx7Ws
         WdQjh38gNveMYTvtoy9dc+Fn28KbMlcvMUM+uGVsK8/K+vRoU/M3U9X/PGum0C7l4Kxg
         oVMAr7g/i2+e8e7MgH8dv1OEyU8vYx3HS+53lt3mt2s6WKukF+/fPrsSFg08EoqSQ4q6
         d2aLpUG0Cvyt2ZmZvOLWEqwk8IQUxpRV0L3M/Y+rfCwiJvk0WfMxoR0BHcp9vZLf+wMt
         +UXXPD5GVryfCOYTg8AkcHXGn1WmFdPwGm95M/GOT41xCuv5jMM2YZrNyPoihHiv12SF
         Y/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOZIycxZoqDAGz7KsgdDi2o13zCj8SvRA6Ip/qqhkN4=;
        b=UJJFkPtnHhqOQaqn85hVRP9CAbvhdkDvNSNo5zGFWH02gMOpg0x+svLBuAiso3dnEA
         N9PQ3zorQN+r6ROu9oYWh2Zhi5qL+tCAx0s4D2dvqT9mMtUyjTGJVilQK1whfV1oPwSq
         rq401aJ8y0NBkyA24qQV3tKJPiBG8yMQCIHpk6lDR8pbaqO0TL4jnU3SvDVy1Wx450oR
         bjnwNyT35PQFzt0NCKOwiMB48pZyYDy9NgM1BmqiP5eSWm3CcXEzMO6CwWaXR6WjwBKe
         w+5862p+5+O0hor7RJYaSD4gLcS5b4qERt9SyTbc/iykFCX5V6uXWYluzZUvgQ/qRA1p
         QX5Q==
X-Gm-Message-State: APjAAAXwuX5oqGjhViX15lVJj2R3R4PXLdpcf+gTcbD19CUcdvZiHBHi
        9E+ty9bSoeOkv6KwECgN1cbt0yRBggmxmDTTBtUhgws7
X-Google-Smtp-Source: APXvYqxxcFA1OOhndJaGrk3WmTXq5vzdwjt8psRrLguMLfS6Ok88KCFLKHP7jg+QX/vN/EnTszqMoYw6V03i+z1uqIU=
X-Received: by 2002:aca:39d6:: with SMTP id g205mr6761955oia.33.1571822731462;
 Wed, 23 Oct 2019 02:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
 <20190628011012.GA19488@lerouge> <CANRm+CxUpwZ9KwOcQp=Ok64giyjjcJOGb2=zU6vayQzLqYvpXQ@mail.gmail.com>
 <alpine.DEB.2.21.1910231028250.2308@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910231028250.2308@nanos.tec.linutronix.de>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 23 Oct 2019 17:25:20 +0800
Message-ID: <CANRm+Cx41peFT9WpqGjZcYDHiXsSAoJ-ONgO-c9t6cJ0puQQuQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/nohz: Optimize get_nohz_timer_target()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, kvm <kvm@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 at 16:29, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 23 Oct 2019, Wanpeng Li wrote:
> > I didn't see your refactor to get_nohz_timer_target() which you
> > mentioned in IRC after four months, I can observe cyclictest drop from
> > 4~5us to 8us in kvm guest(we offload the lapic timer emulation to
> > housekeeping cpu to avoid timer fire external interrupt on the pCPU
> > which vCPU resident incur a vCPU vmexit) w/o this patch in the case of
> > there is no busy housekeeping cpu. The score can be recovered after I
> > give stress to create a busy housekeeping cpu.
> >
> > Could you consider applying this patch for temporary since I'm not
> > sure when the refactor can be ready.
>
> Yeah. It's delayed (again).... Will pick that up.

Sorry, you will pick up the patch or refactor? :)

    Wanpeng
