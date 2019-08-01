Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E6C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7720B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ui73Jo/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfHATui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:50:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33122 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfHATui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:50:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id u15so54965547oiv.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FWtSgzRD4bHrWCNNgJRr3LQVys4kFqT4AsZYk1+5PU=;
        b=ui73Jo/4/huIvxvzrGT6zAMrXY2OVPod58pVaM1xjpAa6z4vw54kNetazl/71za763
         7HJ7eUOq/T5JDdsHX9DvAI4ifl22hscvfd8MKkYBtOuyG8q/1xomAP1EWo72JXODdzXv
         8J7wgO/Fe5tr4w3PQqfn+qqPNpkvQbo9EljAJ9uTfXvW6fD4gKAfybd4ShFKjXt7dMh/
         8anwkXE/rca9UJQ8iDBEmt/FwuV8Nx1CYADNtUz/ZPMtdrNgyvKlmrpqUMS0KITD08jv
         qPmXAnmuIjHI4lV4ZlqmLYymJAAtM7ioxzNfyDVJ/WWs8a6zGKgiMNkO40APY5av+jR5
         dPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FWtSgzRD4bHrWCNNgJRr3LQVys4kFqT4AsZYk1+5PU=;
        b=Xghgdl25teBfE2u8S5MAjKmB2PbFV/Q1fF5zbKBURr0xNsqvH0YQwAWOntR1DOMCGK
         FmJjXms4+alBJdMjtq7qG6l+cqyNZ/Ie5RbENRyZV7YK+dXXb7WtYBA/6YaXaVGhoefK
         4AgbgwWb2M08dswMDTu5fN+4UntHD8Up5mvhG8He5iapMNlObpr+t4LhxykUbEkenf7N
         Pb684iiJHiIV2A3ds6Abh1yEX49d6YgHv6h40qStWAcRe8FGoX7vtV7aOAMhIqGxlMME
         PnTfoHTYaLzimzbVFJXvpIDm0Cm0mnUhxh9IzJqxqCCsg8nRlBmox0j1RZM9HGGKBF0w
         KOHA==
X-Gm-Message-State: APjAAAXYwUxDkl4j9kV8zQPIo3LJRcLI4sMDs8SH0pnmEnW9ObjPbVsZ
        St9YochMgfZfxv1+H4d0V5gzRsXVbG5Cn9fnzIE=
X-Google-Smtp-Source: APXvYqzKWvVMME8K4tc58thnPzpWYQeXjmQmuceEAqCtv5bexvVsFzjvB8ZcDWVDYqECcq2QFOdhHYQchyVxoBgKt44=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr369657oig.18.1564689037172;
 Thu, 01 Aug 2019 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com>
In-Reply-To: <5d42281c.1c69fb81.bcda1.71f5@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Thu, 1 Aug 2019 12:50:25 -0700
Message-ID: <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 4:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-07-31 16:10:38)
> > On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> > >
> > > On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > That's not my point (see below).
> > > >
> > > > > > > > +       if (id < 0)
> > > > > > > > +               return id;
> > > > > > > > +       ws->id = id;
> > > > > > > > +
> > > > > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > > > +                                       wakeup_source_groups, "ws%d",
> > > > > > >
> > > > > > > I thought the name was going to still be 'wakeupN'?
> > > > > >
> > > > > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> > > > >
> > > > > "ws%d" here is the name in the sysfs path rather than the name of the
> > > > > wakeup source. Wakeup source name is not altered in this patch.
> > > > >
> > > >
> > > > So why wouldn't something like this suffice:
> > > >
> > > > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> > > >
> > > > ?
> > >
> > > ws->name is inherited from the device name. IIUC device names are not
> > > guaranteed to be unique. So if different devices with the same name
> > > register wakeup sources, there is an error.
> >
> > OK
> >
> > So I guess the names are retained for backwards compatibility with
> > existing user space that may be using them?
> >
> > That's kind of fair enough, but having two different identification
> > schemes for wakeup sources will end up confusing.
>
> I understand your concern about the IDA now. Thanks for clarifying.
>
> How about we name the devices 'wakeupN' with the IDA when they're
> registered with a non-NULL device pointer and then name them whatever
> the name argument is when the device pointer is NULL. If we have this,
> we should be able to drop the name attribute in sysfs and figure out the
> name either by looking at the device name in /sys/class/wakeup/ if it
> isn't 'wakeupN', or follow the symlink to the device in /sys/devices/
> and look at the parent device name there.

This makes it difficult for userspace to query the name a wakeup
source, as it now has to first figure out if a wakeup source is
associated with a device or not. The criteria for that is also
awkward, userspase has to check if directory path contains "wakeupN",
then it's a virtual wakeup source.

IMO it's cleaner to consistently have /sys/class/wakeup/wakeupN/name
for every wakeup source.
