Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A4ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA7C21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="vpcxzkJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfJOFK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:10:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42376 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfJOFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:10:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so28767568qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 22:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dChf/x5s1DseSM03Kd0rBda9MTuM8UvOTK3yPnAuTk=;
        b=vpcxzkJInTYYTNcBMnSERYa46NajSWpvFdC59LQdNTooIVhXTh7qftBI9WpOwP5jOr
         +gC1uITascMS89FnA0M4P8oojnafg8gvu1Y4JvDLn8xsaO9JkLRHEc4V7T/ETfZ9+DXy
         lA5U2OXDGWKu614JrU/eO3+OSWyhwzKaQ9kSQ1UFsKd8JX/0zrZJXYeAY6fSRlMIUqoI
         1FX+3gUhOBSZKuHtD1q1zGl7GbuJERh+omu2PTYZgcCWvptuEfA3bzx4wCHF18m6qG9u
         6I4n5UrJVlr+Erp7xM7xKjeTjq0n4nCmiaN7qUyanqYUAxAzzSnoCaVPpBVauJHNtCxj
         T61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dChf/x5s1DseSM03Kd0rBda9MTuM8UvOTK3yPnAuTk=;
        b=noiQQjDib7hyV023a4vbugZT0tlZ2m433lmQm0NImdC/gV03WHaZgFR6fDkmoCVnir
         ZhpCtXvycDt7Z5AM60AjCA0OfUsJgmLDAh/SU/eezr8lpsyK49kh6Tg79RFW0BhCy25g
         cyHTV60GV60/ywj8UGQQ0Pqdp1lMbo9+szmjqR2MfyKoJ444Pwt1zs873NHkTV5CbQ/5
         IUVZ0X9eKOXHp9SaOoi9JGrjjcG/IgZjoF3k2hWVmENN4PNRzTrU7FWBXiJost2L3vHR
         r9z/Oq3O4OxLRvIQPW5+Bgbg5gCVpVeTRdvk1dVz6G/lbIi3ECzXpM3PyWn5zDAgjkQR
         3DGQ==
X-Gm-Message-State: APjAAAUlunFLMPTge4fm7+E9ujDG7WLy7ylE0Uq6E+ZFNRMhtsdpigGl
        QZuNIJTyJi6oG+77wQeaji7J4510oV7FwZ0zlzXnBA==
X-Google-Smtp-Source: APXvYqy4g6NAupYLZe3cJqQPtl4z1+OKDrP3eSTx8LtKVS3LsxInbV9XUFzeN+VzoMb7cdtLLoGGrSDxq8+zqWSj/xM=
X-Received: by 2002:ac8:32ab:: with SMTP id z40mr8448770qta.391.1571116255461;
 Mon, 14 Oct 2019 22:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
 <3118349.722IRLjr4b@kreacher> <5720276.eiOaOx1Qyb@kreacher>
In-Reply-To: <5720276.eiOaOx1Qyb@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 15 Oct 2019 13:10:44 +0800
Message-ID: <CAD8Lp45rKeLs5xSvS9ffs+G0D5iLMn5-MWypqCKWCn0jGdfGHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Fix pci_power_up()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 7:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Since there is no reason for that difference to exist, modify
> pci_power_up() to follow pci_set_power_state() more closely and
> invoke __pci_start_power_transition() from there to call the
> platform firmware to power up the device (in case that's necessary).
>
> Fixes: db288c9c5f9d ("PCI / PM: restore the original behavior of pci_set_power_state()")
> Reported-by: Daniel Drake <drake@endlessm.com>
> Link: https://lore.kernel.org/linux-pm/CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com/T/#m21be74af263c6a34f36e0fc5c77c5449d9406925
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Daniel, please test this one.

This one is working too, thanks

Daniel
