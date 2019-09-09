Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3594C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84228206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbfIIMQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391102AbfIIMQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:16:01 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06B6881F10
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 12:16:01 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id n125so15998982qkc.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 05:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cR0iPk7k3gak2smW+VGCzi1D6+WqwWLkfLqRmEk+oQ0=;
        b=faa4al/6w8XxOqfTvF1R6CUbA4py+M607+qkl9uUwQGFbDKWNnWWmC8sexgQNU96n4
         sJseKD63B0gF7JV6Wn8zKkLM2tWR1lE+N8OGUuCos/gRISxmIfc5PewPHCqRVV2bhJiX
         KGNwQ5NpL13kA/sHbu5AyBumljHgzMErsSIYIurCjw5BGUTVHcc8TDweWS/WccHEfJvj
         skDgS9Qx9zR0kfSmZxMm4ex+HCAI18XSYhatFZ0iSPBA+1+yB//MaxlB7hdfIH/71QuM
         AtO90nypCaWmJJ8GcAhtpJ+XaRnEKpAfJ9Kj77eg69OZvlrDudhkv56Y84q5CsfeZSQB
         0WYg==
X-Gm-Message-State: APjAAAU9aza5wWaJjvPxG5cyvv6g16JaIL1Ci/EJ7K2rNeBB0eDwQopz
        p13fPuvbZCaThtujImw6XED6Kaq0aPQurVGRSdtHUM8IQebgyoVwJlRw4ZL+sYtVXlUHYuNVPnf
        lSzgNMSuLsVbbvlW3SSwE3lIv
X-Received: by 2002:aed:3527:: with SMTP id a36mr23116299qte.82.1568031360373;
        Mon, 09 Sep 2019 05:16:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTjEC9gLktIgrr/FKS4EvJdW8yr2QsPhfhm1/EGltRDxNNwBhSFB09DwZLmFGxdw8mqFXn1g==
X-Received: by 2002:aed:3527:: with SMTP id a36mr23116262qte.82.1568031360138;
        Mon, 09 Sep 2019 05:16:00 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id g194sm7059848qke.46.2019.09.09.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:15:59 -0700 (PDT)
Date:   Mon, 9 Sep 2019 08:15:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     David Miller <davem@davemloft.net>, jgg@mellanox.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, jglisse@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Message-ID: <20190909081537-mutt-send-email-mst@kernel.org>
References: <20190905122736.19768-1-jasowang@redhat.com>
 <20190905135907.GB6011@mellanox.com>
 <7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
 <20190906.151505.1486178691190611604.davem@davemloft.net>
 <bb9ae371-58b7-b7fc-b728-b5c5f55d3a91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb9ae371-58b7-b7fc-b728-b5c5f55d3a91@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 03:18:01PM +0800, Jason Wang wrote:
> 
> On 2019/9/6 下午9:15, David Miller wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Date: Fri, 6 Sep 2019 18:02:35 +0800
> > 
> > > On 2019/9/5 下午9:59, Jason Gunthorpe wrote:
> > > > I think you should apply the revert this cycle and rebase the other
> > > > patch for next..
> > > > 
> > > > Jason
> > > Yes, the plan is to revert in this release cycle.
> > Then you should reset patch #1 all by itself targetting 'net'.
> 
> 
> Thanks for the reminding. I want the patch to go through Michael's vhost
> tree, that's why I don't put 'net' prefix. For next time, maybe I can use
> "vhost" as a prefix for classification?

That's fine by me.

-- 
MST
