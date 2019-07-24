Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3963921951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7bJdNy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfGXJIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:08:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42112 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfGXJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:08:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so20609288pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=09CsS3ko6lzH/0V10YXQF8pRitb7C2CLQvJO5AREnSE=;
        b=V7bJdNy/iE/nCZXfk/Q/TCnAA34debDwTZZ1M4YDyiNLF6A5FE9wxdfYAvxN6rgiVO
         IUBynba+yRV/n7ePvcmhmYOj/PbxbakbGXO0zye+0AMCIuUhyR3U45Mb2hl9bZoZclvz
         MTWSfkANhFigy7uwXG6B7jzYuOOGYJY2zJjoXWokPFeZx9kcHyyfvXcNWCGk3T8iyNja
         Q/qoqYD1WhvhAe5ZM56ROmssx+3m3ifSr+VMYzqR6VNHVAIwh6wd6ZTdLv82y3Fgzwjb
         so/cAlhL1qfgy6MUqcEilF2uRZmFj1ybyonnqxcIdSizWUx7/szxnh71u9Y6m9MF/cjd
         INTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=09CsS3ko6lzH/0V10YXQF8pRitb7C2CLQvJO5AREnSE=;
        b=FoYJwHZhHljkifcyeCb2e3UMVyPByPxJ3b4pOjBHvCCzJ4pLRJAMRXCG6sJWy7WEbo
         Cq0/nXEg7mTCS0M5s5pZV/n6EEsnL9iSx8nseIcNnP6fP/o70zB2cQcV96HXx6X07+g4
         qdjWw9GEM0+Gmk+LF7EA94kAn6+jvd5an21gD2UDqobWMawJjREm2fnrJkUevZx8f5PC
         eHJvjGLSjaRdfcEeQYEPW793zx0Koib4c7hZmPVycN6GW3zGhR2Q++58L1wdnIDjJTaA
         a7f09HDjZgUkulkoqE9KTj227fYja+LELyKb2QmwjN7hSDUrVSDklfiQcB/yPcWy/7k1
         M0ug==
X-Gm-Message-State: APjAAAXfqyJkaSgbui3nsS2O0JglnQ7GPPM+lq2gkJKx/L6ZQB1qJzLS
        18j7ps8pbxycTrDiDpuridkeMQaCsd8=
X-Google-Smtp-Source: APXvYqxa+oNYmupFnZcbNaTroSq3yDCbTnIojD2SeB7FIypF8xyOhbA+keos0ryT6Z1Fyf/gaoZljQ==
X-Received: by 2002:a62:79c2:: with SMTP id u185mr10440507pfc.237.1563959325044;
        Wed, 24 Jul 2019 02:08:45 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id o14sm93701300pfh.153.2019.07.24.02.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 02:08:44 -0700 (PDT)
Subject: Re: [Cluster-devel] [BUG] fs: gfs2: possible null-pointer
 dereferences in gfs2_rgrp_bh_get()
To:     Steven Whitehouse <swhiteho@redhat.com>, rpeterso@redhat.com,
        agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
References: <8d270882-54da-365e-1be7-a291a5178b1e@gmail.com>
 <cd7c0bb4-53d2-8a67-0719-c26d043a31fc@redhat.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <48547b12-ee4c-4f8c-d004-925d65f672d8@gmail.com>
Date:   Wed, 24 Jul 2019 17:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cd7c0bb4-53d2-8a67-0719-c26d043a31fc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)

On 2019/7/24 17:04, Steven Whitehouse wrote:
> Hi,
>
> On 24/07/2019 09:50, Jia-Ju Bai wrote:
>> In gfs2_rgrp_bh_get, there is an if statement on line 1191 to check 
>> whether "rgd->rd_bits[0].bi_bh" is NULL.
>
> That is how we detect whether the rgrp has already been read in, so 
> the function is skipped in the case that we've already read in the rgrp.
>
>
>> When "rgd->rd_bits[0].bi_bh" is NULL, it is used on line 1216:
>>     gfs2_rgrp_in(rgd, (rgd->rd_bits[0].bi_bh)->b_data);
>
> No it isn't. See line 1196 where bi_bh is set, and where we also bail 
> out (line 1198) in case it has not been set.
>

I overlooked the operation on line 1196...
Thanks for the pointer, I am sorry for the false report...


Best wishes,
Jia-Ju Bai
