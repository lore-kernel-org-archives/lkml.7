Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07296C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3622133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cv/MNIaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDIQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:36:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42218 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDIQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:36:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so9602710pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbMpZbRnUTFEXDQLgX9+Zlogt63k0YgCAkVAWzWlJ8w=;
        b=Cv/MNIaAjoMU8AOj0RLccvJL39r1bG77lFm3QHBfTn8Too7t3iBmPJu7Z5WXJYPvSN
         8FmeOqqbP6XNNNip5Tvukw2mXXaaPKYdGrwaGMOoAq5LUd3HHD+h1W/Euzm+fy8sMhut
         dLZjM80j1R/uUk8GkFTnaDHKBbPB60c1kl2/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbMpZbRnUTFEXDQLgX9+Zlogt63k0YgCAkVAWzWlJ8w=;
        b=agoqfL9H1AgCQoVt63VhJbB7Wx8HyywhCDEhRellLXoLPSYz9UfXNCK9D3UEhqHQn5
         cTxGR5M/GtpkuclFi64mpIecQO0vzMkh4JbGv+y/O6wdh6s9an+Q+XlDyq9p5wIcnOKK
         dXcdP5LcK/zbLx2JLmj1LgRobGTwlrMvB0DbzUqG0EjKjzRdxJmjDzqXLwulWN/dOIMj
         j07VK3Hgpci6hiqu57PCCl5nMHj4EhCUwL+D4gafFgASBEog7kRjHRdN2PrKbTk+66vh
         VrmJ/VKcXid67HB+eukFWqWOrzbowEMok9aRLUXT1Bur/cLYH2zU0hBrSbCyCiAQ9HgL
         6Jyg==
X-Gm-Message-State: APjAAAVVG90zElp6SAYPpjF9A5oDSiuca8/8SA210MVYRVhkfUUn8tvA
        Rgp+WQbPkXY7ejQDGkZeBA4uXQ==
X-Google-Smtp-Source: APXvYqxFQCSBZ9faeE/pcs9NfTyUcYpEw+BGg89qI/c2JnmDDN/k5RkNq9NmHjfYQgXhIvcSYmyRvA==
X-Received: by 2002:a63:e402:: with SMTP id a2mr36262869pgi.268.1554827796585;
        Tue, 09 Apr 2019 09:36:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l2sm34708768pgl.2.2019.04.09.09.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:36:35 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:36:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     c-hbandi@codeaurora.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190409163635.GU112750@google.com>
References: <20190307182009.GB138592@google.com>
 <20190307233039.GA69116@google.com>
 <c985a6712f91930d7c710ca4abb42e80@codeaurora.org>
 <a03acbdc6bfad172fdd65f428ffbe4cf@codeaurora.org>
 <20190401171202.GH112750@google.com>
 <1bebaf0766988a9f27cbbcb9bb35e26f@codeaurora.org>
 <20190402180501.GK112750@google.com>
 <1200f5c32e029c603667d66a4c62a634@codeaurora.org>
 <20190403161438.GN112750@google.com>
 <a3bde5419145e9dccc2886d2d29c9d3f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3bde5419145e9dccc2886d2d29c9d3f@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:22:15PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-04-03 21:44, Matthias Kaehlcke wrote:
> > On Wed, Apr 03, 2019 at 11:53:26AM +0530, Balakrishna Godavarthi wrote:
> > > + Harish to update his findings on wcn3998.
> > > Mean time i will perform a regression to detect the failure.
> > 
> > On my system it typically reproduces within a few dozen
> > iterations. Make sure your tree doesn't contain any custom BT patches,
> > even if they just add logging or fix the timeout during
> > initialization. Since this problem is timing sensitive it might get
> > masked. My tree is based on 4.19 LTS with all QCA BT related changes
> > on top:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-4.19
> > 
> > I found some problems during initialization easier to reproduce
> > when binding and unbinding the device through sysfs, instead of
> > doing hciconfig up/down, this resembles more the initialization at
> > boot time.
> > 
> [Bala]: I am able to replicate this issue.
>         are you seeing the below error message getting logged on the console
> in the issue case or an different error message.
>         Bluetooth: hci0: QCA TLV response size mismatch

Yes, that's the error message. The size doesn't match because the
driver expects a TLV response but gets a baud rate response.
