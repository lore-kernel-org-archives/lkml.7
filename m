Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B6C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5538207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 23:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQhT8V6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfL1XkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 18:40:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbfL1XkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 18:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577576421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Is3zCMnykm3YLB/25LcQIuM+CSYuIJcnmCpT0uGhuGA=;
        b=QQhT8V6iDiWAcnIABm6XtyhMlWHsmokSbTWfCLAOqB0D13RwJKxf8iHiXr0ZTQuNxGoH+6
        qyJtYKebI6cRpcj4W2TPGxxk5ic+zDbhlbVSdTJ9/mIfgot0VxmiSs4LpHjIhJtH1/mK/u
        tDQh79mapzmltP7yK0zCY6xHYsAXjTg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Evc_6CMBMyGlzQVpu-K4ew-1; Sat, 28 Dec 2019 18:40:19 -0500
X-MC-Unique: Evc_6CMBMyGlzQVpu-K4ew-1
Received: by mail-lj1-f198.google.com with SMTP id v1so2670984lja.21
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 15:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is3zCMnykm3YLB/25LcQIuM+CSYuIJcnmCpT0uGhuGA=;
        b=tI6hf3mD8JL0N4AtjLC7rQXIfIotfcm7TO9ZuuN3H8kMnRRvaTmgvM7FwLSpBjn3AV
         nJ4KkiHKyNMnA2V6VAnxrIS/UcPEUl9ByFBuUgXrVLgISNEEma1X5pYu8pLWvqHYWHhH
         jbLyV6PkfkGFkYLmUn77KvmELwLqycwfLgyaUQsJs1iaHSWStO0j5XrzWkKMFx28wU/P
         2xzhfEjyQ+TYgRsKwH3uvQrCnOym4NxwqtwoP7QAAkK62zXnWp6Tn25kBLowwkkJNbF0
         0Ga/PWKwfmMrX3rxS3CrENjhrhYyJ3vnPuGnkj1hYLjXiJId3hEwG11v5f6mJyrX0Xar
         rRTA==
X-Gm-Message-State: APjAAAVib70faYAyi//1NXODMbt4+uu0Boi5gFSQE69o7+BbZLSqPodn
        gv7hkPdD9l/acjtZNSuekl5q46rcAMQ5qbQT33yAEBZrb+ZVCYg16iqwbEV3DMp0hJTz9L1kDBR
        O++VIyB6l27ASKsMqKWWTNTqaN5++1/M/SArOa/Pj
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr31637662ljo.41.1577576418506;
        Sat, 28 Dec 2019 15:40:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOuhqb8WZQbccD0PFPulnZMqC/UpEhWcURSgW+wh+/9jktf1hFRczfhVM4qdeQVKbwlm1pads2IcbsEjsmChg=
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr31637641ljo.41.1577576418278;
 Sat, 28 Dec 2019 15:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com> <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com> <20191228151526.GA6971@linux.intel.com>
In-Reply-To: <20191228151526.GA6971@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Sat, 28 Dec 2019 16:39:53 -0700
Message-ID: <CALzcdduip_XX5cRC662YUgRdb4UqcLSg+pomF29NkZdHep6sbg@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 8:15 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> > Dan, please also test the branch and tell if other patches are needed.
> > I'm a bit blind with this as I don't have direct access to the faulting
> > hardware. Thanks. [*]
> >
> > [*] https://lkml.org/lkml/2019/12/27/12
>
> Given that:
>
> 1. I cannot reproduce the bug locally.
> 2. Neither of the patches have any appropriate tags (tested-by and
>    reviewed-by). [*]
>
> I'm sorry but how am I expected to include these patches?
>
> [*] https://patchwork.kernel.org/project/linux-integrity/list/?series=208305
>
> /Jarkko
>

Hi Jarkko, sorry I've been under the weather the past couple of days.
I will try to get some testing of your branch done tomorrow. I'm
trying to find a system that use tpm_tis and uses interrupts to test
as well.

