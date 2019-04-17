Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC8206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3aCrIZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfDQN7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:59:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46316 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDQN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:59:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so32051170wrw.13;
        Wed, 17 Apr 2019 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w6bSU+aoJzkpTqgevvPOdjffpkj+vw/h7/N6upl4I1E=;
        b=d3aCrIZfC1c8ZNp5KfpUfaTCTrPdWUzFNK5X/zD5gIjtyHC98BsuDA2yMulK00wt3k
         DQgv8vCihflozMNGhNhP2kjts5Fb6VCJc98bQHzAqUY+/1crXAy3kW4ZqmDuUksOmWdV
         1mZuh8Pg+6TnpOthNE/lMrhGo7Wj6Pt8DB7JdIhhTAc408V0fRbycArUbciJ62Ay5dB/
         jWuIFmXj8hWO1ZiM5N6BaqBps3zofU+q5QFHZ0alIrACpTwiEVtgZv312QcNUF5W1Fiu
         i2k/MoouE3CUIdnwr6gS3sFbA506h6j604EO8OFkRcwp+bw8QAMzQU9RMoO21UGoipX5
         7LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w6bSU+aoJzkpTqgevvPOdjffpkj+vw/h7/N6upl4I1E=;
        b=pnsI4GUuuE+7DOWwL7ym4f8JQPbA4a739W6sgJY2UgIIW5f5fi7YKI0k1RNtxr8sGU
         zrvpHBeyc5v9/D+jxeljmPgPUaZ2aTlSAZjPrS5drMta0OrOoQ/QyhEAOgg/Uorkf7v3
         pBGtUq6EXPcVccOGoEFBSBCSR74jCy34JrIol2Wo6qxfbisrLcf5m89Ze6qjyaMAd3Zy
         TiUpaHnNXj0VIzogLomP5QGlV8FRGCMgSln/cw0HakAdg9D50KrdNQ1QMp4n9tJwmcmj
         m9t1unV3jdbs1Ndk4iRjlzGucDr2ferkB8zjtg6AoD8lpr4Psn3a3MKsIgAu6KQwLid1
         R00w==
X-Gm-Message-State: APjAAAWnfg13DrvdcQtMa0j0A6CsG/qoI7tMnskx2DDMnwENrsZoWU1B
        dY4BTMfB1j7mAnI+Rkw0Vtp9TMJL
X-Google-Smtp-Source: APXvYqxlErQCHkXeMFNHjqw8q0+/CNg+qXFS1R46qIh3OUvsusNL0r4WGWDKqjtqh1Xw6lULjaPY8w==
X-Received: by 2002:adf:e790:: with SMTP id n16mr19803632wrm.292.1555509593857;
        Wed, 17 Apr 2019 06:59:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id z18sm84325274wrr.90.2019.04.17.06.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 06:59:53 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: dynamic DMA-buf sharing between devices
To:     Chunming Zhou <zhoucm1@amd.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <04558379-9788-bbcc-5c64-7fa9ad92f60d@gmail.com>
Date:   Wed, 17 Apr 2019 15:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of those I have 6 more patches in the pipeline to enable VRAM P2P 
with DMA-buf.

So that is not the end of the patch set :)

Christian.

Am 17.04.19 um 15:52 schrieb Chunming Zhou:
> Thanks Christian, great job. I will verify it this week when I finish my
> current work on hand.
>
> -David
>
> 在 2019/4/17 2:38, Christian König wrote:
>> Hi everybody,
>>
>> core idea in this patch set is that DMA-buf importers can now provide an optional invalidate callback. Using this callback and the reservation object exporters can now avoid pinning DMA-buf memory for a long time while sharing it between devices.
>>
>> I've already send out an older version roughly a year ago, but didn't had time to further look into cleaning this up.
>>
>> The last time a major problem was that we would had to fix up all drivers implementing DMA-buf at once.
>>
>> Now I avoid this by allowing mappings to be cached in the DMA-buf attachment and so driver can optionally move over to the new interface one by one.
>>
>> This is also a prerequisite to my patchset enabling sharing of device memory with DMA-buf.
>>
>> Please review and/or comment,
>> Christian.
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

