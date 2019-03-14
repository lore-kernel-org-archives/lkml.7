Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7918320854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KtuqdYkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfCNM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:57:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35669 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCNM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:57:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so5874246qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bX/rd3bmqqBCTFhzbUqNph1QeoI3wmJKqgdu6nyWf0w=;
        b=KtuqdYkv5zyaq6xbbGZTBGQxAmKAEAyqM639VsOxYdzF6+qFgXAeCSsJ3lsWNdwBKa
         Dlb/U3NBUn5PVjvmmOuA41fVskx9ykiRUHXzXhldeQkhA2U0UR2M2Pi39UIIbJouLHBx
         dbrmPwgrTISjAqzk03zyrwSm3D9kAf0Kv92fVum/v9jerCBbbOoqlhrENhOvWoYGxg+A
         jsoTmfUgPkx0kEb1NfTJteG0904Bc6SCzF7gT4BYs4gImC6XMpq9AIDsZzhhey2L64Vo
         VSJ+wZnnALkE7SNdc0nuf/9i2YgPi2lWMZ+kCq2O3VdX9lFgJYf92zkS/VYCAIcMuNVB
         pi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bX/rd3bmqqBCTFhzbUqNph1QeoI3wmJKqgdu6nyWf0w=;
        b=GvOYe27BrRmKtP3bUxGwgrMWjc+U2JRDXfu3o3cDQuF34bQDbdh29+9litr0BbSRML
         q97Kd8HgCXnA0fntUfkLTMoVDQTr4A7tgVLIe5YQ2wgM+5DcgfZ7Inwsw+fS5nR6V/3D
         ZpH1fGzPML4MCmDJG9qn+axaabTl5XOunWz8esvU0hCtNA7Q4H80YZ4nYM14udr4kCX6
         FUXRehfBcMoBKK1mlUx8TcnRcNOpbZYK1/E14BXcKukgrGVD7D9ts2St39J6t6liz3d1
         loa2IvvnvakrJQiQTSfZPOmHCQChWXYzkZ6czBfh7uQ7Bb1j463/iVe1Ljd7qWNO19lv
         Q1gA==
X-Gm-Message-State: APjAAAWrsG1Je7JY7X5BkAJZCPjiFtVQLxj25lgo7Ok8UcnuenHNbEWs
        rk2aTe4YvJMjmqttbynazlc0+g==
X-Google-Smtp-Source: APXvYqytd9p0uuBZA+SHiOfiS+QNDImQNuNaDK+xWX3URuepKNRKJc6m8GyKCufcLMESAHwzO4Z/Zw==
X-Received: by 2002:aed:3608:: with SMTP id e8mr39101742qtb.31.1552568241012;
        Thu, 14 Mar 2019 05:57:21 -0700 (PDT)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id 59sm6692195qtg.26.2019.03.14.05.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 05:57:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h4PvC-0003Fv-Vi; Thu, 14 Mar 2019 09:57:18 -0300
Date:   Thu, 14 Mar 2019 09:57:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Christopher Lameter <cl@linux.com>,
        Jerome Glisse <jglisse@redhat.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190314125718.GO20037@ziepe.ca>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
 <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
 <20190314090345.GB16658@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314090345.GB16658@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:03:45AM +0100, Jan Kara wrote:
> On Wed 13-03-19 19:16:51, Christopher Lameter wrote:
> > On Tue, 12 Mar 2019, Jerome Glisse wrote:
> > 
> > > > > This has been discuss extensively already. GUP usage is now widespread in
> > > > > multiple drivers, removing that would regress userspace ie break existing
> > > > > application. We all know what the rules for that is.
> > 
> > You are still misstating the issue. In RDMA land GUP is widely used for
> > anonyous memory and memory based filesystems. *Not* for real filesystems.
> 
> Maybe in your RDMA land. But there are apparently other users which do use
> mmap of a file on normal filesystem (e.g. ext4) as a buffer for DMA
> (Infiniband does not prohibit this if nothing else, video capture devices
> also use very similar pattern of gup-ing pages and using them as video
> buffers). And these users are reporting occasional kernel crashes. That's
> how this whole effort started. Sadly the DMA to file mmap is working good
> enough that people started using it so at this point we cannot just tell:
> Sorry it was a mistake to allow this, just rewrite your applications.

This is where we are in RDMA too.. People are trying it and the ones
that do enough load testing find their kernel OOPs

So it is not clear at all if this has graduated to a real use, or just
an experiment. Perhaps there are some system configurations that don't
trigger crashes..

Jason
