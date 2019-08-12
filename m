Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD0EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C152067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mTXf7n2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHLTbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:31:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43379 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfHLTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:31:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so19015967otp.10;
        Mon, 12 Aug 2019 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2rO/WLuk4jqhjOyvblSLWfVGDCVFevnenUKc3T2vXE=;
        b=mTXf7n2L/tWj2GeXTRaqOKVq3tmQ6jcRutXb0WOYoYol7v5Ctz5NPeNpUoaVd2hqbs
         oP4O46zAaQYhq6ZJN6xaVycFmxC0Jnwynysm/+DtOPtQwrKWLAfYlgejb98NvLDfcIbL
         OWnIRPq+ZOngD8zCvkRGVcWoT+VD7VKgKiTKa/L0u1t6HdnF3UGz3tCUjUONzNmGpsC9
         6QxhaMGdca19AfLglykP5gfweF4Fvs/aLGCu08nxPFU9bXoXwjpiyhI7vGrHLTq4Xrc3
         DHvVeh5IuWl+ZzL/0d5yEjKJ+do5EPgnU0mHYmXrM6RhWCkNF974u9OGl8SKXt9Yid2M
         bZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2rO/WLuk4jqhjOyvblSLWfVGDCVFevnenUKc3T2vXE=;
        b=oMxjfB9YDM03v9BsBXCAGQODVNv9TIbU+h3CXBTw7PxIVa1UofXBLBWmKf6nPWdVPT
         6vGU4F9i2Bb5CQ8OnTeGsnP4rZ+rv6vBgo03r5Z0xkXpMWo6qRDjIBbTAAZdziXogQZV
         njcFccFwmXjH2rDNZZRww61M+V9h+ldcAVie69ds+To2TUi/eRtVqu2mWK7UIxqelDEf
         KsdfccqOrJllcmvHmPwvryA8TgcH38nCoLMgdFtO71dEsTVbCj4h14W71jKy1BHDd8Mx
         5AQThlniGxnswOD0j+pnNZMTYzGdhPjMIVixzO/ZyUxBvskLB6+lCh0CR4uYglH3Qksq
         Tqfg==
X-Gm-Message-State: APjAAAW51jIjq00UK/WNbSPImsUj/zNvLc8hnDouVX0SY9o6/b/StmHR
        F0C+a/yuno8DthCTHPy34BVtwVEJm0OBp36KzgI=
X-Google-Smtp-Source: APXvYqyNn0/qfDF9fazKFcP1RqRIS7NkpYdZ41O1fLhn9LJCvmdHKKWpJQkr0PSt/J3+1pT90Q8ZxbzSsa2/mRaQjSg=
X-Received: by 2002:a6b:fd19:: with SMTP id c25mr23437832ioi.267.1565638306900;
 Mon, 12 Aug 2019 12:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org> <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com> <20190812180613.GA18377@infradead.org>
In-Reply-To: <20190812180613.GA18377@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Aug 2019 12:31:35 -0700
Message-ID: <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device ID
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:08 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 12, 2019 at 05:49:29PM +0000, Stephen Douthit wrote:
> > Does anyone know the background of the original PCS workaround?
>
> Based on a few git-blame iterations on history.git the original PCS
> handling (just when initializing) goes back to this BK commit:
>
> --
> From c0835b838e76c9500facad05dc305170a1a577a8 Mon Sep 17 00:00:00 2001
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Thu, 14 Oct 2004 16:11:44 -0400
> Subject: [libata ahci] fix several bugs
>
> * PCI IDs from test version didn't make it into mainline... doh
> * do all command setup in ->qc_prep
> * phy_reset routine that does signature check
> * check SATA phy for errors
> * reset hardware from scratch, in case card BIOS didn't run

Ok, that at least matches the expectation that platform firmware
initially enables the ports. However, it still leaves open the
question of whether the PCS bits were actually not configured, or
whether just the controller reset was needed. Certainly there is no
reason to touch that configuration register after every controller
reset (via the HOST_CTL mmio register)

It seems platforms / controllers that fail to run the option-rom
should be quirked by device-id, but the PCS register twiddling be
removed for everyone else. "Card BIOS" to me implies devices with an
Option-ROM BAR which I don't think modern devices have, so that might
be a simple way to try to phase out this quirk going forward without
regressing working setups that might be relying on this.

Then again the driver is already depending on the number of enabled
ports to be reliable before PCS is written, and the current driver
does not attempt to enable ports that were not enabled previously.
That tells me that if the PCS quirk ever mattered it would have
already regressed when the driver switched from blindly writing 0xf to
only setting the bits that were already set in ->port_map.
