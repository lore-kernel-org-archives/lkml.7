Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B44C3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5AE22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0UUia2/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfH3MxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:53:03 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36688 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3MxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:53:03 -0400
Received: by mail-ed1-f47.google.com with SMTP id g24so7909459edu.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJ9lwG3RTP+Jvi/HZawXrUdGY7AI93wOtzLOW9EdgGk=;
        b=0UUia2/qGEF00d/i/y8PSkp/UHVDdyuDytcD3HFpzES8GBzFXkOL9FU2pcMd4H+ElV
         fLO/0YNsUioOlhgtGrVm2aA+cR1Xs2RGMwH7kfxlPmxWH20wOW/kiVgtmacdjFVnJiFz
         Fbme+Kzl3zTGMfgJKjQKJdnNS0Y0ffPZCaL2e6FYFzkyuEbr+SZk3F+X77cxn8+LuKLE
         UAcHGrhi3U5XbblvhIMSuhUbZKm2d26JS+S/gC4cVAoG/jPA27zoU4muERx61y6Z/W4a
         xoxkzuQleilkx70JqbhE0KETyo7dIKGiKxtHoAAnH2Dbp0RnhAYHheqYQb6Ru9LgYNfY
         nMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJ9lwG3RTP+Jvi/HZawXrUdGY7AI93wOtzLOW9EdgGk=;
        b=WgWNAoMSLbtocLsYZJBKWtiFp6jETF0N0jm0LurLwXcVv9IAdyH5F02KYCwuAtRRIW
         0euB2W4A3WSkjEf6wvGiVAjHyWqBGGkJkDFgjcUy7BZbXKC/nWvCzylzCnt/sEwofj2X
         2A+h/wZNsw31DUZwmFzHelmdYLDKsaNhOWj1C+2VPsi8sUFGcF3+EpvGBGxSPYITJnrj
         b4wyadc1+4eCxWHYWHY+W8Sx/MyuVM1WbQ2r+M5dVVombnqAjJxpI9JyKCteEVot7FmF
         2HvnxpPwr5PsLqR7z70VzVu4ctO1yQNc5By6uOKKhW/Dkme55AcGnJNR66O1ytrwiEhJ
         1o/A==
X-Gm-Message-State: APjAAAUvnFrWeSdB61Ct5dKPzuUNo/TZnHH0bQOGsO+c6hDHm2wbBc59
        7y/UcGOi6BH+cCC4rayb5GFVSLtL8C0=
X-Google-Smtp-Source: APXvYqzdkhhcak1xWdA+IKDsOWAlWIvSXkkrHP68LeLhE8lEQrCEEok6PsdDDqVswLNoQtlst9PvIg==
X-Received: by 2002:a17:906:aeca:: with SMTP id me10mr13012730ejb.255.1567169581381;
        Fri, 30 Aug 2019 05:53:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r23sm996022edx.1.2019.08.30.05.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:53:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86ED61023D2; Fri, 30 Aug 2019 15:53:04 +0300 (+03)
Date:   Fri, 30 Aug 2019 15:53:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190830125304.m6aouvq5ohkerfls@box>
References: <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
 <20190827120923.GB7538@dhcp22.suse.cz>
 <20190827121739.bzbxjloq7bhmroeq@box>
 <20190827125911.boya23eowxhqmopa@box>
 <d76ec546-7ae8-23a3-4631-5c531c1b1f40@linux.alibaba.com>
 <20190828075708.GF7386@dhcp22.suse.cz>
 <20190828140329.qpcrfzg2hmkccnoq@box>
 <20190828141253.GM28313@dhcp22.suse.cz>
 <20190828144658.ar4fajfuffn6k2ki@black.fi.intel.com>
 <20190828160224.GP28313@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828160224.GP28313@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:02:24PM +0200, Michal Hocko wrote:
> > > 
> > > Any idea about a bad case?
> > 
> > Not really.
> > 
> > How bad you want it to get? How many processes share the page? Access
> > pattern? Locking situation?
> 
> Let's say how hard a regular user can make this?

It bumped to ~170 ms if each THP was mapped 5 times.

Adding ptl contention (tight loop of MADV_DONTNEED) in 3 processes that
maps the page, the time to split bumped to ~740ms.

Overally, it's reasonable to take ~100ms per GB of huge pages as rule of
thumb.

-- 
 Kirill A. Shutemov
