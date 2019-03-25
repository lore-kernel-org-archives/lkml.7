Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9922C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26822085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQqJdZHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCYOL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:11:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46928 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:11:57 -0400
Received: by mail-yw1-f66.google.com with SMTP id v127so7102532ywe.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTt93h75wJmE7jV6jCleD3fv2thkBfT2D18E2mIVZzA=;
        b=lQqJdZHJ6UcPCjywy2RwjHTQh0ANBIl+04G15xC+jF06ooEmgZg4AJYpJ3UgX9nlhb
         UWrv2nOqqhCcoWXRs+3jxpOfuGdbIEiXCETU2ZwXzVM6Ybn4AT/spneX6zcCeNqAy+VY
         ClDPIrjs4m8Z61P3TzyIXEmYUyR+4UuuNobyBjU5AiZX+Fgd5mP4Z8fAvvhMhNRAyNak
         atOPMmu/uH17V9Tn6R+NQgnlGzO1exy9RbnulNsl/xtVi80dh9K57BZXJUMcpcLinSI5
         QcHyd0zlEo0ocHb0UIFCNEIoYRGzslm+o6REHXetwyp2Ivx6m9V6ttvpUAJy4RsAkaha
         353A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTt93h75wJmE7jV6jCleD3fv2thkBfT2D18E2mIVZzA=;
        b=i1Jj6+b2CgPD1M8Tna9aZW0fcz78wVuCPD6wkG5HVilxSrovwz8WzOhA4yKQ3RYdM2
         Hp34fd/P2bt2M2EBEeht8fS5/Q6K1jSWaZwa4p9qMHUVvcy2LdPgW6fkpL7TjO0KQSOg
         +pAIgRDS4K/KK8n5evN56eOiYijIw3Bllp27O95eWDTiaasSmhSb4JMluUpXE7naZKbd
         H236HcIoMQYCeQjuOwenJ9aSqyvRWMSyBhne49695IMB7fWMQ+lS23ft3n4IpNhczlfu
         mO7gKPjGK2x1vkuSdDlXfC+P3w1Mmn8U2duwLykvV+T6zypX2v2Zpy5Uv/14t0bB3QNz
         gxYg==
X-Gm-Message-State: APjAAAWgUn9frAdBxKAhdMtc1+GRzvJeevmH2+twRCZv216mNooqwj6R
        L+iroInVCsUFuzk0RV30xeI=
X-Google-Smtp-Source: APXvYqya9JwKLI0eSzN4/2JY+RsLV0Z9pV4cQyE55E/XHyGB5dYTs9BGyLg0FV/Z/rONODHAQBrpeg==
X-Received: by 2002:a25:d20d:: with SMTP id j13mr21035429ybg.417.1553523117103;
        Mon, 25 Mar 2019 07:11:57 -0700 (PDT)
Received: from centos-dev.localdomain (pool-173-66-89-81.washdc.fios.verizon.net. [173.66.89.81])
        by smtp.gmail.com with ESMTPSA id i189sm5631147ywa.73.2019.03.25.07.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 07:11:56 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:11:38 -0400
From:   Ryan Thibodeaux <thibodux@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Dario Faggioli <dfaggioli@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190325141138.GA44413@centos-dev.localdomain>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
 <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
 <20190323114151.5cebf31b@sweethome>
 <20190325130530.56603806@luca64>
 <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:43:20AM -0400, Boris Ostrovsky wrote:
> On 3/25/19 8:05 AM, luca abeni wrote:
> > Hi all,
> >
> > On Sat, 23 Mar 2019 11:41:51 +0100
> > luca abeni <luca.abeni@santannapisa.it> wrote:
> > [...]
> >>>> Is there any data that shows effects of using this new parameter?
> >>>>     
> >>> Yes, I've done some research and experiments on this. I did it
> >>> together with a friend, which I'm Cc-ing, as I'm not sure we're
> >>> ready/capable to share the results, yet (Luca?).  
> >> I think we can easily share the experimental data (cyclictest output
> >> and plots).
> >>
> >> Moreover, we can share the scripts and tools for running the
> >> experiments (so, everyone can easily reproduce the numbers by simply
> >> typing "make" and waiting for some time :)
> >>
> >>
> >> I'll try to package the results and the scripts/tools this evening,
> >> and I'll send them.
> > Sorry for the delay. I put some quick results here:
> > http://retis.santannapisa.it/luca/XenTimers/
> > (there also is a link to the scripts to be used for reproducing the
> > results). The latencies have been measured by running cyclictest in the
> > guest (see the scripts for details).
> >
> > The picture shows the latencies measured with an unpatched guest kernel
> > and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary small
> > value :).
> > All the experiments have been performed booting the hypervisor with a
> > small timer_slop (the hypervisor's one) value. So, they show that
> > decreasing the hypervisor's timer_slop is not enough to measure low
> > latencies with cyclictest.
> 
> 
> 
> I have a couple of questions:
> * Does it make sense to make this a tunable for other clockevent devices
> as well?

I gather that would be on a case-by-case basis for very specific 
ones.

For many timers in the kernel, the minimums are determined by the
actual hardware  backing the timer, and the minimum can be
adjusted by the clockevent code. This case is special since it 
is entirely a software-based implementation in the kernel, where 
the actual timer implementation is in the Xen hypervisor.

> * This patch adjusts min value. Could max value (ever) need a similar
> adjustment?

I cannot think of such a case where that would be helpful, but I
cannot rule that out or speak as an authority.

- Ryan
