Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D6C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A67220673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YgTkFvh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgAHBjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:39:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38222 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgAHBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:39:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so2028894otf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d9k45/z7659u+xtEjN+MYx3Q6GpIJRf/rpR3Gk/DdU=;
        b=YgTkFvh6k7M6dHhTjbBTUDG+NIIUI6w5fWZZA+SRtfvALbUkv5kvWYonJKu3sSN8bN
         b+37/Q5KLz31UR0SYudLvDmy3JK9UFCkDIiMhXQQj3dHQVUjo9J9ywjL/XUPmwYswP+/
         xeZnbYsjQkynkvVrvx19nSACawRXUpVW3q/vIubfYBFV7v5sMRYWA0QCbBX53/Lh0Y7W
         ilS3gDYmvch66jqOGL1GQp/MCtciI6dWOmQeI8tXQSnJmFLQE2FOeA4lxSiGMCYIgXRf
         1q2zJd9/QHTXMPJFdyvYajbTtvIkBgU7ptveduecznGjcWJeA/35nNkhH+y9tInkFeK1
         ra9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d9k45/z7659u+xtEjN+MYx3Q6GpIJRf/rpR3Gk/DdU=;
        b=RD7LVQkFhBXBivF22wpZEpLVonmBKmVTq8G9D1+LykFBQrH1t7elrNMgO/BcX/TX2p
         OFnM/GPsjD2w9/08fcJa3hHu/ZqNywSRjTQiltOwdB2XDpZgY1XZSM/Qd4mbDjSEL2HY
         R1FOLxtG99LY4lKilhVNfZRwgrwXpCu4FvleIeYZrEmG0VWbeKK0tYgr1TXuepAu7j06
         1aoLOXYoXv4Ok0aiD1bWFpIC8V3j6Q7BPlS81uWjCt4hjkmvzchCVylNwrdDO9uhBnWu
         xPosyvxT2kkVBzzZbTJKJlz3lIL7yLh+rg7+ZuM0c57hKtC9J+8XuDBXEsarJkgIZ9sU
         //JQ==
X-Gm-Message-State: APjAAAV0EjsSp/ptEBLjLunkDEs821JJTCQKCaJIDfk9ouOwIC23pW7o
        dV/MlB89Xh3nSuGLKn7fREem6kT0pukieQboX9/+Tw==
X-Google-Smtp-Source: APXvYqxdf0Bo2pMJ9s40oQqu9673Krm3/AIHd7ihdu+tmuZao9+mHEVhrRD0TY+1uOwKKPxbusMCMUEGKxcHJtyvZxo=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr2328311oto.207.1578447579439;
 Tue, 07 Jan 2020 17:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20191212182238.46535-1-brho@google.com> <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com> <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com> <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com> <e012696f-f13e-5af1-2b14-084607d69bfa@google.com>
 <20200107190522.GA16987@linux.intel.com> <08a36944-ad5a-ca49-99b3-d3908ce0658b@google.com>
 <20200108012014.GF16987@linux.intel.com>
In-Reply-To: <20200108012014.GF16987@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jan 2020 17:39:28 -0800
Message-ID: <CAPcyv4jW3HTU7mmctL_d+zTS8yT_NLxa5cx_w8nbqVSwBMdSLQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Barret Rhoden <brho@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zeng, Jason" <jason.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 5:20 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jan 07, 2020 at 02:19:06PM -0500, Barret Rhoden wrote:
> > On 1/7/20 2:05 PM, Sean Christopherson wrote:
> > >Hopefully you haven't put too much effort into the rework, because I want
> > >to commandeer the proposed changes and use them as the basis for a more
> > >aggressive overhaul of KVM's hugepage handling.  Ironically, there's a bug
> > >in KVM's THP handling that I _think_ can be avoided by using the DAX
> > >approach of walking the host PTEs.
> > >
> > >I'm in the process of testing, hopefully I'll get a series sent out later
> > >today.  If not, I should at least be able to provide an update.
> >
> > Nice timing.  I was just about to get back to this, so I haven't put any
> > time in yet.  =)
> >
> > Please CC me, and I'll try your patches out on my end.
>
> Will do.  Barring last minute hiccups, the code is ready, just need to
> finish off a few changelogs.  Should get it out early tomorrow.
>
> One question that may help avoid some churn: are huge DAX pages not
> tracked as compound pages?  The comment from your/this patch is pretty
> unequivocal, but I wanted to double check that they will really return
> false for PageCompound(), as opposed to only returning false for
> PageTransCompoundMap().

PageCompound() returns false.

>
>         /*
>          * DAX pages do not use compound pages.  ...
>          */
>

None of the head / tail page infrastructure is set up for dax pages.
They are just independent 'struct page' objects that are
opportunistically mapped by different pte sizes in the dax core.
