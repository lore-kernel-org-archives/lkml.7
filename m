Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8CCC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0257224BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CecSWFJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfKTMKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:10:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24498 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbfKTMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574251804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knFBJ+jIledi9b7Ia4deKRuiHotpqtnvRJzVLFu8J74=;
        b=CecSWFJeDa2330RCBeYrqMKU5Qlb17mU2xfUcHP0NdImDrsZVUiJkMjT4gfmyd8i303HPe
        furWfkp9gNlZ/Ro/7LAFGxQNu2ZRJ58WhzHQ3LnFoBbwpPnt5yEKsUPHRxYzCsNEvEzi+p
        +fDD46WQEy6IzSNj2fFMA2cFkWE5BFM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-F3ySAK5aNzyjVecbZRnG9w-1; Wed, 20 Nov 2019 07:10:03 -0500
Received: by mail-qv1-f70.google.com with SMTP id d12so16965182qvj.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7p4rYZMTKBgx0gRU2Y/8e1TMHUDBS8YuAIk55PkbbCM=;
        b=SF3uCSOhdWCELp5PvOGABe3zF+yrB8Do6Dt+q8wstL4gk5tBZMeU1AGTPwikhv8AWa
         I0wE6A1xEUq/i+30Oy7Nc5hWq7wFp8NKTS+nPfVkZMIBTj11TIKIUVvTouMoeeXmveR8
         eew9WhKoVDq17FV1yxk2wz8XSBRDJCMbLc+L8J2DnNL3ysxfrVdhxyag8r/tQ8oCKYJR
         ypc/xuuHo93FaUVf6DNsemi7dpMu6UmXiD1C6aih0+7lQDl6rqvUfT9iqrHKpFC5HkL5
         ee6IXBBvNVJ5F1wDpJ3zMnke2kxUez3NWMd40fw5+Jh79dyyz8HVNQjAVuE4vLQ4sMwd
         AsMA==
X-Gm-Message-State: APjAAAUOA1HfPtFbe7TxNvp7QaXOVm1HQcGhoFJGO7+EqS7ezruWcrJc
        Ex+aQzXqALkwAw3WXlkLJXc8cXRQLpNFo+GW1GxXx2HcDkF7fq/5NNHWI4h0LEiQKRiowbVJPMu
        +jEpco+INdQJN+9GJt8QJvYlyn5upbaR1qqvzissx
X-Received: by 2002:a37:9083:: with SMTP id s125mr2035563qkd.192.1574251802834;
        Wed, 20 Nov 2019 04:10:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4S4Yg7VICuKWth27RQHwQbnKmUWBvPlof4TRp3+1St7VECDM0n728MYoDSOHL10176AueXActPrjMWKfP+xo=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2035532qkd.192.1574251802589;
 Wed, 20 Nov 2019 04:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com> <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:09:51 +0100
Message-ID: <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: F3ySAK5aNzyjVecbZRnG9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> =
wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
>
> [cut]
>
> > > > >
> > > > > Oh, so does it look like we are trying to work around AML that tr=
ied
> > > > > to work around some problematic behavior in Linux at one point?
> > > >
> > > > Yes, it looks like so if I read the ASL right.
> > >
> > > OK, so that would call for a DMI-based quirk as the real cause for th=
e
> > > issue seems to be the AML in question, which means a firmware problem=
.
> > >
> >
> > And I disagree as this is a linux specific workaround and windows goes
> > that path and succeeds. This firmware based workaround was added,
> > because it broke on Linux.
>
> Apparently so at the time it was added, but would it still break after
> the kernel changes made since then?
>
> Moreover, has it not become harmful now?  IOW, wouldn't it work after
> removing the "Linux workaround" from the AML?
>
> The only way to verify that I can see would be to run the system with
> custom ACPI tables without the "Linux workaround" in the AML in
> question.
>

the workaround is not enabled by default, because it has to be
explicitly enabled by the user.

