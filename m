Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22780C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF12075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561075664;
	bh=F0RJup2dvaTl58+4clVYeHCpyFz0GuLGSTYU0fqgXvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qADP1lvuVsXvEndJYxlwsCwU++kunEs+kgINaS2zsSwrFiIF/0uw+M7D+gDLOC4d8
	 Xe/7mNuuQo7BsPiC6vbT8VfwnEcoKugpxK3oS+jiTqpB1aEPDhyZrbLjaHrj+X3V7S
	 3Ev41IfyqDwuql+C3pK/bdika3LUf5K28WIgeooM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfFUAHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:07:42 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40563 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:07:41 -0400
Received: by mail-lf1-f54.google.com with SMTP id a9so3679489lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2z2u574W9H71BioYVxLQ0ozgxvmOVS9ZyuXKTynCQ8I=;
        b=eOYdft4VCOo1FjwQ83dZ9VZGvR/D+h+ysV8dTzc6d3lCPpwPy4PFUttAcLDdDTNmtV
         5wENLEbsDTZAkJzA7xaOEBCxkFvMReHYVkdBdeUIC8ba/5mU9mSYbDhp9jGLS6WOz8nr
         P4fPq8bVR1aMtzI71pdeWLxLHYJHDCFgdOR4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2z2u574W9H71BioYVxLQ0ozgxvmOVS9ZyuXKTynCQ8I=;
        b=tq+hByhsPwM8N/T9aMDyDZVqiSTukYrhcvELUs50zIWQ/ejx1j+Cq+j5E/Zp0VL2ip
         A5D+VgdENRmZSq06TQNE26DHi8yevKuJiVUPLcS3h0hkiQEldWQBWubajJ/3IYRF0EFL
         ZQ6VcOgDzQ5y8opbxOdZuR0hMKOfKW03BFEUd/HFOiEm+pxRyskEZtzhSFGYZBbPSGya
         j+aB3Bs6UXLyPp7y49mqpb32u7bMCMxCId+mUBxgWE3rbXX5zCfa2V/uTQ4cd3kqhCb3
         Xceb8Vanq7hD0xae074s0DZid3wkkxvYU2ehK8/gLxOxtbHdvjPfNyGbohbLwbJAEjBN
         TgvQ==
X-Gm-Message-State: APjAAAVSPUkCxRrMSWOrZMdS/eOHpS+0EnznJ+2Zzlo91sdETiqRj4p1
        l05McL00sW8PCzO4MAvsnEP47uckRpA=
X-Google-Smtp-Source: APXvYqwqrY+E4MtAqJgb5pWz9SS3Iak1DrKesVZaPnbZreheWXOM2Xppjv7GpqgMEZXshx2vgerPsw==
X-Received: by 2002:a19:7905:: with SMTP id u5mr66217016lfc.117.1561075659594;
        Thu, 20 Jun 2019 17:07:39 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k82sm152933lje.30.2019.06.20.17.07.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 17:07:36 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 16so4305207ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 17:07:36 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr7451510ljm.180.1561075656161;
 Thu, 20 Jun 2019 17:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190522100808.66994f6b@canb.auug.org.au> <20190528114320.30637398@canb.auug.org.au>
 <20190621095907.4a6a50fa@canb.auug.org.au>
In-Reply-To: <20190621095907.4a6a50fa@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jun 2019 17:07:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
Message-ID: <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> At what point does it become worth while to do a back merge of v5.2-rc4
> (I think the last of the SPDX changes went into there) to take care of
> all these (rather than Linus having to edit each of these files himself
> during the merge window)?

For just trivial conflicts like this that have no code, I really would
prefer no backmerges.

That said, I would tend to trust the due diligence that Thomas, Greg &
co have done, and am wondering why the scsi tree ends up having
different SPDX results in the first place..

             Linus
