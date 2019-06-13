Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A11CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="U4iRJrkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfFMPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34592 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732446AbfFMOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:15:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so9143010qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbvrt5MZdKQZtIDBTdvl9Mov/hKhPttcrBddG8hlTHo=;
        b=U4iRJrkgboqXD/9ecVEMGKPpyhkTFeK6mRiuk3Hy6ZSjwXCUQjTvFcN1/3TbP0NwfD
         Cc0zRy15Gx4ZrC16COD805lwAeHf+qTzSuM79QtyZaBjBOLBNYC4OcekJA1r2UIVSfCF
         d7WXvg5HrlhBXYtFb5VvFctZCG/Ixpw8iY5IcU88+E9uOEfz1mmm4oqCAf/PiZySI+WX
         zEsdmJ64iKb2T8hzeutqLaiWHI3UhHek9Rp74I2YSN7P2KgZU/L9RdBvxkx4IV/qxmSt
         AGAkIzRqZ8bwB2xirmaAcULCaO3AAs2Bs0nonS+DUCjHnU1NBiJuLN34fx159zgfGaVJ
         GVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbvrt5MZdKQZtIDBTdvl9Mov/hKhPttcrBddG8hlTHo=;
        b=PmG+bjeIfdXbNYrLVHfJ7PyEWq1qG4aVvqxsbb1ISYTpEnhaVsPEBDC5XJ8PejyLsS
         vWJsVFLYgeEOJOQCKIOz8JG561eBzEXeNNqi9uZiQKUn1HzxCSFgUcey9aXKI135IPP+
         379m0fBNWV9e1KZAF2F08MzyYQSP91L+brZsdL2qsuInS4bQyU88csoAiv+icDQbXpMQ
         2igEd9LP3AEi9/KN4YIwY7oXY5qaZ47llm1ku18adPDJi+9F8T6szR1MWL8C7JvyBA6U
         NGHwiLAo+qbxFhtz4BWgOy7GbH6z3DHKJ+KvP3zScziPlL64Q8kCnb64TQdpa3/4sOdi
         eRtQ==
X-Gm-Message-State: APjAAAXUUPMB9TGxS8GQHl/zggavTBK46bi4/Xlnel+pIhz8rYGuEB1v
        7DzcIp9MHgmAQE82HEZjGM81cQ==
X-Google-Smtp-Source: APXvYqwg9ItFMlhHRYGvsdkND+NywXN/99yJ/OfGCgepby4UQnidXK6DCCbLqQXc5D4yRoAVhsjoyA==
X-Received: by 2002:a05:620a:16cc:: with SMTP id a12mr13267398qkn.256.1560435351183;
        Thu, 13 Jun 2019 07:15:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id t29sm2155361qtt.42.2019.06.13.07.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:15:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:15:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 12/19] btrfs: expire submit buffer on timeout
Message-ID: <20190613141548.vlczaxiqqzbxgtzk@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-13-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-13-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:18PM +0900, Naohiro Aota wrote:
> It is possible to have bios stalled in the submit buffer due to some bug or
> device problem. In such situation, btrfs stops working waiting for buffered
> bios completions. To avoid such hang, add a worker that will cancel the
> stalled bios after a timeout.
> 

The block layer does this with it's request timeouts right?  So it'll timeout
and we'll get an EIO?  If that's not working then we need to fix the block
layer.  Thanks,

Josef
