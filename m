Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57889C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EFD20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLnqbkZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfDYUMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:12:38 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45355 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbfDYUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:12:38 -0400
Received: by mail-vk1-f196.google.com with SMTP id h127so253432vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfNCC4cNJiY3lAUAdfNHomLA3rntwN1qhSdX3fgdF8U=;
        b=HLnqbkZwGIyYIxWOvDny5h/cIgWh9KBW/0awCRtKoyIvsow79Dykk74jMdsnNi+cMk
         L/PHBYJfjM6HYdfi7jTF2ZdRU1tsBP/ek9ss4dn6D9MMnz3ZpugTfutJn7f5STfouONU
         MfP44zMNQN3/TPuxiJyZj99PNzY1tlo992M1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfNCC4cNJiY3lAUAdfNHomLA3rntwN1qhSdX3fgdF8U=;
        b=B4JS/tg32lt2IHry1MXh/c/EONYzzxBfg1UyqmtixnfLepjfJ+3gjDbg/r7c89ZDoQ
         mQy9JhHhwfgDfa9WtLD92nH2mvjNvzAw+GBP4q9OKrxl7kauGnSgVqMbFVl/O5aoh2aQ
         AtafcbGkqwJZzARN/F/G0mRV0+5CXp2ECAnLYcNRRZ22vY4AVLd7ckcCxXoXhQ3unLbp
         6XThh+ol+KB3gwXsJbHt6mEupp5lKlhDBPHQgSF12Xy4SAzfHrcKtpR5YeQcNatAEU5T
         X9vQFBNeuhGcv32UYu9t+38NgKkqRvssRnL6AcLar1N+ALf9IEP83HXZgBAEykOId3gc
         mRIA==
X-Gm-Message-State: APjAAAXiwQzoPA5NOrWxG34b4OxfJ5s2MtW3ONWCnuwPas2qMA/sNtRo
        uCARxfsdDL3v8qN1nw2zIxpVIjUSkkk=
X-Google-Smtp-Source: APXvYqypJujhmE8BSK/LwUtgojy91/OS4qI9QcjjpZ42MN7IfIIYbpEEQJNT6MqDt8PFxtj/UosZcA==
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr22342633vku.44.1556223156479;
        Thu, 25 Apr 2019 13:12:36 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 2sm26979276vke.27.2019.04.25.13.12.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 13:12:35 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id w13so640529vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:12:35 -0700 (PDT)
X-Received: by 2002:a67:7b53:: with SMTP id w80mr22582363vsc.144.1556223154836;
 Thu, 25 Apr 2019 13:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555672441.git.arturp@synopsys.com> <87k1fis1b5.fsf@linux.intel.com>
 <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Apr 2019 13:12:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
Message-ID: <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes.
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 7:01 AM Artur Petrosyan
<Arthur.Petrosyan@synopsys.com> wrote:
>
> Hi,
>
> On 4/25/2019 16:43, Felipe Balbi wrote:
> > Artur Petrosyan <Arthur.Petrosyan@synopsys.com> writes:
> >> This patch set, fixes and improves partial power down and hibernation power
> >> saving modes. Also, adds support for entering/exiting hibernation by
> >> system issued suspend/resume.
> >>
> >> This series contains patches which were submitted to LKML. However, a part
> >> of those patches didn't reach to LKML because of local issue related to
> >> smtp server.
> >>
> >> The patches which reached to LKML are:
> >>
> >> - usb: dwc2: Add part. power down exit from dwc2_conn_id_status_change().
> >> - usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume() function.
> >> - usb: dwc2: Fix suspend state in host mode for partial power down.
> >> - usb: dwc2: Fix wakeup detected and session request interrupt handlers.
> >> - usb: dwc2: Add descriptive debug messages for Partial Power Down mode.
> >> - usb: dwc2: Fix dwc2_restore_device_registers() function.
> >>
> >> The patches which didn't reach to LKML are:
> >>
> >> - usb: dwc2: Add enter/exit hibernation from system issued suspend/resume
> >> - usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.
> >> - usb: dwc2: Clear fifo_map when resetting core.
> >> - usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
> >> - usb: dwc2: Fix hibernation between host and device modes.
> >> - usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
> >> - usb: dwc2: Add default param to control power optimization.
> >> - usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
> >>
> >> Submitting all of the patches together in this version.
> >>
> >> Changes from V0:
> >>   - Replaced 1 with DWC2_POWER_DOWN_PARAM_PARTIAL in commit
> >>     "9eed02b9fe96 usb: dwc2: Fix wakeup detected and session request
> >>     interrupt handlers.
> >>
> >>
> >> Artur Petrosyan (14):
> >>    usb: dwc2: Fix dwc2_restore_device_registers() function.
> >>    usb: dwc2: Add descriptive debug messages for Partial Power Down mode.
> >>    usb: dwc2: Fix wakeup detected and session request interrupt handlers.
> >>    usb: dwc2: Fix suspend state in host mode for partial power down.
> >>    usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume()
> >>      function.
> >>    usb: dwc2: Add part. power down exit from
> >>      dwc2_conn_id_status_change().
> >>    usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
> >>    usb: dwc2: Add default param to control power optimization.
> >>    usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
> >>    usb: dwc2: Fix hibernation between host and device modes.
> >>    usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
> >>    usb: dwc2: Clear fifo_map when resetting core.
> >>    usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.
> >>    usb: dwc2: Add enter/exit hibernation from system issued
> >>      suspend/resume
> >
> > patches don't apply.
> >
>
> Do we need to wait for Minas's acknowledge or there is problem related
> to the patches?

It looks like the problem is that my patches won the race and Felipe
applied them before yours.  Thus, presumably, it'll be up to you to
rebase your patches atop mine and re-submit.  Specifically, you can
do:

git remote add linux_usb_balbi
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
git fetch linux_usb_balbi
git checkout linux_usb_balbi/testing/next

If you do that and then try to apply your patches you'll find that
they no longer apply.  AKA try running:

for patch in 10909749 10909737 10909739 10909745 10909533 \
   10909531 10909747 10909535 10909523 10909741 10909525 \
   10909751 10909527 10909743; do
  curl -L https://patchwork.kernel.org/patch/${patch}/mbox | git am
done

You'll see:

> Applying: usb: dwc2: Fix wakeup detected and session request interrupt handlers.
> error: patch failed: drivers/usb/dwc2/core_intr.c:435
> error: drivers/usb/dwc2/core_intr.c: patch does not apply
> Patch failed at 0001 usb: dwc2: Fix wakeup detected and session request interrupt handlers.

NOTE: before reposting it might be a good idea to apply the last 3
patches in my series as per [1] before sending up your series.  Since
Felipe has already applied patches #1 and #2 in that series presumably
he'll also apply #3 - #5.

I know it'a also up to me to try testing our your patches.  It's still
on my list to give it a shot...

[1] https://lkml.kernel.org/r/CAD=FV=WA07+gUkVvsikN=iDHZLUJQtzjkKtiBHAEDw4gLNWY7w@mail.gmail.com

P.S: It's helpful if you CC LKML on patches and discussions about
them.  That allows the magic "permalink via message ID" on
lkml.kernel.org and also allows your patches to be found on
lore.kernel.org/patchwork/

-Doug
