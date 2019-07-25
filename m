Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041F722BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564074015;
	bh=rUvoep2pM3vj54Sm9rSlOTf9dMwrZBVrNG/VMRkq86k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FO6agGGsHJW1yVkXD3Vuvy9/a8sEmAC/iZJsk0IcbX/nkmFOoqj1wsJi4y4JKEESM
	 tsAJAGwi/yxOeq1ryyeGMD/Ft2rVTqIsoHr7GjU58KJ9PPljVgb8ck2hisvy8d2IQW
	 UWFhtxwv7Rfa97FbyOD5DexvIVq5WTs6EMGG0Svg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbfGYRAN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:00:13 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42023 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390569AbfGYRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:00:11 -0400
Received: by mail-ot1-f53.google.com with SMTP id l15so52362955otn.9;
        Thu, 25 Jul 2019 10:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nu/6Jl+HBxw+VOc7p7gwAZO2Ah9nif6btTNqwzyXHtE=;
        b=O+R17amnJVwwSrN2r/mXQM1Ffb1NEvNztBmT7KJ903OZGDe52Ubo1xMK3rS37YZxl3
         DPLogO/0u/H6kihu7SIuPGQ2oXPwE3KzSyJGU55yuYnSG9lXlRH1sadVf/DvT+Q0PXe/
         tLGmMdt1mwoPqCfiv3R/qtrM+lQ0YgcttVVHzwK+mRxQWSgKgUH3UKiMgdmv/Vr5zZ7L
         DqH6eYZ5Cu/2uxrhdpQULs8inSPtrhblWcrti9JPlQfkDPYf/JPq2CLmT1L4CW6sIqWL
         pYxoT+TDL7B8bnIOnWKwrnRGyax0K/rAB+fyaDsoq/R3rUMRiAD14kW99kEoE64jDVeV
         a51w==
X-Gm-Message-State: APjAAAWeJS90Wy8S/KZidW3CebPKmLqMjNNfFGwGUs/ZHJ+VMu5zgOBl
        zNCFwlmgzxOF6zWg83vsJH8jhpOoTmz8FxsoiCY=
X-Google-Smtp-Source: APXvYqzMgHXa1Gkf/c/ovl2wHUVQ2oCDhTGepbQxnE05RSibxMVYVgLmVpuyMF6RzbOdNMUmQ/gQHjcIFBrqMNisrZo=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr61254051otp.189.1564074010668;
 Thu, 25 Jul 2019 10:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <2332799.izEFUvJP67@kreacher> <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
In-Reply-To: <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jul 2019 18:59:59 +0200
Message-ID: <CAJZ5v0h++56je0z_3f9K9g3qtZMcquKC=7Ew+fmu6+KjCsjMWA@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 4:02 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Rafael,
>
> at 17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> > Hi Keith,
> >
> > Unfortunately,
> >
> > commit d916b1be94b6dc8d293abed2451f3062f6af7551
> > Author: Keith Busch <keith.busch@intel.com>
> > Date:   Thu May 23 09:27:35 2019 -0600
> >
> >     nvme-pci: use host managed power state for suspend
> >
> > doesn't universally improve things.  In fact, in some cases it makes
> > things worse.
> >
> > For example, on the Dell XPS13 9380 I have here it prevents the processor
> > package
> > from reaching idle states deeper than PC2 in suspend-to-idle (which, of
> > course, also
> > prevents the SoC from reaching any kind of S0ix).
> >
> > That can be readily explained too.  Namely, with the commit above the
> > NVMe device
> > stays in D0 over suspend/resume, so the root port it is connected to also
> > has to stay in
> > D0 and that "blocks" package C-states deeper than PC2.
> >
> > In order for the root port to be able to go to D3, the device connected
> > to it also needs
> > to go into D3, so it looks like (at least on this particular machine, but
> > maybe in
> > general), both D3 and the NVMe-specific PM are needed.
> >
> > I'm not sure what to do here, because evidently there are systems where
> > that commit
> > helps.  I was thinking about adding a module option allowing the user to
> > override the
> > default behavior which in turn should be compatible with 5.2 and earlier
> > kernels.
>
> I just briefly tested s2i on XPS 9370, and the power meter shows a 0.8~0.9W
> power consumption so at least I don’t see the issue on XPS 9370.

It works for me on a XPS13 9360 too, only the 9380 is problematic.

> Can you please provide the output of `nvme id-ctrl /dev/nvme*` and I’ll
> test the NVMe controller on XPS 9380.

I'll reply to Keith with that later.
