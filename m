Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9EAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717612073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfLKKVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:21:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbfLKKVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:21:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EAF4B2CF;
        Wed, 11 Dec 2019 10:21:21 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v2 2/4] xenbus: limit when state is forced to
 closed
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191210113347.3404-1-pdurrant@amazon.com>
 <20191210113347.3404-3-pdurrant@amazon.com>
 <20191211100627.GI980@Air-de-Roger>
 <86a7d140501047028c49736c43fe547c@EX13D32EUC003.ant.amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <a5506f58-a469-913d-6860-1214fa346089@suse.com>
Date:   Wed, 11 Dec 2019 11:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <86a7d140501047028c49736c43fe547c@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.19 11:14, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Roger Pau Monné <roger.pau@citrix.com>
>> Sent: 11 December 2019 10:06
>> To: Durrant, Paul <pdurrant@amazon.com>
>> Cc: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org; Juergen
>> Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
>> Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Subject: Re: [Xen-devel] [PATCH v2 2/4] xenbus: limit when state is forced
>> to closed
>>
>> On Tue, Dec 10, 2019 at 11:33:45AM +0000, Paul Durrant wrote:
>>> If a driver probe() fails then leave the xenstore state alone. There is
>> no
>>> reason to modify it as the failure may be due to transient resource
>>> allocation issues and hence a subsequent probe() may succeed.
>>>
>>> If the driver supports re-binding then only force state to closed during
>>> remove() only in the case when the toolstack may need to clean up. This
>> can
>>> be detected by checking whether the state in xenstore has been set to
>>> closing prior to device removal.
>>>
>>> NOTE: Re-bind support is indicated by new boolean in struct
>> xenbus_driver,
>>>        which defaults to false. Subsequent patches will add support to
>>>        some backend drivers.
>>
>> My intention was to specify whether you want to close the
>> backends on unbind in sysfs, so that an user can decide at runtime,
>> rather than having a hardcoded value in the driver.
>>
>> Anyway, I'm less sure whether such runtime tunable is useful at all,
>> so let's leave it out and can always be added afterwards. At the end
>> of day a user wrongly doing a rmmod blkback can always recover
>> gracefully by loading blkback again with your proposed approach to
>> leave connections open on module removal.
>>
>> Sorry for the extra work.
>>
> 
> Does this mean you don't think the extra driver flag is necessary any more? NB: now that xenbus actually takes module references you can't accidentally rmmod any more :-)

I'd like it to be kept, please.

Juergen
