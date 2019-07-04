Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D664C46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779462184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfGDPce convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:32:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbfGDPcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:32:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66563AF81;
        Thu,  4 Jul 2019 15:32:32 +0000 (UTC)
Date:   Thu, 4 Jul 2019 17:32:31 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        George Wilson <gcwilson@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
Message-ID: <20190704173231.27365b51@kitsune.suse.cz>
In-Reply-To: <0EDE02C7-3716-47A2-B7B0-007025F28567@linux.vnet.ibm.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
        <1562241547.6165.81.camel@linux.ibm.com>
        <0EDE02C7-3716-47A2-B7B0-007025F28567@linux.vnet.ibm.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 19:26:36 +0530
Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:

> > On 04-Jul-2019, at 5:29 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2019-07-03 at 23:32 -0400, Nayna Jain wrote:  
> >> The nr_allocated_banks and allocated banks are initialized as part of
> >> tpm_chip_register. Currently, this is done as part of auto startup
> >> function. However, some drivers, like the ibm vtpm driver, do not run
> >> auto startup during initialization. This results in uninitialized memory
> >> issue and causes a kernel panic during boot.
> >> 
> >> This patch moves the pcr allocation outside the auto startup function
> >> into tpm_chip_register. This ensures that allocated banks are initialized
> >> in any case.
> >> 
> >> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> >> PCR read")
> >> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>  
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>  
> 
> Thanks for the fix. Kernel boots fine with this fix.
> 
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> 

Tested-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal
