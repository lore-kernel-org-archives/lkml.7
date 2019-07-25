Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C946921851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EAMhUgfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbfGYQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:58:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34476 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbfGYQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:58:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so36971228qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ATcDQ4WGQDqhMlOnuVN9hszx95z6CBf+uB6RvpSIK0=;
        b=EAMhUgfFuMhf2nsSU2L5GIwGK9f57Sb/xACUt4ECKjBJpm/HQqZ6/u5e8A8tXTo/S3
         E3W6xJmA+YFzYvj4SCg8GDGMtyc73QKjzKeQ7zeZ+8JGd20fiYcxZNAxZ/DxcnCLMizY
         oyHR8M0fLK/310xgxRE1X7kKREcU5OXmnmX87LVCS0q2/z73W2l7tsc49vAMOmRSjI+s
         dUpcUAsRleTi7YDosx37UbhE0Xy0fEv/cSQKqsCGtQjdHV3n5F2sGst/TSLk1EYys4Be
         iruLCzsaVpM9Jks2yzoVRQ+y0gq7dLugpuFCUxEJ2gNC9sjSFFfqA/DfR/DS5aXbFGXH
         A92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ATcDQ4WGQDqhMlOnuVN9hszx95z6CBf+uB6RvpSIK0=;
        b=g57JrsSmyMygchtjUhJldwhkCuIUjnfPBHU/LlL5Dg+qFe2YqTibjPsEf0xnuREEUY
         EsggvwxmajOZuys1piyscNWd4/NhFc4+V7+NpG3CDjGwff3r0Tv6tM8yAAC0BpAkrtBs
         W8o4X++iYWzl3QocbpjiUqFYbzwHKCbJ83Qo4yvr/5PMulvJoJdBxS50czEv+Hn43/Yn
         gEdgA9TffLXsTzVphBLXrNIip7002H/xxqYkISBxg4mqFcI3C6ph+U+bcWkmx9wlJOx8
         CA/cvweH5oAQKnWOLvs5KVIdMteZg94NVdSW5bGDQ7IvUDsqyWS5wjm7y3oNbloxwoEG
         CpLw==
X-Gm-Message-State: APjAAAWoqyhGGWMSisbmRMKePK0uvzMjyfRffpfI0OVRUFrXUW07ZbMv
        KK9ui8DmDRqBOChqfwXk5gQOhA==
X-Google-Smtp-Source: APXvYqxTDi9HHRYX7j/EoLB/+mI2k7Y0/3qlUqeXTQ/gWE/1YFV3VrGK0iQ1XBh8tmO+bugZXPl4hw==
X-Received: by 2002:ae9:ebc3:: with SMTP id b186mr60322698qkg.222.1564073909961;
        Thu, 25 Jul 2019 09:58:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t76sm23568871qke.79.2019.07.25.09.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 09:58:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqh4X-0007VM-0x; Thu, 25 Jul 2019 13:58:29 -0300
Date:   Thu, 25 Jul 2019 13:58:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw: qib: Unneeded variable ret
Message-ID: <20190725165829.GA28812@ziepe.ca>
References: <20190716172924.GA12241@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716172924.GA12241@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:59:25PM +0530, Hariprasad Kelam wrote:
> fix below issue reported by coccicheck
> drivers/infiniband/hw/qib/qib_file_ops.c:1792:5-8: Unneeded variable:
> "ret". Return "0" on line 1876
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/infiniband/hw/qib/qib_file_ops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
