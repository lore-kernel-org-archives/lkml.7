Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93672175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nVUP5i5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCSXCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:02:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46819 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCSXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:02:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so262984oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoLgzKOhBZS0FoA/bvGhth2HeRfby/EH6YEfcTaXC+g=;
        b=nVUP5i5IAvtqFBTNe+PxuhknsP0XXvasCvVemcgBZZbqhFQoGHYQee0YivP6GzRaah
         OW32ER83bIbna/Cmn27GOoU26o7UrZyz4i3vRNWHoDVMUd+avYibMRm7+nqgy3cgCD3X
         DRZSZztIEbsexl0kGnew2VMYLrHM6dPd+1qJ46NYpMTo3a1YgIEFo175ruK/AJ77AGsE
         xyyg8Bg3r2phCUnhZIQ/25Hpv41Et/3BVlG6aBsygf1axMpj1e7M9O2jzpijdKW13lFY
         dHYTgUJoPCTMd/bLG/edZX2rXoumuL3LOaCJiSVQZopyjxhYdexg8DinMK+b71h1Wp5x
         bvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoLgzKOhBZS0FoA/bvGhth2HeRfby/EH6YEfcTaXC+g=;
        b=VOXSXLodwomeS5nxjSMKmdDEvXsyfNiMoPqG/QxvSPTLh4xRNVtaDHOQa4yK4CSURF
         QWECrpUhlBLUPW3ug0rcGVp7GQpym8PzOHZCQJr9zVthCxkABHx2vcpb5Vykwnu5M2ws
         cXUUWSer2IQ8VZ3kRONwg5mvmZbqbW5w9t1x7Mv1Owqf71MAtjrbZ8ejU4bLYVWIP4NF
         Xgl3WstURyYDRhD+FgbNsTKYPWQa/1dSWHtja4QeXJ55NS4FjHVB6XVo8v8hc+fqE0q9
         VBavHWqp3JC3iSc5AzwAUZo4H4xlanFmKZZgYKra1DyCtozUA5Lzc4DOnIKnOMlE/VRD
         W1TQ==
X-Gm-Message-State: APjAAAVEePmFA5B4f/H9991LsyrsuUztrJHpnLjHOQRoefmRkoUkDuQT
        8WFejR2ojXKjeZo4S3r24JiyXaCDUWMYtT9Adlpung==
X-Google-Smtp-Source: APXvYqyM+2J83LRcxow/EWAJEEAOaNUMWol/UFwxjB+8+9NBtPI+QLK2vOyLjOg529EIh+rkodVCb8xv8i9wUu8uJ8c=
X-Received: by 2002:aca:aa57:: with SMTP id t84mr3204872oie.149.1553036522625;
 Tue, 19 Mar 2019 16:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1552955080.2785.26.camel@linux.ibm.com> <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
 <1553036189.4899.136.camel@linux.ibm.com>
In-Reply-To: <1553036189.4899.136.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 16:01:51 -0700
Message-ID: <CAPcyv4j+4WMFsEbT_TDQfNs2ZG6+ME6b07RaqmT9kfbTStWgJQ@mail.gmail.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 3:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:
>
> Sorry for the late reply.
>
> > On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com> wrote:
> > >
> > > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > > Rather than fail initialization of the trusted.ko module, arrange for
> > > > the module to load, but rely on trusted_instantiate() to fail
> > > > trusted-key operations.
> > >
> > > What actual problem is this fixing?  To me it would seem like an
> > > enhancement to make the trusted module fail at load time if there's no
> > > TPM rather than waiting until first use to find out it can never work.
> > > Is there some piece of user code that depends on the successful
> > > insertion of trusted.ko?
> >
> > The module dependency chain relies on it. If that can be broken that
> > would also be an acceptable fix.
> >
> > I found this through the following dependency chain: libnvdimm.ko ->
> > encrypted_keys.ko -> trusted.ko.
> >
> > "key_type_trusted" is the symbol that encrypted_keys needs regardless
> > of whether the tpm is present.
>
> Commit 982e617a313b ("encrypted-keys: remove trusted-keys dependency")
> removed the dependency on trusted keys.  masterkey_trusted.c should
> only be included if "CONFIG_TRUSTED_KEYS" is enabled.  Is
> CONFIG_TRUSTED_KEYS enabled?

Yes, TRUSTED_KEYS is enabled, the module is built/available, and tries
to load when encrypted_keys.ko loads. The problem is that it fails to
load due an error returned from init_trusted(). The error is new for
v5.1. So, instead of requiring the module dependencies to resolve
successfully, and init_trusted() to return 0, the proposal is to just
lookup the key types by name.
