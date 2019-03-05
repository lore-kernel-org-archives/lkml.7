Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104AB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXDwgpRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfCEE0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:26:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfCEE0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JwwcttM2cWT4KB8XyzeEqi7PlaKzpJpbAYIc//MbWhM=; b=XXDwgpRQQ2gcdgdzAsUszn0GB
        +F8s10psmzKqTr1ZWB59rBYnUQkANcv6WiNEM5n6F+kYoUrK2XSbKFLU/gwP6/psFBVD4odJGgeGt
        Qg1wOxnIaZOR7dmewYd6g/+0XFpNswRdYmX0G2KuXgZc0vNvOV65CEwewPxr6tqR0hpENVNMX9AE5
        k1bzuUkElKrqOl9ZVggvcsr1/oQL48x+WRQGU0+BEezMFPHLOEGBH6TlVE9/8w/O4/AMWWAh7rp/n
        wf2LeDqMf5QN+BQULMoySGdpMkTL+VfhNnD1W7IQYfbGOTCzMD2ZzvgTrajofP72b2mHtPZT3V9Ov
        qJQ15CRPQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h11er-0002Qv-FN; Tue, 05 Mar 2019 04:26:25 +0000
Date:   Mon, 4 Mar 2019 20:26:25 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] fs: Avoid signed overflow UBSAN warning
Message-ID: <20190305042625.GC13380@bombadil.infradead.org>
References: <20190223090210.116847-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223090210.116847-1-yaohongbo@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 05:02:10PM +0800, Hongbo Yao wrote:
> I ran into this:
> 	UBSAN: Undefined behaviour in fs/read_write.c:251:11
> 	signed integer overflow:
> 	9223372036854775805 + 9223372036854775805 cannot be represented in
> 	type 'long long int'
> 
> Use unsigned types to do math, it doesn't throw a UBSAN warning
> when it does overflow.This patch doesn't change generated code.

You don't need to be this verbose to fix it.

> -			offset += file->f_pos;
> +			offset = (u64)file->f_pos + (u64)offset;

			offset += (u64)file->f_pos;

