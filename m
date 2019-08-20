Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9310C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF9222DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP2JVhuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfHTQI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:08:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46969 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHTQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:08:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so2977668plz.13;
        Tue, 20 Aug 2019 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97QLXB8lHOGizWTCYqqOiIcONI9R+7mpmxz57KY9Srs=;
        b=uP2JVhuMxV1h0sXuG8TvQSUvyglb+0aQSIs3DUtLpW5eW8SrbAiR2xrYLRnYY15NRj
         q7D/4D25J8LlBz/C6RnMsXOsi13b2VaTivIQv0xUgPTDdqRtI1/gbHWsU45W5t960JkX
         ER6IrkJKwIuuKomSFKipX7E8Pu8BN6Hvjx1HRbTbD4YpQyvsye3ZuhvFQGiuDkoin46H
         7yLryJOOI5i3bfMei8EQoDk1b9GcBZCGbzn1B468uhFxvtJoCzQ5uA3v7LzGzS6EyG1d
         nYOhHMr72jZUhvPxGgFoV2NWDh6cgV+MOa6cfqVowYpRB28/bylUGpZuGRr1fxx05AGB
         4EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97QLXB8lHOGizWTCYqqOiIcONI9R+7mpmxz57KY9Srs=;
        b=bl1U0Xe5OFZU1BRBETpzqsrQRJKjAR23r17oo6GBDRrAWtrLgLRwJFu9KWxdShVMr6
         GVYy8XLyjFW/5qyMIrKQ4iLk1UfgzQdTdAmgnsyHwDQ136bqA1bn5noFnBbHQVvu11cK
         ZLx5AGWOGJDRmMEBV2LltDI90DJ7LJrsK7M5S6XjSlvHzDGKy/bbRFBvEVJNbFaDe/a/
         IijIX/uYcCVvH3teAlhMQNCKMCpvh2Tg1vr2sVCSXkgqzl01r5fUsEk6x/yj0Fd86Mkg
         xcXDiQNqSsUYhZtt1XTlwk/Cg11svvsttD53bNZv9ucmj4ZtVB/5UTBnO9s+xGau94h/
         Ssbw==
X-Gm-Message-State: APjAAAVWfTM2azao3UFW85htD2rsUhOhn1opvir+5P7koC1VyAJIHHU9
        /PVdz+p6lSlLW6TgyeWlT0E=
X-Google-Smtp-Source: APXvYqzms0bu0DnDtue04LyAMdXTKPIxc6JwRX9Jlbp2qQDU1kFArb7iW/pVQapNCXXK1A+YofHCdw==
X-Received: by 2002:a17:902:2f05:: with SMTP id s5mr29240623plb.170.1566317308032;
        Tue, 20 Aug 2019 09:08:28 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id e13sm21986232pff.181.2019.08.20.09.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 09:08:27 -0700 (PDT)
Date:   Tue, 20 Aug 2019 21:38:22 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim Krcmar <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        khalid.aziz@oracle.com
Subject: Re: [Question-kvm] Can hva_to_pfn_fast be executed in interrupt
 context?
Message-ID: <20190820160821.GA5153@bharath12345-Inspiron-5559>
References: <20190813191435.GB10228@bharath12345-Inspiron-5559>
 <54182261-88a4-9970-1c3c-8402e130dcda@redhat.com>
 <20190815171834.GA14342@bharath12345-Inspiron-5559>
 <CABgObfbQOS28cG_9Ca_2OXbLmDy_hwUkuqPnzJG5=FZ5sEYGfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbQOS28cG_9Ca_2OXbLmDy_hwUkuqPnzJG5=FZ5sEYGfA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 08:26:43PM +0200, Paolo Bonzini wrote:
> Oh, I see. Sorry I didn't understand the question. In the case of KVM,
> there's simply no code that runs in interrupt context and needs to use
> virtual addresses.
> 
> In fact, there's no code that runs in interrupt context at all. The only
> code that deals with host interrupts in a virtualization host is in VFIO,
> but all it needs to do is signal an eventfd.
> 
> Paolo
Great, answers my question. Thank you for your time.

Thank you
Bharath
> 
> Il gio 15 ago 2019, 19:18 Bharath Vedartham <linux.bhar@gmail.com> ha
> scritto:
> 
> > On Tue, Aug 13, 2019 at 10:17:09PM +0200, Paolo Bonzini wrote:
> > > On 13/08/19 21:14, Bharath Vedartham wrote:
> > > > Hi all,
> > > >
> > > > I was looking at the function hva_to_pfn_fast(in virt/kvm/kvm_main)
> > which is
> > > > executed in an atomic context(even in non-atomic context, since
> > > > hva_to_pfn_fast is much faster than hva_to_pfn_slow).
> > > >
> > > > My question is can this be executed in an interrupt context?
> > >
> > > No, it cannot for the reason you mention below.
> > >
> > > Paolo
> > hmm.. Well I expected the answer to be kvm specific.
> > Because I observed a similar use-case for a driver (sgi-gru) where
> > we want to retrive the physical address of a virtual address. This was
> > done in atomic and non-atomic context similar to hva_to_pfn_fast and
> > hva_to_pfn_slow. __get_user_pages_fast(for atomic case)
> > would not work as the driver could execute in interrupt context.
> >
> > The driver manually walked the page tables to handle this issue.
> >
> > Since kvm is a widely used piece of code, I asked this question to know
> > how kvm handled this issue.
> >
> > Thank you for your time.
> >
> > Thank you
> > Bharath
> > > > The motivation for this question is that in an interrupt context, we
> > cannot
> > > > assume "current" to be the task_struct of the process of interest.
> > > > __get_user_pages_fast assume current->mm when walking the process page
> > > > tables.
> > > >
> > > > So if this function hva_to_pfn_fast can be executed in an
> > > > interrupt context, it would not be safe to retrive the pfn with
> > > > __get_user_pages_fast.
> > > >
> > > > Thoughts on this?
> > > >
> > > > Thank you
> > > > Bharath
> > > >
> > >
> >
