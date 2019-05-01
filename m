Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC1C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6732087B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZR2GyJS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfEABl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:41:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36915 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEABl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:41:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id c1so9499783qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VzGKxXFfllxyPKqLe/F+e5VHkssK7p8Vb80iGpJgCFA=;
        b=ZR2GyJS5dWX7nLKzsIONL3xnxWag/CPBF5z5Q3WK4lqkd0uuprDeD/PvnrPHd+4U94
         wj8wxPBjQvKSHa8bKLP0YPQa22v6D5IK1Qk+OWvF6LZyVxs/f24ikLRRuo5C6b6qV8WP
         Yj2z8dNAXONHRRn4vANpEqSjjdF9+LD8Si+kulNXhWlDfWXzGilwpom0mW20Qqy0QlKP
         VI+psISXQUlkSuzu/k2MY5KWwQ+PjXvlvIz3cfcEhkfxa8QQrCyKfFndwTrjxkfCEE/o
         YX9uFd30PbyKcPfP8d2HNblJjkx21LkGIDuTLbGqG80QkBVF107m8/u/keL3bz/L1XB6
         LXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzGKxXFfllxyPKqLe/F+e5VHkssK7p8Vb80iGpJgCFA=;
        b=GJ9uRMik9arC++dJ96/d938WDeyG7UqhiSheZCRxuwbvJX5sEjdezvkGbzfsnhDrJk
         IgsHUFnbD/sb28WLZ5tNY5XBAsamY2IEuJsUQtqVTicWR4b5ET/OjzP9aD8dfVKs6VQG
         osqQKoWAYOtuivxpt9jHoCzoT/7KF0QxBMSjg/9toej+RCJYgmbdu2elJ9kbGuqEWVcq
         Grl1EC9VYVzbUs2iDhNcGpnpEANLNVK0mRdiWQGAFS9g9dXrCgj2BBjYLzbbmOaiPo33
         /BZkLX3wmTu7qxIb/EyrMMBZR5rkOIVCi8Zk4gjQ7wpjsQ2iaEaeb83NKwByJTVZOpH3
         hzjA==
X-Gm-Message-State: APjAAAWhkIO56rk7UH0zegATpw5QIiKL4ZwndL1PcS5gZ59WI60qQ182
        TYPc6bf7MQBy1BMOYVTxECtRv0atYaE=
X-Google-Smtp-Source: APXvYqxDJRW8H1a19W7cRgf2FHPg/okPqiJ0Vj9a0lEZHAKZo54gr9gYUOu23p/8BJzgO3lcoC4zIA==
X-Received: by 2002:a37:5042:: with SMTP id e63mr52290993qkb.240.1556674918195;
        Tue, 30 Apr 2019 18:41:58 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m60sm20587636qte.81.2019.04.30.18.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 18:41:57 -0700 (PDT)
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
To:     Joerg Roedel <jroedel@suse.de>
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1556290348.6132.6.camel@lca.pw> <20190426152632.GC3173@suse.de>
 <1556294112.6132.7.camel@lca.pw> <20190429142326.GA4678@suse.de>
From:   Qian Cai <cai@lca.pw>
Message-ID: <61d3a8d6-48b0-0ec4-82e0-10c67ad9dcd7@lca.pw>
Date:   Tue, 30 Apr 2019 21:41:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429142326.GA4678@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/19 10:23 AM, Joerg Roedel wrote:
> On Fri, Apr 26, 2019 at 11:55:12AM -0400, Qian Cai wrote:
>> https://git.sr.ht/~cai/linux-debug/blob/master/dmesg
> 
> Thanks, I can't see any definitions for unity ranges or exclusion ranges
> in the IVRS table dump, which makes it even more weird.
> 
> Can you please send me the output of
> 
> 	for f in `ls -1 /sys/kernel/iommu_groups/*/reserved_regions`; do echo "---$f"; cat $f;done
> 
> to double-check?

It is going to take a while to reserve that system again to gather the
information. BTW, this is only reproducible on linux-next but not mainline.
