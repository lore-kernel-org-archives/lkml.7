Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CBC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52214216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557903199;
	bh=CMD85OI414KOORpCEc6HTIF53RbLy/VLnhlCzxpfBhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tMt9XVp0WkJyFr7oeDZhoH+wUKUV5iIcjVYLJ5Kj508tXhXHrPgIOQ5juSgiGTcvQ
	 a9+3/li/15HlPdoOZn/J5gp/VTZoKkR9HrDIu2V+SZlXcvKjRtJ5pAhN4nsWdig75c
	 7YPBUQJCCJ1j0lCbeLt37zmoB+g+V8usTHMozmOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEOGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:53:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:48310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfEOGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15111AE5D;
        Wed, 15 May 2019 06:53:16 +0000 (UTC)
Date:   Wed, 15 May 2019 08:53:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515065311.GB16651@dhcp22.suse.cz>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 08:25:23, Oleksandr Natalenko wrote:
[...]
> > > Please make sure to describe a usecase that warrants adding a new
> > > interface we have to maintain for ever.
> 
> I think of two major consumers of this interface:
> 
> 1) hosts, that run containers, especially similar ones and especially in
> a trusted environment;
> 
> 2) heavy applications, that can be run in multiple instances, not
> limited to opensource ones like Firefox, but also those that cannot be
> modified.

This is way too generic. Please provide something more specific. Ideally
with numbers. Why those usecases cannot use an existing interfaces.
Remember you are trying to add a new user interface which we will have
to maintain for ever.

I will try to comment on the interface itself later. But I have to say
that I am not impressed. Abusing sysfs for per process features is quite
gross to be honest.

-- 
Michal Hocko
SUSE Labs
