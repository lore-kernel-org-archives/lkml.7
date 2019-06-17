Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C15AC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA7C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTubHMqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfFQUdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:33:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:33:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so11391487wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7E1TXWJ9WLYHHONH4DcJ3hmnFFn3u3c4hO6CFHndTl4=;
        b=ZTubHMqHIeC1nxY1QX1noMgJ9RcBXyK6k2HQf5dvRtlumh8NqN3N+HzEQySF3jbMGN
         OF7YfVe/Vgjn0U2Jr5jvc/nyFj8yKhS9jQIG0nrfajFCzJB2DX+l9XZlP9s81WzmfbBT
         P1PLlMLf7dBitXaQZZi/kOxdPYIWJjTYX2YB4gfkg6/6a34RsnWwwCODiYljZZyikllY
         eDWWCSneL7xRfxL3175oJtP/0na6CIiMdtPKD9grGW3NkydZ5llWGNKgie6Qlkp54vD9
         qYuRH3ID792auXlFyyqh7AsKoxMCfOrRVzKbiHDm3IfkiKXGooGRToJDDCMEiy32xN49
         LE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7E1TXWJ9WLYHHONH4DcJ3hmnFFn3u3c4hO6CFHndTl4=;
        b=PqE+oE5YE/cR8LlUyquxOx0EwxhM8rYiZTp5JTXIMnrWXSeTyXNZ3rmOsYIYunww79
         CEHTHm+Dz2KAJXyhngCBfU2ueS8zbCRrA+eB5OcksuyqOykSsWn7Ccl6epeWyGuIb2iF
         zvjBrMtn4LcfLF+qw9lHyC/smUSphf1OooXLUAxX8+AOmnUvbv0uLm6JGisYUH4rO3PH
         wAeHSBU7dXq8FYza+PU/pXJqNTDAj3I0KAI1UUCQWv/PrAPywGNetvMpNidgh74PigRK
         MOfb+/jHMRMz0CCMLZsI7pmh6iVYiFullg4WXAiZQ29ehdkek3XptovOJwrtKNPwJlZq
         LEGw==
X-Gm-Message-State: APjAAAXC0r/bCD/uLpH6CkYSY7ssn9zQyMFd1zS1UtIfS77SU0AGWu7S
        YCjigSDsAC3ytL5+5j/N91Tta9RKhPQZ5fL1OMDG
X-Google-Smtp-Source: APXvYqyKBLWICZZiQ4EbUBGZFEfhIYjEqyI1qV4DAnaUEbQW547tmo/FkxONfJWYCR/vP+6V7P88Z0nOZtAzjY9EEpU=
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr4647049wrn.54.1560803624477;
 Mon, 17 Jun 2019 13:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
 <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
 <CAErSpo6qaMc1O7vgcuCwdDbe4QBcOw83wd7PbuUVS+7GDPgK9Q@mail.gmail.com>
 <82840955-6365-0b95-6d69-8a2f7c7880af@huawei.com> <CAErSpo5cqJCZjt6QqMNZ6_n=G-_WxFeERnsESOMxsdr1P-6JLg@mail.gmail.com>
 <9e8b6971-3189-9d4b-de9a-ff09f859f4f6@huawei.com>
In-Reply-To: <9e8b6971-3189-9d4b-de9a-ff09f859f4f6@huawei.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 17 Jun 2019 15:33:32 -0500
Message-ID: <CAErSpo4DemDWtnP2Gtram9tfQ0CaN9Na9_Gxk6Qk+nG5+JLuzA@mail.gmail.com>
Subject: Re: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "zhichang.yuan" <zhichang.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:47 AM John Garry <john.garry@huawei.com> wrote:
>
> >>
> >> For the logical PIO framework, it was written to match what was done
> >> originally for PCI IO port management in pci_register_io_range(), cf
> >> https://elixir.bootlin.com/linux/v4.4.180/source/drivers/of/address.c#L691
> >>
> >> That is, no method to unregister ranges. As such, it leaks IO port
> >> ranges. I can come up with a few guesses why the original PCI IO port
> >> management author did not add an unregistration method.
> >
>
> Hi Bjorn,
>
> > I think that was written before the era of support for hot-pluggable
> > host bridges and loadable drivers for them.
>
> I see that the original support was added in 41f8bba7f555. I don't know
> how this coincides with hot-pluggable host bridges and their loadable
> drivers support.
>
> >
> >> Anyway, we can work on adding support to unregister regions, at least at
> >> probe time. It may become more tricky to do this once the host children
> >> have probed and are accessing the IO port regions.
> >
> > I think we *do* need support for unregistering regions because we do
> > claim to support hot-pluggable host bridges, and the I/O port regions
> > below them should go away when the host bridge does.
>
> It's now on my todo list.
>
> I'll need advice on how to test this for hot-pluggable host bridges.
>
> >
> > Could you just move the logic_pio_register_range() call farther down
> > in hisi_lpc_probe()?  IIUC, once logic_pio_register_range() returns,
> > an inb() with the right port number will try to access that port, so
> > we should be prepared for that, i.e., maybe this in the wrong order to
> > begin with?
>
> No, unfortunately we can't. The reason is that we need the logical PIO
> base for that range before we enumerate the children of that host. We
> need that base address for "translating" the child bus addresses to
> logical PIO addresses.

Ah, yeah, that makes sense.  I think.  We do assume that we know all
the MMIO and I/O port translations before enumerating devices.  It's
*conceivable* that could be changed someday since we don't actually
need the translations until a driver claims the device, and it would
gain some flexibility if we didn't have to program the host bridge
windows until we know how much space is required.  But I don't see
that happening anytime soon.

Bjorn
