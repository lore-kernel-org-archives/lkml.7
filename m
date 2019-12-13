Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A64C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E797E22527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfLMFkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:40:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:40704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfLMFko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0FB8ACAE;
        Fri, 13 Dec 2019 05:40:42 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH net-next] xen-netback: get rid of old udev
 related code
To:     David Miller <davem@davemloft.net>, pdurrant@amazon.com
Cc:     xen-devel@lists.xenproject.org, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20191212135406.26229-1-pdurrant@amazon.com>
 <20191212.110513.1770889236741616001.davem@davemloft.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <cefcf3a4-fc10-d62a-cac9-81f0e47710a8@suse.com>
Date:   Fri, 13 Dec 2019 06:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212.110513.1770889236741616001.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.19 20:05, David Miller wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> Date: Thu, 12 Dec 2019 13:54:06 +0000
> 
>> In the past it used to be the case that the Xen toolstack relied upon
>> udev to execute backend hotplug scripts. However this has not been the
>> case for many releases now and removal of the associated code in
>> xen-netback shortens the source by more than 100 lines, and removes much
>> complexity in the interaction with the xenstore backend state.
>>
>> NOTE: xen-netback is the only xenbus driver to have a functional uevent()
>>        method. The only other driver to have a method at all is
>>        pvcalls-back, and currently pvcalls_back_uevent() simply returns 0.
>>        Hence this patch also facilitates further cleanup.
>>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> If userspace ever used this stuff, I seriously doubt you can remove this
> even if it hasn't been used in 5+ years.

Hmm, depends.

This has been used by Xen tools in dom0 only. If the last usage has been
in a Xen version which is no longer able to run with current Linux in
dom0 it could be removed. But I guess this would have to be a rather old
version of Xen (like 3.x?).

Paul, can you give a hint since which Xen version the toolstack no
longer relies on udev to start the hotplug scripts?


Juergen
