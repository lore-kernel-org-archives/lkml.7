Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E182C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A6C206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574871846;
	bh=VlHFPAgt/0WbocE6gcofEs0ZlUbvLUxBAz1rxxQ5jN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KPMHcdrogLYcQVnhZluyxLrH5PiSLxfbaIDv0GQgM7OdSuz45lefA4t7Vwx4/ZRdA
	 tRCouNX/+fIgCukk29oX80HJJZCU/jtMZd9PDpj+G5NxHGbxd6yTjMYefil5iXkxGE
	 Je+1613kL1qAQvPr5xKVdsPPGRYWth5OaDAtV0zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0QYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:24:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54196 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0QYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:24:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so7730971wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnpQ1IWgNHmtlkWcvo5sOfYKcJiRkrf1DJyC0wdyg/A=;
        b=RcwyNTIgz9nBqmxExLTkMLYyM15f8K5uTuf90wuXjcN5Pg+znUTGf3viUxLA2bTHG+
         87XHZ0HLBY8ghRog+j+4MUhs9ivmuU/4aBJl3TNp7v862gIMhkJ8H3pD2fpSKIZ34jUb
         cCUtX8tX9RhZPUgLOcLSXdBnmJ2lbe3Yd2Qtej7L8ZEBIKwD5zhBEfc1oDXuCc8xaM25
         COKQ6NN8JurLAv0YahAxI5C5mSkfZJOU/wwPHbT6zXUenoQayTj0e3h5GKwnwOnRn3mR
         k51nPTSWvEHP8CtEpcUD5kQkG9JbZ1gYMEWv6gGadCUHrABMbwVH3RniD7GMe443aTRH
         68sg==
X-Gm-Message-State: APjAAAWKV9KIrOJR/r/n1Hd6toyYMcaGD6sIqyaFdcSuhbZA1rB6rx2+
        H4DXLF525F1P5ALVehmgsc5vlmL0
X-Google-Smtp-Source: APXvYqw6koBVsu5yFcWL1pdK7n5WvXeFkttdBC8iFePiyXMzO4FE1ke8OMzRk3dC4MmzI/7Nbxm8HA==
X-Received: by 2002:a7b:c44c:: with SMTP id l12mr4938300wmi.71.1574871842910;
        Wed, 27 Nov 2019 08:24:02 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a24sm5209426wmb.29.2019.11.27.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 08:24:01 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:24:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191127162400.GT20912@dhcp22.suse.cz>
References: <20191126121901.GE20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
 <20191126165420.GL20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-11-19 15:40:19, Cristopher Lameter wrote:
> On Tue, 26 Nov 2019, Michal Hocko wrote:
> 
> > > I have no idea about what this is.
> >
> > It seems to be there since the initial merge. I suspect this is just
> > following a generic sysfs rule that each file has to provide those
> > events?
> 
> I have never heard of anyone using this.
> 
> > > There have been many people who
> > > reworked the sysfs support and this has been the cause for a lot of
> > > breakage over the years.
> >
> > Remember any specifics?
> 
> The sequencing of setup / teardown of sysfs entries has frequently been
> a problem and that caused numerous issues with slab initialization as well
> as kmem cache creation. Initially kmalloc DMA caches were created on
> demand which caused some issues. Then there was the back and forth with
> cache aliasing during kmem_cache_create() that caused another set of
> instabilities.
> 
> > I am mostly interested in potential users. In other words I am thinking
> > to suppress those events. There is already ke knob to control existence
> > of memcg caches but I do not see anything like this for root caches.
> >
> 
> I am not aware of any users but the deployments of Linux are so diverse
> these days that I am not sure that there are no users.

Would you mind a patch that would add a kernel command line parameter
that would work like memcg_sysfs_enabled? The default for the config
would be on. Or it would be preferrable to simply drop only events?
-- 
Michal Hocko
SUSE Labs
