Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E4BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2742089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556790500;
	bh=izrYoKTU4xWJRGopNdBEVJaICGTT0gZCvv2SqjNIn1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PXogCUCtg4YEAxDIB+5J1utS20nmby3w5osGR013pEM972HGHwGeBu/pmzINcPJvp
	 DJNUpNO2g9nkKjS9Kw9IxEl4TdeTLVWqYiMM8vmTz+Q57vzR1XGQglYGNrO60A8ZTz
	 NkQN5aEPkKAwXfKXMjP6GtKVDE5UNA3QlXaJvAAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBJsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfEBJsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:48:19 -0400
Received: from linux-8ccs (ip5f5ade58.dynamic.kabel-deutschland.de [95.90.222.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588B9206DF;
        Thu,  2 May 2019 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556790498;
        bh=izrYoKTU4xWJRGopNdBEVJaICGTT0gZCvv2SqjNIn1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdbUWmrvxijmiVfMWUtjlXpscQSHqZq3GqPkGTrtp/+KqsIObnFELpvpwmTv/CnJ+
         cmY2ZrmaBiSGD+K6OTlqONxIwG5WrXGPdtzr5Xzd12Udohl86b+i485k1rJlVozc6s
         MBCFvdBCyeTe40o1Oo0306A1eN8xf2KQxLeVIbcg=
Date:   Thu, 2 May 2019 11:48:14 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
Subject: Re: [PATCH v3] kernel/module: Reschedule while waiting for modules
 to finish loading
Message-ID: <20190502094813.GA6690@linux-8ccs>
References: <20190430222207.3002-1-prarit@redhat.com>
 <90e18809-2b70-52d8-00b3-9c16768db9ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90e18809-2b70-52d8-00b3-9c16768db9ad@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [01/05/19 17:26 -0400]:
>
>
>On 4/30/19 6:22 PM, Prarit Bhargava wrote:
>> On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>> loading the s390_trng.ko module.
>>
>> Add a reschedule point to the loop that waits for modules to complete
>> loading.
>>
>> v3: cleanup Fixes line.
>
>Jessica, even with this additional patch there appears to be some other issues
>in the module code that are causing significant delays in boot up on large
>systems.

Is this limited to only s390? Or are you seeing this on other arches
as well? And is it limited to specific modules (like s390_trng)?

>Please revert these fixes from linux-next & modules-next.  I apologize for the
>extra work but I think it is for the best until I come up with a more complete &
>better tested patch.

Sure, then I will revert this patch and the other one as well
("modules: Only return -EEXIST for modules that have finished
loading").

>FWIW, the logic in the original patch is correct.  It's just that there's, as
>Heiko discovered, some poor scheduling, etc., that is impacting the module
>loading code after these changes.

I am really curious to see what these performance regressions look
like :/ Please update us when you find out more.

>Again, my apologies,

No problem! Thanks again.

Jessica

