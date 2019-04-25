Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A648A20890
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RG6efg+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfDYMay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:30:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43102 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfDYMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:30:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id j20so18971285edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67R0k05803KguupIDta7Ra/6RBriLS9l4FIpl33TABc=;
        b=RG6efg+wINT5PtOxJThnJ7/GhcdJnGb39Z4ZiVojLVulIllPY6WegbUX1iE+KXv7ix
         hw7G3Q35WeIJFBq6h+DTKCSoq6Caf3U4HMLnir6Y2Fpepl+Yg62BlPdyDc+AfIeAdC6G
         T5q6JA5VpPnsEZbc1Y3THNGipkJEYTCX5YvtGmIytNOobkbu5pJOI8FPfiRA+c2salf8
         qIjHlzsMeZbUV6ujc/e+TQwLohjwZU6jQscEF+qeF4JPVtvV/MenGzVv1/zUdUKvFb4o
         XQFGsXg+neKHnqNqXD/JaZm33914fdkJ2/qSt+EWsmhg8bcDYJt8SzWMQ5M1Jr4er9q8
         DqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67R0k05803KguupIDta7Ra/6RBriLS9l4FIpl33TABc=;
        b=Nn54y9zeRvg7jHG7hpxTViV3Y3UMrmhxU2gW6pFuqhcw/JW2BsmEHrL+O9ehgmGq/C
         u0KSqjxINk9bbWA2OeufDxFbhhzXFq0kdgzBDwRw0zuBGpEqWuDD9nuZq860ZBXuvZ5N
         5zrWfpV9/AGrlGyBnCM3MMA0Imyd63aWDnvI0uebdq0230j8vpLQ2po86kFS78asnrEE
         VxIIKON3mn6bHIGEvI9lF5HKwo4gBxRFjgOY8LSRa18zj0bVhoLn8op8jG++BPpBPo1/
         mexTOFjEXRecpKW/o9Q6UgoC09ueGh78DXAq5JA2KOJyd6cOTsk1inUDYpKNUpiRiAmm
         RzaQ==
X-Gm-Message-State: APjAAAXVD+uaL11ZhUv1wmS6t4BPI54snCIlxDfxN9C9FD/nKRf1tWYg
        edlSBPBY4MyqHVJO7zdClThVllN4yzvOk4buZhJHhA==
X-Google-Smtp-Source: APXvYqwiC0RYDcdWaH93fKry+qe407e7uBBkYjvENxoUhOgx5lCTLYYQiqnziqtuQkVFJZxzsIpjW4zsSKchIjg+TPc=
X-Received: by 2002:a50:b68a:: with SMTP id d10mr1779006ede.79.1556195451949;
 Thu, 25 Apr 2019 05:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190421014429.31206-1-pasha.tatashin@soleen.com>
 <20190421014429.31206-3-pasha.tatashin@soleen.com> <4ad3c587-6ab8-1307-5a13-a3e73cf569a5@redhat.com>
 <CAPcyv4h3+hU=MmB=RCc5GZmjLW_ALoVg_C4Z7aw8NQ=1LzPKaw@mail.gmail.com>
 <CA+CK2bDB5o4+NMc7==_ipVAZoEo7fdrkjZ4etU0LUCqxnmN-Rg@mail.gmail.com> <180d6250-8a6a-0b5d-642a-ec6648cb45b1@redhat.com>
In-Reply-To: <180d6250-8a6a-0b5d-642a-ec6648cb45b1@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Apr 2019 08:30:40 -0400
Message-ID: <CA+CK2bBt0vHr9D+BuvM=GmjCMESu5iBiUTdvid_TaoE6j2daQg@mail.gmail.com>
Subject: Re: [v2 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Yes, also I think you can let go of the device_lock in
> check_memblocks_offline_cb, lock_device_hotplug() should take care of
> this (see Documentation/core-api/memory-hotplug.rst - "locking internals")
>
Hi David,

Thank you for your comments. I went through memory-hotplug.rst, and I
still think that device_lock() is needed here. In this particular case
it can be replaced with something like READ_ONCE(), but for simplicity
it is better to have device_lock()/device_unlock() as this is not a
performance critical code.

I do not see any lock ordering issues with this code, as we are
holding lock_device_hotplug() first that prevents userland from
adding/removing memory during this check.

https://soleen.com/source/xref/linux/arch/powerpc/platforms/powernv/memtrace.c?r=98fa15f3#248

Here we have a similar code:
lock_device_hotplug();
   online_mem_block();
    device_online()
     device_lock(dev);

Pasha
