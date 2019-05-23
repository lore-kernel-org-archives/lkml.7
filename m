Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5FDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9244520881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CStJflZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfEWTts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:49:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33884 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387902AbfEWTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:10:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id t64so4319626qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ghkOAlfJKu4tMoQKys/1EHqRxAiTe4oOiX6IKeo2jBc=;
        b=CStJflZDRmQsaJAW4LdEdIgLN08TdeV6wfXiFQVetGvvLwGR78wlPTdu3Y1rnSUP2z
         PAdqF6JW8oZyONTN6ZJAK/owBJKO5ZdBZN4letqRLItdPhUvAPD44UBf4mdPEuvvfl9m
         jQu+i+rHGzgN5b9nt83NlNqp9sm4osT9bZ2JSg+rcNZfu24HiPbA/IvSv8NNAlI3gpny
         UdpW+yXapIINK+p+9EMp7a3udWtaLUtEXQgU9RBmoU47E9VDVODLv2J4/RKajH+FwK//
         Luh2IQjW7wfZctKpOvPkEJ1SafhIIKBlPNhORqpfr9ACctHprx1sexCgWxJrclZRsgF+
         +1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghkOAlfJKu4tMoQKys/1EHqRxAiTe4oOiX6IKeo2jBc=;
        b=L0lg1ZScWRV1e3l08Vwb65fGmyg5akH7zhvS357RbOzgllfd+hyx4E4nD7X+h/735Y
         9Gdv8Yo/qCiiEDHjXMJw6jib56J9tFQK+LxyAsn4o4OzIhEZkCxyhPU6icf8wzH8Yksm
         Su730JU9DLL0RNMWMHRNaV+apNv7TdcrBvdBWwOr+zEY1UYnmF736Ut5zcVb45mvxf/c
         Qjqlmiy0NSbze11AWg8w4B/6W5nhtK2cBX/FO6Y8XLVTK1M/Pv1nsEHwPe92A/c74f4e
         C2hwrUSAnNOQf9snhy4DuGfr1FgFnb5uC4L+tGloDZSMg/m4AqMLKKdJkca8o3DgRsd+
         CjXQ==
X-Gm-Message-State: APjAAAVEncN8C27UjHUzEupN3kHh0Q8aifrfPVKsh1/8ANAUczMFUhxU
        uadaA0WhKV3p5ymlAULCc3YYTg==
X-Google-Smtp-Source: APXvYqy/wYrbpFnHYbhiKL987tF9J8OP2PBwu2icZP7tr48Sjo+bfXBS/A5sIwuRti5XspgHsz+C5A==
X-Received: by 2002:a37:a1d0:: with SMTP id k199mr76164698qke.116.1558638640113;
        Thu, 23 May 2019 12:10:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f33sm122704qtf.64.2019.05.23.12.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:10:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTt6t-0000gd-0V; Thu, 23 May 2019 16:10:39 -0300
Date:   Thu, 23 May 2019 16:10:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523191038.GG12159@ziepe.ca>
References: <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523182458.GA3571@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> I can not take mmap_sem in range_register, the READ_ONCE is fine and
> they are no race as we do take a reference on the hmm struct thus

Of course there are use after free races with a READ_ONCE scheme, I
shouldn't have to explain this.

If you cannot take the read mmap sem (why not?), then please use my
version and push the update to the driver through -mm..

Jason
