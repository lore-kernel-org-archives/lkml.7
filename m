Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01018C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C801E2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSAySRZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLPT5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:57:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbfLPT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576526237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DOwHvAlU3+FqtDr78ifXP7sbVzpoMf0fWDCOTmcOuvI=;
        b=QSAySRZrzDdywDR3+4YDcapB+L0yL140ikPY3rS9GN8orfvnbOZVk7wPOaR4MDW9hbcZ3g
        pCi4GUTQ6Tx8hf6/ZckOoht3AB58PToaZcQXh27vRJ6x3dRe7q/XMTEXSUJCyimlDb+L5P
        Qbp7YFiEY8zaBKC2gJR3WjEWuruVsbE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-eEeQpdfhOOOBWj4NOr0hvQ-1; Mon, 16 Dec 2019 14:57:14 -0500
X-MC-Unique: eEeQpdfhOOOBWj4NOr0hvQ-1
Received: by mail-qt1-f199.google.com with SMTP id y7so5389192qto.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 11:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DOwHvAlU3+FqtDr78ifXP7sbVzpoMf0fWDCOTmcOuvI=;
        b=FcF3YFzyQ3l2Rh42mlhmu6mCfGeI6hPODL7NYsibCiMa9elRvQ8u8Io3sLMbhc0ISS
         J4w07Q4d4lsz0H2mrVfof+5tzNmgEYOl/K3AX5j9wNVHNmW3CZ30aGNnSLcKJSwGO6PD
         VmTBXo53NzdQP2d2uWzy3BU2G/8fg8JINv5y2tuZYiDPMbYoXZ+C5lqgZ+L1BTqSBU2C
         rrWf1JLWqNO+Q+bhkHL3rkXo7EVjrEXQC6zW5UmoNSwv/z+M9o0Yu1QgAh+BhYR3vdrS
         7K9pAkLXQO8sy2ElrtcnG8COjY7E+Li6mVcuU1nPHUb0ToxyBTa92wc0ITi6wMAtkn8U
         t0aQ==
X-Gm-Message-State: APjAAAVZF9uR/XmfUEuIpFw72Jtq8MCzMRFqMjhS2nTYSHmXORITiZRU
        aDXolINadokW6b/3TF3xj9jWD9+vz3O65n/rFWrc5TbC/3RRdzSg9RfiXujBuKzBLAmFbr7aoC2
        8SelRhUlBssEaBvVUxmJrZi65
X-Received: by 2002:a05:620a:8d7:: with SMTP id z23mr1058255qkz.15.1576526233977;
        Mon, 16 Dec 2019 11:57:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzi8KLE4Tfi0bIypfD9lAkeARlwnwMobt4XlMVrtWmvcOC3qmyFs2WIu9NMmJevqYjejrRNlQ==
X-Received: by 2002:a05:620a:8d7:: with SMTP id z23mr1058223qkz.15.1576526233634;
        Mon, 16 Dec 2019 11:57:13 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id f26sm7068038qtv.77.2019.12.16.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 11:57:12 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:57:12 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Subject: Kernel-managed IRQ affinity (cont)
Message-ID: <20191216195712.GA161272@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

(Sorry I must have lost the discussion during an email migration, so
 I'll start with a new one)

This is a continued discussion of previous one on kernel managed IRQ
affinity [1].  I think at that time the conclusion is that we don't
have a usage scenario to change current policy [2].  However recently
I noticed that it is probably a very fundamental requirement for some
real-time scenarios, even when there's no multi-queue involved.

In my test case, it was a very common realtime guest with 10 vcpus,
0-1 are housekeeping vcpus, 2-9 are realtime vcpus.  The guest has one
virtio-blk device as boot disk.  With a distribution very close to
latest upstream, we can observe high spikes, probably due to the IRQs.

To guarantee realtime responsiveness, we need to make sure the IRQs
will be managable, say, when I run a real-time workload on vcpu9, we
should be able to move all the IRQs from vcpu9 to the other vcpus
(most probably vcpu0 and vcpu1).  However with the kernel managed IRQs
we can't echo to /proc/irq/N/smp_affinity.  Here, vcpu9 gets IRQ 38
from the virtio-blk device:

  # cat /proc/interrupts | grep -w 38
  38: 0 0 0 0 0 0 0 0 0 15206 PCI-MSI 2621441-edge virtio2-req.0
  # cat /proc/irq/38/smp_affinity
  3ff
  # cat /proc/irq/38/effective_affinity
  200

Meanwhile, I don't think there's anything special for VMs, so this
issue should exist even for hosts as long as the IRQ is managed in the
same way here as the virtio-blk device.

As Ming has mentioned in previous discussions [3], I think it would be
at least good if the kernel IRQ system can respect "irqaffinity=" when
assigning IRQs to the cores.  Currently it's not.  What would you
suggest in this case?  Do you think this is a valid user scenario?

Thanks,

[1] https://lkml.org/lkml/2019/3/18/15
[2] https://lkml.org/lkml/2019/3/25/562
[3] https://lkml.org/lkml/2019/3/25/308

-- 
Peter Xu

