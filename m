Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D77C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE8120675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575467337;
	bh=YqFbjWPUk3rwAf93tYmJstAPKYk1zOHT37wBLmZzO+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ach69JTCS+jutrjdViUF+589111NuwpOYYUaEeI9tMfg8fviW1/khez4XgItMjd6M
	 Qp/1neV7rixqgutpwk5sq5DYVELl1nRPXJAqPWaVmLFpYkw6XTTKpWisjHsnbyElql
	 POWVvYyARJkGU41cagYpFg9pEcEKetTPIzCov7vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfLDNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:48:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44438 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfLDNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:48:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so8622866wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qKt3fgYEHdyVjIAjoOhERCvfE0DFlu+fhVdi9xPnJdk=;
        b=CVdZQ3pFsu74FoWs3/jTRafSytujQJEovTahfYVcYa2k9jmZmGavC4qXoCqCvk9eLy
         w7N8VHkc7dT0djny+a7fLPtGv/rO0YjYOzQmQ3wz+boVv0lgdKehoykpDODXRDMr8Ye/
         C5+paj5Yy4MRceeQ2vRk28l+bZOs7TLIMR5uXu9KEclDqrv/s0s//EliUT002r36xqLz
         J5zSyIfFaU+V5scVGxuAv1CpT73fGWutmaRxdd5WA3MKkTPWsGm4T8aFZw865st4qUP3
         7kCHz8D8Wdt4a+Tbpj48w/P2Y084l4atC1bMCXGZrySd2aDVBMOP5FCvgWYw5WeRrXEV
         1f/Q==
X-Gm-Message-State: APjAAAVx+mY+wX+M5yXAgiAIt8M1Qgv/zrgLuvL5iG1r7Fz5y3aOdura
        eXgubGWs2i8tqeKtXurjLCE=
X-Google-Smtp-Source: APXvYqzUiAsWvg1avw6/n9S8BdQL0pHzBtuvBpKCZhCyP0XWFnjFNbmmp8KFGWWwfhW5J3HZ9PnlQw==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr4341444wrb.22.1575467331881;
        Wed, 04 Dec 2019 05:48:51 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o15sm8765601wra.83.2019.12.04.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:48:51 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:48:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/2] mm: Add and export vmf_insert_mixed_prot()
Message-ID: <20191204134850.GG25242@dhcp22.suse.cz>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
 <20191203104853.4378-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203104853.4378-2-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-12-19 11:48:52, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The TTM module today uses a hack to be able to set a different page
> protection than struct vm_area_struct::vm_page_prot. To be able to do
> this properly, add and export vmf_insert_mixed_prot().

A new symbol should be added in a patch that adds a new user which is
not the case here.
-- 
Michal Hocko
SUSE Labs
