Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C93120657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554339863;
	bh=7gV+H9oWVrSmWiRY3ZA5y4avAoyv9NfPzH4g7pSOHcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X1cImf4gL/LVjod8CU86V0D4weVC4osD/6eiA63Ia4oXPHoXgr7lieU8X+rpTNIlm
	 UrfCg9rqVO7q5saEWWlrG6cltIwY7qg9CnNlVmtiICvXvsKGzGSfFzLq57N9jTmCMz
	 moyHC2CORDr8Z/S7Ys+6/S1UA21AGdqQ4sV6THdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDDBEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDBEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:04:21 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897E0214AF;
        Thu,  4 Apr 2019 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554339860;
        bh=7gV+H9oWVrSmWiRY3ZA5y4avAoyv9NfPzH4g7pSOHcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ngFzqrHVClHf8AKU8TUdzx2MuAdhyEGs7bD0Nr2Vdjxn6JXcGRKZtxUGYvtoZ7Mos
         ACyEtqzflIYeBo2iy87cjysasCSrq3O/v7xlHZhJW5KU5s5AlUBhTDlT8iI/p06MwJ
         7qS2kI5YfP4lYVDjxJX3i+4ep2hit/A8QhGCLQC0=
Received: by mail-qt1-f174.google.com with SMTP id s15so1369219qtn.3;
        Wed, 03 Apr 2019 18:04:20 -0700 (PDT)
X-Gm-Message-State: APjAAAUuWP5DvKWpGse52cs1y96g0wr86loX2iyIdpzcjIgjzUfWjXWr
        IlkSXY19Zg7L1OMpRvLKJmmlRlyBTy/eks0S5g==
X-Google-Smtp-Source: APXvYqyWv7yLQFKukfd4/5BAuNkQxH1Vx/0oZJKIOCVjjboPJD2I1/a8JY6urWk+zTrHQlgB3s3VdhTbZu5R6sAdHPY=
X-Received: by 2002:ac8:33cf:: with SMTP id d15mr2959220qtb.149.1554339859777;
 Wed, 03 Apr 2019 18:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com> <20190328131657.GA9056@bogus>
 <be7246a0-2426-995d-0a24-f104c173d752@arm.com> <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
 <20190329142739.GG21152@zn.tnic> <CAL_JsqLQ1XvQq7L=xA5Z8Y0Xa4Bmp0t2pgxn+hLF+tD=_L7Mvg@mail.gmail.com>
 <20190329202416.GI21152@zn.tnic>
In-Reply-To: <20190329202416.GI21152@zn.tnic>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 3 Apr 2019 20:04:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+NMapJqM4N_kpeojvrS_W19vPLfMzdiENy6FjcOiqoDA@mail.gmail.com>
Message-ID: <CAL_Jsq+NMapJqM4N_kpeojvrS_W19vPLfMzdiENy6FjcOiqoDA@mail.gmail.com>
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

On Fri, Mar 29, 2019 at 3:24 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 29, 2019 at 02:41:05PM -0500, Rob Herring wrote:
> > DT dictates aligning with what the h/w looks like which has little to
> > do with OS driver design.
>
> Ok, then, where does this goal for doing a driver or compilation unit
> per IP block come from?
>
> Because everytime an ARM EDAC driver pops up, we are having the same
> discussion.
>
> > I never said you should change EDAC and I outlined how things should
> > be handled if it is one driver.
>
> Ok, we will add that to the EDAC driver design document we're currently
> working on.
>
> > DT and OS subsystems are independent things. I can't tell you how to
> > design the subsystem and you can't dictate DT design (based on EDAC
> > design).
>
> I don't think I've ever intentionally or unintentionally dictated DT
> design - all I've opposed to is having multiple EDAC drivers on ARM.

No, but folks just extend 1 driver to mean 1 DT node because that's
easy and certainly the more common case.

Rob
