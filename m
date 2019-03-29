Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A64217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553868700;
	bh=mXhTNqf6f8vF2K2fJX4RBUBo2Tx2X0tY6KwqLiAnf+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2eCgU/VcSDVq8NsdsUTWkbvFmKfYgUfmMtnBp2ijKKT5r5etdmLL27JvXxazu0Vnv
	 8nWVG9ZJzCqeFLxEeQ5iwF1l82BDoDcx2zyjgsKLQWy3Qxf89LTNOvCFsCyJRkEhZo
	 ou/TWemxuVuU3X0Rhl6P8WTOO3uTTOXtRj/4eDWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfC2OLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbfC2OLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:11:39 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E722184E;
        Fri, 29 Mar 2019 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553868697;
        bh=mXhTNqf6f8vF2K2fJX4RBUBo2Tx2X0tY6KwqLiAnf+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0lA0vM3zaxOyJNXpQLWsyTDXUPqxlDMz4ZMK6NEkDTqWw9jKL96vJNMfjpj+4iGv9
         7K3I1zWWXXN7I/FNxvO8oNbyj3jRQ0yBDiL88oN2E39h1nMn6TNTEhP5i3/dEIER/f
         Xmxo4SxJ5bU2YG1zEZNwUoXxfxxqwurU3NeeFx3U=
Received: by mail-qk1-f175.google.com with SMTP id k189so1437943qkc.0;
        Fri, 29 Mar 2019 07:11:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWFNykR0elRGt304JM2C7aThM127QbgA7vJFh+cjxb4vqd1mUHo
        UDlbMvel94Xl/wRyMYitpyx/FgQAzaZ2wThlwA==
X-Google-Smtp-Source: APXvYqyTxjcJr1YGE/tHpafOjY+swUJl59rbSCq4bX9dliWVZ/WX+wcCWUVVR8GEz3VALP5YYhJ0kJjHPDIGVHpAnO0=
X-Received: by 2002:a37:6748:: with SMTP id b69mr39377769qkc.79.1553868696804;
 Fri, 29 Mar 2019 07:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com> <20190328131657.GA9056@bogus>
 <be7246a0-2426-995d-0a24-f104c173d752@arm.com>
In-Reply-To: <be7246a0-2426-995d-0a24-f104c173d752@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Mar 2019 09:11:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
Message-ID: <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
To:     James Morse <james.morse@arm.com>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:47 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Rob, Yash,
>
> On 28/03/2019 13:16, Rob Herring wrote:
> > On Tue, Mar 12, 2019 at 02:51:00PM +0530, Yash Shah wrote:
> >> DT documentation for L2 cache controller added.
>
> >> diff --git a/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> >> new file mode 100644
> >> index 0000000..abce09f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> >> @@ -0,0 +1,31 @@
> >> +SiFive L2 Cache EDAC driver device tree bindings
> >> +-------------------------------------------------
> >> +This driver uses the EDAC framework to report L2 cache controller ECC errors.
> >
> > Bindings are for h/w blocks, not drivers. (And Boris may want a single
> > driver, but bindings should reflect the h/w, not what Linux (currently)
> > wants.
>
> For h/w block compatibles and edac, I think all we need now is to ensure the DT contains
> the three compatible strings: platform (if there is one), soc and ip-name (if its a
> re-usable thing).
> This is so that linux can pick the biggest of the three (usually platform) to probe the
> driver from, as this lets us capture platform properties we only find out about later.

DT is not the only what to instantiate drivers. If the OS really wants
to have a single driver for multiple h/w blocks, then it needs to
instantiate a driver itself (based on the top-level compatible
probably) and then that driver can find the DT nodes it needs itself.

> The single-driver idea is because ras/edac gets done late, (its not necessary to boot
> linux on the board), and the edac core has difficulty with multiple components feeding
> into it.
>
> I don't think we need platform-specific-drivers until someone has a platform that needs
> one for this multiple-component issue. To let us do that later (and possibly your
> customer's customer to do it), we'd like to avoid probing based on the smallest
> compatible, and use the biggest instead.

I honestly don't understand the issue with EDAC is here. Highbank is
separate drivers for L2 ECC (PL310) and DDR. Both are used on
highbank. Only the DDR driver is used midway. (I think we never got
around to how to report A15 L2 ECC errors within Linux.)

In any case, it's all irrelevant to the DT binding. We don't design
bindings around what some particular OS wants.

Rob
