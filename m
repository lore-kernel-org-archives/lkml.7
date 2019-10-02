Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B984C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312621D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="f5Z+M3Tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfJBOBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:01:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41505 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:01:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so15057917qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhowmgkseytW1pHuL0lgJJtUtqRUC7YPO7Hg/w47jj4=;
        b=f5Z+M3TlEajM14Is5sfbCMdOd2HhlK8i0KmSIAeMyb4aLvRrtXXEXq5FqOgrAJSK2T
         yAbPBmBn+avTkNPz3tQSGYBZSqdBA1rFyoQ2/yLZbskpWBhmDEbQwkiAYWal6vzP86Ow
         2iQ2vPs3n+zVFM/UxyNyxEtgUlpfRJ7DyDfkMi/dr9kSNey+knDX9zA6Mv2iZk0rgo4Y
         pQ6401zA76ug5k1YbtCGXoJJ1TZoHrgVVJlq0A0Fj41rpfwWmnAIkIE7Zidhs10WADig
         X1IIzF5d3wzTBNiyEt/bYkQ0vvZdRmh7iTmvfq9ctSo73YK1oxqsWkibC0TyZxrx03hb
         HsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhowmgkseytW1pHuL0lgJJtUtqRUC7YPO7Hg/w47jj4=;
        b=i1EdWJJnavM/mIn5CpaMdKxf0KRUMbiGwxMNDFdwybr2FwcfNo3wefF2Ro9OTLlLR+
         7c+TeWcYYuO2BG2EXiJ/Yy+3w2dwnghexs/fgumS+egiV/mSXVd0AdQup7lJZgwFbWRT
         olpjfVDo9muC7xdlvy1HopL8XJI9PLhCV320Pvobfj/wvxWmfN+A5lSYupxTL0/yNijw
         8xbh8EjjgZkTPcJzBtFsaDIhUg70qOS8sFaVuOJy8pY9hbgigCJObg1fR+UVlR9pD7ML
         vDgKZoVNlaurc02/q6QQpcLPXxrJbDCM1SRWqPvHZIiDSWSHK/+yCEwS33bUWPM4jdPG
         4Yog==
X-Gm-Message-State: APjAAAV7KfGrPimSiyZf4Y6a2WVKhOWw1SUEYtwKdreqhj24aI2Z5GPD
        SrcwG9JQekr04in5+9GORJf58A==
X-Google-Smtp-Source: APXvYqyySH0r+WBQZU52aaYxkrLDrFDZU5I5GNsKBRtrlsSyyLyl/sV/Sqxs9OBHY8uGqLsEPmYAlw==
X-Received: by 2002:a37:6713:: with SMTP id b19mr3658748qkc.301.1570024901663;
        Wed, 02 Oct 2019 07:01:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p77sm10127501qke.6.2019.10.02.07.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 07:01:40 -0700 (PDT)
Date:   Wed, 2 Oct 2019 10:01:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Btrfs: add a extent ref verify tool (static analysis bug report)
Message-ID: <20191002140138.eug7xvwhlsn5qnby@MacBook-Pro-91.local>
References: <3d1bcdce-16ae-d490-0a68-19d9d9d41d92@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1bcdce-16ae-d490-0a68-19d9d9d41d92@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 02:50:51PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis on linux-next with Coverity has picked up a potential
> issue in file fs/btrfs/ref-verify.c, function process_leaf() in the
> following commit:
> 
> commit fd708b81d972a0714b02a60eb4792fdbf15868c4
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Fri Sep 29 15:43:50 2017 -0400
> 
>     Btrfs: add a extent ref verify tool
> 
> The potential issue is when on the unlikely event when all the items
> contain unknown key.types and so ret is not assigned a value. Since ret
> is not initialized then a garbage value is returned by this function in
> this unlikely scenario.
> 
> In the previous function process_extent_item any unknown key types are
> flagged up as an error and -EINVAL is returned.  I'm unsure if this kind
> of error handling should also be applied to function process_leaf with
> invalid key types too.
> 

Thanks I'll fix this up.  You can run into block group item key types and we
don't care about those, so we just need ret = 0;  Thanks,

Josef
