Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E8C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E7821707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="TSNNeF/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404912AbfGHUPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:15:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44103 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404799AbfGHUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:15:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so11795559lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q2/rC+X6yKcx0fkaxjN7H0BsXdkViaefBc4lpUZqdtg=;
        b=TSNNeF/SB7mryv3kPjBwLncUvhieZnXh8iFH92xhPGPysNiNQoeKJE5qj8IB7Z5BZW
         UMby29lUeRqccPhcSnzqaoSrfZIHocEjbxdg484y3UxR57QTR6vybYFSlVA6OISOkAJf
         XBcB2o9O7m5+vT8eP7+iT6K3smA9RqmnYVGfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q2/rC+X6yKcx0fkaxjN7H0BsXdkViaefBc4lpUZqdtg=;
        b=eSK8NAU4Lieq9l+lZARrprSgwSL/k/gbIQEHffaaYr7sd1T7w5SNQtzF5RjeQWwu6u
         eASUbAbUiI+I8pFaLnjnLs+ruH/jf4/qOW6jNH5wvRoWNogHZ0A5p/tPL/aNVpBE/f1I
         QdDRlB5t7xoihSJks4oBrry3Mhwu0L88GNV154VR9/hK7TkAIdcNd4mZESM9BM01G8gz
         vCv/gXZQwJZp8yZGc2dPjqSOrc3cT7xRXtXh/vP/VwSvvR9PuHFyot4nzYjc3s4ZeLdV
         qvLC/s1Ev2KaLEB0e9pWKJ2MKzf+be3VZFdR83d75zJgwJjdxebu7lcpVsQLC+RjrwEf
         pdaw==
X-Gm-Message-State: APjAAAUULCt3CU2aaQvHiFFj5w9otE5RVCReuGpbEvObOx9r48j6Qcx0
        ehF5f78xscKYPJmp0yqa1X8FfQ==
X-Google-Smtp-Source: APXvYqyVe6l6QxTV00tB/7TZDsbLAToaMqslKFjf3c5kn1KSK2kw7x2QWom//FIicKUaq+Zq8aK5Cg==
X-Received: by 2002:a19:5044:: with SMTP id z4mr9273020lfj.80.1562616918960;
        Mon, 08 Jul 2019 13:15:18 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id c12sm2842062lfj.58.2019.07.08.13.15.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 13:15:18 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:15:10 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: kvm: Convert cpuid.txt to .rst
Message-ID: <20190708201510.GA13296@luke-XPS-13>
References: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
 <e8cd24f40cdd23ed116679f4c3cfcf8849879bb4.1562448500.git.lnowakow@eng.ucsd.edu>
 <20190708140022.5fa9d01f@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708140022.5fa9d01f@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 02:00:22PM -0600, Jonathan Corbet wrote:
> On Sat,  6 Jul 2019 14:38:14 -0700
> Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu> wrote:
> 
> > From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
> > 
> > Convert cpuid.txt to .rst format to be parsable by sphinx. 
> > 
> > Change format and spacing to make function definitions and return values
> > much more clear. Also added a table that is parsable by sphinx and makes
> > the information much more clean. 
> > 
> > Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
> > ---
> >  Documentation/virtual/kvm/cpuid.rst | 99 +++++++++++++++++++++++++++++
> >  Documentation/virtual/kvm/cpuid.txt | 83 ------------------------
> >  2 files changed, 99 insertions(+), 83 deletions(-)
> >  create mode 100644 Documentation/virtual/kvm/cpuid.rst
> >  delete mode 100644 Documentation/virtual/kvm/cpuid.txt
> > 
> > diff --git a/Documentation/virtual/kvm/cpuid.rst b/Documentation/virtual/kvm/cpuid.rst
> > new file mode 100644
> > index 000000000000..1a03336a500e
> > --- /dev/null
> > +++ b/Documentation/virtual/kvm/cpuid.rst
> > @@ -0,0 +1,99 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> 
> Do you know that this is the appropriate license for this file?  If so, you
> should say how you know that.  I appreciate that you thought to add the
> SPDX line, but we have to be sure that it actually matches the intent of
> the creator of this file.
> 

I do not know what the authors intent was. You are right. This is not my
work after all. Ill remove it in the next version.

> > +==============
> > +KVM CPUID bits
> > +==============
> > +
> > +:Author: Glauber Costa <glommer@redhat.com>, Red Hat Inc, 2010
> 
> I rather suspect that email address doesn't work these days.
> 

No I guess it wont :). We would still keep this correct? 

> > +A guest running on a kvm host, can check some of its features using
> > +cpuid. This is not always guaranteed to work, since userspace can
> > +mask-out some, or even all KVM-related cpuid features before launching
> > +a guest.
> > +
> > +KVM cpuid functions are:
> > +
> > +function: **KVM_CPUID_SIGNATURE (0x40000000)**
> 
> I wouldn't add the **markup** here, it doesn't really help.
> 

My intent was to make the "function" part more readable immediately
because otherwise it sort of looks like a wall of text. I might have
gotten a little too fancy here though. 

> > +
> > +returns::
> > + 
> > +   eax = 0x40000001
> > +   ebx = 0x4b4d564b
> > +   ecx = 0x564b4d56
> > +   edx = 0x4d
> > +
> > +Note that this value in ebx, ecx and edx corresponds to the string "KVMKVMKVM".
> > +The value in eax corresponds to the maximum cpuid function present in this leaf,
> > +and will be updated if more functions are added in the future.
> > +Note also that old hosts set eax value to 0x0. This should
> > +be interpreted as if the value was 0x40000001.
> > +This function queries the presence of KVM cpuid leafs.
> > +
> > +function: **define KVM_CPUID_FEATURES (0x40000001)**
> > +
> > +returns::
> > +
> > +          ebx, ecx
> > +          eax = an OR'ed group of (1 << flag)
> > +
> > +where ``flag`` is defined as below:
> > +
> > ++--------------------------------+------------+---------------------------------+
> > +| flag                           | value      | meaning                         |
> > ++================================+============+=================================+
> > +| KVM_FEATURE_CLOCKSOURCE        | 0          | kvmclock available at msrs      |
> > +|                                |            | 0x11 and 0x12                   |
> 
> You might consider using the
> 
>     ======= ===== ======
>     simpler table format
>     ======= ===== ======
> 
> here, it might be a bit easier to read and maintain.
>

Understood. 

> Thanks,
> 
> jon

Thanks for the review, 
- Luke
