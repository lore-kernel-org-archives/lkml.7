Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7B2C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B8F2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="OSQ58w+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfKGUJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:09:17 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35741 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfKGUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:09:16 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so3003503ilp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n78FTesTpTJ/BSxJVBGWGsxOBEQaJP9PhxbGA4r4iXs=;
        b=OSQ58w+QwGhCdyzBMBRwZRUHTZ5uUdY5Q8wpDqk6wTm1BN4AQWkVJP+mxLn3O1xKJI
         NHAEhD7OvvuyZUBT0VX6OStvYV1wPuH+98zXPOOj6CFJNRd7DknMBmpAodzC/FMhH/n9
         z5upvFKxrVdCr2JIoRQP9M0uASWSHNnWg/NZ8hoVPKfTq7r4fCyG3kcTVwOKxAjvbYt6
         4Zk/CNOux3lwuVziuy03ALQ1815alAq3ogiw/H5giUsjr2XExcm/wxp5nY3saZVGUzsV
         a9CKR3ZC08yjDL2ah1TBoZxRSnBPAHDbF30bqzmaH1hXJbhHBCqzFK2oraXr7MM4akKq
         w/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n78FTesTpTJ/BSxJVBGWGsxOBEQaJP9PhxbGA4r4iXs=;
        b=OLD1VCiUra7vF9c3NlVdMXWnipaDefIc6a/53EoWAks1yTb/j58QP8RKclGFyAZSf9
         tgV/4wdQOXwGVdHmEgS8S0M0+gq2oa4tWlPYISKTO5Urj68dlZ2ILln76tBtB7afy6EN
         m6b9yVjVUrOfwgOMeqakB5x+uSAPt3MLcFy77SRKarNjQi4RTqnsYYEyYW4HdzA46yzm
         uFLufpqgarYlQ+45ubYJuSXZj/7TRpMAtHQN8QjMDTHhOUQoHEjttrH3CkA6FN3LzVJn
         23eaqzTr4KJ+lAkad2X4lMEqCDrIDSSDN8KL28ygPBd7+Y820Hxk4/T8zB+NyMHP/pba
         /QZw==
X-Gm-Message-State: APjAAAX93BfdBDEhfBQwfGUG1LA5w5x+iY96/lLG+QFhF2Zp/+vn09zX
        3FvGvImbWCeelb09A77gGWZdPdHoGtD98krniIgAgHuwbLlaVFdo
X-Google-Smtp-Source: APXvYqxluSqAu+N734VP6mdWZsNX+hE3qJdUV4umr4wntSPeGfNfSxx5fhGbskmP6UPxh7BN7/R4EnznrMWxse8n0D8=
X-Received: by 2002:a92:1b1c:: with SMTP id b28mr6612291ilb.278.1573157353544;
 Thu, 07 Nov 2019 12:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20191025202004.GA147688@google.com> <1ade6a9f-9532-c400-9bb0-4e68ed5752ce@linux.intel.com>
In-Reply-To: <1ade6a9f-9532-c400-9bb0-4e68ed5752ce@linux.intel.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 7 Nov 2019 12:09:02 -0800
Message-ID: <CAOesGMhdAUKj9f0=sVwH7kffr=P-LqWWqKxKK3N3e0MpcjLExw@mail.gmail.com>
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 12:02 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi,
>
> On 10/25/19 1:20 PM, Bjorn Helgaas wrote:
> > On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
> >> In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
> >> the behavior was changed such that native (kernel) handling of DPC
> >> got tied to whether the kernel also handled AER. While this is what
> >> the standard recommends, there are BIOSes out there that lack the DPC
> >> handling since it was never required in the past.
> > Some systems do not grant OS control of AER via _OSC.  I guess the
> > problem is that on those systems, the OS DPC driver used to work, but
> > after eed85ff4c0da7, it does not.  Right?
>
> I need some clarification on this issue. Do you mean in these systems,
> firmware expects OS to handle DPC and AER, but it does not let OS know
> about it via _OSC ?

The OS and BIOS both assumed behavior as before eed85ff4c0da7 -- AER
handled by firmware but DPC handled by kernel.

I.e. a classic case of "Sure, the spec says this, but in reality
implementations relied on actual behavior", and someone had a
regression and need a way to restore previous behavior.


-Olof
