Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE412184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCTPIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:08:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41206 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:08:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so2127420pfn.8;
        Wed, 20 Mar 2019 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I49wioiMvC6KAbOi6h5iHDc6bbMlKkfl9gInYq8kWzE=;
        b=HX4dhwGPFbCGLwCb9H7+qgiVy9MHsV5EwOlC21StKaPoSdcWmVv2tj7DAG3sHZ8VKZ
         pRQdEuczxZySEcf0X8qtqIZDGc9lbpzHIcRa10k524PGWKeMFM5uwJaA5Zc+P5iesv0d
         HgzxBaTOrzjI57n4/+Lhu3p2zh9k31P4gvMfpg2bhjQ514kJPm0jvquBklQXV/Yw0SmC
         QwBCoOu5xOxcEwQAKCKgMxgr6Wf6gazyUmYRTyn+1532hlf6F6AX+js2U/XgaezCjSiE
         ENqk67LUsfzl9LXt6ubD7rT/tkjitNIXdUwDMkM1H7P23j2N8L+SE5bOiXixsmYM/qMF
         azAg==
X-Gm-Message-State: APjAAAX0JvCoGUqPUhGA12DZaZtimOIJZvog+9n1JxhmYfJY7UHf/bdM
        fQavfNq1+7IuUULBMD0T+/8=
X-Google-Smtp-Source: APXvYqwNzqENVsDUjOaGEonP5DyJOiUiFNdHuMdMLXjp1Oowf1g+Z6E4hUZU5z7nfrdcARkEOdT5sw==
X-Received: by 2002:a62:6306:: with SMTP id x6mr3244959pfb.244.1553094530231;
        Wed, 20 Mar 2019 08:08:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m69sm5580034pfi.151.2019.03.20.08.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 08:08:49 -0700 (PDT)
Message-ID: <1553094528.65329.29.camel@acm.org>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-nvme@lists.infradead.org
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Wed, 20 Mar 2019 08:08:48 -0700
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 16:41 +-0200, Maxim Levitsky wrote:
+AD4 +ACo Polling kernel thread is used. The polling is stopped after a 
+AD4 predefined timeout (1/2 sec by default).
+AD4 Support for all interrupt driven mode is planned, and it shows promising results.

Which cgroup will the CPU cycles used for polling be attributed to? Can the
polling code be moved into user space such that it becomes easy to identify
which process needs most CPU cycles for polling and such that the polling
CPU cycles are attributed to the proper cgroup?

Thanks,

Bart.
