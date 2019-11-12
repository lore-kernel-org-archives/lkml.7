Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A421783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573551699;
	bh=LXxeytabQjsph84q3+95D2mwzsIe1w47bZe2Y4jsDXA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=gcmfxKXCOIKXcF9ooxG2sGgyc216b2Qj2ibBeYdx/qDk684zqZl40sU/Pr4YnlZ9I
	 XECQEwqxCB+DgChVzn2wnt2velQ/+ZRHIrHmhYYKh2VlEGG68Ir8PkDsKEn4aLsOxz
	 zKd7Lqgi8SgqGnvTc1s20z0NwgNEwJHKcicR00+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKLJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbfKLJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:41:34 -0500
Received: from [192.168.1.9] (unknown [59.97.49.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080F320650;
        Tue, 12 Nov 2019 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573551693;
        bh=LXxeytabQjsph84q3+95D2mwzsIe1w47bZe2Y4jsDXA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BkEifLj71wCGeAGa+cBfeJVnzullgFBNby/EuLvSp5GBhv2h8Mo3cyw1gvBkXcWT0
         A6biDw0Qo8IWVv2w1OzqF7s15n1Rv8+Pciaze9ZSjDrtTxSN5YujjZ2rcJ7jDIwTjo
         zg2oipa6wt+MWMkqYWh3L9iXdYJ6SF0KzspoGJdc=
Subject: Re: [PATCH] usbip: Fix uninitialized symbol 'nents' in
 stub_recv_cmd_submit()
To:     Suwan Kim <suwan.kim027@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dan.carpenter@oracle.com, valentina.manea.m@gmail.com,
        kbuild test robot <lkp@intel.com>, shuah <shuah@kernel.org>
References: <20191111141035.27788-1-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <270931e3-c859-a0fd-67f5-35d83ef6e5e9@kernel.org>
Date:   Tue, 12 Nov 2019 02:41:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111141035.27788-1-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 7:10 AM, Suwan Kim wrote:
> Smatch reported that nents is not initialized and used in
> stub_recv_cmd_submit(). nents is currently initialized by sgl_alloc()
> and used to allocate multiple URBs when host controller doesn't
> support scatter-gather DMA. The use of uninitialized nents means that
> buf_len is zero and use_sg is true. But buffer length should not be
> zero when an URB uses scatter-gather DMA.
> 
> To prevent this situation, add the conditional that checks buf_len
> and use_sg. And move the use of nents right after the sgl_alloc() to
> avoid the use of uninitialized nents.
> 
> If the error occurs, it adds SDEV_EVENT_ERROR_MALLOC and stub_priv
> will be released by stub event handler and connection will be shut
> down.
> 
> Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---

Looks good.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

