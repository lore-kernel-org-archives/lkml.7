Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA852C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9A62133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551375218;
	bh=iaZTOBnrrgWE18p50uYDA3VkgY6khMk2Osf8xCHMiMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uQP/Y4oIY6Ya2Mnm9yPaS5Wy9PKJQkGzx+iYAYoJPErbtNyIY7gL335u7yJnza6kR
	 sI0vSMDqd2IVNFfYEUOzRgaRaZ1yswLsa1ly0wvgkdGunu5t4DsK+tniYS9EZGOzND
	 QW6Q9lvxZOgKM/CfStMwXf1a2ylrRd3bY/74yAbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbfB1Rdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:33:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43556 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733298AbfB1Rdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:33:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id j1so15867967lfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMu2O/vZRJSlcfN6NkwY2zHaqajsdGz15PfunWQ8voA=;
        b=ZF/VH/DUrQzhpZ6+3Za0Zcvx9YddFk6+TNpyRcIHZ+0xx6VLg/iqUWyvM2w91by5GG
         pHP+9xqpeiCuI9O0z8SX34yxkk+Qfw30hi+3h0XKKwLOeRcg8ed0C4vxo1mj6PNfV2Oz
         vgpGG9J+yy+OTm1blkCBf52UDj+4idBwrG+1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMu2O/vZRJSlcfN6NkwY2zHaqajsdGz15PfunWQ8voA=;
        b=g9LT1gEXeK2m3GtzivpKgOUFps+yRV/HV4raTBxdwQT311GNRgKuINX4C+bw1escou
         BAnLHC3PtdTfennWFqfxEPaX2tDjQ8ACSzVO1oG4j+9X6sJXcUxTACQEAKbYA5uMFD5l
         3W8CY0STSEnYORIuH6RFXs+ovKDblsGj0DJvRm4U649RGAritIAo2WBpSKVMYaD33tMP
         RIWbYvby16EprSeFveEtIm1ZrXNxJbU/PkSPVcCf/Y8uWtkr0EaWHRpOu8gpRKW/QOvR
         4yuvLFKRFuuqohJyQ/bVCoGOAiGpHc4HEKQTJ6W0+lYhMw6c7FY2CPb3nempiQBS5Drw
         lMMg==
X-Gm-Message-State: APjAAAXyP6EmDIUY3DIE7prue1h9VgDlzxEM/k81lJTycvi6ZycXfr66
        ve5Q+37bMncxwVF3qgRgVgO1gbhllfk=
X-Google-Smtp-Source: APXvYqx9CML4faAiULtuvua8ATMDRnPBMGNHLTqfX0KB1Ka5FtF7Uuxhe+JuZZbzaYE6bSxbHBUkWQ==
X-Received: by 2002:ac2:4219:: with SMTP id y25mr374291lfh.130.1551375212847;
        Thu, 28 Feb 2019 09:33:32 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s129sm4171470lja.49.2019.02.28.09.33.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 09:33:31 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id l5so17908327lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:33:31 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr33158lji.135.1551375210888;
 Thu, 28 Feb 2019 09:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20190228171242.32144-1-frederic@kernel.org>
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Feb 2019 09:33:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5MQiXNUBCN6VKNGRR2gDekhXpaTc914D3y4=dHpmh4Q@mail.gmail.com>
Message-ID: <CAHk-=wh5MQiXNUBCN6VKNGRR2gDekhXpaTc914D3y4=dHpmh4Q@mail.gmail.com>
Subject: Re: [PATCH 00/37] softirq: Per vector masking v3
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 9:12 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> So this set should hopefully address all reviews from the v2, and
> fix all reports from the extremely useful (as always) Kbuild testing
> bot. It also completes support for all archs.

The one thing I'd still like to see is some actual performance
(latency?) numbers.

Maybe they were hiding somewhere in the pile and my quick scan missed
them. But the main argument for this was that we've had the occasional
latency issues with softirqs blocking (eg the USB v4l frame dropping
etc), and I did that SOFTIRQ_NOW_MASK because it helped one particular
case.

And you don't seem to have removed that hack, and I'd really like to
see that that thing isn't needed any more.

Because otherwise the whole series seems a bit pointless, don't you
think? If it doesn't fix that fundamental issue, then what's the point
of all this churn..

See commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous"),
which also has a couple of people listed who could hopefully re-test
the v4l latency thing with whatever USB capture dongle it was that
showed the issue.

                 Linus
