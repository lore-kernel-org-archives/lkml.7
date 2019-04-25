Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22748C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B1220685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l56nmXBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfDYSLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:11:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41454 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfDYSLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:11:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so298327pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5lGPiotqFsXnHCFPcp4p25LBjmPjAhvbjVU4U9JLqy8=;
        b=l56nmXBzEGn1m1ng/I+i9/CB4YNSitXs36Enhz6nr5OVnUymBa/d9hvhoTQPzHSA9l
         XehOK/PtPQ8Gwkasm5ySnOXMQmSPT0aIQahOAEtx8KBCE46M42Uvkmfc5Nsa9pQ8MkiL
         y2Dq+rPIxm4BkyUQA+P8IC2zp+SGpEaZwK6JMdk81I55bBOnHfjVpT3beLY6LHUJgpc2
         6elPBLWDBUvrUt7edFugW1bQbgXRfzowRCpvyuRPSrwn2qWo92eJU8UUJTKkjGgYOGKV
         /JTvobI/pZ8VbnUcPYQHt4jVbCV0w57KEHfuVgXhG3jB8yS5ys1GH7VSOskJ3bblJ6i8
         Strw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5lGPiotqFsXnHCFPcp4p25LBjmPjAhvbjVU4U9JLqy8=;
        b=tp4ZKNyDNx8tADz7+YVtVhgXDvVtzPxlxyhouEwbG6i4M/jxhR/gSm4I09T6W+6Evf
         OxxOYPHAeLYyg24jNcQZsl1mHoIsW2z6BkvcXcMZ1oOWXbJp+b4ASr+mKXV54RTHiXUy
         dUVHwgRpiXAyNyyOIyViRUo7xZM2YzWZM0tZrKeSfyRjzp1HfTklXgI58qD+0XEjN8Hs
         xFodzRgyih07pl/7MbqYcH139wLxmRVSglheuKICM5CM4SexetxmcQWiFipYks0gSC29
         +uVG/pPpNXwM5FoGI6nWFztiC1GZWMzwD9zmpprySaf9mXlOWup7IoDahuuBldnhgRoC
         5I2g==
X-Gm-Message-State: APjAAAUgAvSN2YPhDHt7RQXuMvkkIFRLXqWTn4cjRDcWd3BhVYNWDbaU
        Z7yjdEqDeIb191YrZwKXHD4Gfw==
X-Google-Smtp-Source: APXvYqyfOTs6fTSBCpgWsKOSSyK/s8tWQGXiH4g6Y4lSbp0B7Dqo90yoBnMyARIpT+YLy9Mou3ZpaA==
X-Received: by 2002:a62:fb16:: with SMTP id x22mr2818961pfm.140.1556215880706;
        Thu, 25 Apr 2019 11:11:20 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id e4sm8629592pfn.185.2019.04.25.11.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 11:11:19 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:11:19 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 11:11:15 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv/signal: Fixup additional syscall restarting
In-Reply-To: <20190410065304.GA2942@infradead.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ren_guo@c-sky.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-e56eb5bc-3336-4e0e-897f-be508b1c5f4a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Apr 2019 23:53:04 PDT (-0700), Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!  I've pulled just this patch into my for-next, as I'm assuming the
c-sky patches will go in seperately.  Given that it's been on the list for a
while I think it's a good candidate for rc7, so unless anyone says something or
testing causes a problem I'll send it up tomorrow.
