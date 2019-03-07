Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E233920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LWMljVSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCGU1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:27:48 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41262 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCGU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:27:48 -0500
Received: by mail-yw1-f65.google.com with SMTP id q128so14444555ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 12:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBlNSo7HAYuMJs+aJMR6Uu2EgbzXOL50Q/wOaOFZ/hE=;
        b=LWMljVSp3x/sn+xiSUMQbv2Yrd0xIM3aRcyEgRhsi0BUnRCjybbySQeZRtZ3fan8Pg
         uy7KXVN7ZNT6AB9rwzbRLsACMZoFhJLvI+8VDGTTAeF6uBx63NV3Sxtznm+doY/uDFbd
         SAF16pVcuWpCLEUWHcycErmsH1fWjH8B+nL/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBlNSo7HAYuMJs+aJMR6Uu2EgbzXOL50Q/wOaOFZ/hE=;
        b=WX0FIQWTT8YfKCcALSf9x9sTq7fKqLhXOsLdYEd0ArUTZ1mHJBZdUKWAEwiWoSif6+
         83owq9v5HK5DyIiV5jAc3D8dYHZ/bZY4XpXE1cq3DKn33utNjLQ1URWgQ9DfNF05yfoz
         LJVaNeAU+MYiQXyapkfoiOD39pIiiURGn1BPKxm2aeqo9N9WugUVXrUq6YAcGHmmtxk+
         1YbOZvd15kc2VjRou4jU2on0I23Lqa4bhH7aXG/VJFk7xINMyhrnu2yIHwOFMdxRj5ZS
         uNaun+LVnb0UrVVkDQ83tU2/gz27UhM0mX4tJKgyosqUOdGk9+1RX2EOvp85KmsZ2XDW
         ARbQ==
X-Gm-Message-State: APjAAAVg8SG+lqpN3JdyNErKY1yrkTFj+CZVNaIXPxOYwcwCN/H5cVbB
        UIEyEB966xmB6/JYksL0TsX8rJ8i4AJdyRCTYnSM3Q==
X-Google-Smtp-Source: APXvYqx8b1nup2SRjQJqro5PE0fKjmaOsZHNqPngWmsjb1l1nGOL7XQQQb40SEfTqKxxETgOm8z6qPkdp505nkodpgQ=
X-Received: by 2002:a0d:e607:: with SMTP id p7mr11306266ywe.329.1551990466813;
 Thu, 07 Mar 2019 12:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com> <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
In-Reply-To: <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 7 Mar 2019 12:27:35 -0800
Message-ID: <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        rajatja@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas,

I am looking at problem on a laptop machine that suspends to S01x, but
link_management is set to max_performance, because the machine is
connected to a charger.
Given DVLSP must be set before the laptop suspends ["""One of the
requirement for modern x86 system to enter lowest power mode  (SLP_S0)
is SATA IP block to be off."""], the machine never reaches S01x.
Does it make sense to change the target_lpm_policy at suspend
(ata_port_suspend()) to min_power and bring it back to the original
value on resume?

Gwendal.


On Mon, Jul 30, 2018 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Jul 30, 2018 at 05:26:45PM +0200, Hans de Goede wrote:
> > Hi,
> >
> > On 30-07-18 17:22, Tejun Heo wrote:
> > >On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
> > >>Hi Tejan,
> > >>
> > >>On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> > >>>Some minor fixes to be able to correctly set devslp register
> > >>>to optimize power.
> > >>>
> > >>>Srinivas Pandruvada (2):
> > >>>   ata: libahci: Correct setting of DEVSLP register
> > >>>   ata: libahci: Allow reconfigure of DEVSLP register
> > >>>
> > >>Are you applying this series?
> > >
> > >I was waiting for Hans's reviews.  Hans, what do you think?
> >
> > Ah I missed that this was another series. With the caveat that
> > I do not really know that much about devslp, both patches
> > seem sensible to me, so both are:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Applied 1-2 to libata/for-4.19.
>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
