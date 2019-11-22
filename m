Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79414C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5062420674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="am0gFJ8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKVLbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:31:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbfKVLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574422273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fk7+9wRBOnitbINGrkgws0BRV6i2F3wIBf4jxMH1Ew8=;
        b=am0gFJ8oeeamkBk6LbGJJjIR16i4lD2AgkGK/Lew+mQJu3LeF0QjX6EedNCirWm1GcTCpN
        +r0+Wp+OShB7sFTxB2hFN280xwYt5/5tz3phIZ0YCwEzZsArAgOndBUz0KE5CeaoFf0l5/
        hooHNre2ZCJbLrwGTKvPwP7W4hKHQWM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-SgPYKJRZPECIjFEnqzMu7A-1; Fri, 22 Nov 2019 06:31:04 -0500
Received: by mail-qk1-f198.google.com with SMTP id q125so4125610qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 03:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aur9rsWegbHLh3oY6ky2CGYiseXs+N84XUMnQYfdl6g=;
        b=g0d7x3X+kH3EO6ndr68V1fdyWmKM9/vWdjs4tS1D/nE1P4HCaWTYcLsWTLDU99Nrl5
         8ob8sE623q46ys0CLilW9JWvlImwM32QMZV0O3nWX36Q+24VhvvCgz2EB/v++SBdt4d+
         5XoZ5JcFnpoTtx7k5wxq3t73V9f9ZVjDdASI3JhSwrmnDEElMIcVSuGC3JKebO5LVS7p
         oQ8Yuxl7vWvupS3+A0UoSW7KP96CmD1FieWplMjNSGSoTl/fLG2xbKdEtqwzEBVFhnnH
         7pOqbvRXlqMv3HARBL82hU5BqYRKxfJ2CZYc9eaSCaACPuMiX0SMOnrOvoCflT81Y9Hr
         NaeQ==
X-Gm-Message-State: APjAAAX73H8BowJ1YAH2uoam4K28830JQqLX/NpMfbfO5qEJktsxrXaE
        eJpirp9z8of4Gpls6qjlgN1T7swMYdH5XVHJUyR4xd4zLexSS3jas5Po6URYbkAz7ODsNKkbleQ
        vVeJqF44lbLUTRlWWvcZRm6QvA/XZ3iwjdkbF5MVA
X-Received: by 2002:ac8:5557:: with SMTP id o23mr13894108qtr.378.1574422264297;
        Fri, 22 Nov 2019 03:31:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4tUnanEcz7OF5qm09oSIPeTrgesqROQcAYMdb3VQX3IrvgvC0XjOQgTAq+ByslNwLSUis/BX58JFkAfiwgdw=
X-Received: by 2002:ac8:5557:: with SMTP id o23mr13894072qtr.378.1574422264060;
 Fri, 22 Nov 2019 03:31:04 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <CACO55tvFeTFo3gGdL02gnWMMk+AHPPb=hntkre0ZcA6WvKcV1A@mail.gmail.com>
 <CACO55tvkQyYYnCs71_nJuNFm4f8kkvBqje8WeZGph7X+2zO3aA@mail.gmail.com> <CAJZ5v0jNq77xPXxeYeq_JJBCfekVPVPOye1mZwpQi=+=MKSS7w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jNq77xPXxeYeq_JJBCfekVPVPOye1mZwpQi=+=MKSS7w@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 22 Nov 2019 12:30:52 +0100
Message-ID: <CACO55tue979AjxXO0MsOMVzUYvVaLh3rMDVg43=kqz=-OpW3Jw@mail.gmail.com>
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
X-MC-Unique: SgPYKJRZPECIjFEnqzMu7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:07 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Fri, Nov 22, 2019 at 1:13 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > so while trying to test with d3cold disabled, I noticed that I run
> > into the exact same error.
>
> Does this mean that you disabled d3cold on the GPU via sysfs (the
> "d3cold_allowed" attribute was 0) and the original problem still
> occurred in that configuration?
>

yes. In my previous testing I was poking into the PCI registers of the
bridge controller and the GPU directly and that never caused any
issues as long as I limited it to putting the devices into D3hot.

> > And I verified that the
> > \_SB.PCI0.PEG0.PG00._STA returns 1, which indicates it should still be
> > turned on.
>
> I don't really understand this comment, so can you explain it a bit to
> me, please?
>

that's the ACPI method to fetch the "status" of the power resource, it
should return 0 when the device was powered off (the GPU) and 1
otherwise.

