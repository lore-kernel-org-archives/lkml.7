Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020E9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5986218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jBLvne+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfC1PYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:24:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35508 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfC1PYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:24:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so23571637qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isKXPTi8LFmieVU9az7vGWyOVcJN5veMcrXh05ersr4=;
        b=jBLvne+Y5fUraduT/VckpbPVKTob1kJZoDxd9KIjZfV7U+A806jqSPp/3QykQO3IOL
         fyiBYokAsKRGPXyKm9dUIYpXQjenxKIR799LfwrYU80WZCiMf7RkKCJ0xMgXRCY3xARP
         IHclH8z4Gz3yeTTYZNYpg7mhCT38xCQg+18K/v5Jtb2s/1svWH6+lM84nFnGOi8VvPOt
         mIWCvs7RJ35Tx/39vtbXtYmwM1G3xfqHBpV3TJF6f+i613mkgc4W6X9aY861AMQrrBgB
         Z5Ks5QqGIv+9dqQTPzarnv6W7YWpxaLDKmEcsbklI/SHB/y/ebAtD0cE0jNhNTD1BUao
         IMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isKXPTi8LFmieVU9az7vGWyOVcJN5veMcrXh05ersr4=;
        b=GIR04ruq4rcTD5mTbpanHXZAQkqdhBbO1feAzILQusBXP3g1100xTHXAOUWkOX3XCP
         DXGDyqbrzJRZXD9keMHD2bz4IBAYMnem/UfSqdIxR3Jaii6Ov4LMuZ4NmZLG4km4wEx4
         Es99NVUyhBFgX4l8ShVCqneAGJOaEqgGgMEiOz40IGczS0n5QNyJ1D5uaSu2MkZa8TeY
         6GiklnBXppWAAASyB9v8MHswFapoq2R843HOMq/4IC24FdeVSseRtoiL4cDKWDzep1Xa
         Fz0WFNMIf3ZBQDJvUoTB0N0y237MfHnlwkXRX67Hdu7Ku35XBnqCxBc8Qyje6QvNQukH
         BR9Q==
X-Gm-Message-State: APjAAAXLjsxDJfvyoBAcoZf9X0MzMGfoQXL40xc/xx2HiXchtHFJcdzR
        5GF+i3V8CVpXEboqxy0KnMe7R2k2jbY=
X-Google-Smtp-Source: APXvYqzeVsoiYbOK4d1VbCnhthXv63Uaa1JU9I1KDKpO6mOK9lOyKBYREjeg0vBsAw56x/2RTtLzGA==
X-Received: by 2002:a0c:afd4:: with SMTP id t20mr21676186qvc.128.1553786689804;
        Thu, 28 Mar 2019 08:24:49 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s43sm14189589qth.47.2019.03.28.08.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:24:49 -0700 (PDT)
Message-ID: <1553786687.26196.26.camel@lca.pw>
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Mar 2019 11:24:47 -0400
In-Reply-To: <20190328145917.GC10283@arrakis.emea.arm.com>
References: <20190327005948.24263-1-cai@lca.pw>
         <20190327084432.GA11927@dhcp22.suse.cz>
         <20190327172955.GB17247@arrakis.emea.arm.com>
         <20190327182158.GS10344@bombadil.infradead.org>
         <20190328145917.GC10283@arrakis.emea.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 14:59 +0000, Catalin Marinas wrote:		2
> +/* minimum memory pool sizes */
> +#define MIN_OBJECT_POOL		(NR_CPUS * 4)
> +#define MIN_SCAN_AREA_POOL	(NR_CPUS * 1)

I am thinking about making those are tunable, so people could have a big pool
depends on their workloads.

Also, I would like to see a way to refill this emergency pool. For example, once
OOM kiler freed up more memory. Maybe at the time of kmemleak_scan kthread
kicked in and then monitor and refill the pool whenever possible.
