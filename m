Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10B5C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B95120825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jp9Og7Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfDOOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:15:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37888 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:15:58 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so26862248ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//ZWKO3J3IGW9KsVK1oAtDSzP/HI71VH1noKGb0jD9I=;
        b=Jp9Og7EyE9rkkNx/caE/0s3PtZ2N3gJiHD7H9fc2qqA3AgH9h46NAKt60CI0m2oFCN
         IPyXuEC1ZTvDrqBg2i39oPrHC+7gc2CytzwQQtgeOP6Eqg5MBPRp7A6QkDu2vRvmjIpL
         SUFOjkcG9fKBEAJA+bZsxHBUrh/heUsPrQBEUeSytH7urSXrCVyJLiBQfagVegi6zNI/
         jLWSoVHjDFAiLYbvO5uMUjgwY2kHiF0qRn5ZpUGhnSFc+vbFyk6zQrM0tquQekR1Yr4O
         NFzfK6tKHRT8ymXmszScWW36RPrYMJmblm3Z23GuVF3FDOgmCnFuVwPeBQ4QKd+rO4Ss
         s1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//ZWKO3J3IGW9KsVK1oAtDSzP/HI71VH1noKGb0jD9I=;
        b=n+f4fJw2UQE3GHnuiM9qkQFWYG+SWJ2Mx4cH9dkejYm6kzsN3oVPf5Gp7E6uKXsQhA
         0YMzQOMREzR8pLCZVV9tODvshVb9YiV3xUzQ7IxGHdofcnBeYQ4uulaMAaecU7dok4GB
         W0yoSerCXiwIjV1qY9dMJ6EhNCgWi6Drrs0H1KjkirPbtbELIzrAudD3uegKemXqe5EV
         7CueEqyILbcJSggzAVHlebjXq451LWv6UG88JR1bZWDIosnkSm5KW1qm3kp5qrbZ+HNI
         TLzHmIYXprStd+pWYbHYrPFxrTbu+gJdfyTtW/226BMRtHTqXRaiZZDIzKjf1gbfmtsQ
         bdtA==
X-Gm-Message-State: APjAAAWYeXiGCr6eD5I6iJbPQ4e6GF09LoGGJLOD5XYQl3GO1vmfrOf3
        6SGjXrjYPzsBoANNAPXlVX1aCToZLnXnjw==
X-Google-Smtp-Source: APXvYqzL7beUUpmB4VVvwheL+E+WusT8J+4qTf51GY0p1n3F8LPLSmtk3MeupVl2pxI6fVjRSrtMMA==
X-Received: by 2002:a24:de0a:: with SMTP id d10mr25924876itg.131.1555337757939;
        Mon, 15 Apr 2019 07:15:57 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q8sm17617581ioi.33.2019.04.15.07.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:15:56 -0700 (PDT)
Subject: Re: linux-next: manual merge of the block tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20190415130608.02fabb3e@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66a7abb7-7550-b2df-698b-b59932290f8a@kernel.dk>
Date:   Mon, 15 Apr 2019 08:15:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415130608.02fabb3e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/19 9:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   include/linux/bvec.h
> 
> between commit:
> 
>   1200e07f3ad4 ("block: don't use for-inside-for in bio_for_each_segment_all")
> 
> from Linus' tree and commit:
> 
>   52d52d1c98a9 ("block: only allow contiguous page structs in a bio_vec")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks fine Stephen - but due to this and the BFQ one, I've merged in
5.1-rc5 and resolved them as well. Tomorrow's branch should merge
cleanly for you.

-- 
Jens Axboe

