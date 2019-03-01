Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC0BC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55084218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXH2nYGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfCADd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:33:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45978 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfCADd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:33:29 -0500
Received: by mail-io1-f68.google.com with SMTP id x9so18444381iog.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtFvcteIBJq3dYSU1h9ov8iTU+O9WXT4b1Ku5DaUd0w=;
        b=VXH2nYGzuptscs7Fi4efQlx/r+cyna9QZXwaSg4rMz9AxSl9/Ehdtwpe4teyPs/qdy
         rc2Y4LKBegDyBC0E43GDNfna6kWvvA4NngkXrHqB7Wp15yNUlvN6Nh5CpP3H/iwP3zPh
         I8nFNir6284yHc/TvfVVvw4jYsR3guVNvL5TCah6YngTBf4Slm+t0rWNIPZcuY7fK4FR
         9cd7gubpIrrk0rA1z/xrYjuQepAkTjZwi3d48W73JZNPl86xgFAM71znC9GoCBeg0MR1
         DRrzonpU6222sy7XhhzWY/1USFNCfz36OqPRl/ZCl7Bcf4Udquz/eITqHhPpS1tSmUds
         wtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtFvcteIBJq3dYSU1h9ov8iTU+O9WXT4b1Ku5DaUd0w=;
        b=e1N63RJf8kzjRryz05aI/jWC1xJ7+Dr+Sjc8Lk8atrWjB3qPn8AN5JpETCip4/svxQ
         WbLSHFeVmQa8DmMZ7ruclNfNzEYubJdVQQsmlA5Vx5sTHkRzI6gva+SrW/f3EHtaKH5P
         eXU4xRGtIXFCQB6T3vIjy57xRHA+TC/K0ivYiV7Y426WgXdaJHZTriY689jiikBlqRrJ
         C/OvJP4shpp6ZnN8jI4U6pjBh32aDIFgzfDyNnnhoChihPE9B71oGVuom6G+hLbqAD4h
         0+RGtGutfkvyhbC0bFrLeJxBCdwYTffSnC4khrnS2nkZbkMoGuZwaPDnCYQAy3nle7w2
         MVIg==
X-Gm-Message-State: APjAAAWJboGMOskaHmQw6bFc3qCGZdAYIVmIuBK/PyCv+i2vX+mAZRCX
        U4OdAoD/bWYAAnCZsUEkKlFSpw02+nwykIwl1EMdIOkwmAd4Tg==
X-Google-Smtp-Source: APXvYqyPENJJcQkJnxS6nB1jB8TSdoJmkbYn1a2eZoOmbzIaClwCmZeL3fRP/q0osC/tT4t3aVJTl0giuhpgkon/cb0=
X-Received: by 2002:a5d:9254:: with SMTP id e20mr1601733iol.88.1551411207771;
 Thu, 28 Feb 2019 19:33:27 -0800 (PST)
MIME-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <1551392438.10911.227.camel@linux.ibm.com> <CACdnJuvwnh0PKr5jUTm2h=P5-u-oLgBjvThX+DxcegShXReCdA@mail.gmail.com>
 <1551398720.10911.270.camel@linux.ibm.com> <CACdnJutqg26pk5xnK2ii3ia9JabAnBptE3YQ3yLvVT93as666Q@mail.gmail.com>
 <1551404654.10911.276.camel@linux.ibm.com>
In-Reply-To: <1551404654.10911.276.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 19:33:16 -0800
Message-ID: <CACdnJuvn4uC075+Z99CaO3YGjJ+4nviPj=4TEQpkndC3JwFovg@mail.gmail.com>
Subject: Re: [PULL REQUEST] Lock down patches
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 5:45 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-02-28 at 17:01 -0800, Matthew Garrett wrote:
>
> > > That's not a valid reason for preventing systems that do use IMA for
> > > verifying the kexec kernel image signature or kernel module signatures
> > > from enabling "lock down".  This just means that there needs to be
> > > some coordination between the different signature verification
> > > methods. [1][2]
> >
> > I agree, but the current form of the integration makes it impossible
> > for anyone using an IMA-enabled kernel (but not using IMA) to do
> > anything unless they have IMA signatures. It's a problem we need to
> > solve, I just don't think it's a problem we need to solve before
> > merging the patchset.
>
> That's simply not true.  Have you even looked at the IMA architecture
> patches?

Sorry, I think we're talking at cross purposes - I was referring to
your patch "ima: require secure_boot rules in lockdown mode"
(https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=efi-lock-down&id=7fa3734bd31a4b3fe71358fcba8d4878e5005b7f).
If the goal is just to use the architecture rules then I don't see any
conflict, and as far as I can tell things would just work as is if I
drop the ima portion from "kexec_file: Restrict at runtime if the
kernel is locked down"? Apologies, I'd thought that the secure_boot
ruleset was still intended to be used in a lockdown environment.
