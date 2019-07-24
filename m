Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB1FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A22189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfGXJFB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:05:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfGXJFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:05:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9442830C75C0;
        Wed, 24 Jul 2019 09:05:00 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F4D1001B28;
        Wed, 24 Jul 2019 09:04:56 +0000 (UTC)
Subject: Re: [Cluster-devel] [BUG] fs: gfs2: possible null-pointer
 dereferences in gfs2_rgrp_bh_get()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, rpeterso@redhat.com,
        agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
References: <8d270882-54da-365e-1be7-a291a5178b1e@gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <cd7c0bb4-53d2-8a67-0719-c26d043a31fc@redhat.com>
Date:   Wed, 24 Jul 2019 10:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8d270882-54da-365e-1be7-a291a5178b1e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 24 Jul 2019 09:05:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/07/2019 09:50, Jia-Ju Bai wrote:
> In gfs2_rgrp_bh_get, there is an if statement on line 1191 to check 
> whether "rgd->rd_bits[0].bi_bh" is NULL.

That is how we detect whether the rgrp has already been read in, so the 
function is skipped in the case that we've already read in the rgrp.


> When "rgd->rd_bits[0].bi_bh" is NULL, it is used on line 1216:
>     gfs2_rgrp_in(rgd, (rgd->rd_bits[0].bi_bh)->b_data);

No it isn't. See line 1196 where bi_bh is set, and where we also bail 
out (line 1198) in case it has not been set.


> and on line 1225:
>     gfs2_rgrp_ondisk2lvb(..., rgd->rd_bits[0].bi_bh->b_data);
> and on line 1228:
>     if (!gfs2_rgrp_lvb_valid(rgd))
>
> Note that in gfs2_rgrp_lvb_valid(rgd), there is a statement on line 1114:
>     struct gfs2_rgrp *str = (struct gfs2_rgrp 
> *)rgd->rd_bits[0].bi_bh->b_data;
>
> Thus, possible null-pointer dereferences may occur.
>
> These bugs are found by a static analysis tool STCheck written by us.
> I do not know how to correctly fix these bugs, so I only report bugs.
>
>
> Best wishes,
> Jia-Ju Bai
>
So I'm not seeing how there can be a NULL deref in those later lines. I 
think this is another false positive,

Steve.



