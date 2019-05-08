Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD97DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B1020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfEHMjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:39:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40093 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfEHMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:39:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so7749487wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Rmas8gcFMGufmlR3c5DQmI8ZQrCroMRQQbwgTv6K0o=;
        b=DVjJI9GLM0wGMGsW8NcrWxaNTRSWQUQT/e2HemxV6gKKszBdt71XgKMcsPAQWygPf7
         94aouo1wkHPxev0xOu8X/pZu8Ut268zcYV3wVE7giNpDBw6oajvEj1jFy3jXPzR3Oag7
         FNhM5+XhhI/r0lbFR4uf/tzoZ9CjgfvzDCVhKRvVsboM3k1ZQxt/Yzv9y5xbdmJqUuc8
         zxVte/v+qKcUESpHMks+PQ4Lp84DWNd95IWbWcvIkTjrTQdpSFA+/TO/ENNYDmflQ3yt
         8OKHXbix+B3g4J3NlRhk8OlA7kL23wkG4g0WWFTbYmTMMOyQdpPp0CVTMrQQKkIzdPgY
         dPWA==
X-Gm-Message-State: APjAAAXQMHCz8ygOv26aKQf4Kwskpet0xMhX/PGqKcUfYocxA/arzgQs
        9QHuUBGnPqiZmByWnFM0OmuT0w==
X-Google-Smtp-Source: APXvYqwuyoFh7G+bUNBJPQbUYqVHJhmvLVup6b4hVfQDP/ku/Jv9N/UUoJIUxNspRHbGoU418ffKdw==
X-Received: by 2002:adf:dc8a:: with SMTP id r10mr10988770wrj.15.1557319160335;
        Wed, 08 May 2019 05:39:20 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id a9sm2110131wmm.48.2019.05.08.05.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 05:39:19 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] RFC: NVME MDEV
To:     Christoph Hellwig <hch@lst.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, John Ferlan <jferlan@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
 <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
 <20190506125752.GA5288@lst.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a789d935-e665-c339-d7ae-3d23997b92d9@redhat.com>
Date:   Wed, 8 May 2019 14:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506125752.GA5288@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/19 07:57, Christoph Hellwig wrote:
> 
> Or to put it into another way:  unless your paravirt interface requires
> zero specific changes to the core nvme code it is not acceptable at all.

I'm not sure it's possible to attain that goal, however I agree that
putting the control plane in the kernel is probably not a good idea, so
the vhost model is better than mdev for this usecase.

In addition, unless it is possible for the driver to pass the queue
directly to the guests, there probably isn't much advantage in putting
the driver in the kernel at all.  Maxim, do you have numbers for 1) QEMU
with aio 2) QEMU with VFIO-based userspace nvme driver 3) nvme-mdev?

Paolo
