Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312FF2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554154953;
	bh=+bI9lOnQ8yMBC/6vKeYZrlkKYkhlbuUbHoW5Wcph/3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IbqQmI8ZtUHwKhRlYt3USe2+TIRBOsm8RunL/T20TuBsmCJob/cBFPN4o15ZqcUNK
	 WF8X3klS24xS2nccDWKAY/9OGLi1uS/I8DT82A2CUlE6uropYrohnpdkplmyctmyeE
	 O2m1tq4XBELo6Ezcw/ONGHAGlzlamNCgJ4zL67Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDAVmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfDAVmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:42:31 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06652070B;
        Mon,  1 Apr 2019 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554154951;
        bh=+bI9lOnQ8yMBC/6vKeYZrlkKYkhlbuUbHoW5Wcph/3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yxdG1g3cmgAnDjIr2Y0KWliJh1djO1NNwmJ2Dd9TBW9+PUGrpcsQ22RiAtyXJFkro
         Y8R+K9DpxrpLR/p6bh6aF8WzzJ2Z9/ur4CD5nbsvxkLF5NXD+8YdUqHWn07rPPJ9bh
         u19pPDe+cAwZEVDsE8RRuRiZFNPY0/oNqUSmW5wI=
Received: by mail-ed1-f42.google.com with SMTP id h22so9749202edw.7;
        Mon, 01 Apr 2019 14:42:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXmqgDto23JPzNvGBH/A/XMoIRhHPoNaTQlFtiY1/RjpxoDKtFc
        wK8vg22GaTRtZUfxf27+StbtcOzsnP0zG/7dx54=
X-Google-Smtp-Source: APXvYqywx/Bok50DHYF/OKcxvzLRanVE783UVfThE5i0pjDBz7Nx5x5qC4lu+7ae1J/ayvkIL0nBjvLlcVbeM3OrA+c=
X-Received: by 2002:a50:a4db:: with SMTP id x27mr23669728edb.120.1554154948828;
 Mon, 01 Apr 2019 14:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-9-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-9-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 1 Apr 2019 16:41:52 -0500
X-Gmail-Original-Message-ID: <CANk1AXR_sp-w0D7ftkdMn-_PrvV1h5Qvg-qSUEE6ZRm9BvYZ1g@mail.gmail.com>
Message-ID: <CANk1AXR_sp-w0D7ftkdMn-_PrvV1h5Qvg-qSUEE6ZRm9BvYZ1g@mail.gmail.com>
Subject: Re: [PATCH 08/17] fpga: dfl: afu: add userclock sysfs interfaces.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:24 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looks fine.

>
> This patch introduces userclock sysfs interfaces for AFU, user
> could use these interfaces for clock setting to AFU.
>
> Please note that, this is only working for port header feature
> with revision 0, for later revisions, userclock setting is moved
> to a separated private feature, so one revision sysfs interface
> is exposed to userspace application for this purpose too.
>
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
