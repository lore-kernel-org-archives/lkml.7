Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3147C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD9F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbfB1LXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfB1LXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:23:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A53230BF4BB;
        Thu, 28 Feb 2019 11:23:03 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC7C5DF28;
        Thu, 28 Feb 2019 11:22:54 +0000 (UTC)
Date:   Thu, 28 Feb 2019 12:22:51 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, pmorel@linux.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Message-ID: <20190228122251.75b31f62.cohuck@redhat.com>
In-Reply-To: <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
        <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
        <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
        <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
        <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
        <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
        <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
        <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 28 Feb 2019 11:23:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 12:03:38 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 28.02.2019 10:42, Christian Borntraeger wrote:
> [...]
> >> Okay, let's go back to the genesis of this discussion; namely, my
> >> suggestion about moving the fc == 0x03 check into the hook code. If
> >> the vfio_ap module is not loaded, there will be no hook code. In that
> >> case, the check for the hook will fail and ultimately response code
> >> 0x01 will be set in the status word (which may not be the right thing
> >> to do?). You have not stated a single good reason for keeping this
> >> check, but I'm done with this silly argument. It certainly doesn't
> >> hurt anything.  
> > 
> > The instruction handler must handle the basic checks for the
> > instruction itself as outlined above.
> > 
> > Do we want to allow QEMU to fully emulate everything (the  ECA_APIE case being off)?
> > The we should pass along everything to QEMU, but this is already done with the
> > ECA_APIE check, correct?
> > 
> > Do we agree that when we are beyond the ECA_APIE check, that we do not emulate
> > in QEMU and we have enabled the AP instructions interpretion?
> > If yes then this has some implication:
> > 
> > 1. ECA is on and we should only get PQAP interception for specific FC (namely 3).
> > 2. What we certainly should check is the facility bit of the guest (65) and reject fc==3
> > right away with a specification exception. I do not want the hook to mess with
> > the kvm cpu model. @Pierre would be good to actually check test_kvm_facility(vcpu->kvm, 65))
> > 3. What shall we do when fc == 0x3? We can certainly do the check here OR in the
> > hook. As long as we have only fc==3 this does not matter.
> > 
> > Correct?  
> 
> Thinking more about that, I think we should inject a specification exception for all
> unknown FCc != 0x3. That would also qualify for keeping it in the instruction handler.
> 

So, to summarize, the function should do:
- Is userspace supposed to emulate everything (!ECA_APIE)? Return
  -EOPNOTSUPP to hand control to it.
- We are now interpreting the instruction in KVM. Do common checks
  (PSTATE etc.) and inject exceptions, if needed.
- Now look at the fc; if there's a handler for it, call that; if not
  (case does not attempt to call a specific handler, or no handler
  registered), inject a specification exception. (Do we want pre-checks
  like for facility 65 here, or in the handler?)

That response code 0x01 thingy probably needs to go into the specific
handler function, if anywhere (don't know the semantics, sorry).

Question: Will the handlers for the individual fcs need to generate
different exceptions on their own? I.e., do they need to do injections
themselves, or should the calling function possibly inject an exception
on error?

(Are there more possible fcs than 0x3 and whatever the other
subfunction was?)
