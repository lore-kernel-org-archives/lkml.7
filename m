Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F59C3A59D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1996122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfHUBsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:48:53 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25756 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfHUBsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:48:53 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 21:48:52 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1566351194; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=qXDiO8FzgxJCCamp5ZOnxH8GADPlPSHLur4pqj/1XkFusSgR4zxgAAPbvwa5TWc65Y9yvJph6Cc4mwYnqJdsIGA0e+fTcvvitOwy7Vi1yXXxLpKAClkJylh8RabS1eXPowpAZtsGI70zuyphL1jJ31T2xP/2N2rgV+IotA6IXwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1566351194; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=DcF5su0fLTO1Pln6URG5KEfqkJ7no+cr1/Tz3A0/29c=; 
        b=WTGfIeb93/NnQATYhsuXKzuOj0HAYuNGPHQivWs4851ioPX+zB0McGmqi7I7/RmWu8koplnSLV3b+oi3M2Khs6vzZ9y4zmY12xj5MQK98GJVqzz2RejmsyDvsjVK2pp9TRizYFc49W4NjZysM6wiVlhrBylsaGwxUNqgGGYYnuo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1566351192884306.16074813454156; Wed, 21 Aug 2019 09:33:12 +0800 (CST)
Message-ID: <9afcec4d3987296ed4823d024c5a6fc54f741364.camel@zoho.com.cn>
Subject: Re: [PATCH] 9p: avoid attaching writeback_fid on mmap with type
 PRIVATE
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date:   Wed, 21 Aug 2019 09:33:09 +0800
In-Reply-To: <20190820114927.GA12715@nautica>
References: <20190820100325.10313-1-cgxu519@zoho.com.cn>
         <20190820114927.GA12715@nautica>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 13:49 +0200, Dominique Martinet wrote:
> Chengguang Xu wrote on Tue, Aug 20, 2019:
> > Currently on mmap cache policy, we always attach writeback_fid
> > whether mmap type is SHARED or PRIVATE. However, in the use case
> > of kata-container which combines 9p(Guest OS) with overlayfs(Host OS),
> > this behavior will trigger overlayfs' copy-up when excute command
> > inside container.
> 
> hmm, I guess this just works for non-ovl cases because sync_inode()
> realizes there is nothing to sync, but the fsync at the end still
> triggers the copy-up ?
> 
> Well, I guess there really is no need to flush for private mappings,
> so might as well go for this; sparing an extra useless clone walk cannot
> hurt.

Unfortunately, overlayfs does copy-up at open operation if the open flags
indicate data/meta modification, so as long as we attach writeback_fid with
O_RDWR on private mmap there are a lot of unnecessary copy-up of binary and
shared library files on backedn overlayfs when executing command inside kata
containers. After this patch we found there are no useless copy-up files anymore
and also private/shared mmap worked as expected.


Thanks,
Chengguang.

> 
> I'll queue this up after tests, no promise on delay sorry :/



