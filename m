Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DBB23402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bobcopeland-com.20150623.gappssmtp.com header.i=@bobcopeland-com.20150623.gappssmtp.com header.b="unrFFDPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfICNZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:25:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33616 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfICNZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:25:34 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so3852340ioo.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Omkb6Y1k6iVX6Bk6vIsRTuajaqaftVLtp6emv+Kx7bY=;
        b=unrFFDPk1S+m9ImXNYeQsruY/eqadqHA4WAA99F8iF5AcxUdQ7dZQgKi2LhIa44CiM
         YbaGNdskCps6N8fPIhnm1tcLVsFKv1+D3w1n/ICnGLXM3xM28qS+Ydl+idyfQUFqW3vt
         Rhec1x/89RK8Bf+NR6vx4o/+2cP6+lAKW9WzaqtpdpGZwtNWqsRoCekGEJp3vXClCgNd
         7q+DPnwSniuKPy8x/OoWFvw0JUovMtYKbb6jMT0RKwd2mvT5mPLIarb5E7k+XPFG3+Kw
         Ow+APsl5c4YSZBczYm9vHd5u6gOpZm66HV0TaSYT+qbydbQGvo52pceMMhfFklI52vkf
         1olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Omkb6Y1k6iVX6Bk6vIsRTuajaqaftVLtp6emv+Kx7bY=;
        b=Jg2W9Lb/OZkYKbdsk9uF20LNZ81iLFQvq29lDSexwFqMyATjGoJ7m6zARjwQZ4BQKD
         qqEz+E+qdsRFUikWJRb0NVBIeWv1uwbyQMxcizh/snLsDnRU8RudtJwh47mht+OIkHi3
         NeL1+pot+llWPE2OfFWkeFivGot81Ppi0SK9ZIROVVL8QAncFEQ/coYJYA+R05JJPqAF
         cLlcdkJLf5boIfPmr2/yX0mpgl/xVo2U84ewADtHIlvclqXEvbSXfPrZ8d0lLbM8PAN0
         mEyliKjR+stC7R3R/ZUqGSDK6MCfch9d0SUtzPw0XtD7ZJHv12O4Ku+3UGhGM9oXHbER
         Jrvg==
X-Gm-Message-State: APjAAAUIxLv6BX6Z0ktQ68sD5cAjlvrKsMw9lPN29mFpuatg8c04R4ZP
        j1lO58F1FuTGw52pgAK0o/yM7w==
X-Google-Smtp-Source: APXvYqwnaujr93c8PMgu8zRP1g4si48eJ6dESBSUcPkTqi5VF2i9t2yA5yYAau+yDmACnVlG3wAseg==
X-Received: by 2002:a05:6602:cf:: with SMTP id z15mr24462832ioe.67.1567517133970;
        Tue, 03 Sep 2019 06:25:33 -0700 (PDT)
Received: from hash ([2607:fea8:5ac0:1dd8:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id c11sm15089761ioq.63.2019.09.03.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:25:33 -0700 (PDT)
Received: from bob by hash with local (Exim 4.92)
        (envelope-from <me@bobcopeland.com>)
        id 1i58oO-0000GI-Kb; Tue, 03 Sep 2019 09:25:32 -0400
Date:   Tue, 3 Sep 2019 09:25:32 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH] fs: omfs: Use kmemdup rather than duplicating its
 implementation in omfs_get_imap
Message-ID: <20190903132532.GB5280@localhost>
References: <1567492784-19304-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567492784-19304-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:39:44PM +0800, zhong jiang wrote:
> kmemdup contains the kmalloc + memcpy. hence it is better to use kmemdup
> directly. Just replace it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

This same patch was already sent to me by someone else and I acked it:

https://lore.kernel.org/lkml/20190703163158.937-1-huangfq.daxian@gmail.com/

-- 
Bob Copeland %% https://bobcopeland.com/
