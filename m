Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98B0C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77490208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UykzDSAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAFSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:44:15 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37292 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:44:14 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so19456454qvi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TvsBEWaiYBZ2H17klDWmqKbuYTFZJoljwApjESxGTXI=;
        b=UykzDSAPX/ekra+WJHO0rI9DOpxf3LrEfin4zpblHFwND1Tan9sDYreT28HalQHYmF
         Rzi0Wr4mrid/WIi+nBPUd0JRVghQ/nmq7trM7ewFIBAGMyHDnMfVWuBcbEutPASnUIF1
         63FmsTKbfEG/a1APanPUofQJvKdvUJi/gzTdHy22Buld3m+bnjQa1P+KLfL//+igY8zU
         Gt1Pf+IjqkhgRYua631idbwBKGp4mj5r5R6oI5bejahzguGV+Xv2YHbRfU7q4GxxQxTe
         yxVgT8RF7It+WvZvCrbNNEgk8fAiBhKITv6bQRqsK9sKSjTgZBY7EdrhOcANVJA2GeKH
         ceeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TvsBEWaiYBZ2H17klDWmqKbuYTFZJoljwApjESxGTXI=;
        b=Wraa7dvouXfckHNidCC33U9xobID/pOrXBFY+Jh1XI6eyu/ZG09inbwUg6y3z2AOIW
         MR5vkAhPHtdx1hPh2Dv/TZURMb7C0VfxkefzBFUcorpIrfydQEwwHJClaF11OgIzwQee
         ie+7EavN7l1UeW22bvwue5WtwNaSviRkwc4sfdnG3uhSdGEnNUeeSaMOybQQFj7Pnm0W
         2JKJeI7tvqSrNbtJmW3gg26QTKmR1YnGPi4g+G2RxiM8aWgwPmbtvZfiiUMnMQV/3Xad
         MnmDLSuwzzxddga3u0hSzzHmMKk5IvGxSZ8jHkrZFEZCzLqlpkpbeQ5ueq7dhy4X3dhg
         ibFg==
X-Gm-Message-State: APjAAAUjqB4Vx1cugDHYt+OIW9INpbaOdIBk/7MH7Hnv9UbbOxw82tVv
        2J0RknuTd/DJjNPEYWhuFA+8rA==
X-Google-Smtp-Source: APXvYqybBDuHQSIN7YupUN/tu5gSnhXgnkVgnI6aC6tQvSyOeKrs63bRLYiD6KDtD8pNqV2zqWuL4g==
X-Received: by 2002:a05:6214:1348:: with SMTP id b8mr80545269qvw.137.1578336253923;
        Mon, 06 Jan 2020 10:44:13 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e21sm21131559qkm.55.2020.01.06.10.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 10:44:13 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iommu/dma: fix variable 'cookie' set but not used
Date:   Mon, 6 Jan 2020 13:44:11 -0500
Message-Id: <1A4C3B76-FCC0-4C4F-85A3-4172BD42429D@lca.pw>
References: <418dcce0-f048-a4cc-3360-d4b9c7926a6d@arm.com>
Cc:     jroedel@suse.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <418dcce0-f048-a4cc-3360-d4b9c7926a6d@arm.com>
To:     Robin Murphy <Robin.Murphy@arm.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 6, 2020, at 1:19 PM, Robin Murphy <Robin.Murphy@arm.com> wrote:
> 
> Fair enough... I guess this is a W=1 thing?

Yes.
