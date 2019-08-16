Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23EC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AD32171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PKOKEY8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHPRX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:23:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33701 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfHPRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:23:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id w18so4627868qki.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pD8Tbdojb+tV/T42U7/Bt4fJei4dk6nxHPESNZBzUPg=;
        b=PKOKEY8hGxaOdpj1T8hBrDGYtsUrnU0AObkNmorj7jn7hBXpX2Kp/ztvI9DGVCYTQE
         dc7AfGY5084FNsyK1iFgRwps/IMRwPx5SDeHZ6iG6Vx1Auh9Jiwqi8IwIFgmkC1IyaaP
         ZG/0N27IRdZCGF/hPvMRXRbsTrG+8jAJ2xVMkv6g6aeYSe5QxCHrQ2ZmirGBi7NhhAtL
         8LPoo597le/ShD9ep2nuha5j6xRqGlB/XWU5NWICIfVLLTfLX0mziYqsaSh3ZaTmUF0u
         cvAphTs2Z1DvPDJOzISG6/SYjf5j85EYdPNZa7ztM4aMs2xfCrXlpdbNpKuWGh1E+PLB
         PLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pD8Tbdojb+tV/T42U7/Bt4fJei4dk6nxHPESNZBzUPg=;
        b=kgkduQ+f7cO8/V+j1AchGGWRJIkaxTsD5LV33RmVRREmxz/Kajdvj96fvH1/9drZ/B
         U3BKRkWBDgcmQ15QBi+9jZkYNWtGWz9oF88IWEqXAn+Cz0OswBNHkQv+6aEnpb4VpRUl
         fdm5sj7oA5xrTaqn4q7NlE04BodfiE63RGM+kS6Nfppq/zHSCrw49bcQQj4eQbZYkE6c
         /eLvB5wIEccaib7MV20JrXqtVGCLrZ4gZ4ssDCf9nhMwmJIOnedR8ndjEIzct5UueX5F
         cbn8DgE3lp4xDf4YESOvw3k/VQMn4f6cMDTbpvkG8PlgHCp8MdscGi+NN8DcH0Gf9ZAs
         +rWw==
X-Gm-Message-State: APjAAAXwXJCUDB2XwLu6WkkWyats1BESNYuJlk6T24qKOflw7GasArSM
        0GB93fX46YSOPWE2DcpkMChNTg==
X-Google-Smtp-Source: APXvYqyAuZxMtBrIj2lrXbWPNUHVpEBKMq4p2dvILNeEBwhH8SLFMps9jaKCtPjbt9+U/fOmx5c77w==
X-Received: by 2002:a37:805:: with SMTP id 5mr9982722qki.351.1565976207466;
        Fri, 16 Aug 2019 10:23:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 23sm3185723qkk.121.2019.08.16.10.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 10:23:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyfwk-0000tb-MA; Fri, 16 Aug 2019 14:23:26 -0300
Date:   Fri, 16 Aug 2019 14:23:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: turn hmm migrate_vma upside down v3
Message-ID: <20190816172326.GI5398@ziepe.ca>
References: <20190814075928.23766-1-hch@lst.de>
 <20190816065141.GA6996@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816065141.GA6996@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 08:51:41AM +0200, Christoph Hellwig wrote:
> Jason,
> 
> are you going to look into picking this up?  Unfortunately there is
> a hole pile in this area still pending, including the kvmppc secure
> memory driver from Bharata that depends on the work.

Done,

Lets see if Dan will comment on the pagemap part (looks
straightforward to me), and then after we grab that I will declare
hmm.git non-rebasing and Bharata can build his series upon it.

As a reminder, please do not send hmm.git inside another pull request
to Linus without making it very clear in that cover letter and Cc'ing
me. Thanks.

Regards,
Jason
