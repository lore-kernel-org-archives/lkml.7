Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A3C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD122146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giL2cRqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfLRPKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:10:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbfLRPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576681819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QM58zRG2E33uopTi5C1OLZUP84XlNWgGlqpWQbuCIPw=;
        b=giL2cRqi7uySqBFzskBehkV1wUW21VtzT/szfQoPmHMZHhfhIp1sP6/YB/kt2YUmqaU3+i
        VmiHC6An73+bsyz9InEjx3FJ4+NH8ZgBN7a/qdgW5TUK6bYmbypN0enjkFYVAO/WgBfZnP
        Z3LounYvq1sOhEhXX+mh1L6n5qgA8Ws=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-u8ryBpnTP02wqiERj4m_Yw-1; Wed, 18 Dec 2019 10:10:16 -0500
X-MC-Unique: u8ryBpnTP02wqiERj4m_Yw-1
Received: by mail-qt1-f200.google.com with SMTP id e8so1568169qtg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QM58zRG2E33uopTi5C1OLZUP84XlNWgGlqpWQbuCIPw=;
        b=VnCixpAETyJfVra0n10Gwb8SR8ihBQ18oX2LS26+LK437l7Mc/TqirwnRuPwkg/GcP
         kb0L7ETkji0EYclkdCGdCWtgQSOXZpMyUldN9zbqcqCLFKd/Z0xECU4hj8+wYtX5BeA1
         j3W8BvlUkdYgmwFqRWIyIAubLatOidpSYwt6qCw6NkyQRsKmjVhsY+Ai60SNiJzX6gny
         rCxn1DQKgqktwW7JEEp+NUajTh2Q3d7PGwf/Yfy07G6ZSEnyounSfCaIJbUwKGDtJLlY
         f5MArOQpHUsAvmEC9kbprt2Pt/2teBIRLkVNc3oiFvEk/eCLrkK+TTOa/vRmRSBkncER
         uBIA==
X-Gm-Message-State: APjAAAW+w7mxr57KyMIjMZl8tL160azXWzL8fyZ7MuliMCYWqvm5ZWn5
        Q6tuHBNWSINih+DcmDJTRs5kCYrMwprP+hbMPRjMO6keXp3tkQ7CM++Xxv97TB2WqkTv8Z3fIkj
        0kuyow1J0FYl/kuN1ER2kmxz9
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr2673046qvl.39.1576681816438;
        Wed, 18 Dec 2019 07:10:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhQfsc+4bORIeWfJPGw6vR+W11ECcHruYmI+Dy/4t2QYKRuVwYMstb8WaGcqyUqp1oBsusFQ==
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr2673022qvl.39.1576681816185;
        Wed, 18 Dec 2019 07:10:16 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id i19sm716606qki.124.2019.12.18.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:10:15 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:10:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Message-ID: <20191218100926-mutt-send-email-mst@kernel.org>
References: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:43:43PM +0100, Christian Borntraeger wrote:
> Michael,
> 
> with 
> commit db7286b100b503ef80612884453bed53d74c9a16 (refs/bisect/skip-db7286b100b503ef80612884453bed53d74c9a16)
>     vhost: use batched version by default
> plus
> commit 6bd262d5eafcdf8cdfae491e2e748e4e434dcda6 (HEAD, refs/bisect/bad)
>     Revert "vhost/net: add an option to test new code"
> to make things compile (your next tree is not easily bisectable, can you fix that as well?).

I'll try.

> 
> I get random crashes in my s390 KVM guests after reboot.
> Reverting both patches together with commit decd9b8 "vhost: use vhost_desc instead of vhost_log" to
> make it compile again) on top of linux-next-1218 makes the problem go away.
> 
> Looks like the batched version is not yet ready for prime time. Can you drop these patches until
> we have fixed the issues?
> 
> Christian
> 

Will do, thanks for letting me know.

-- 
MST

