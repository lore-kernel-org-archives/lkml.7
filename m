Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B9DC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C3927137
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfFCJIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFCJIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:08:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C3C2308404B;
        Mon,  3 Jun 2019 09:08:47 +0000 (UTC)
Received: from gondolin (ovpn-204-96.brq.redhat.com [10.40.204.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C650C648B1;
        Mon,  3 Jun 2019 09:08:43 +0000 (UTC)
Date:   Mon, 3 Jun 2019 11:08:39 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
Message-ID: <20190603110839.1a44f352.cohuck@redhat.com>
In-Reply-To: <67136b8b-251f-4745-a220-2624aeac289e@redhat.com>
References: <20190531093628.14766-1-david@redhat.com>
        <3dfea8fd-dbe7-f9d0-f7a7-2c65349c0a81@linux.ibm.com>
        <67136b8b-251f-4745-a220-2624aeac289e@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 03 Jun 2019 09:08:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 10:14:53 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 03.06.19 09:48, Harald Freudenberger wrote:
> > On 31.05.19 11:36, David Hildenbrand wrote:  
> >> systemd-modules-load.service automatically tries to load the pkey module
> >> on systems that have MSA.
> >>
> >> Pkey also requires the MSA3 facility and a bunch of subfunctions.
> >> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
> >> any system that does not have all needed subfunctions. For example,
> >> when running under QEMU TCG (but also on systems where protected keys
> >> are disabled via the HMC).
> >>
> >> Let's use -ENODEV, so systemd-modules-load.service properly ignores
> >> failing to load the pkey module because of missing HW functionality.
> >>
> >> Cc: Harald Freudenberger <freude@linux.ibm.com>
> >> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  drivers/s390/crypto/pkey_api.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> >> index 45eb0c14b880..ddfcefb47284 100644
> >> --- a/drivers/s390/crypto/pkey_api.c
> >> +++ b/drivers/s390/crypto/pkey_api.c
> >> @@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
> >>  	 * are able to work with protected keys.
> >>  	 */
> >>  	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
> >> -		return -EOPNOTSUPP;
> >> +		return -ENODEV;
> >>  
> >>  	/* check for kmc instructions available */
> >>  	if (!cpacf_query(CPACF_KMC, &kmc_functions))
> >> -		return -EOPNOTSUPP;
> >> +		return -ENODEV;
> >>  	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
> >>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
> >>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
> >> -		return -EOPNOTSUPP;
> >> +		return -ENODEV;
> >>  
> >>  	pkey_debug_init();
> >>    
> > I can't really agree to this: there are a lot more modules returning
> > EOPNOTSUPP, for example have a look into the arch/s390/crypto
> > subdirectory. The ghash_s390 module also registers for MSA feature
> > and also returns EOPNOTSUPPORTED when the required hardware extension  
> 
> For s390x KVM, we return ENODEV in case the SIE (the HW feature) is not
> available. Just because s390x crypto is doing it consistently this way
> doesn't mean it is the right thing to do.
> 
> Maybe we should change all s390x crypto modules then.

I agree.

> 
> > is not available. Same with the prng kernel module, sha1_s390, sha256_s390
> > and I assume there is a bunch of other kernel modules with same behavior.
> > I would prefer having this fixed on the systemd-modules-load.service side.  
> 
> 
> A very, very bad comparison (because it contains a lot of false positives):
> 
> t460s: ~/git/linux memory_block_devices2 $ git grep -A 20 "_init("  --
> 'drivers*.[c]' | grep ENODEV | wc -l
> 1552
> 
> t460s: ~/git/linux memory_block_devices2 $ git grep -A 20 "_init("  --
> 'drivers*.[c]' | grep EOPNOTSUPP | wc -l
> 56
> 
> No, I don't think EOPNOTSUPP is the right thing to do.

If we frame it as
-EOPNOTSUPP -> operation not supported (i.e. we cannot perform this
operation)
-ENODEV -> no such device (i.e. we're lacking hardware support)

I think -ENODEV makes more sense (even though we could argue for both.)
And it is an easy change to make...
