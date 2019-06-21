Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F85C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9612070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tw4tco25";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QU4p2pKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFUAfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:35:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48054 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfFUAfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:35:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4B6D18EE109;
        Thu, 20 Jun 2019 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561077344;
        bh=4SybJ64WRzbF81D+u3E9E1lNdPTnhgguApMd3wSkw38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tw4tco25cgbnb+/WKfb8+z2HKiGks93PhclKKf5NdrelPDYy44Q4RwZgfvH3TvKq3
         0z/uaAv/y4xlAIKH+DGJT72I1+LIrpXA4jFjEPw3af/fLExbI7dzmLIzWCsnI6znpg
         DmhQuvQbaIH/xnJnwKvAGcRoNVYZQ8sUV7uEwAFk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UMYu4CxO6Nxh; Thu, 20 Jun 2019 17:35:44 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7D9CF8EE0CF;
        Thu, 20 Jun 2019 17:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561077343;
        bh=4SybJ64WRzbF81D+u3E9E1lNdPTnhgguApMd3wSkw38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QU4p2pKft3QyAscZ7C2T5smYqAWqaxb2ax2/Thov2rf1hr91Biv+hgDa1WfQEMcnh
         OVH7Rk74TYnC2vfAa/SGCzZ3rje2HugUo9Pav0oCrOwwMtQSgWIERznHtoMXywV3gG
         L7ch6tfa0GaKSL3ua1yDr2SOZxHm8jcvIm2XuPNo=
Message-ID: <1561077341.7970.47.camel@HansenPartnership.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Thu, 20 Jun 2019 17:35:41 -0700
In-Reply-To: <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
References: <20190522100808.66994f6b@canb.auug.org.au>
         <20190528114320.30637398@canb.auug.org.au>
         <20190621095907.4a6a50fa@canb.auug.org.au>
         <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 17:07 -0700, Linus Torvalds wrote:
> On Thu, Jun 20, 2019 at 4:59 PM Stephen Rothwell <sfr@canb.auug.org.a
> u> wrote:
> > 
> > At what point does it become worth while to do a back merge of
> > v5.2-rc4 (I think the last of the SPDX changes went into there) to
> > take care of all these (rather than Linus having to edit each of
> > these files himself during the merge window)?
> 
> For just trivial conflicts like this that have no code, I really
> would prefer no backmerges.
> 
> That said, I would tend to trust the due diligence that Thomas, Greg
> & co have done, and am wondering why the scsi tree ends up having
> different SPDX results in the first place..

There's two problems.  One is simple terminology: the
Documentation/process/licence-rules.rst say:

GPL-2.0 means GPL 2 only
GPL-2.0+ means GPL 2 or later

I believe RMS made a fuss about this and he finally agreed to 

GPL-2.0-only
GPL-2.0-or-later

It's just the kernel doc hasn't been updated so Christoph did what the
doc says when making the change and Thomas did what we've apparently
agreed to with RMS, hence textual discrepencies.

The other problem is actually substantive: In the libsas code Luben
Tuikov originally specified gpl 2.0 only by dint of stating:

* This file is licensed under GPLv2.

In all the libsas files, but then muddied the water by quoting GPLv2
verbatim (which includes the or later than language).  So for these
files Christoph did the conversion to v2 only SPDX tags and Thomas
converted to v2 or later tags.  Based on somewhat distant recollections
of history, I believe Christoph is right on this one.

James

