Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9E721721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575037276;
	bh=33j3Z20z5OQVtX3tNOLKexXbvv+YriEvd/5cBPgPYHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKr32H4zMl9NdtdSq/8vQhHwzl+KxQagRFLmqTKYJWjVYwVu6K4Yt0tKgC/CacQX/
	 x2Dzkwur6WzYF0u456/K75gjqWsZdb3w/vZqBsY7V2RsHELgDc9hjhj+/4P0othSCF
	 vOik5/YQvStim/WS18ZR6Caet3sLkjCrCuM8dUm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfK2OVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfK2OVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:21:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3AA2215A5;
        Fri, 29 Nov 2019 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575037273;
        bh=33j3Z20z5OQVtX3tNOLKexXbvv+YriEvd/5cBPgPYHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0zuCmOeYqc+44mSujRYOrkLJQWVAKpJi93TWAy0zK04wF9HLW6ShevcbLQNVP+rXn
         8X2yClvykNlAGdGXVgmh8RkoimAmoeAUvDMtQbjMNaFClp6sMndNfoP0lEPyTBDIZa
         Yxpkz23z/IRIAwP7xGkOnyLniAJefq5dz1SHamTA=
Date:   Fri, 29 Nov 2019 15:21:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 0/3] debugfs: introduce
 debugfs_create_single/seq[,_data]
Message-ID: <20191129142110.GA3708031@kroah.com>
References: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 05:27:49PM +0800, Kefeng Wang wrote:
> Like proc_create_single/seq[,_data] in procfs, we could provide similar debugfs
> helper to reduce losts of boilerplate code.
> 
> debugfs_create_single[,_data]
>   creates a file in debugfs with the extra data and a seq_file show callback.
> debugfs_create_seq[,_data]
>   creates a file in debugfs with the extra data and a seq_operations.
> 
> There is a object dynamically allocated in the helper, which is used to store
> extra data, we need free it when remove the debugfs file.
> 
> If the change is acceptable, we could change the caller one by one.

I would like to see a user of this and how you would convert it, in
order to see if this is worth it or not.

When you redo this series, can you add that to the end of it?

thanks,

greg k-h
