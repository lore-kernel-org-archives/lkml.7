Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFCBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30B422CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="j++zj8lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfHTCSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:18:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35609 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfHTCR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:17:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so2924274oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 19:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAZ1DKclwBk3qGTCISZmLl9nQ8pdrslR5WbQgrKeNgI=;
        b=j++zj8lf48qrLqLQGMfBsGHVAuMO36GqhxxxwFu9F6qktIYLOFT9VF8ksNSIkrvrlL
         pRN+xQumjZNbttXaXGR9TByYzUhRHR8ktiZYEsFH5entlTKiLDcKX5LNvROI0fN6I41i
         kowti6oJ8aqI7NMSweTIWjMEBokzoGwyVdgBbdeTlbNTcMDzGOrhYN3z1glci9dVt4kO
         TpKL/UKw/Xr0/Zau3JuIe4cORZoRxkhP/qXW3mC9gMPPe+4CJtMQKBZKRZ9GIyZXwKpE
         kU+p7ENvtHkpq/Vf96++0PECMzQIYe70Zgwti9awgdXP1WwYH++F/v3wd8hnk5d8RR/v
         snUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAZ1DKclwBk3qGTCISZmLl9nQ8pdrslR5WbQgrKeNgI=;
        b=BPqnKc31cNoxHGZQwnrG9+xlGH8JWE64/o0VLQRpjrYuXvDDkUlOINdOI07h2N8fDH
         ocDqhot7xnN3yCkik/tzJMFCOQUtr0SMUCZO5zYUPiwy7i4NSxH8HVhEYkzShAcJu0dl
         l/6lYArJW6My4kmyKtP99vSuPIXnjD4askWEi/be5xN2zIC3euckPKu6OiMIw4kAqMOa
         ef4ZtF7LFTUOqsoCRhRSQxDljjUGWfv26BeVXnZWLPj5mfFau6dci0OhtmfbwqIsC6PV
         GAjvVBWfrELViv+7gXpeIZ9HB8nMHt6rz1rc7lFRA9CJpMk9wdhlkSaprNnHYByShQma
         DE7w==
X-Gm-Message-State: APjAAAW67quCLKdNn3XN5hepU3iCKxUjo8EDfxhoBivMf28HiqVgv4KL
        +df6STW8ZqPLfwVZYgiGunZoL1b5sWs2zj0bvbjCloRuV8I=
X-Google-Smtp-Source: APXvYqwHeT/aESUYbIUg84cxPXCn8xBO8F7c7d37ZEC8P0/FE1NWQioWuSQaVgbWwsRV8F54sPk0AzmSUFZlKSzVXNA=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr14608027oif.70.1566267478056;
 Mon, 19 Aug 2019 19:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org> <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com> <20190812180613.GA18377@infradead.org>
 <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
 <20190813072954.GA23417@infradead.org> <CAPcyv4h5kCKVyCjomBUY27MJwheDZ8v87+a9K-2YCgyqRWR7eQ@mail.gmail.com>
 <c023a18c-8b70-dc59-3db8-51d3a6b23d3c@silicom-usa.com> <CAPcyv4jcaY04nu31oStLc-eCO-+T1iOpxARmAHvPS1jxKF9cQA@mail.gmail.com>
 <40ef7e71-2c87-9853-fcbd-1510b97647f0@silicom-usa.com> <CAPcyv4ivzdEKbVepxcyJMmDmb5zG4Zvw+3f0rVJ8FOErK+c27g@mail.gmail.com>
 <f6399f3a-3899-2663-6667-e967eb43b156@silicom-usa.com>
In-Reply-To: <f6399f3a-3899-2663-6667-e967eb43b156@silicom-usa.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Aug 2019 19:17:47 -0700
Message-ID: <CAPcyv4giQDk3ZMzCUM5dv_QLk_NDVCeAgcTi-Mk-YVENq_xpjg@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device ID
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 9:30 AM Stephen Douthit
<stephend@silicom-usa.com> wrote:
>
> On 8/14/19 1:17 PM, Dan Williams wrote:
> >> Can you get someone from the controller design team to give us a clear
> >> answer on a revision where this PCS change happened?
> >>
> >> It would be nice if we could just check PCI_REVISION_ID or something
> >> similar.
> >
> > I don't think such a reliable association with rev-id exists, the> intent was that the OS need never consider PCS.
>
> Can you please ask to confirm?  It would be a much simpler check if it
> is possible.

No. Even if it were accidentally the case today the Linux driver can't
trust that rev-id across the different implementations will be
maintained for this purpose because the OS driver is not meant to
touch this register. Just look at a sampling of rev-id from a few
different systems, and note that rev-id applies to the chipset not
just the ahci controller.

    rev 08
    rev 11
    rev 31

...which one of those is Denverton?

The intent is that PCS is a platform-firmware concern and that any
software that cares about PCS is caring about it by explicit
identification.

> > The way Linux is using
> > it is already broken with the assumption that it is performed after
> > every HOST_CTL based reset which only resets mmio space. At most it
> > should only be required at initial PCI discovery iff platform firmware
> > failed to run.
>
> This is a separate issue.
>
> It's broken in the sense that the code is called more often that it
> needs to be, but reset isn't a hot path, and there are no side effects
> to doing this multiple times that I can see.

The problem is that there is no known need to do it for Denverton, and
likely more platform implementations.

>  And as you point out, no
> bug reports, so pretty benign all things considered.
>
> We could move the PCS quirk code to ahci_init_one() to address this
> concern once there's agreement on what the criteria is to run/not-run
> this code.
>
> > There are no bug reports with the current
> > implementation that only attempts to enable bits based on PORTS_IMPL,
> > so I think we are firmer ground trying to draw a line where the driver
> > just stops worrying about PCS rather than try to detect the layout.
>
> Someone at Intel is going to need to decide where/how to draw this line.

This is a case of Linux touching a "BIOS only" register and assuming
that the quirk is widely applicable. I think a reasonable fix is to
just whitelist all the known Intel ids, apply the PCS fixup assuming
the legacy configuration register location, and stop applying the
quirk by default.

Here is a proposed patch along these lines. I can send a
non-whitespace damaged version if this approach looks acceptable:

---

From f40a7f287c97cfba71393ccb592ba521e43d807b Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 11:30:37 -0700
Subject: [PATCH] libata/ahci: Drop PCS quirk for Denverton and beyond

The Linux ahci driver has historically implemented a configuration fixup
for platforms / platform-firmware that fails to enable the ports prior
to OS hand-off at boot. The fixup was originally implemented way back
before ahci moved from drivers/scsi/ to drivers/ata/, and was updated in
2007 via commit 49f290903935 "ahci: update PCS programming". The quirk
sets a port-enable bitmap in the PCS register at offset 0x92.

This quirk could be applied generically up until the arrival of the
Denverton (DNV) platform. The DNV AHCI controller architecture supports
more than 6 ports and along with that the PCS register location and
format were updated to allow for more possible ports in the bitmap. DNV
AHCI expands the register to 32-bits and moves it to offset 0x94.

As it stands there are no known problem reports with existing Linux
trying to set bits at offset 0x92 which indicates that the quirk is not
applicable. Likely it is not applicable on a wider range of platforms,
but it is difficult to discern which platforms if any still depend on
the quirk.

Rather than try to fix the PCS quirk to consider the DNV register layout
instead require explicit opt-in. The assumption is that the OS driver
need not touch this register, and platforms can be added to a whitelist
when / if problematic platforms are found in the future. The list in
ahci_intel_pcs_quirk() is populated with all the current explicit
device-ids with the expectation that class-code based detection need not
apply the quirk.

Reported-by: Stephen Douthit <stephend@silicom-usa.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/ahci.c | 211 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 184 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f7652baa6337..ceb38d205e1b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -623,30 +623,6 @@ static void ahci_pci_save_initial_config(struct
pci_dev *pdev,
        ahci_save_initial_config(&pdev->dev, hpriv);
 }

-static int ahci_pci_reset_controller(struct ata_host *host)
-{
-       struct pci_dev *pdev = to_pci_dev(host->dev);
-       int rc;
-
-       rc = ahci_reset_controller(host);
-       if (rc)
-               return rc;
-
-       if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-               struct ahci_host_priv *hpriv = host->private_data;
-               u16 tmp16;
-
-               /* configure PCS */
-               pci_read_config_word(pdev, 0x92, &tmp16);
-               if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
-                       tmp16 |= hpriv->port_map;
-                       pci_write_config_word(pdev, 0x92, tmp16);
-               }
-       }
-
-       return 0;
-}
-
 static void ahci_pci_init_controller(struct ata_host *host)
 {
        struct ahci_host_priv *hpriv = host->private_data;
@@ -849,7 +825,7 @@ static int ahci_pci_device_runtime_resume(struct
device *dev)
        struct ata_host *host = pci_get_drvdata(pdev);
        int rc;

-       rc = ahci_pci_reset_controller(host);
+       rc = ahci_reset_controller(host);
        if (rc)
                return rc;
        ahci_pci_init_controller(host);
@@ -884,7 +860,7 @@ static int ahci_pci_device_resume(struct device *dev)
                ahci_mcp89_apple_enable(pdev);

        if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-               rc = ahci_pci_reset_controller(host);
+               rc = ahci_reset_controller(host);
                if (rc)
                        return rc;

@@ -1619,6 +1595,181 @@ static void
ahci_update_initial_lpm_policy(struct ata_port *ap,
                ap->target_lpm_policy = policy;
 }

+static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct
ahci_host_priv *hpriv)
+{
+       static const struct pci_device_id ahci_pcs_ids[] = {
+               /* Historical ids, ambiguous if the PCS quirk is needed... */
+               { PCI_VDEVICE(INTEL, 0x2652), }, /* ICH6 */
+               { PCI_VDEVICE(INTEL, 0x2653), }, /* ICH6M */
+               { PCI_VDEVICE(INTEL, 0x27c1), }, /* ICH7 */
+               { PCI_VDEVICE(INTEL, 0x27c5), }, /* ICH7M */
+               { PCI_VDEVICE(INTEL, 0x27c3), }, /* ICH7R */
+               { PCI_VDEVICE(INTEL, 0x2681), }, /* ESB2 */
+               { PCI_VDEVICE(INTEL, 0x2682), }, /* ESB2 */
+               { PCI_VDEVICE(INTEL, 0x2683), }, /* ESB2 */
+               { PCI_VDEVICE(INTEL, 0x27c6), }, /* ICH7-M DH */
+               { PCI_VDEVICE(INTEL, 0x2821), }, /* ICH8 */
+               { PCI_VDEVICE(INTEL, 0x2822), }, /* ICH8 */
+               { PCI_VDEVICE(INTEL, 0x2824), }, /* ICH8 */
+               { PCI_VDEVICE(INTEL, 0x2829), }, /* ICH8M */
+               { PCI_VDEVICE(INTEL, 0x282a), }, /* ICH8M */
+               { PCI_VDEVICE(INTEL, 0x2922), }, /* ICH9 */
+               { PCI_VDEVICE(INTEL, 0x2923), }, /* ICH9 */
+               { PCI_VDEVICE(INTEL, 0x2924), }, /* ICH9 */
+               { PCI_VDEVICE(INTEL, 0x2925), }, /* ICH9 */
+               { PCI_VDEVICE(INTEL, 0x2927), }, /* ICH9 */
+               { PCI_VDEVICE(INTEL, 0x2929), }, /* ICH9M */
+               { PCI_VDEVICE(INTEL, 0x292a), }, /* ICH9M */
+               { PCI_VDEVICE(INTEL, 0x292b), }, /* ICH9M */
+               { PCI_VDEVICE(INTEL, 0x292c), }, /* ICH9M */
+               { PCI_VDEVICE(INTEL, 0x292f), }, /* ICH9M */
+               { PCI_VDEVICE(INTEL, 0x294d), }, /* ICH9 */
+               { PCI_VDEVICE(INTEL, 0x294e), }, /* ICH9M */
+               { PCI_VDEVICE(INTEL, 0x502a), }, /* Tolapai */
+               { PCI_VDEVICE(INTEL, 0x502b), }, /* Tolapai */
+               { PCI_VDEVICE(INTEL, 0x3a05), }, /* ICH10 */
+               { PCI_VDEVICE(INTEL, 0x3a22), }, /* ICH10 */
+               { PCI_VDEVICE(INTEL, 0x3a25), }, /* ICH10 */
+               { PCI_VDEVICE(INTEL, 0x3b22), }, /* PCH AHCI */
+               { PCI_VDEVICE(INTEL, 0x3b23), }, /* PCH AHCI */
+               { PCI_VDEVICE(INTEL, 0x3b24), }, /* PCH RAID */
+               { PCI_VDEVICE(INTEL, 0x3b25), }, /* PCH RAID */
+               { PCI_VDEVICE(INTEL, 0x3b29), }, /* PCH M AHCI */
+               { PCI_VDEVICE(INTEL, 0x3b2b), }, /* PCH RAID */
+               { PCI_VDEVICE(INTEL, 0x3b2c), }, /* PCH M RAID */
+               { PCI_VDEVICE(INTEL, 0x3b2f), }, /* PCH AHCI */
+               { PCI_VDEVICE(INTEL, 0x1c02), }, /* CPT AHCI */
+               { PCI_VDEVICE(INTEL, 0x1c03), }, /* CPT M AHCI */
+               { PCI_VDEVICE(INTEL, 0x1c04), }, /* CPT RAID */
+               { PCI_VDEVICE(INTEL, 0x1c05), }, /* CPT M RAID */
+               { PCI_VDEVICE(INTEL, 0x1c06), }, /* CPT RAID */
+               { PCI_VDEVICE(INTEL, 0x1c07), }, /* CPT RAID */
+               { PCI_VDEVICE(INTEL, 0x1d02), }, /* PBG AHCI */
+               { PCI_VDEVICE(INTEL, 0x1d04), }, /* PBG RAID */
+               { PCI_VDEVICE(INTEL, 0x1d06), }, /* PBG RAID */
+               { PCI_VDEVICE(INTEL, 0x2826), }, /* PBG RAID */
+               { PCI_VDEVICE(INTEL, 0x2323), }, /* DH89xxCC AHCI */
+               { PCI_VDEVICE(INTEL, 0x1e02), }, /* Panther Point AHCI */
+               { PCI_VDEVICE(INTEL, 0x1e03), }, /* Panther M AHCI */
+               { PCI_VDEVICE(INTEL, 0x1e04), }, /* Panther Point RAID */
+               { PCI_VDEVICE(INTEL, 0x1e05), }, /* Panther Point RAID */
+               { PCI_VDEVICE(INTEL, 0x1e06), }, /* Panther Point RAID */
+               { PCI_VDEVICE(INTEL, 0x1e07), }, /* Panther M RAID */
+               { PCI_VDEVICE(INTEL, 0x1e0e), }, /* Panther Point RAID */
+               { PCI_VDEVICE(INTEL, 0x8c02), }, /* Lynx Point AHCI */
+               { PCI_VDEVICE(INTEL, 0x8c03), }, /* Lynx M AHCI */
+               { PCI_VDEVICE(INTEL, 0x8c04), }, /* Lynx Point RAID */
+               { PCI_VDEVICE(INTEL, 0x8c05), }, /* Lynx M RAID */
+               { PCI_VDEVICE(INTEL, 0x8c06), }, /* Lynx Point RAID */
+               { PCI_VDEVICE(INTEL, 0x8c07), }, /* Lynx M RAID */
+               { PCI_VDEVICE(INTEL, 0x8c0e), }, /* Lynx Point RAID */
+               { PCI_VDEVICE(INTEL, 0x8c0f), }, /* Lynx M RAID */
+               { PCI_VDEVICE(INTEL, 0x9c02), }, /* Lynx LP AHCI */
+               { PCI_VDEVICE(INTEL, 0x9c03), }, /* Lynx LP AHCI */
+               { PCI_VDEVICE(INTEL, 0x9c04), }, /* Lynx LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c05), }, /* Lynx LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c06), }, /* Lynx LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c07), }, /* Lynx LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c0e), }, /* Lynx LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c0f), }, /* Lynx LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9dd3), }, /* Cannon Lake PCH-LP AHCI */
+               { PCI_VDEVICE(INTEL, 0x1f22), }, /* Avoton AHCI */
+               { PCI_VDEVICE(INTEL, 0x1f23), }, /* Avoton AHCI */
+               { PCI_VDEVICE(INTEL, 0x1f24), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f25), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f26), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f27), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f2e), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f2f), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f32), }, /* Avoton AHCI */
+               { PCI_VDEVICE(INTEL, 0x1f33), }, /* Avoton AHCI */
+               { PCI_VDEVICE(INTEL, 0x1f34), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f35), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f36), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f37), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f3e), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x1f3f), }, /* Avoton RAID */
+               { PCI_VDEVICE(INTEL, 0x2823), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x2827), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x8d02), }, /* Wellsburg AHCI */
+               { PCI_VDEVICE(INTEL, 0x8d04), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x8d06), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x8d0e), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x8d62), }, /* Wellsburg AHCI */
+               { PCI_VDEVICE(INTEL, 0x8d64), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x8d66), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x8d6e), }, /* Wellsburg RAID */
+               { PCI_VDEVICE(INTEL, 0x23a3), }, /* Coleto Creek AHCI */
+               { PCI_VDEVICE(INTEL, 0x9c83), }, /* Wildcat LP AHCI */
+               { PCI_VDEVICE(INTEL, 0x9c85), }, /* Wildcat LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c87), }, /* Wildcat LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9c8f), }, /* Wildcat LP RAID */
+               { PCI_VDEVICE(INTEL, 0x8c82), }, /* 9 Series AHCI */
+               { PCI_VDEVICE(INTEL, 0x8c83), }, /* 9 Series M AHCI */
+               { PCI_VDEVICE(INTEL, 0x8c84), }, /* 9 Series RAID */
+               { PCI_VDEVICE(INTEL, 0x8c85), }, /* 9 Series M RAID */
+               { PCI_VDEVICE(INTEL, 0x8c86), }, /* 9 Series RAID */
+               { PCI_VDEVICE(INTEL, 0x8c87), }, /* 9 Series M RAID */
+               { PCI_VDEVICE(INTEL, 0x8c8e), }, /* 9 Series RAID */
+               { PCI_VDEVICE(INTEL, 0x8c8f), }, /* 9 Series M RAID */
+               { PCI_VDEVICE(INTEL, 0x9d03), }, /* Sunrise LP AHCI */
+               { PCI_VDEVICE(INTEL, 0x9d05), }, /* Sunrise LP RAID */
+               { PCI_VDEVICE(INTEL, 0x9d07), }, /* Sunrise LP RAID */
+               { PCI_VDEVICE(INTEL, 0xa102), }, /* Sunrise Point-H AHCI */
+               { PCI_VDEVICE(INTEL, 0xa103), }, /* Sunrise M AHCI */
+               { PCI_VDEVICE(INTEL, 0xa105), }, /* Sunrise Point-H RAID */
+               { PCI_VDEVICE(INTEL, 0xa106), }, /* Sunrise Point-H RAID */
+               { PCI_VDEVICE(INTEL, 0xa107), }, /* Sunrise M RAID */
+               { PCI_VDEVICE(INTEL, 0xa10f), }, /* Sunrise Point-H RAID */
+               { PCI_VDEVICE(INTEL, 0x2822), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0x2823), }, /* Lewisburg AHCI*/
+               { PCI_VDEVICE(INTEL, 0x2826), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0x2827), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa182), }, /* Lewisburg AHCI*/
+               { PCI_VDEVICE(INTEL, 0xa186), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa1d2), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa1d6), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa202), }, /* Lewisburg AHCI*/
+               { PCI_VDEVICE(INTEL, 0xa206), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa252), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa256), }, /* Lewisburg RAID*/
+               { PCI_VDEVICE(INTEL, 0xa356), }, /* Cannon Lake PCH-H RAID */
+               { PCI_VDEVICE(INTEL, 0x0f22), }, /* Bay Trail AHCI */
+               { PCI_VDEVICE(INTEL, 0x0f23), }, /* Bay Trail AHCI */
+               { PCI_VDEVICE(INTEL, 0x22a3), }, /* Cherry Tr. AHCI */
+               { PCI_VDEVICE(INTEL, 0x5ae3), }, /* ApolloLake AHCI */
+               { PCI_VDEVICE(INTEL, 0x34d3), }, /* Ice Lake LP AHCI */
+
+               /*
+                * Known ids where PCS fixup is needed, be careful to
+                * check the format and location of PCS when adding ids
+                * to this list. For example Denverton supports more
+                * than 6 ports and changes the format of PCS, but
+                * deployed platforms are not known to require a PCS
+                * fixup.
+                */
+               { },
+       };
+       u16 tmp16;
+
+       if (!pci_match_id(ahci_pcs_ids, pdev))
+               return;
+
+       /*
+        * port_map is determined from PORTS_IMPL PCI register which is
+        * implemented as write or write-once register.  If the register
+        * isn't programmed, ahci automatically generates it from number
+        * of ports, which is good enough for PCS programming. It is
+        * otherwise expected that platform firmware enables the ports
+        * before the OS boots.
+        */
+       pci_read_config_word(pdev, 0x92, &tmp16);
+       if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
+               tmp16 |= hpriv->port_map;
+               pci_write_config_word(pdev, 0x92, tmp16);
+       }
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
        unsigned int board_id = ent->driver_data;
@@ -1731,6 +1882,12 @@ static int ahci_init_one(struct pci_dev *pdev,
const struct pci_device_id *ent)
        /* save initial config */
        ahci_pci_save_initial_config(pdev, hpriv);

+       /*
+        * If platform firmware failed to enable ports, try to enable
+        * them here.
+        */
+       ahci_intel_pcs_quirk(pdev, hpriv);
+
        /* prepare host */
        if (hpriv->cap & HOST_CAP_NCQ) {
                pi.flags |= ATA_FLAG_NCQ;
@@ -1840,7 +1997,7 @@ static int ahci_init_one(struct pci_dev *pdev,
const struct pci_device_id *ent)
        if (rc)
                return rc;

-       rc = ahci_pci_reset_controller(host);
+       rc = ahci_reset_controller(host);
        if (rc)
                return rc;

-- 
2.20.1
