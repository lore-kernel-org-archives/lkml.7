Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C80AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C06A22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="JZ5+WGDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfLLSZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:25:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfLLSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:25:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so1559116pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dq8iMUhZ2yfBywJFDlsyvo5d9zUYOkAnGOhY/ugaTfg=;
        b=JZ5+WGDLMqcN43s4lZE8f2qx6LIqv25/YKdRZArNa+TIOR4zXMBDSDbF7EmxMp0teV
         z1yPgFHV6R/Y9nblOr69R2by1K+voQaFqi1czL1TEgAnwKlhaWWZZOyJb4nkuo/BLt/j
         wvdVj/ii5Vw695+oPBU4gtmV6mzDwuLoBejlJLVaGxuRsPGe5db080gTD4+bXeAAkx7d
         YsJRtU9GgMY8L8P2KyUMmX/U6lfmDO4F9mwWnkrYv/C/XW/u2hNoBAISrq4fnjV5ENKG
         fM0llueVK1mnbYBGRuPlE3cVPr1d4j3j6vm3deESJo64OOHDYqdZvR+4eQMMthrLa89/
         3kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dq8iMUhZ2yfBywJFDlsyvo5d9zUYOkAnGOhY/ugaTfg=;
        b=FIbaWbUZdfEVkXZE/88dkj3VGCJ0n3b+Y4tC/ZtReSygShib+hej2Hskp7k3Oi2/hy
         vg0GwplIAyLqwDMeOjzWHiqroNa+yGrGYyzJs/eYpUx8h9XSlQcPYNwet4gYL7zj6ObO
         ZIYDas9VbCLo5Tk+4WER9yPfruSi5RckpD69DmdQ3aB5Xkpait1cNzY/laZWj6pibVW1
         1TpW9RLwgzPU0BIqLxtOtUneC1Nfgk4dQmBZQNmf2KCDjL7czc2RenaFCG2USUM5uDFt
         57aFjhsGuJFUfevIxvxjjq1gvXoH4/hg5wjYhk1UuAcC/pvD/pBqGVmSOHGqhDNJgri6
         wQaA==
X-Gm-Message-State: APjAAAVlIdKOUsYPRRAf8ULAvYKrPw3My0sgVI8lOyZLYdaGBqjxRbkP
        S0/CUHkpXZ0qVgg/JSVB5jFUZA==
X-Google-Smtp-Source: APXvYqwKszuLsvTn/P8C2foIW/l93vtwMR+8x9dN4BqBvz0LjXnY6T5W9/poyEteamIBt2ikAk11+A==
X-Received: by 2002:a63:c12:: with SMTP id b18mr11819556pgl.156.1576175121153;
        Thu, 12 Dec 2019 10:25:21 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i4sm6344645pjw.28.2019.12.12.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:25:20 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:25:17 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Yuval Avnery <yuvalav@mellanox.com>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gospodarek <andy@greyhouse.net>
Subject: Re: [PATCH net-next] netdevsim: Add max_vfs to bus_dev
Message-ID: <20191212102517.602a8a5d@cakuba.netronome.com>
In-Reply-To: <AM6PR05MB51425B74E736C5D765356DC8C5550@AM6PR05MB5142.eurprd05.prod.outlook.com>
References: <1576033133-18845-1-git-send-email-yuvalav@mellanox.com>
        <20191211095854.6cd860f1@cakuba.netronome.com>
        <AM6PR05MB514244DC6D25DDD433C0E238C55A0@AM6PR05MB5142.eurprd05.prod.outlook.com>
        <20191211111537.416bf078@cakuba.netronome.com>
        <AM6PR05MB5142CCAB9A06DAC199F7100CC55A0@AM6PR05MB5142.eurprd05.prod.outlook.com>
        <20191211142401.742189cf@cakuba.netronome.com>
        <AM6PR05MB51423D365FB5A8DB22B1DE62C55A0@AM6PR05MB5142.eurprd05.prod.outlook.com>
        <20191211154952.50109494@cakuba.netronome.com>
        <AM6PR05MB51425B74E736C5D765356DC8C5550@AM6PR05MB5142.eurprd05.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 05:11:12 +0000, Yuval Avnery wrote:
> > > > Okay, please post v2 together with the tests. We don't accept
> > > > netdevsim features without tests any more.  
> > >
> > > I think the only test I can currently write is the enable SR-IOV max_vfs  
> > > enforcement. Because subdev is not in yet.
> > > Will that be good enough?  
> > 
> > It'd be good to test some netdev API rather than just the enforcement itself
> > which is entirely in netdevsim, I think.
> > 
> > So max_vfs enforcement plus checking that ip link lists the correct number of
> > entries (and perhaps the entries are in reset state after
> > enable) would do IMO.  
> 
> Ok, but this is possible regardless of my patch (to enable vfs).

I was being lenient :) Your patch is only really needed when the
devlink API lands, since devlink will display all max VFs not enabled.

> > My knee jerk reaction is that we should populate the values to those set via
> > devlink upon SR-IOV enable, but then if user overwrites those values that's
> > their problem.
> > 
> > Sort of mirror how VF MAC addrs work, just a level deeper. The VF defaults
> > to the MAC addr provided by the PF after reset, but it can change it to
> > something else (things may stop working because spoof check etc. will drop
> > all its frames, but nothing stops the VF in legacy HW from writing its MAC
> > addr register).
> > 
> > IOW the devlink addr is the default/provisioned addr, not necessarily the
> > addr the PF has set _now_.
> > 
> > Other options I guess are (a) reject the changes of the address from the PF
> > once devlink has set a value; (b) provide some device->control CPU notifier
> > which can ack/reject a request from the PF to change devlink's value..?
> > 
> > You guys posted the devlink patches a while ago, what was your
> > implementation doing?  
> 
> devlink simply calls the driver with set or get.
> It is up to the vendor driver/HW if to make this address persistent or not.
> The address is not saved in the devlink layer.

It'd be preferable for the behaviour of the kernel API to not be vendor
specific. That defeats the purpose of having an operating system as a
HW abstraction layer. SR-IOV devices of today are so FW heavy we can
make them behave whatever way we choose makes most sense.

> The MAC address in mlx5 is stored in the HW and
> persistent (until PF reset) , whether it is set by devlink or ip link.

Okay, let's see if I understand. The devlink and ip link interfaces
basically do the same thing but one reaches from control CPU and the
other one from the SR-IOV host? And on SR-IOV host reset the addresses
go back to 00:00.. i.e. any?

What happens if the SR-IOV host changes the MAC? Is it used by HW or is
the MAC provisioned by the control CPU used for things like spoof check?

Does the control CPU get a notification for SR-IOV host reset? In that
case the control CPU driver could restore the MAC addr.

> So from what I understand, we have the freedom to choose how netdevsim
> behave in this case, which means non-persistent is ok.

To be clear - by persistent I meant that it survives the SR-IOV host's
resets, not necessarily written to NVRAM of any sort.

I'd like to see netdevsim to also serve as sort of a reference model
for device behaviour. Vendors who are not first to implement a feature
always complain that there is no documentation on how things should
work.
