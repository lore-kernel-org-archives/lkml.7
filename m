Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5451C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07722083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfB1NxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfB1NxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17236ABBC5;
        Thu, 28 Feb 2019 13:53:04 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F16E2620D1;
        Thu, 28 Feb 2019 13:52:56 +0000 (UTC)
Date:   Thu, 28 Feb 2019 14:52:54 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Message-ID: <20190228145254.2909425e.cohuck@redhat.com>
In-Reply-To: <be69498a-c4d3-81e7-b8bf-6931058cee74@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
        <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
        <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
        <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
        <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
        <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
        <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
        <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
        <20190228122251.75b31f62.cohuck@redhat.com>
        <be69498a-c4d3-81e7-b8bf-6931058cee74@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 28 Feb 2019 13:53:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 14:16:09 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 28/02/2019 12:22, Cornelia Huck wrote:

> > So, to summarize, the function should do:
> > - Is userspace supposed to emulate everything (!ECA_APIE)? Return
> >    -EOPNOTSUPP to hand control to it.
> > - We are now interpreting the instruction in KVM. Do common checks
> >    (PSTATE etc.) and inject exceptions, if needed.
> > - Now look at the fc; if there's a handler for it, call that; if not
> >    (case does not attempt to call a specific handler, or no handler
> >    registered), inject a specification exception. (Do we want pre-checks
> >    like for facility 65 here, or in the handler?)
> > 
> > That response code 0x01 thingy probably needs to go into the specific
> > handler function, if anywhere (don't know the semantics, sorry).  
> 
> What do you mean with specific handler function?
> 
> If you mean a switch around the FC with static function's call, I agree, 
> if you mean a jump into a hook I do not agree.

Ah, ok; so each case (that we want to handle) should call into a
subhandler that does
{
	(... check things like facilities ...)
	if (!specific_hook)
		inject_specif_excp_and_return();
	ret = specific_hook();
	if (ret)
		set_resp_code_0x01(); // or in specific_hook()?
}

?
 
> > 
> > Question: Will the handlers for the individual fcs need to generate
> > different exceptions on their own? I.e., do they need to do injections
> > themselves, or should the calling function possibly inject an exception
> > on error?  
> 
> There are some specificities.

Ok, should probably done in the subhandlers?

(I hope I don't muddy the waters too much; but basically, I'm poking
around with a stick in the dark :)
