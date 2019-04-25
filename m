Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2CBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3F22084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556215689;
	bh=mM2waGQCnGKBXmQ+1Cz9C2QAtfI3HncCalnxazu97d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YVas678Ww1PqgFk7ZNTCDWIucxHHPA1BtvBfc9UXJMbPR5mKLXawASiMHmm4sO0nT
	 xsklGt1a3HonFOLTBSrwfTWhj5qexi/SCuUgLn4RaBn3piIsKsHJh3ewqRVuwaH5mb
	 P1aZZKsZpn5ydF4VMzSeiYS96O1wd2qQ+QhScdB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfDYSIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDYSIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:08:07 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D5420878;
        Thu, 25 Apr 2019 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556215687;
        bh=mM2waGQCnGKBXmQ+1Cz9C2QAtfI3HncCalnxazu97d8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kNAddwW8q1Zo4qmWmTXMdzjB9qVQamI2E83mvnEkMz6U386rFcbnhefIoqC1RQzFE
         gCLa5fxpuDiy6WUIuLdva+bLzSpM4K4zlyYBrGMPUlyx25gA7gxYBatTh31unCD9YL
         lh83aG/+N6qIikGY462bStfU5o7Pf8JEJE9EQrWI=
Received: by mail-qt1-f177.google.com with SMTP id g4so1114553qtq.10;
        Thu, 25 Apr 2019 11:08:06 -0700 (PDT)
X-Gm-Message-State: APjAAAVj0iNJYZLfT8VkQXu9O9dQt5JhKrP3lHIewxw6gYiv46UdxCiL
        D9/sI7pvX9lohgjbYTFONuqJ+rgFln2ZmlNV6w==
X-Google-Smtp-Source: APXvYqxl1eB+8DxdeRn1YTUBVgRbcMNGbGlIrlqDaBk745PWY737lfV4v2mz8AIBpix4GooLhv6sFERd4uiNAGNC63U=
X-Received: by 2002:ac8:7647:: with SMTP id i7mr31438312qtr.38.1556215685478;
 Thu, 25 Apr 2019 11:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Apr 2019 13:07:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com>
Message-ID: <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add of_ functions for device_link_add()
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 5:19 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> It could happen that we need to control suspend/resume ordering between
> devices without obvious consumer/supplier link. For example when touchscreens
> and DSI panels share the same reset line, in this case we need to be sure
> of pm_runtime operations ordering between those two devices to correctly
> perform reset.
> DSI panel and touchscreen aren't sharing any heriachical relationship (unlike
> I2C client and I2C bus or regulator client and regulator provider) so we need
> to describe this in device-tree.

Needing to know which touchscreen is attached to a panel could be
important to describe if you have multiple displays.

Doesn't the reset subsystem already have some support for shared
resets? Seems like it could provide clients with struct device or
device_node ptrs to other devices sharing a reset.

>
> This series introduce of_device_links_{add,remove} and devm_of_device_links_add()
> helpers to find and parse 'links-add' property in a device-tree node.

Going to document that property somewhere? :)

I think this is too generic and coupled to Linux. It doesn't have any
information as to what is the dependency or connection nor what the
direction of the dependency is.

I'm not convinced we need to solve this generically vs. defining
something for this specific example.

Rob
