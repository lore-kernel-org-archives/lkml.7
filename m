Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D68CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A849D20663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bj9aU8RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409270AbfJYKQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:16:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42523 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409209AbfJYKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:16:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so1644130wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NP2Oouc7q1f33SRB3lHPUh+PTnPTT6dHPVBMKG6sPiU=;
        b=bj9aU8RCRgfOVopITop5T+/S7+KhRLClYo637JC469jcCDxsyhi7R7ikwq1cpJxUPA
         dlL/pvGGk0ohBWtJiL9fXWDv+nw9Uo6Z13Pwte/z0s6tXFdg6qjIgFGH/86a+YX/BiGV
         4Djt72clRVeBDRAkAzTZ9nSHbmKMQ1wJC8cU/1uG/UrT/T/JoesqptzOPoYiJeYKo45R
         zoztkaJre2osrvBkTZDYGVf8GI/puig6CLMB+Imo8jHopE+zv27hMiGNe20mQCVnN7MJ
         SESL7Hn0UPiiufI2wbXz/4z5cHGH87Hw1Qd/oZl/zj6GmWNSKF/F98/vwnXfmImQDL7m
         crRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NP2Oouc7q1f33SRB3lHPUh+PTnPTT6dHPVBMKG6sPiU=;
        b=CZY6zyVfMtxRfakrSMhOxhGjd8ol52ZxDQ5IfVEg+RlBSfM3GJG4mTVTlIUPIU7F/4
         CmvhBOLb89iRrrRXG0TiZi3bVpTW6HvqMrnCs8DkjSpMluv0CyKK8MqRvdRUas5SChDk
         qWaTp+lt8qCll+AXkGT3nP5QiIq89yuYfa5Y8vRF7egSWeaxlXOKfeCPznnFM3o9UJOL
         ftIBGJSvkjvrpqk0BAA865kNZXGApFF//2FU+opvRQu50NosIw9Ta5bWEsIFPUb5V4kX
         2L/hm4Ej5Wkblz5UTzpHY2okQjTZAqAUfCBwT1Cx7whsFOiFqHzFWDIMermXzfJJh+l+
         84IA==
X-Gm-Message-State: APjAAAWy4SKkWWIOd0OmNzHbVfd5PK1J2McK11LqvKR0hc7x1rm8Hie8
        BLjab+RL2csD0aT6hSHDF4jczQ==
X-Google-Smtp-Source: APXvYqyQmDbEw04RVn2bj6bG5HpjBc5PMzPUHuWj3daUsWSfNOQ0apCRK9QUZmbPG1dd/cOcivlT2g==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr2281953wrv.92.1571998586903;
        Fri, 25 Oct 2019 03:16:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id r19sm1732999wrr.47.2019.10.25.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 03:16:26 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:16:24 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     elsk@google.com, dvander@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: dm-snapshot for system updates in Android
Message-ID: <20191025101624.GA61225@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

I hope you will appreciate knowing that we are currently evaluating the use of
dm-snapshot to implement a mechanism to obtain revertible, space-efficient
system upgrades in Android.  More specifically, we are using
dm-snapshot-persistent to test the updated device after reboot, then issue a
merge in case of success, otherwise, destroy the snapshot.
This new update mechanism is still under evaluation, but its development is
openly done in AOSP.

At the current stage, we have a prototype we are happy with, both in terms of
space consumption overhead (for the COW device) and benchmarking results for
read-write and merge operations.

I would be glad if you could provide some feedback on a few points that I don't
have completely clear.


-- Interface stability

To obtain an initial, empty COW device as quick as possible, we force to 0 only
its first 32 bit (magic field). This solution looks clear from the kernel code,
but can we rely on that for all the kernels with SNAPSHOT_DISK_VERSION == 1?
Would you appreciate it if a similar statement is added as part of
/Documentation, making this solution more stable? Or maybe I can think of
adding an initialization flag to the dm-snapshot table to explicitly request
the COW initialization within the kernel?

Another issue we are facing is to be able to know in advance what the minimum
COW device size would be for a given update to be able to allocate the right
size for the COW device in advance.  To do so, we rely on the current COW
structure that seems to have kept the same stable shape in the last decade, and
compute the total COW size by knowing the number of modified chunks. The
formula would be something like that:

  table_line_bytes      = 64 * 2 / 8;
  exceptions_per_chunk  = chunk_size_bytes / table_line_bytes;
  total_cow_size_chunks = 1 + 1 + modified_chunks
                        + modified_chunks / exceptions_per_chunk;

This formula seems to be valid for all the recent kernels we checked. Again,
can we assume it to be valid for all the kernels for which
SNAPSHOT_DISK_VERSION == 1?


-- Alignment

Our approach follows the solution proposed by Mikulas [1].
Being the block alignment of file extents automatically managed by the
filesystem, using FIEMAP should have no alignment-related performance issue.
But in our implementation we hit a misalignment [2] branch which leads to
dmwarning messages [3, 4].

I have a limited experience with the block layer and dm, so I'm still
struggling in finding the root cause for this, either in user space or kernel
space.
But our benchmarks seems to be good, so we were thinking as last option to
rate-limit or directly remove that warning from our kernels as a temporary
solution, but we prefer to avoid diverging from mainline. Rate-limiting is a
solution that would make sense also to be proposed in the list, but completely
removing the warning doesn't seem the right thing to do. Maybe we are
benchmarking something else? What do you think?

Many thanks for taking the time to read this, feedbacks would be highly
appreciated.

Regards.
Alessio

[1] https://www.redhat.com/archives/dm-devel/2018-October/msg00363.html
[2] https://elixir.bootlin.com/linux/v5.3/source/block/blk-settings.c#L540
[3] https://elixir.bootlin.com/linux/v5.3/source/drivers/md/dm-table.c#L484
[4] https://elixir.bootlin.com/linux/v5.3/source/drivers/md/dm-table.c#L1558

