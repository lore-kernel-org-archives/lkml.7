Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FE6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994F42082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394289AbfIFORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392868AbfIFORv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:17:51 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3586D11A12
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 14:17:51 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id x19so6406244qto.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tzDszuqoBQ88xDVaM9hs1cwB75PSJweaPTjm/VD0ZjM=;
        b=DFbubj0wKzg2LMH+TwMezS3jRlWnn7ZrIsrErgEsqnovWlS22W6RatbBqlKxPFfsZl
         jg1fsj3blg7vlaufxTv04XrvMGWpLtqiWJgPqDlmQknxMt3CR233kYnvt6qTQzOyFlpA
         rLvjmUixftyMv3LgbAQbi/5gQkHyLbkBTnKFaGjkNC9fqHj8hkmMhu0q8rb0l+7ke2T/
         ACaw6DgUmGLeNVYZuAQbTPh3xm5YnXB5Ttdv8HZHuWr3zp3GhyJujMm2ukiodCcqFOs2
         TGeLBxSs+ZR5hj1TiOwYg1ntNC87CJ5HqDnS5QC+N6vyKSaJ7NoOVCEqiLyZPC7YSm/i
         k8MA==
X-Gm-Message-State: APjAAAX5JqCmqgh5jYtrslfWqKHC0FA9im80HNROX+8xMbHZJz7zbbBK
        QHF1iL/6H9mEGeFxuM0JXW7b7QnVzPR4rhtgQh5fEfJLy23lF+023LfRPxLhqIpWcnActwMjIVM
        /wkh/428E+md+y7S92fyZEkmy
X-Received: by 2002:ac8:4510:: with SMTP id q16mr8952801qtn.247.1567779470605;
        Fri, 06 Sep 2019 07:17:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQiC3PC9TmfSYzvcGUcmmMs1BRVachZAgmwDWOQxgs/xawnMqIPU9mszTB1/u4msJYq21W3A==
X-Received: by 2002:ac8:4510:: with SMTP id q16mr8952787qtn.247.1567779470471;
        Fri, 06 Sep 2019 07:17:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id z5sm3254157qtb.49.2019.09.06.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:17:49 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:17:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906101339-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <20190906120817.GA22083@redhat.com>
 <20190906095428-mutt-send-email-mst@kernel.org>
 <CAJfpeguVvwRCi7+23W2qA+KHeoaYaR7uKsX+JykC3HK00uGSNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguVvwRCi7+23W2qA+KHeoaYaR7uKsX+JykC3HK00uGSNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:11:45PM +0200, Miklos Szeredi wrote:
> This is not a drop in replacement for blk and scsi transports.  More
> for virtio-9p.  Does that have anything similar?

9p seems to supports unplug, yes. It's not great in that it
blocks until we close the channel, but it's there and
it does not crash or leak memory.
