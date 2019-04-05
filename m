Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EC52184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rlFHpGeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDEEww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:52:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44738 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfDEEwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:52:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 18B108EE12C;
        Thu,  4 Apr 2019 21:52:51 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hkgxeMu99DMi; Thu,  4 Apr 2019 21:52:50 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 83EAD8EE03B;
        Thu,  4 Apr 2019 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554439970;
        bh=cNWVCotOzkN8JshvEU0GwzGg9x/N/sNQd+FajbwMyWw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rlFHpGehm7pgmJmnSRW4KyZ997pxlr+pTDvskj7n/HN4Eg5pEz3I/B12ULnRrKGzS
         EdHxsH3m52n8ltqPKDYR8DOzyF+tT5dWCW+BlD9i5kKwsFlSMXYgRZFQ/FgoQKpTCb
         tNvca1ffzwi7hmlK6PuPE7FGAU0alA/Pl8Joo01c=
Message-ID: <1554439969.24612.41.camel@HansenPartnership.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Thu, 04 Apr 2019 21:52:49 -0700
In-Reply-To: <a1d4b608-a077-a757-9407-5cde4681e3af@acm.org>
References: <20190405142347.1f264cdf@canb.auug.org.au>
         <a1d4b608-a077-a757-9407-5cde4681e3af@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-04 at 21:30 -0700, Bart Van Assche wrote:
> On 4/4/19 8:25 PM, Stephen Rothwell wrote:
> > Hi James,
> > 
> > After merging the scsi tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> > 
> > drivers/scsi/lpfc/lpfc_nvme.c:2140:1: warning:
> > 'lpfc_nvme_lport_unreg_wait' defined but not used [-Wunused-
> > function]
> >   lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Introduced by commit
> > 
> >    3999df75bccb ("scsi: lpfc: Declare local functions static")
> > 
> > It use is guarded by IS_ENABLED(CONFIG_NVME_FC).
> 
> I will have a closer look at this tomorrow.

In the meantime, we can just revert the patch.  Making functions static
serves no real purpose except it does tell the compiler they have to be
used internally which is where the problem is coming from.  Once the
issue is sorted, the static patch can be reapplied.

James

