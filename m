Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671AD20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfCAMgV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAMgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:36:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 230D29C170;
        Fri,  1 Mar 2019 12:36:20 +0000 (UTC)
Received: from gondolin (ovpn-117-66.ams2.redhat.com [10.36.117.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58C02620D2;
        Fri,  1 Mar 2019 12:36:12 +0000 (UTC)
Date:   Fri, 1 Mar 2019 13:36:09 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Message-ID: <20190301133609.3ee469dc.cohuck@redhat.com>
In-Reply-To: <f4b3dec4-cdf6-85df-309e-b542ba83230a@de.ibm.com>
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
        <20190228145254.2909425e.cohuck@redhat.com>
        <261a1e22-3703-21a4-e33d-e737651e7d89@linux.ibm.com>
        <3fedbde5-ef83-c67e-6352-fd492f258009@linux.ibm.com>
        <f4b3dec4-cdf6-85df-309e-b542ba83230a@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 01 Mar 2019 12:36:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 13:05:54 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01.03.2019 13:03, Pierre Morel wrote:
> > On 28/02/2019 15:14, Pierre Morel wrote:  
> >> On 28/02/2019 14:52, Cornelia Huck wrote:  
> >>> On Thu, 28 Feb 2019 14:16:09 +0100
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>  
> >>>> On 28/02/2019 12:22, Cornelia Huck wrote:  
> >>>  
> >>>>> So, to summarize, the function should do:
> >>>>> - Is userspace supposed to emulate everything (!ECA_APIE)? Return
> >>>>>     -EOPNOTSUPP to hand control to it.
> >>>>> - We are now interpreting the instruction in KVM. Do common checks
> >>>>>     (PSTATE etc.) and inject exceptions, if needed.
> >>>>> - Now look at the fc; if there's a handler for it, call that; if not
> >>>>>     (case does not attempt to call a specific handler, or no handler
> >>>>>     registered), inject a specification exception. (Do we want pre-checks
> >>>>>     like for facility 65 here, or in the handler?)
> >>>>>
> >>>>> That response code 0x01 thingy probably needs to go into the specific
> >>>>> handler function, if anywhere (don't know the semantics, sorry).  
> >>>>
> >>>> What do you mean with specific handler function?
> >>>>
> >>>> If you mean a switch around the FC with static function's call, I agree,
> >>>> if you mean a jump into a hook I do not agree.  
> >>>
> >>> Ah, ok; so each case (that we want to handle) should call into a
> >>> subhandler that does
> >>> {
> >>>     (... check things like facilities ...)
> >>>     if (!specific_hook)
> >>>         inject_specif_excp_and_return();
> >>>     ret = specific_hook();
> >>>     if (ret)
> >>>         set_resp_code_0x01(); // or in specific_hook()?
> >>> }
> >>>
> >>> ?  
> >>
> >> Yes something in this direction.  
> > 
> > Sorry, after reflection, no, we do not want to change the previous behavior so we only handle the AQIC case.  
> 
> I think what you wanted to say is the following:
> Today (without the patch set) we will answer PQAP with an exception.
> With this patch set we want to handle FC==3, but nothing else. So for anything FC!=3 we
> will continue to return an exception?
> 
> Correct?
> 

That sounds reasonable; but I don't see how this conflicts with my
proposal? Just don't introduce a subfunction for fc != 3...
