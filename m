Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE3C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1979F20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BVi3rXe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391006AbfFJOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:54:26 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39673 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfFJOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:54:25 -0400
Received: by mail-vk1-f196.google.com with SMTP id o19so890064vkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBy9mlIx6f1ckhMxMH/Wiz5DhTWHFCPX4zeEAJIdzTE=;
        b=BVi3rXe2/KugjTlNlPcpf2KyS+kd6TzwaRjTYOBqUDoP0ySDW/7ANUn8qtvQeomFq0
         6NZkgIcpD29Z3NxCclmpssuc0uVdNWF/wsPBaCYsCMDDlRnB7gA8HNTFnxkcvE+yoFZL
         T48YcrPMHqQ4HlFJRTYzpQaClRTfGfFufgI0HC/jSCLO6izLfC+0XMKVxHJbM+1bu3az
         1n6G47VzZzlpXRhQBBjUrwl5+X2gT1pSzs9o+YgzJsMfgKBbdLmODs/nBFQKv6WIWJIR
         4rzIv0v7W3WBtucArXz7IFPGU57HAS0TdXmyPwGWyul64U8BxsLVcPivqi7gJqx/QSyZ
         VFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBy9mlIx6f1ckhMxMH/Wiz5DhTWHFCPX4zeEAJIdzTE=;
        b=SQsesp6qobAqylvD5klPJXRJwYEg4NMQ3y7NYwwLXZA2flRUsh5oiWeZk6pVwilIxY
         1QfmaPWyXyTSfnwAUTnBx9Ity7J5aB7OgFoyzYwVCIFYFNllM03GvVZboZ8RxsxDN7P+
         jaIIyUbSJXuiYSuF1AwbzTsy7UXBLGwO+sITHlC+ny9svpDjteiXWpE9/4mf4iBU2BcQ
         bKIt1zbIi8CvxdGYqOWpA+M4AoNPqngdN2EHForY3pGhkuOXQvMV7TXZNoMW2OUz9AnR
         xsP8GEfAlBxBVT/iiNWJvRSEKZkUmJWJer8CmjjHae37gsb6FstFslX1fpiFNxnDjGBz
         6uKw==
X-Gm-Message-State: APjAAAUtFIlU47ycafNHDD8zkGOsmNUizQc3+JcfQGps2UIJ0Y3QhpOJ
        rcGQ/NB1B8iqY35A+ZGOruwLAw==
X-Google-Smtp-Source: APXvYqxYzZy8GY/dH4++ulBqMjOZ+eAp+O+p7QamjiVEJcLK5ZjpBYUCIQg3RTAriMJkMKHnoI/wAw==
X-Received: by 2002:a1f:ff17:: with SMTP id p23mr3910123vki.62.1560178464373;
        Mon, 10 Jun 2019 07:54:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z10sm983720vsn.23.2019.06.10.07.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 07:54:23 -0700 (PDT)
Message-ID: <1560178459.6132.66.camel@lca.pw>
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series
 breaks megaraid_sas
From:   Qian Cai <cai@lca.pw>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     James Sewart <jamessewart@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Date:   Mon, 10 Jun 2019 10:54:19 -0400
In-Reply-To: <1560174264.6132.65.camel@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
         <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
         <1560174264.6132.65.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-10 at 09:44 -0400, Qian Cai wrote:
> On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
> > Hi Qian,
> > 
> > I just posted some fix patches. I cc'ed them in your email inbox as
> > well. Can you please check whether they happen to fix your issue?
> > If not, do you mind posting more debug messages?
> 
> Unfortunately, it does not work. Here is the dmesg.
> 
> https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=AMC35QKPIZBYUM
> FUQKLW4ZC47ZPIK

This one should be good to view.

https://cailca.github.io/files/dmesg.txt
