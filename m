Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A12FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0029120851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKkRKM8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFDSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:20:47 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34507 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:20:46 -0400
Received: by mail-pf1-f180.google.com with SMTP id c85so4390908pfc.1;
        Tue, 04 Jun 2019 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rkSwU71K73scZ+gaddkeCEXxdBDgv49bmVU1xExpRSo=;
        b=jKkRKM8ez3ciBU6QKJC1DXaqmvggOmTW8dQdy1/qcEUfgjn3+AIObJrmSlYoboTCir
         p2v/Kv9PkrhSLr4BxjJMxQSLllOOMTM2ln98cG1mU8O5zPE19LoWziUyDTTVuGcRR7wW
         M0Bs9GQD4FrgIzx/gf2hGl9ohJxr0407NBMwbXoPBw0yHNvxfoqWgPCC9ljSFyYgOGPZ
         gCL9UiaKv8rv6tu0nkfsIw0UctBZ1cP5xXC7JZAwLr4tjoiZFQtOQtIaU9W0gSgY2CsL
         7m1EG36hk7Dysvsul+kO4UDebsQXxtP2RppzV3+4GUZ3IiejT0UdwMq1gaEbzQP7yy0K
         f+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkSwU71K73scZ+gaddkeCEXxdBDgv49bmVU1xExpRSo=;
        b=T1IdOGm8zD9aMTNnjNyxQsalIL5PqhGN0ZwwJBoFPvGaDtqmWrNtoqQJzamusd64TC
         9Z1nKntZEuWztGLhbE/WKPakIxdzVsAQrgq1jQ5j/h7P5XcFAyArMYuuQZfuvtTMhwaG
         y2b4eTKQKlNLB5HDrzvNA7bO6yvdvYn00mEjdgUdKKNNF0+6tlZjBGYMrcTljZt7thiw
         5bPQoqfE7my9sYAr3HBWgaJ8HtaNz6CWfzEytPMjliBvl8D/C3v9p5IbrtCnIJQ8puq/
         oz8qpUYPSU6hQank9Bzj4PNTb5CYKyVG+zCwXJU1FFYovKipXUzkaWcHBV3borhnmO4G
         e/Lg==
X-Gm-Message-State: APjAAAW5A52dPQj5ISTj4ahPIkMjl6GR6Z+5shN2P5SLmfmweXMg0TRR
        J3BIGaemedWhUprWWxRX6reBDMmA
X-Google-Smtp-Source: APXvYqwiSebMkHd42axWHMY4tve11l/QHgRBaJ2adjNS8DZHLvZUGcXQzFwWBosw4EzQ2VzE3rEysw==
X-Received: by 2002:a63:f54c:: with SMTP id e12mr33695pgk.62.1559672445760;
        Tue, 04 Jun 2019 11:20:45 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s42sm22991062pjc.5.2019.06.04.11.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 11:20:45 -0700 (PDT)
Subject: Re: Dynamic overlay failure in 4.19 & 4.20
To:     Phil Elwell <phil@raspberrypi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c5af11eb-afe5-08c4-8597-3195c25ba1d5@raspberrypi.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4d5b9fba-3879-0729-119a-f7d585a74cc1@gmail.com>
Date:   Tue, 4 Jun 2019 11:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c5af11eb-afe5-08c4-8597-3195c25ba1d5@raspberrypi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On 6/4/19 5:15 AM, Phil Elwell wrote:
> Hi,
> 
> In the downstream Raspberry Pi kernel we are using configfs to apply overlays at
> runtime, using a patchset from Pantelis that hasn't been accepted upstream yet.
> Apart from the occasional need to adapt to upstream changes, this has been working
> well for us.
> 
> A Raspberry Pi user recently noticed that this mechanism was failing for an overlay in
> 4.19. Although the overlay appeared to be applied successfully, pinctrl was reporting
> that one of the two fragments contained an invalid phandle, and an examination of the
> live DT agreed - the target of the reference, which was in the other fragment, was
> missing the phandle property.
> 
> 5.0 added two patches - [1] to stop blindly copying properties from the overlay fragments
> into the live tree, and [2] to explicitly copy across the name and phandle properties.
> These two commits should be treated as a pair; the former requires the properties that
> are legitimately defined by an overlay to be added via a changeset, but this mechanism
> deliberately skips the name and phandle; the latter addresses this shortcoming. However,
> [1] was back-ported to 4.19 and 4.20 but [2] wasn't, hence the problem.

I have relied upon Greg's statement that he would handle the stable kernels, and that
the process of doing so would not impact (or would minimally impact) maintainers.  If
I think something should go into stable, I will tag it as such, but otherwise I ignore
the stable branches.  For overlay related code specifically, my base standard is that
overlay support is an under development, not yet ready for prime time feature and thus
I do not tag my overlay patches for stable.

Your research and analysis above sound like there are on target (thanks for providing
the clear and detailed explanation!), so if you want the stable branches to work for
overlays (out of tree, as you mentioned) I would suggest you email Greg, asking that
the second patch be added to the stable branches.  Since the two patches you pointed
out are put of a larger series, you might also want to check which of the other
patches in that series were included in stable or left out from stable.  My suggestion
that you request Greg add the second patch continues to rely on the concept that
stable does not add to my workload, so I have not carefully analyzed whether adding
the patch actually is the correct and full fix, but instead am relying on your good
judgment that it is.

To give you some context on the patch series, I started with 144552c78692 ("of: overlay:
add tests to validate kfrees from overlay removal") due to my concerns with how
memory is allocated and freed for overlays.  The added tests exposed issues, and
the rest of the patches in the series were dealing with the issues that were
exposed.

You can see the full series (with maybe an extra patch or so) with
git log --oneline 144552c78692^..eeb07c573ec3


> The effect can be seen in the "overlay" overlay in the unittest data. Although the
> overlay appears to apply correctly, the hvac-large-1 node is lacking the phandle it
> should have as a result of the hvac_2 label, and that leaves the hvac-provider property
> of ride@200 with an unresolved phandle.
> 
> The obvious fix is to also back-port [2] to 4.19, but that leaves open the question of
> whether either the overlay application mechanism or the unit test framework should have
> detected the missing phandle.

Yes, unittest showed the missing phandle, as you described in the /proc view of
overlay.dts above.  That portion of unittest depends on someone looking at the
result of what is in /proc/device-tree and is not automated and is not documented.
I intend to automate that check someday, but the task is still languishing on my
todo list.

> 
> Phil
> 
> [1] 8814dc46bd9e ("of: overlay: do not duplicate properties from overlay for new nodes")
> [2] f96278810150 ("of: overlay: set node fields from properties when add new overlay node")
> 

