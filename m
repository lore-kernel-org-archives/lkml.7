Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DAAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B65E2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UsXVcz/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfHHNF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:05:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33612 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732836AbfHHNF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:05:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so87779089qtt.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9m6QChW1Hz/Ce2TOg5A9I+Mvna5Z6uz7U57CNrS3DMc=;
        b=UsXVcz/0fx+mbrQVrDfthdHqx/TQAG6mZCOjIrVyOeqqQ52UZpnPAoCRoyaHnv8XhS
         myAYX36Qc07br0W255vMKbULw2ztt1SK9LCxY6t+qNSGUH8lgf/3KrkhNmVLhnuXPk75
         8NKhNYfOP0paEoLotKXkfyPj6WC9fRZDjL/390dyyF/8bhzq6seIlrIR7AftrabVSUCt
         9CsyV03odYVVSHvklvyseXwr4U05s7IrXQRwta90NNKp3g9VPyivRSNNHC+ZMXAvgadj
         C7aT5FJ9sAlB+caYQhcUKnsovzehTBq/uSqC2bLHwecFVaJ/O/Uv9sooTvOk7mSYFNNc
         0qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9m6QChW1Hz/Ce2TOg5A9I+Mvna5Z6uz7U57CNrS3DMc=;
        b=QYh301N05mfg4DOtzWUqd3G20WY29eCVWWOpuw6Cdpu7u7vlwNPxP1UfAwBR8WExmN
         0vKiiollTaqhJ8FvYR1X0nrM6WoAL52+cBesR+er0Tnx8bDMt+AyqVmqE+f4MKAZgAvA
         eXHoRRNVcH0SkpnCTvE6YRUr//+r948cTLXssB/4V2Nr7xc35j1MRHusB8jeWuIMMosE
         gfaxW2XBKef1twuKqcV9LHZtKshPN5N0MH6FAd06VUXqWirq35q1i9PtWy+tiaU8SVV6
         17QKOQwky3VGfHe3jrlY/LcYQBAddkN8kxuIsi0InCqPX4JOC22THf40dF08vHUhHyi3
         vaSQ==
X-Gm-Message-State: APjAAAWRTT4JSp2i7/kpOwWlLjKfInui21EhuXmyfIwoIYm3yEN6Dsgu
        OVJvuJi7UBuhLbh53F7dicD2+w==
X-Google-Smtp-Source: APXvYqxk+1+rmZi904v8k29c8RjsPTgNO19TH+tlNz6F8hGZWv6LBYxggtUeflQkroZ7XbRUiUsHTA==
X-Received: by 2002:aed:3ed8:: with SMTP id o24mr12601256qtf.252.1565269526793;
        Thu, 08 Aug 2019 06:05:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b1sm15328088qkk.8.2019.08.08.06.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 06:05:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvi6f-0003Ih-LV; Thu, 08 Aug 2019 10:05:25 -0300
Date:   Thu, 8 Aug 2019 10:05:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V4 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190808130525.GA1989@ziepe.ca>
References: <20190807070617.23716-1-jasowang@redhat.com>
 <20190807070617.23716-8-jasowang@redhat.com>
 <20190807120738.GB1557@ziepe.ca>
 <ba5f375f-435a-91fd-7fca-bfab0915594b@redhat.com>
 <1000f8a3-19a9-0383-61e5-ba08ddc9fcba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1000f8a3-19a9-0383-61e5-ba08ddc9fcba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:54:54PM +0800, Jason Wang wrote:

> I don't have any objection to convert  to spinlock() but just want to
> know if any case that the above smp_mb() + counter looks good to you?

This email is horribly mangled, but I don't think mixing smb_mb() and
smp_load_acquire() would be considerd a best-practice, and using
smp_store_release() instead would be the wrong barrier.

spinlock does seem to be the only existing locking primitive that does
what is needed here.

Jason
