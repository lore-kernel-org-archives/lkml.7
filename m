Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289792064A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553888482;
	bh=IhnzjRCSQBK+vXxVogaJZrgUaYfASlIvpdvWT5VAAww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NpP9OPd0QgBcYJY0phxHJaq2TnVBmhoSPwwrhzaH4Wlwn+NTC7dTGTIhMH9TLZT6e
	 K/+roCeYSntKR1lsGduWF7aDL+h9z8KyOCqkOVKuqw5OCtH2k/+ERL1TCvIGE5Czn3
	 0yK6J8dkMKqpq7+IrI080dP61QTYhrPwTJudqWTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfC2TlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfC2TlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:41:20 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F6E218AE;
        Fri, 29 Mar 2019 19:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553888478;
        bh=IhnzjRCSQBK+vXxVogaJZrgUaYfASlIvpdvWT5VAAww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ojKTR1VRIuqgu0FFeOFovaM7I6vyNnlomZnRF7RFkyIFQKbfxkAJyhgei3Gag4dw6
         83Sc0gkcj7LVEGRqrqDnB0cAcfZCya9B5xnip0U1fY3N5rXjXfeobs5NcYDdfZpsUT
         zyAC8m8CGrbj+PPSSTMVQwd/8lXmdGTcWNdfmzD8=
Received: by mail-qt1-f173.google.com with SMTP id v20so3698728qtv.12;
        Fri, 29 Mar 2019 12:41:18 -0700 (PDT)
X-Gm-Message-State: APjAAAVP/Be2IW952VsBxhTzqOm8/8yO97Rvr0jZDZIAOlzX0U7BDPUj
        VnE2vWFAJU2xqKqtyR83K3AjfR770D/Tnnz7hw==
X-Google-Smtp-Source: APXvYqzCUtNKCf26jdI194VOtmDfMhUt/+PKKdd3Jz7SKJUXM5LxDsOFFwhhEE1DizGlUh19fY+S62qZWDC9YyFbAQo=
X-Received: by 2002:ac8:30bc:: with SMTP id v57mr42228073qta.26.1553888477975;
 Fri, 29 Mar 2019 12:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com> <20190328131657.GA9056@bogus>
 <be7246a0-2426-995d-0a24-f104c173d752@arm.com> <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
 <20190329142739.GG21152@zn.tnic>
In-Reply-To: <20190329142739.GG21152@zn.tnic>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Mar 2019 14:41:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQ1XvQq7L=xA5Z8Y0Xa4Bmp0t2pgxn+hLF+tD=_L7Mvg@mail.gmail.com>
Message-ID: <CAL_JsqLQ1XvQq7L=xA5Z8Y0Xa4Bmp0t2pgxn+hLF+tD=_L7Mvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>,
        Yash Shah <yash.shah@sifive.com>,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:27 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 29, 2019 at 09:11:24AM -0500, Rob Herring wrote:
> > I honestly don't understand the issue with EDAC is here.
>
> The EDAC core supports only one driver and if you need to load more, you
> need to dance around that.
>
> Also, if those drivers need to talk amongst each other, then they need
> to build something ad-hoc so that they can.
>
> And the other architectures can very well do one driver per platform -
> only ARM wants to do this special thing because DT said so. Or whatever.
>
> > Highbank is separate drivers for L2 ECC (PL310) and DDR. Both are used
> > on highbank.
>
> That's because your L2 driver does allocate an edac_device
> (edac_device_alloc_ctl_info()) and the DDR one an edac_mc
> (edac_mc_add_mc_with_groups).
>
> For example, altera_edac does edac_device_alloc_ctl_info() for each IP
> block just fine. So a single driver *can* work.
>
> > Only the DDR driver is used midway. (I think we never got around to
> > how to report A15 L2 ECC errors within Linux.)
> >
> > In any case, it's all irrelevant to the DT binding. We don't design
> > bindings around what some particular OS wants.
>
> And just because DT dictates one driver per IP block, I'm not going to
> redesign EDAC to fit that scheme. You or someone else who feels strongly
> about it, is more than welcome to do so, of course. And then maintain it
> too.

DT dictates aligning with what the h/w looks like which has little to
do with OS driver design. I never said you should change EDAC and I
outlined how things should be handled if it is one driver. DT and OS
subsystems are independent things. I can't tell you how to design the
subsystem and you can't dictate DT design (based on EDAC design).

Rob
