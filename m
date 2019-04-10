Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE56C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B86C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="byWdSdBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfDJOS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:18:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40101 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbfDJOSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:18:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1521838plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XQhHJQm0ddO90MHKaMiAhLuRoa5Q1cwmepr9DZq4g8=;
        b=byWdSdBrVXsB6nM6gY6PtteabTNB0rScomQUhi9qwW5Ag+qlQ9ByF2KacvVY1M2l2V
         gDkAiGEdGyXjcXNvQvOWPsybNUCwNPlw6eRAUjrOZd54FEDipql8V/E0VMi1fvcZ8Gs+
         XGyfbbz+AXPYTwh3WkbW1YYR3OW3aAhUjWgAywleOHXYyU6j1UfE7qYILNJt65A8odic
         ONE3EJ5HDUUwwvy3VkqlpOdFh8MLmp9mahGZE59UIOIBcrYjhkuV+A5Yr1CApwGr30Gd
         Pg3obzeXsGAoCWRkwfjZsxJoYAirJrSI9532sg1lYCCkPTtJwBkcNrKSfxei2NCc9Cjv
         X72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XQhHJQm0ddO90MHKaMiAhLuRoa5Q1cwmepr9DZq4g8=;
        b=DG/v/ZGaWg5BPEkeQldFAKO3oWKVBuiA5Sf4WDpDRWKLDCWKVYzDs8zr4iVBJ4VWMH
         rC34I2AoV+yMWbqm6k/QTazVqzePHeET47sneRTC3nbhQMP46WjTlb8CEuQF4PXBo9Qh
         HiutQjWqbuVoqWxlwkBvWPIibSOdISXMqDjKCtvpqY70a6u+fR0w8RY4xBK+GWdk6BeI
         dhMCso3K6HJDCNHx+olUDiGoZJI4jqZIw4K0tv0Qa0pQ64joCgaFVtAQfei+IqZ73WWe
         iW79OrRu+U1pVhzhFzfb2xjTpaLsAtj/hYdBsgsK10vLJSghO6ND53ilK3HD7wydY89w
         FGDg==
X-Gm-Message-State: APjAAAX//YgsIsLGiG2g547RjmqZkGNyqx5ZvN2WiIDRKJEAbmDtPW5o
        rPPzz7Ou3WSWmPZSUjBhUzbNn5oQQn4zKA==
X-Google-Smtp-Source: APXvYqyx+difYdU8IvLiam0r34Z01kso6TmEcv7pCk8SJJ1Ni6J5DDcxcAnQOd/RrSIlzS3/MjX9Sw==
X-Received: by 2002:a17:902:b715:: with SMTP id d21mr45017137pls.103.1554905933766;
        Wed, 10 Apr 2019 07:18:53 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d15sm51575592pfo.34.2019.04.10.07.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 07:18:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] Limit number of hw queues by nr_cpu_ids for
 virtio-blk and virtio-scsi
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org
References: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <47e8d8bf-1820-5cb4-ac78-1bcd5ea26c49@kernel.dk>
Date:   Wed, 10 Apr 2019 08:18:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 4:36 AM, Dongli Zhang wrote:
> When tag_set->nr_maps is 1, the block layer limits the number of hw queues
> by nr_cpu_ids. No matter how many hw queues are use by
> virtio-blk/virtio-scsi, as they both have (tag_set->nr_maps == 1), they
> can use at most nr_cpu_ids hw queues.
> 
> In addition, specifically for pci scenario, when the 'num-queues' specified
> by qemu is more than maxcpus, virtio-blk/virtio-scsi would not be able to
> allocate more than maxcpus vectors in order to have a vector for each
> queue. As a result, they fall back into MSI-X with one vector for config
> and one shared for queues.
> 
> Considering above reasons, this patch set limits the number of hw queues
> used by nr_cpu_ids for both virtio-blk and virtio-scsi.

I picked both up for 5.1.

-- 
Jens Axboe

