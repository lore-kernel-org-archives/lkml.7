Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1534C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BBF2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504817;
	bh=pQUevLF0xyowVLislNwxncOmUDmy7xUj+/6lMyQ5Cd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OAOeicy6nOveVvB6wjoJ0mxVxFL3SBYP6b/bDb8AMhpcdamSl7MdoPUEjwHTvgkyQ
	 6OU7uLZVfosKPQIqxSeYXkP73SmQDPdIzTATp9mHdRrU/doOYYCpdWJTghDggzsjie
	 jhBYvmJqYfx4Hu4t+cHaei57m4dWsdCOU4gdswBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfCMTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbfCMTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:20:13 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51702184E;
        Wed, 13 Mar 2019 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504813;
        bh=pQUevLF0xyowVLislNwxncOmUDmy7xUj+/6lMyQ5Cd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kO+gwavX+Fu2vh+iOzAap1JKK96oLNWmKjou5KKcCLaJbB0G4MSYH7xMJXTNfz/8C
         S62pGyl9Ma+UxJop4+4kVb8GIjD6MqInaknO0kh+e76yjcRgP/l45TWJ7A/ncG+Ri0
         i6DvOCcVuGdSL3clxKIKQE7EZudTl/0Lcp8fJIJk=
Received: by mail-qt1-f180.google.com with SMTP id u7so3271662qtg.9;
        Wed, 13 Mar 2019 12:20:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWy6EFvf3uT265srS9jPpCx0rDF/NHzL5orP/LWFZe7lmJPQnYg
        j2Yry7/aL4+Pkel4+bAdcC1xGN738XGvfISMhw==
X-Google-Smtp-Source: APXvYqw2mTzZnaLVN86rMrEMIpQc0QpykQNSqJ7Dkha/VOSiIF4y4v37ja91/C1roLS/eV0QnaQjhqcWDAOtPg2ri/I=
X-Received: by 2002:ac8:5445:: with SMTP id d5mr8463948qtq.38.1552504812075;
 Wed, 13 Mar 2019 12:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-3-git-send-email-thor.thayer@linux.intel.com>
 <20190312160445.GA8802@bogus> <8b671f75-8488-1e06-a020-5f7d95166918@linux.intel.com>
In-Reply-To: <8b671f75-8488-1e06-a020-5f7d95166918@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Mar 2019 14:20:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHKwOBcHLwfHfB407XkU4SFDymbWR05fN+Zft1ki+b=w@mail.gmail.com>
Message-ID: <CAL_JsqJHKwOBcHLwfHfB407XkU4SFDymbWR05fN+Zft1ki+b=w@mail.gmail.com>
Subject: Re: [PATCHv2 2/5] Documentation: dt: edac: Add Stratix10 Peripheral bindings
To:     thor.thayer@linux.intel.com
Cc:     Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 2:28 PM Thor Thayer <thor.thayer@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 3/12/19 11:04 AM, Rob Herring wrote:
> > On Wed, Feb 27, 2019 at 11:27:22AM -0600, thor.thayer@linux.intel.com wrote:
> >> From: Thor Thayer <thor.thayer@linux.intel.com>
> >>
> >> Add peripheral bindings for Stratix10 EDAC to capture
> >> the differences between the ARM64 and ARM32 architecture.
> >
> > What's the difference? Sounds like 2 different chips, so Stratix10 or
> > s10 is not specific enough perhaps.
> >
>
> Yes, our ARM32 chips are the Cyclone5 and Arria10. The Stratix10 is
> ARM64 and I'm using S10 as shorthand for the Stratix10.

So it's really just differences between one chip and another... ARM32
vs 64 really has nothing to do with that.

>
> The ECC blocks are very similar between Arria10 and Stratix10 but there
> are differences as a result of the ARM32 vs ARM64 architecture
> differences. The major difference is how Double Bit Errors are handled.
> In the ARM32, the DBE is mapped to an IRQ. On ARM64, the DBE is mapped
> to a SError.

Okay, I guess that's why arm64 matters...

> I had started out re-using the Arria10 bindings for Stratix10 since they
> were very similar. Dinh pointed out that having separate bindings for
> ARM64 would allow separation between the architectures and make future
> changes easier.
>
> I'm unclear on the comment about being specific enough. Are you
> suggesting that I use arm64 in the binding name instead of s10? Or is
> there a better naming convention I should follow?

NM, it was me that was confused. It was that Stratix10 was already
mentioned in the doc that confused me.

Rob
