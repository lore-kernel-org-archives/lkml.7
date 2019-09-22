Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1AC4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64F020C01
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jznDIUba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfIVCO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:14:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44982 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfIVCOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:14:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so4909177pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Y6ym4Jb74HV5Ic0bRz8+IsF8ACoZYIX3JdjNQ9WH2D8=;
        b=jznDIUbabIy4oqDpnAtpS0LxnzoLlxdWBs9qGSpG9ZAqvbMNx4R8G4MwFRcOjCumgP
         c99f3UidfO27AxeR2CAAIOeCQyJ7gkZzDAoeCeIvpOHB4dUPQv66/0DGTX4au7Xaf9Zq
         AnKmGvuuZtf0wWd8tkuemIg5bggrNF7G33ed+l2Ak+MTbk0cqEXsJOrOaSo1Uo3vM2de
         4FK16k5e8ov1xLVm0//p6rjWftKvnNfBkvOnhxQS8zUYw1wFHOhBl2Zq9DeWZ5yNwMz6
         oCKIAj8GkGS5EBz8FHlG1WuY4aytC8LxLBqXTq0LHNZRpUV7+lSWMEhBIVp5Lgj80aCG
         kNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Y6ym4Jb74HV5Ic0bRz8+IsF8ACoZYIX3JdjNQ9WH2D8=;
        b=uPCJQ0eQEFUvvJ5B+oMH0ysfFGknvjpEjUPjQpGQQfUAcF0hbEPJHPOVKDW3lzBypV
         LiRq0XzfDXFy5lROzb252CxeyZHTCJJms6udPBK0Wa/779NpjRuooNH7/6zHAm7EId2y
         1DVNsZlq6BctUCGWGTXJbJ4Sl+3YPyWB7FjtvGCb8KKT63cN8d3NW+CTom03wqn64mVM
         CzyRpHX8eE49NKERyzbd0VkgVISkyimLpl2SgUl5LqL59kIaEGDB5rLt4PzqudIRDavd
         svM5+0lASMFtz4+OkZEwF4P4Jkci0z1cbbxq6pQYPyjsGkcOXEahQWEwMAh0PIacybH0
         a6Lw==
X-Gm-Message-State: APjAAAV2I9JlZ9ZaXnFs/qbAhccBavPBHWLVGYujqaZjUacovMIK/aLR
        W6bf83VpQfjcnfBwrLGUW3nOmfL4sgU=
X-Google-Smtp-Source: APXvYqw3LXv6NsBHRw9j/oiyHWwqS76ZeXOPDpafoCdZiYEV1bfYJjitqt40mLzVZGOJST1LVyodQg==
X-Received: by 2002:a17:902:b701:: with SMTP id d1mr23095246pls.209.1569118465126;
        Sat, 21 Sep 2019 19:14:25 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id g5sm7288490pgd.82.2019.09.21.19.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:14:24 -0700 (PDT)
Date:   Sat, 21 Sep 2019 19:14:21 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: remove netx ethernet driver
Message-ID: <20190921191421.102e6155@cakuba.netronome.com>
In-Reply-To: <20190918202243.2880006-1-arnd@arndb.de>
References: <20190918202243.2880006-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 22:21:24 +0200, Arnd Bergmann wrote:
> The ARM netx platform got removed in 5.3, so this driver
> is now useless.
>=20
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you!

FWIW there seems to be a lone mention of something called netx_timer in
linux-next, not sure if that's related too..

linux $ git grep netx_timer
Documentation/admin-guide/kernel-parameters.txt:                        [AR=
M] imx_timer1,OSTS,netx_timer,mpu_timer2,
