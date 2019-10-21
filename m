Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8418C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89F820700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfJUMA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfJUMA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:00:59 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50CBB83F4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:00:59 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id t1so6381015qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3fNeTrb8zczujjHnQNEjI0XuAROR+Pj6w/x2dFfu/8=;
        b=d4d5m0Vg/PDgs27jWjN5bcgKsFk+hc8OXpd3JMu4wKtZzOIFm6wxv9+lD9L5pfnEBG
         3QMjOk9qwpCh1f83H+QpsPQ1F0rMpOXYTB4A69t4qYAEqO3Gkx9wtGylE/12uwhsm0ps
         57zxE2DGlhuGUlEOfbnpEbl3wWSqA8DgHJSee0tDc2zEKwCWgrJDnCIhgZMYwzNuyCtV
         w2nqENSqvM73uqujL2BYt8HxvSW+OySm4PXOIk2IglzYNQl5K633O9QfhWqMcT9BE7g/
         agkdZiWS8wjxYO+8ThwoDIeUYSJkD6jaQ1Q/yIPa8Lm7TntWhYYoBHeKimoFPPU182r+
         r7uw==
X-Gm-Message-State: APjAAAXR1lf2itsAn9qdGpYawVPFAegyNsVvneg+2AC5o0VAIN6qmv7S
        Zo+sJOtHOLf+WsQrlXC9M0h+Mku4YFuc0wz6WR7LWA64YyoqRl8YCnjDSB2qrCbq938NdA7TE5C
        6EihCFBePFOqfE/ckBb6AIM/lD9sgWA7NNdg4d68L
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22668512qkj.102.1571659258421;
        Mon, 21 Oct 2019 05:00:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLKUy/SzC+Ir3UqXb3Coc4vgrt7sjwm3oLMxhXO6j4sAHWuzrRvXNIFYbci0UPZXZOe/I7+Lh9FVGm0cooVzg=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22668481qkj.102.1571659258106;
 Mon, 21 Oct 2019 05:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191016144449.24646-1-kherbst@redhat.com> <20191021114017.GY2819@lahna.fi.intel.com>
In-Reply-To: <20191021114017.GY2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 14:00:46 +0200
Message-ID: <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 1:40 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> Hi Karol,
>
> Sorry for commenting late, I just came back from vacation.
>
> On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > states.
> >
> > v2: convert to pci_dev quirk
> >     put a proper technical explanation of the issue as a in-code comment
> > v3: disable it only for certain combinations of intel and nvidia hardware
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > ---
> >  drivers/pci/pci.c    | 11 ++++++++++
> >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>
> I may be missing something but why you can't do this in the nouveau
> driver itself?

What do you mean precisely? Move the quirk into nouveau, but keep the
changes to pci core?
