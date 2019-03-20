Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80819C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D76120850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCTRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:15:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfCTRPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:15:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99C3F300521D;
        Wed, 20 Mar 2019 17:15:48 +0000 (UTC)
Received: from [10.10.122.62] (ovpn-122-62.rdu2.redhat.com [10.10.122.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3ED960BE2;
        Wed, 20 Mar 2019 17:15:47 +0000 (UTC)
Subject: Re: [PATCH][next] scsi: target: fix unsigned comparision with less
 than zero
To:     Colin King <colin.king@canonical.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20190320163709.28767-1-colin.king@canonical.com>
 <5C9274D9.30706@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5C927543.2020907@redhat.com>
Date:   Wed, 20 Mar 2019 12:15:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5C9274D9.30706@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 20 Mar 2019 17:15:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2019 12:14 PM, Mike Christie wrote:
> On 03/20/2019 11:37 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently an error return is being assigned to an unsigned
>> size_t varianle and then checked if the result is less than
>> zero which will always be false.  Fix this by making ret
> 
> What kernel version was this made against?
> 
> For Martin's 5.2 queue branch, with these scsi changes it looks like
> strlcpy returns a size_t. And then below it looks like we compare the
> return value from that function to the buffer size and the max len of
> the string we support. We do not seem to check for less than zero.
> 
> 

My mistake. I was looking at len and not ret.

Patch looks ok to me.

Reviewed-by: Mike Christie <mchristi@redhat.com>

