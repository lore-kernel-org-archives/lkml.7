Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A83C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11204206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V4cUClr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfLRMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:53:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40172 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:52:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so1424508qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+CCGksXD0vuDKfmVp0tkHiA2uWnVRsyUsg9W47Em0w=;
        b=V4cUClr1kHNL9cE/3hnbLIPHpTlNhp+WtY4uxMwUV+5JpJW2ZkRU/U2kLhqFzz1Cb7
         /6jIEZjMyCvlYCe4JbT1Mh6uH4++6hoygmRC5fDbvFGRZ05jI+NWTdo/u6g5O8Q6zBqL
         FycUbuQdsTBjDLiDIwi1aSJaUvU9OUxVZaLUftubjgFli8Hxx04lNuXEjWrTYvHBgQDu
         +CeDQJIlzU1f5VErJatobGIzIy5/kPrwvGC8+B/zoYX+60m+ukJ5fG22X5JIKmfL8WpS
         IdI54cOJmFZ/47PZih3TuNKxgQ8S+JlYPvFqHCpBcp6oSFw7YFK2nxGgZ1NqAJH2dBpG
         OWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+CCGksXD0vuDKfmVp0tkHiA2uWnVRsyUsg9W47Em0w=;
        b=VMTPrzhXCFLodq2l39uYrzn4O4s/XxQdKO3C19dGh5nWlgscajgnAL53/IBFxzT6DM
         HBH0HaFQYmaA+YoRs9Fttz3V4mUxap+jpGWjypMrxintu1CNEP/ZDS6kxMalqoUK98tT
         3/5OmjhGuMNZxyVxKgugsG+3sYLwzOMg5Q8Xy2ntbPBVkOl6eOiqpldKY2FCld2T9el4
         TrEO/6Ch0R7WR/IKoxAN4hYZKSsPaPMlPvTag+TJXZyVSva/SRjZ9rHPM/m+wSqSdZ6Z
         h4SkIlHi2Sy5EhWF4zITDsr6IvBDCHrS27ENuMHZaruFx1QTHVel6f9Q1W5rfVzwTfIF
         QIXA==
X-Gm-Message-State: APjAAAXUnzxpcov2mySVqWZkHRnPhwlWneXsm+pfq8qM20+9UaIv/aFr
        rUi6fuLiKUz4MN+Nb17PJAs1FA==
X-Google-Smtp-Source: APXvYqwXxvLIXwbnaU0pbtUaahmQsTY4WJgvs7cvIfEp9WJEolUF/3Lr4p9rKDGIxgul5lRhDBUKSg==
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr2275683qkk.0.1576673578884;
        Wed, 18 Dec 2019 04:52:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l49sm709602qtk.7.2019.12.18.04.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 04:52:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ihYoz-0006wl-U1; Wed, 18 Dec 2019 08:52:57 -0400
Date:   Wed, 18 Dec 2019 08:52:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Hirsch <max.hirsch@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
Message-ID: <20191218125257.GD17227@ziepe.ca>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
 <20191211162654.GD6622@ziepe.ca>
 <CADgTo880aSn++fcf_rt0+8DCE4Y=xgXtZxFx9B0nzM_M1HdWPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgTo880aSn++fcf_rt0+8DCE4Y=xgXtZxFx9B0nzM_M1HdWPw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:33:10PM -0500, Max Hirsch wrote:
> Thanks for the quick response. This is my first patch, so I want to
> follow the correct protocol. I reran checkpatch after making the
> changes and there were no errors or warnings in the region I changed.

You are supposed to run the patch itself through checkpatch:

$ git format-patch HEAD^!
0001-RDMA-cma-Fix-checkpatch-error.patch
$ scripts/checkpatch.pl 0001-RDMA-cma-Fix-checkpatch-error.patch
WARNING: A patch subject line should describe the change not the tool that found it
#4: 
Subject: [PATCH] RDMA/cma: Fix checkpatch error

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
This patch moves the assignment of ret to the previous line. The if statement then checks the value of ret assigned on the previous line. The assigned value of ret is not changed. Testing involved recompiling and loading the kernel. After the changes checkpatch does not report this the error in cma.c.

total: 0 errors, 2 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-RDMA-cma-Fix-checkpatch-error.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Jason
