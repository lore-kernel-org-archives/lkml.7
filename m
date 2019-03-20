Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA79C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E59021850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="agGczCTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCTJkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:40:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35300 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfCTJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:40:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so1411981pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ilZdXEgKQl8eu/If6oZwzfIDgI9nzN5u6h3xxR7k4I=;
        b=agGczCTyVX3YbxtbNXvXDU8mq3XwNWH9k0ijzWdCgnWmZ24E6MXUuKm4fIV2Q58fjO
         rOmnT42x6IFqOMRyniVzVvrcvEdFZuh29FVdN73buc2fLd6c9XSGSU4ekUwdIRP9w0jI
         TnG1CjqVJaKfsNBHua+/pXoacxpFw/skgnhdL+ii6OjDFsLZhdTCVeT8jAXx0g6s32ff
         uOpFM8zsMkWdQ3UMLwxog6cqiiP4a9Wn8JCr/Sm942GLxVQsp/kAULxiT5dKNnnH46Xj
         PRBqmL8qznxMJI3VqLWDQ45wB8rzfg+CagDnTAavLEuE4SvWjzHy/VzxJQpLMF3zACQ4
         92wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ilZdXEgKQl8eu/If6oZwzfIDgI9nzN5u6h3xxR7k4I=;
        b=QbClbMY+wk8BSgJDJukkvzClD6p6o4tUm+vsYKy3XLfTYN+vuTu2o5acaHOiIrUUDe
         ILYnMGoS7jIjb+s5jF9y1gcVlf1qpFAxUGZvVBDmzYfT+CDHaR5FW7ebzTufxz7r/BsD
         RRlv/bNsKfkw2+oIsr2oCzt/9j5kgtJ6uMnNJVrdwJoblFafohkTI7PAgqOfGnKLa4zF
         jsf2+jVZUKibUkstcwpDRy40UTTof9Lc65NrCX8fheecxwSemT57MM/Qwqxr9EWMbrDV
         BNfHJqC6upPcq1vXI3FE2aqj09jZuFFtP2P+xuLVFna4PSNtNt8pLHkmr9gMypOv2baN
         Hp/A==
X-Gm-Message-State: APjAAAU+CQvH5SIa9zuQtFFwn90DMLFBMqZsfN3fa1ABysujPi6/8jia
        vt4amUF6TDnmeohwQyxMOc1qTg==
X-Google-Smtp-Source: APXvYqyRZpQfbFJVEpRMID17XPrBgMkhW+bQ+/Tdq95pUIU9dvdMgO/DYyin4FL9ZRNXRc0CEIUHAw==
X-Received: by 2002:a63:5515:: with SMTP id j21mr6551236pgb.244.1553074834713;
        Wed, 20 Mar 2019 02:40:34 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id 10sm2608365pft.83.2019.03.20.02.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 02:40:34 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 47B4C3011DB; Wed, 20 Mar 2019 12:40:29 +0300 (+03)
Date:   Wed, 20 Mar 2019 12:40:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190320094029.ifweqx4wowyyr3wi@kshutemo-mobl1>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <bf443287-2461-ea2d-5a15-251190782ab7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf443287-2461-ea2d-5a15-251190782ab7@nvidia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:24:00PM -0700, John Hubbard wrote:
> So, I could be persuaded either way. But given the lack of an visible perf
> effects, and given that this could will get removed anyway because we'll
> likely end up with set_page_dirty() called at GUP time instead...it seems
> like it's probably OK to just leave it as is.

Apart from ugly code generated, other argument might be Spectre-like
attacks on these call. I would rather avoid indirect function calls
whenever possible. And I don't think opencodded versions of these
functions would look much worse.

-- 
 Kirill A. Shutemov
