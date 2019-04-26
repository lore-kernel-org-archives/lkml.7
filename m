Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B059C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A2920869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEts8fJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfDZVGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:06:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40320 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDZVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:06:19 -0400
Received: by mail-vs1-f68.google.com with SMTP id r12so1819808vsp.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=26+4vPIr0HgkK6TSeXXOR7r/N2MsWPtygsTJAak7fo0=;
        b=FEts8fJnOm9wOpmTuq+vHE5H4i28mw+KOrrqpeUpPVZs/Zv6+vJlEpYanXNa4N9HRb
         hsMZKZzJsA3heaUaNkqhln7bqPkYJ7hbpMUBeiUdN9N0L82MSwuUiWfsJh7dhWroCv4Z
         BrQ5DGprFMn+FicbwyP8fWhdoGh6ic5o1uLlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=26+4vPIr0HgkK6TSeXXOR7r/N2MsWPtygsTJAak7fo0=;
        b=SJ+4Jd63aLpd7IfpIcmYu7naha5ooUj2omsiJPG1dthPu9JnwNVLr1MI20zWEAUGdm
         zsMrfhqPETp1oKtPrHMAbk10YahDrOtXsY+ebkd0Uh7vH+NQvkhlroG2FfY2EEF3M5BZ
         /ZfddVywzMP7Q+XAmrq0GzH11533FRB8W+irTXxM30oswwg+sy6Opbgj4Mt4DjhJeGYM
         xhmwBjqLuBTrqknn5b5i3vAAKCBx47vqvAzJWNzPZUuE+fYzGHrTnzRlkfH5fJ8V5m+o
         N+hq7jLiykgoG/mriH7/q0DxOackwcT1sc/gOcohofW1KutrRqMDZli0BzsNXrtoS4ZT
         pLlg==
X-Gm-Message-State: APjAAAXw6uURh6n23fviPnsRkcViT8WZ91JeTQQvbzCQKw8GK8WNQ92g
        m78WZ7pmbotOhM09l0JbkPPpoDIGs/M=
X-Google-Smtp-Source: APXvYqy1aFSHDUFwFq04Px/FnJefFi01LIewlbIYMt3GlcXyzLTL1KP1oK5IprOGCKLj7ooEu7fb7A==
X-Received: by 2002:a67:ff12:: with SMTP id v18mr11431649vsp.36.1556312777542;
        Fri, 26 Apr 2019 14:06:17 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id c2sm9849863vsc.32.2019.04.26.14.06.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 14:06:16 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id g16so1667980uad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:06:16 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr25397456uao.106.1556312775694;
 Fri, 26 Apr 2019 14:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555672441.git.arturp@synopsys.com> <87k1fis1b5.fsf@linux.intel.com>
 <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
 <SN1PR12MB24312AEFA71B7EEF6FE4EB59A73E0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WmtKYt5hn8s1PrjEgFcJqyc-8UWbyEmjPPVq0o4YgD5w@mail.gmail.com>
In-Reply-To: <CAD=FV=WmtKYt5hn8s1PrjEgFcJqyc-8UWbyEmjPPVq0o4YgD5w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Apr 2019 14:06:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WM7k-6moen+sgzZXnX-Zcw_BY9L=RTTrmt6pSHpXPLng@mail.gmail.com>
Message-ID: <CAD=FV=WM7k-6moen+sgzZXnX-Zcw_BY9L=RTTrmt6pSHpXPLng@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes.
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 26, 2019 at 9:01 AM Doug Anderson <dianders@chromium.org> wrote=
:
>
> Hi,
>
> On Fri, Apr 26, 2019 at 12:11 AM Artur Petrosyan
> <Arthur.Petrosyan@synopsys.com> wrote:
> >
> > Hi Doug,
> >
> > On 4/26/2019 00:13, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Apr 25, 2019 at 7:01 AM Artur Petrosyan
> > > <Arthur.Petrosyan@synopsys.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 4/25/2019 16:43, Felipe Balbi wrote:
> > >>> Artur Petrosyan <Arthur.Petrosyan@synopsys.com> writes:
> > >>>> This patch set, fixes and improves partial power down and hibernat=
ion power
> > >>>> saving modes. Also, adds support for entering/exiting hibernation =
by
> > >>>> system issued suspend/resume.
> > >>>>
> > >>>> This series contains patches which were submitted to LKML. However=
, a part
> > >>>> of those patches didn't reach to LKML because of local issue relat=
ed to
> > >>>> smtp server.
> > >>>>
> > >>>> The patches which reached to LKML are:
> > >>>>
> > >>>> - usb: dwc2: Add part. power down exit from dwc2_conn_id_status_ch=
ange().
> > >>>> - usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume() fu=
nction.
> > >>>> - usb: dwc2: Fix suspend state in host mode for partial power down=
.
> > >>>> - usb: dwc2: Fix wakeup detected and session request interrupt han=
dlers.
> > >>>> - usb: dwc2: Add descriptive debug messages for Partial Power Down=
 mode.
> > >>>> - usb: dwc2: Fix dwc2_restore_device_registers() function.
> > >>>>
> > >>>> The patches which didn't reach to LKML are:
> > >>>>
> > >>>> - usb: dwc2: Add enter/exit hibernation from system issued suspend=
/resume
> > >>>> - usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is genera=
ted.
> > >>>> - usb: dwc2: Clear fifo_map when resetting core.
> > >>>> - usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
> > >>>> - usb: dwc2: Fix hibernation between host and device modes.
> > >>>> - usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
> > >>>> - usb: dwc2: Add default param to control power optimization.
> > >>>> - usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
> > >>>>
> > >>>> Submitting all of the patches together in this version.
> > >>>>
> > >>>> Changes from V0:
> > >>>>    - Replaced 1 with DWC2_POWER_DOWN_PARAM_PARTIAL in commit
> > >>>>      "9eed02b9fe96 usb: dwc2: Fix wakeup detected and session requ=
est
> > >>>>      interrupt handlers.
> > >>>>
> > >>>>
> > >>>> Artur Petrosyan (14):
> > >>>>     usb: dwc2: Fix dwc2_restore_device_registers() function.
> > >>>>     usb: dwc2: Add descriptive debug messages for Partial Power Do=
wn mode.
> > >>>>     usb: dwc2: Fix wakeup detected and session request interrupt h=
andlers.
> > >>>>     usb: dwc2: Fix suspend state in host mode for partial power do=
wn.
> > >>>>     usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume()
> > >>>>       function.
> > >>>>     usb: dwc2: Add part. power down exit from
> > >>>>       dwc2_conn_id_status_change().
> > >>>>     usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
> > >>>>     usb: dwc2: Add default param to control power optimization.
> > >>>>     usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
> > >>>>     usb: dwc2: Fix hibernation between host and device modes.
> > >>>>     usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
> > >>>>     usb: dwc2: Clear fifo_map when resetting core.
> > >>>>     usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is gene=
rated.
> > >>>>     usb: dwc2: Add enter/exit hibernation from system issued
> > >>>>       suspend/resume
> > >>>
> > >>> patches don't apply.
> > >>>
> > >>
> > >> Do we need to wait for Minas's acknowledge or there is problem relat=
ed
> > >> to the patches?
> > >
> > > It looks like the problem is that my patches won the race and Felipe
> > > applied them before yours.  Thus, presumably, it'll be up to you to
> > > rebase your patches atop mine and re-submit.  Specifically, you can
> > > do:
> > >
> > > git remote add linux_usb_balbi
> > > git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
> > > git fetch linux_usb_balbi
> > > git checkout linux_usb_balbi/testing/next
> > >
> > > If you do that and then try to apply your patches you'll find that
> > > they no longer apply.  AKA try running:
> > >
> > > for patch in 10909749 10909737 10909739 10909745 10909533 \
> > >     10909531 10909747 10909535 10909523 10909741 10909525 \
> > >     10909751 10909527 10909743; do
> > >    curl -L https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__pat=
chwork.kernel.org_patch_-24-257Bpatch-257D_mbox&d=3DDwIBaQ&c=3DDPL6_X_6JkXF=
x7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLM=
gk9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3DaWT1hYtXeIeY8ClQ0sNYxwkmJFKDz4iaa4DchNw=
x3_w&e=3D | git am
> > > done
> > >
> > > You'll see:
> > >
> > >> Applying: usb: dwc2: Fix wakeup detected and session request interru=
pt handlers.
> > >> error: patch failed: drivers/usb/dwc2/core_intr.c:435
> > >> error: drivers/usb/dwc2/core_intr.c: patch does not apply
> > >> Patch failed at 0001 usb: dwc2: Fix wakeup detected and session requ=
est interrupt handlers.
> > >
> > > NOTE: before reposting it might be a good idea to apply the last 3
> > > patches in my series as per [1] before sending up your series.  Since
> > > Felipe has already applied patches #1 and #2 in that series presumabl=
y
> > > he'll also apply #3 - #5.
> > >
> > > I know it'a also up to me to try testing our your patches.  It's stil=
l
> > > on my list to give it a shot...
> > >
> > > [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kerne=
l.org_r_CAD-3DFV-3DWA07-2BgUkVvsikN-3DiDHZLUJQtzjkKtiBHAEDw4gLNWY7w-40mail.=
gmail.com&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeO=
QjP_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLMgk9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3D9Q=
P_h5ZlnT7ayUE1_6EVEgu8FaI3_kWm9xuzs1qrvdI&e=3D
> > >
> > > P.S: It's helpful if you CC LKML on patches and discussions about
> > > them.  That allows the magic "permalink via message ID" on
> > > lkml.kernel.org and also allows your patches to be found on
> > > lore.kernel.org/patchwork/
> > >
> > > -Doug
> > >
> >
> > Besides the issue that comes from the patch "usb: dwc2: Fix wakeup
> > detected and session request interrupt handlers." there is one more
> > serious conflict with one of your patches.
> >
> > So the patch "usb: dwc2: bus suspend/resume for hosts with
> > DWC2_POWER_DOWN_PARAM_NONE" have had also been added to the
> > "balbi/testing/next" before my patch series which conflicts with two of
> > my patches.
> >
> > 1. usb: dwc2: Fix suspend state in host mode for partial power down.
> > 2. usb: dwc2: Add enter/exit hibernation from system issued suspend/res=
ume
> >
> > This patch introduced by you "usb: dwc2: bus suspend/resume for hosts
> > with DWC2_POWER_DOWN_PARAM_NONE" got a little bit of issue. It
> > eliminates entering hibernation through system issued suspend by
> > checking "if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL)=
"
>
> To be fair, the patch does not make entering hibernation worse, does
> it?  Specifically, I'll point to this part of the diff:
>
> - if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {
> + if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL) {
>
> As you can see, if power_down =3D=3D DWC2_POWER_DOWN_PARAM_HIBERNATION th=
e
> flow for this "if" test is exactly the same before and after my patch.
>
>
> > . As per the patch you mention that it fixes suspend/resume flow for
> > Altera SOCFPGA and Chrome OS 3.14 kernel tree. I assume that the board
> > has the Partial Power Down enabled core that is why it works out.
>
> I mentioned some of this in my cover letter [1].  To rehash, I said
> "Turning on partial power down on rk3288 doesn't "just work".  I don't
> get hotplug events.  This is despite dwc2 auto-detecting that we are
> power optimized."
>
> ...it is certainly possible that partial power down would work on
> rk3288 if someone had the time to debug it.
>
> NOTE: I don't have an Altera SOCFPGA, but I'll mention that a previous
> iteration of my patch (written by Kever Yang at Rockchip) was reverted
> because it _broke_ Altera SOCFPGAS.  Given my requests to test the new
> version have been met with silence, I'm inclined to land this and hope
> it's all good.  If there are problems then hopefully some actual
> details can be provided.  Last time there were none provided.
>
>
> > However, we don't just support the Partial Power Down feature enabled
> > cores. We also support Hibernation feature enabled cores.
>
> Sure, but the code that is actually landed upstream (even before my
> series) almost certainly doesn't function for Hibernation.  As pointed
> out above the entire "_dwc2_hcd_suspend()" function had a great big:
>
> if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL)
>   goto skip_power_saving;
>
> ...which, as far as I could tell, meant that Hibernation could not
> possible work.
>
>
> > The patch set that had been introduced by me which includes "usb: dwc2:
> > Add enter/exit hibernation from system issued suspend/resume" patch add=
s
> > support for both hibernation and Partial Power Down feature enabled
> > cores and fixes several of Partial Power Down and hibernation related
> > issues.
> >
> > This patch set may fix all of the issues related with Altera SOCFPGA or
> > Chrome OS 3.14 kernel tree.
> >
> > That is why we asked you to test the patch set before we could ACK or
> > have chance to debug your patch deeper to see the help of it and to
> > provide you information related to it.
>
> It may well fix my problems and maybe I can use partial power down
> now.  That'd be nice.  It was on my list and I would have worked on it
> last week except that your patches weren't on the mailing list then.
> ...so I moved on to some other work.  To avoid context switching too
> much I needed to get to a stopping point before testing your patches.
> I was hoping to have some nice rebased patches from you to test today,
> but maybe I'll try a hand at rebasing them myself.
>
> NOTE also that though I ported this change from the Chrome OS 3.14
> kernel tree, I'm actually currently working on the Chrome OS 4.19
> tree.  I also made sure to test the changes on mainline Linux.
>
>
> > So now I can rebase my changes to the "balbi/testing/next" but I will
> > have to take the logic of skipping Hibernation out otherwise we will
> > have problems with hibernation enabled cores.
>
> As per above, please have a careful look at my patches and you'll see
> that I was not introducing code that skipped hibernation.  I was
> keeping the same flow as the old code that skipped hibernation.  So if
> you are making hibernation work there should be no problems removing
> that.
>
>
> > We can ask Balbi to permanently suspend adding of the patch "usb: dwc2:
> > bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE" and my
> > patch series to his "testing/next". After you can have a chance to test
> > my patch series we can see if the patches are acknowledged and ask Balb=
i
> >   to add them.
>
> Personally I'd prefer if Felipe finished landing my series and then
> you rebased atop it.  As I said I'm convinced I'm not making your
> hibernation case any worse.  If you know of actual things that are
> made worse by my series then that would be a reason not to land it,
> but so far I haven't been convinced.
>
>
> [1] https://lkml.kernel.org/r/20190418001356.124334-2-dianders@chromium.o=
rg

To add a bit of breadcrumbs, I did the rebase atop my patches and also
did some basic review of yours.  Other than a few nits I think I found
at least one bug where you're unlocking a spinlock twice in the
partial power down case.

I continue to be convinced that the right thing to do is to finish
landing my series and then once you've spun yours atop mine we can
look at landing it.

Here's all my picks atop Felipe's tree that show how I resolved
things:  https://chromium.googlesource.com/chromiumos/third_party/kernel/+l=
og/refs/sandbox/dianders/190426-dwc2-stuff


-Doug
