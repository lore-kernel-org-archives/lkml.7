Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73923C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5004A2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cj6EGJBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFFTce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:32:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36851 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFFTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:32:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so2245391qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReUr/Ku4fFDe5ZS2T9E9QBdlSpBszMAhDsjnGAK3/wQ=;
        b=Cj6EGJBe/zmvkukObl2zSGVLq3S3tTaTPWaZ+Sywbvhq92MZz4ML0y38mXzUeTR23/
         t4yPrDLmNbgUewFAGXp6T5P0woF0ZWn9fOSzbizSJOMGmE+qUeXcmRiqM+z2lb4ZCkCi
         31Hiwd8nVObYBpqL1W/0OyvbXZyiVllJFQpXzQ7dnCL4plxyaAq59zyWrvkSTtBqagwO
         WXCbtaEQikmMDKheY3qe8epJmKwbKYjKbjQbBgT5gmfffhj2ooME6lxTLPOsC/RUtQUf
         ZAT0Tf6srv9sdqsxoZmtaxk6jl1ORa+N5QMua3t6i7cD2ev8cPC/Cpmil+zbuW2AM/mI
         HjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReUr/Ku4fFDe5ZS2T9E9QBdlSpBszMAhDsjnGAK3/wQ=;
        b=EP0ZR3aXZiI/vNK3jRpfH3KCSO0+9J3YxlHn5OhwWBurdUguvCdSb5///6AsaZMbSs
         6dc4479QwOzf5h1s0ZxqtPVdHsJ3YHMjvcjUDM1UddeEwFgUvZMNPFBWaW5CsE13U8dc
         Pchy68MuM7L2kg60WZzR5sr3Dhj+jujN+1o7EIiLINwrDB5Gb+Ody3D655mwZ6AdCxH4
         bgcWghKZTCgo/kA8FSUgI8EI7LcvbS64Pq/qAa1Bsuv9FlBHluZDuHR4j2hpPc9ftM5R
         pCkdCn5DhWeoG4giSxxBEgV/LuqPZCes+zkVpvYVcmjERBzRMBd+Tuh3Ioykcdw/AgUF
         32WA==
X-Gm-Message-State: APjAAAXwwqMSeEyVLIzVlHKnr4kD6yelg3FOsVVImQprVN8RtPuzWcBH
        dzRtS/Gwt3Z92+LA3GacgeXaMw==
X-Google-Smtp-Source: APXvYqxslyBL8NRCNrjjqXklGNp+xKIpW25Hd3ru2Bjoc/pn1jUdGOEWQpM2BD662L/L4lP51oy5EA==
X-Received: by 2002:ae9:d601:: with SMTP id r1mr40812490qkk.231.1559849553201;
        Thu, 06 Jun 2019 12:32:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f6sm1381433qkk.79.2019.06.06.12.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 12:32:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYy7k-0000Ve-9j; Thu, 06 Jun 2019 16:32:32 -0300
Date:   Thu, 6 Jun 2019 16:32:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 1/5] mm/hmm: Update HMM documentation
Message-ID: <20190606193232.GH17373@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-2-rcampbell@nvidia.com>
 <20190606140239.GA21778@ziepe.ca>
 <e1fad454-ac9b-4069-1bc8-8149c72655ca@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fad454-ac9b-4069-1bc8-8149c72655ca@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:50:15AM -0700, Ralph Campbell wrote:
> Yes, I agree this is better.
> 
> Also, I noticed the sample code for hmm_range_register() is wrong.
> If you could merge this minor change into this patch, that
> would be appreciated.

Sure, done thanks

Jason
