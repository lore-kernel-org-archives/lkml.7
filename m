Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221A72070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Mi4+zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfCZLlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:41:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33247 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:41:51 -0400
Received: by mail-yw1-f67.google.com with SMTP id l5so9374049ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iThlV3KvC24rOqF3NoyW4PXimOst8xmclrHdJH58cio=;
        b=p6Mi4+zGWOZaaGmadWmMlGfhdPbUN8FuxsN7Zkk7HMwZoRDVXN9L1EIYXxdQ/2HF+1
         04MqE2KDBfkx9hjGcSbqULrveNMM9O9P/mQQvFJ3f7XZbUOXc75RwsxvZA2a4n4jsWNu
         YvnlZlZFzkdFN9TeKerm/TQyhZOZk+GccWHM1ce+MyAvJnCpmP2M90Qx27EEfQKejZ9j
         A2PZBKHBW8niKuMvHaR+dCJOi/1n6syVxjaI+SGoxf340B2pQlfzkUPmqpAaoNCNAlWA
         gR0oLmZgjV5cNf4GmhCGp53lylVKMeSXF0YUrDtlQw6h5gwF/eF2gqE65XyeatHR03gE
         Oq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iThlV3KvC24rOqF3NoyW4PXimOst8xmclrHdJH58cio=;
        b=A366eILSeSC/y9wbV4kpduLNo6hKLA4KmYalHXG/OkbiJ5OAjkdbW6rQ2bOuI7BqE9
         tq3oMBDy72pQjBA7v7bEnwuRqTEAMiW9odTZWc4wTGlgEMkZ67swib/sOdlyrwY65Db2
         Enq1/lplThBhQ6UiSaW+I95FIQXXz/BGYOhF60n4owqqFsQoVoLpuTuMub+OGTiuBEG2
         SkLd7CtrhCvUUlWrB98fVb4CA4YYLhH4NSSTZcAAcMM72LlKqem4jEqbcaWI5aHbYz59
         S1gJYnf6hgasnmYebLcfcCydErbbboz/SlT5JmhiurddSt/NT8yVg4gtAumCwneIAbl0
         hR3w==
X-Gm-Message-State: APjAAAVtSyqaKFpyzugeBNI0ejYtN5MKTCvDzyHUIqSES1u6yqRPMD6O
        OrAvSFVSmtNf0a6yygBs3Uo=
X-Google-Smtp-Source: APXvYqxo/H/3p9ZGaKIIP40J+6jT9I4xxsuRzvOXUX/LxO0KsXqq06+J81VbYsVqauTCPGdEsbzZjA==
X-Received: by 2002:a81:5b04:: with SMTP id p4mr26132713ywb.115.1553600510493;
        Tue, 26 Mar 2019 04:41:50 -0700 (PDT)
Received: from centos-dev.localdomain (pool-173-66-89-81.washdc.fios.verizon.net. [173.66.89.81])
        by smtp.gmail.com with ESMTPSA id 205sm4233898yww.27.2019.03.26.04.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 04:41:49 -0700 (PDT)
Date:   Tue, 26 Mar 2019 07:41:32 -0400
From:   Ryan Thibodeaux <thibodux@gmail.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190326114132.GA85724@centos-dev.localdomain>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
 <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
 <20190323114151.5cebf31b@sweethome>
 <20190325130530.56603806@luca64>
 <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
 <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
 <20190326121256.76ceed71@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326121256.76ceed71@luca64>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:12:56PM +0100, luca abeni wrote:
> Hi all,
> 
> On Tue, 26 Mar 2019 10:13:32 +0100
> Dario Faggioli <dfaggioli@suse.com> wrote:
> 
> > On Mon, 2019-03-25 at 09:43 -0400, Boris Ostrovsky wrote:
> > > On 3/25/19 8:05 AM, luca abeni wrote:  
> > > > 
> > > > The picture shows the latencies measured with an unpatched guest
> > > > kernel
> > > > and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary
> > > > small
> > > > value :).
> > > > All the experiments have been performed booting the hypervisor
> > > > with a
> > > > small timer_slop (the hypervisor's one) value. So, they show that
> > > > decreasing the hypervisor's timer_slop is not enough to measure
> > > > low latencies with cyclictest.  
> > > 
> > > I have a couple of questions:
> > > * Does it make sense to make this a tunable for other clockevent
> > > devices
> > > as well?
> > >  
> > So, AFAIUI, the thing is as follows. In clockevents_program_event(),
> > we keep the delta between now and the next timer event within
> > dev->max_delta_ns and dev->min_delta_ns:
> > 
> >   delta = min(delta, (int64_t) dev->max_delta_ns);
> >   delta = max(delta, (int64_t) dev->min_delta_ns);
> > 
> > For Xen (well, for the Xen clock) we have:
> > 
> >   .max_delta_ns = 0xffffffff,
> >   .min_delta_ns = TIMER_SLOP,
> > 
> > which means a guest can't ask for a timer to fire earlier than 100us
> [...]
> 
> I know this is not fully related with the current discussion, but in
> these days I had a look at the code again, and...
> The comment for TIMER_SLOP in arch/x86/xen/time.c says:
> 	/* Xen may fire a timer up to this many ns early */
> 
> Isn't the comment wrong? shouldn't it be "...many ns late" instead of
> "early"?

I would say is something else entirely. 

If you look at "clockevents_program_event()" in kernel/time/clockevents.c,
you see that the min_delta_ns value sets the limit or granulariy for the
clock's sleep time.

Basically, it is the minimum amount of sleep one can set for the next
event for the clock in question.

- Ryan
