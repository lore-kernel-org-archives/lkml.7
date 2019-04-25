Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D295C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB8D2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfDYKl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:41:26 -0400
Received: from foss.arm.com ([217.140.101.70]:40688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbfDYKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:41:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87F1374;
        Thu, 25 Apr 2019 03:41:25 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E70893F5C1;
        Thu, 25 Apr 2019 03:41:23 -0700 (PDT)
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <fd5b8c6c-05f0-307b-aaa2-0938337014a8@arm.com>
Date:   Thu, 25 Apr 2019 11:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 11:17, Auger Eric wrote:
>> +/**
>> + * ioasid_alloc - Allocate an IOASID
>> + * @set: the IOASID set
>> + * @min: the minimum ID (inclusive)
>> + * @max: the maximum ID (exclusive)
>> + * @private: data private to the caller
>> + *
>> + * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
> I would remove "(or %0 and %INT_MAX)".

Agreed, those where the default values of idr, but the xarray doesn't
define a default max value. By the way, I do think squashing patches 6
and 7 would be better (keeping my SOB but you can change the author).

>> +typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void *data);
> I don't see it used in this series.

There used to be a "ioasid_for_each()", which isn't needed by anyone at
the moment. This can be removed.

Thanks,
Jean
