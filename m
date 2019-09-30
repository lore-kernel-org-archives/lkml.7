Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E0C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCBF207FA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="DMUnUehI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbfI3XqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:46:20 -0400
Received: from onstation.org ([52.200.56.107]:35074 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfI3XqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:46:19 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 0E94C3E89E;
        Mon, 30 Sep 2019 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1569887179;
        bh=mj9vwBsd085w9kLP7AB0YCRyeS221e0uvMfVjjjbr2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMUnUehI+MQ+ByR2KVdAgWIOqvtfmWRWp1sfDv7KVs6v6SCj3f3HwBbiR1TdDE0lr
         8MmdQNDuLIn/GZ2Al+ugjI1Aol49GcxhFN5/zqAMSoKNpRROG8YbzUFva44ak0dyws
         iaX0qP7L44brX2qR5myEKWNsRd54ZhGrkcl0p5qM=
Date:   Mon, 30 Sep 2019 19:46:18 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     "David F." <df7729@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What populates /proc/partitions ?
Message-ID: <20190930234618.GA5536@onstation.org>
References: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 03:47:21PM -0700, David F. wrote:
> Hi,
> 
> I want to find out why fd0 is being added to /proc/partitions and stop
> that for my build.  I've searched "/proc/partitions" and "partitions",
> not finding anything that matters.

It looks like it is done in block/genhd.c with this function:

static int __init proc_genhd_init(void)
{
        proc_create_seq("diskstats", 0, NULL, &diskstats_op);
        proc_create_seq("partitions", 0, NULL, &partitions_op);
        return 0;
}
module_init(proc_genhd_init);

Brian


> 
> If udev is doing it, what function is it call so I can search on that?
> 
> TIA!!
