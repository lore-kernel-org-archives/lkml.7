Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B652C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FF02186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwyxiPx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfB1ES7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:18:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45663 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1ES6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:18:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id t82so15396592oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 20:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYcUG6WC0M7s1zzaRAYjx0mAZZ16h/4zXB0siEm4NnM=;
        b=dwyxiPx3LguhovjXrpiGWwonMlOId9sN3uVnMtRaWGFcAUruW8CsdspVoYURNH63of
         O+8P4gBW7eBtX/vpUNlPXCjwgGTRNtA9ArCZwmhauOdDPKDY+rl1GXBj/UN6IZhEff8F
         iUK6XbiOnSNl7dcK0d1GsfqMuoKq/BTpJgvcQwsy2ApHZLbvJ6trmR9weELukOqGp9c0
         tVLoymnU8eTAsVvMLrZKXWAo2ZrPr0p+ud+9RrzDlavfMPQdZiWOUm0qJGJU8U+VdqGs
         MB7w91xgRGtkdvjqmUgo9UVQYI3BhExx4dhydutXRN5KSkBBtz59m6rL5xSzT1b6QMgk
         ikgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYcUG6WC0M7s1zzaRAYjx0mAZZ16h/4zXB0siEm4NnM=;
        b=P417iTOB0QV9ktr1FLTmfxAZMR4FGhzluYGrlZGA0Idkmb5l45KZDEKTot3kWftqh8
         H76LArDOOULbBxQAW1YfKPwiRNLG4zuZYRKSlL68rZm154esGc/4+cWDsXda7dH6VZl2
         PeHcwMTLJVMnsLK0yp85Mg6mRugYFtmrq2Re9b8R1xAvUqwfA+sY21FPY0NTL+toSZWn
         BI/4I6CVtcTFRbOh6XiOa2L5Op/JpaF55aXNbM3CNCU5MeWHVTI1bmgn+PhTPfEuJ0sv
         q4FtK8JwHt+EBBmTkG1IfHErGOsl7MTG6XOrjtFnUOd6TDr2YlFtSV+qtQR2+m3OWjx9
         7SsQ==
X-Gm-Message-State: AHQUAuY8hk0xZ66Cmerp0hnz/OjZ4lFv7fzsCxBhwg9hXFo5KivpHhgC
        ZCGFCEwxHvZ+JCaXz+jdhRoctcsOr2diFBIFnwtSHQ==
X-Google-Smtp-Source: APXvYqzq0nFFrCdDG1XkPTBbxflQwPXkq+sRV/se+jTEs/oolhMi7IuqlFjghx64JjA0b/+ox15AH/nfqM8rdMhkCiA=
X-Received: by 2002:aca:7503:: with SMTP id q3mr1738723oic.76.1551327537432;
 Wed, 27 Feb 2019 20:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com> <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
 <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com> <871s3zeeay.fsf@morokweng.localdomain>
In-Reply-To: <871s3zeeay.fsf@morokweng.localdomain>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 27 Feb 2019 20:18:46 -0800
Message-ID: <CAFd5g450Vy73fR5mfbuZe=KUzsFD=NAbg40GbuVmJg2udp3tmQ@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:53 PM Thiago Jung Bauermann
<bauerman@linux.ibm.com> wrote:
>
>
> Frank Rowand <frowand.list@gmail.com> writes:
>
> > On 2/19/19 10:34 PM, Brendan Higgins wrote:
> >> On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >> <snip>
> >>> I have not read through the patches in any detail.  I have read some of
> >>> the code to try to understand the patches to the devicetree unit tests.
> >>> So that may limit how valid my comments below are.
> >>
> >> No problem.
> >>
> >>>
> >>> I found the code difficult to read in places where it should have been
> >>> much simpler to read.  Structuring the code in a pseudo object oriented
> >>> style meant that everywhere in a code path that I encountered a dynamic
> >>> function call, I had to go find where that dynamic function call was
> >>> initialized (and being the cautious person that I am, verify that
> >>> no where else was the value of that dynamic function call).  With
> >>> primitive vi and tags, that search would have instead just been a
> >>> simple key press (or at worst a few keys) if hard coded function
> >>> calls were done instead of dynamic function calls.  In the code paths
> >>> that I looked at, I did not see any case of a dynamic function being
> >>> anything other than the value it was originally initialized as.
> >>> There may be such cases, I did not read the entire patch set.  There
> >>> may also be cases envisioned in the architects mind of how this
> >>> flexibility may be of future value.  Dunno.
> >>
> >> Yeah, a lot of it is intended to make architecture specific
> >> implementations and some other future work easier. Some of it is also
> >> for testing purposes. Admittedly some is for neither reason, but given
> >> the heavy usage elsewhere, I figured there was no harm since it was
> >> all private internal usage anyway.
> >>
> >
> > Increasing the cost for me (and all the other potential code readers)
> > to read the code is harm.
>
> Dynamic function calls aren't necessary for arch-specific
> implementations either. See for example arch_kexec_image_load() in
> kernel/kexec_file.c, which uses a weak symbol that is overriden by
> arch-specific code. Not everybody likes weak symbols, so another
> alternative (which admitedly not everybody likes either) is to use a
> macro with the name of the arch-specific function, as used by
> arch_kexec_post_alloc_pages() in <linux/kexec.h> for instance.

I personally have a strong preference for dynamic function calls over
weak symbols or macros, but I can change it if it really makes
anyone's eyes bleed.
