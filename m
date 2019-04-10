Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB0C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565B120850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r5KrsWVT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r5KrsWVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDJEEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:04:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35956 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfDJEEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:04:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E9AD38EE0ED;
        Tue,  9 Apr 2019 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554869063;
        bh=t3y1vE6FUMXCSXVPQz88VgiX94Y2RBfU/N2zmJMsjno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r5KrsWVTQ96FoADiNTLKEIQD8pNo9DA3HNtns77QPd7cpJsxBewOOqO/59juAxcMb
         Njt4i6vMr+aqqzWIschM3NhaXwnHO236ZrLgNkXZjO5q8GHgbUnPf7+yNkDx+Og3+6
         liAkw3a07Nd/CzLi3G4oSki0b2c+LavLklbLJcvA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bDELDNnZ4ybj; Tue,  9 Apr 2019 21:04:23 -0700 (PDT)
Received: from [10.130.243.102] (unknown [195.77.194.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 68BE58EE03B;
        Tue,  9 Apr 2019 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554869063;
        bh=t3y1vE6FUMXCSXVPQz88VgiX94Y2RBfU/N2zmJMsjno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r5KrsWVTQ96FoADiNTLKEIQD8pNo9DA3HNtns77QPd7cpJsxBewOOqO/59juAxcMb
         Njt4i6vMr+aqqzWIschM3NhaXwnHO236ZrLgNkXZjO5q8GHgbUnPf7+yNkDx+Og3+6
         liAkw3a07Nd/CzLi3G4oSki0b2c+LavLklbLJcvA=
Message-ID: <1554869059.3208.0.camel@HansenPartnership.com>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Date:   Wed, 10 Apr 2019 06:04:19 +0200
In-Reply-To: <yq1tvf6myp6.fsf@oracle.com>
References: <20190409162749.7eb6656f@canb.auug.org.au>
         <20190410112138.178aa7bd@canb.auug.org.au> <yq1tvf6myp6.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 21:33 -0400, Martin K. Petersen wrote:
> Stephen,
> 
> > > I have reverted that commit for today.
> > 
> > This has now migrated to the scsi tree.
> 
> I have a fix in my tree but I haven't pushed it yet.

It's upstream in both trees now.

James

