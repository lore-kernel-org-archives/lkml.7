Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97CC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849520842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5m3Y6+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfI3Xtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:49:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfI3Xtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E9ubt9+aej64brgZvM9455FGrDpqWfOc9ZRlZLURQKs=; b=h5m3Y6+D8+QLYdn4kAqdGp3pp
        LdqTkgvwpu36p1OtF4/qPV4NKpJ0GP9CGhXB9wCaTs59kwNAuMtVeuu/FJwtX+BLbr+U7YiZYaje0
        TCKdyuAq5zoVdssgYGKCT4HU3kPSGKDgI82ugc9bbQCoZhFplRkoQ1rZm8/vf1kZw62sQmIb7rbWy
        owDu6UDJ/dXB57khV3NiY0E+LrB6rkoBWTbdqd2fwFQt86GKzfg5SHw+UYYxg4y5gA5pEB0K/RAfR
        Vh2lAwtvPWYAPVG/7p23iJaA+FKWk0Wa7z1RPFgMRZQhwlu5JM3SSSJZIDwaeeZC5LbM/K+HpMtev
        TdgwYFsQA==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iF5QL-0003Iq-K9; Mon, 30 Sep 2019 23:49:49 +0000
Subject: Re: What populates /proc/partitions ?
To:     "David F." <df7729@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0d9d434-1f47-66a0-1129-5003f2f2eb5c@infradead.org>
Date:   Mon, 30 Sep 2019 16:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 3:47 PM, David F. wrote:
> Hi,
> 
> I want to find out why fd0 is being added to /proc/partitions and stop
> that for my build.  I've searched "/proc/partitions" and "partitions",
> not finding anything that matters.

/proc/partitions is produced on demand by causing a read of it.
That is done by these functions (pointers) in block/genhd.c:

static const struct seq_operations partitions_op = {
	.start	= show_partition_start,
	.next	= disk_seqf_next,
	.stop	= disk_seqf_stop,
	.show	= show_partition
};

in particular, show_partition().  In turn, that function uses data that was
produced upon block device discovery, also in block/genhd.c.
See functions disk_get_part(), disk_part_iter_init(), disk_part_iter_next(),
disk_part_iter_exit(), __device_add_disk(), and get_gendisk().

> If udev is doing it, what function is it call so I can search on that?

I don't know about that.  I guess in the kernel it is about "uevents".
E.g., in block/genhd.c, there are some calls to kobject_uevent() or variants
of it.

> TIA!!

There should be something in your boot log about "fd" or "fd0" or floppy.
eh?

-- 
~Randy
