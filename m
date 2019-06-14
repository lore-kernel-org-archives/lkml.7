Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E716C31E49
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59A2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m86vUKlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFNA7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:59:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40557 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNA7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:59:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so489345lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 17:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I98oqQdWH0Mw6Xky+e35CPphdJz8Kck/GJTzPjc3tTc=;
        b=m86vUKlQ5YDSeLdsPSxt2prdHbQs2B+ZLCQyCjgTQ4XxEhaExIG4MVOtJZ2Rxv4BWB
         OnqxPu2Zs0EBCiEM8yaicvi99+VuPs4kRUAsF+DOoMsNhBoJdhjG52b7gWT1OVqfprBD
         bFTu53qvb0g8WsRqm2ycpLwX3/rFbOt4C8MuoNAYZkymmThu9YJvadbaThMdcIdPf3f2
         TFC7SdjwKdj6SC/Q9Devf27OW1PXhhi61Cc4zoZMszqkk8dP1cgmXALP7M7RXuyNcPq2
         fML/W6Dfr7kw97sKJygEzaN+5XCfmaYDNSjI1eyjc7IZ76XXTLVHwr7ClthlP9luANHI
         qr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I98oqQdWH0Mw6Xky+e35CPphdJz8Kck/GJTzPjc3tTc=;
        b=HrWr6ueAc74mXThIaHaJ+/3utc3NOX8VR2SbYXE7sBH1hMhS+O62FsR0d0WtFmj5Gr
         gw1d3m9TAHR8f/CtLlj6/QVnKbaT81mk1khdHwZd3kdcjH6acE6PfOHRo8CE9zr9rWTe
         ZqlqGfMFdbhNuzEsbxzZapwtq0Odg5CJ/rpWwb2UE7IlcJ/w9EW4hJp0AYykNffAkCuX
         bXg+owv4W0gQ0BSi2Bp+1/2OOBNRih+ChM0mQQVatDLub28w999AqTraJgrUzb8Y5rv2
         88EK1gaNNGC+UsiA9wFvR+Ch1XiwrvzgWB49zpG9ae7WO531cpdntsgu3MlrYJcLGFB1
         DvoQ==
X-Gm-Message-State: APjAAAWh6eFB56TwpAUNSA4jdU52LJCe2NePbxqIk/Q2J+w1QJ8IjtCB
        SjkyuorjQU0I8hGR1bgVqCYBIf1nFAzSZFnepScymg==
X-Google-Smtp-Source: APXvYqxa8i4seJt+9sQManfHUjpo6iIyu8cCnEkRp5QyNecroE6qCOITvQU8pCRJ3t73s2XvMb32/2GnFwaKqCjMXis=
X-Received: by 2002:a19:488e:: with SMTP id v136mr44908837lfa.192.1560473948895;
 Thu, 13 Jun 2019 17:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190516193616.252788-1-furquan@google.com> <13361760.nMXA0SR1Mq@kreacher>
In-Reply-To: <13361760.nMXA0SR1Mq@kreacher>
From:   Furquan Shaikh <furquan@google.com>
Date:   Thu, 13 Jun 2019 17:58:54 -0700
Message-ID: <CAEGmHFFmfyB=bEx_UMi4ZGeTR9Bxs2TdnscyzJMrv2fW1_fDMg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Clear wake-up device GPEs before enabling
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:24 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, May 16, 2019 9:36:16 PM CEST Furquan Shaikh wrote:
> > This change clears GPE status for wake-up devices before enabling that
> > GPE. This is required to ensure that stale GPE status does
> > not result in pre-mature wake on enabling GPE for wake-up devices.
> >
> > Without this change, here is the sequence of events that is causing
> > suspend aborts on recent chrome books:
> >
> > 1. System decides to enter sleep.
> > 2. All devices in the system are put into low power mode.
> > 3. This results in acpi_dev_suspend being called for each ACPI
> > device.
> > 4. If the device is wake capable, then acpi_dev_suspend calls
> > acpi_device_wakeup_enable to enable GPE for the device.
> > 5. If GPE status is already set, enabling GPE for the wakeup device
> > results in generating a SCI which is handled by acpi_ev_detect_gpe
> > ultimately calling wakeup_source_activate that increments wakeup
> > events, and thus aborting the suspend attempt.
> >
> > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > ---
> >  drivers/acpi/device_pm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index b859d75eaf9f6..e05ee3ff45683 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> > @@ -721,6 +721,8 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
> >       if (error)
> >               goto out;
> >
> > +     acpi_clear_gpe(wakeup->gpe_device, wakeup->gpe_number);
> > +
> >       status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> >       if (ACPI_FAILURE(status)) {
> >               acpi_disable_wakeup_device_power(adev);
> >
>
> This patch may cause events to be missed if the GPE.  I guess what you reall mean is
> something like the patch below.

Thanks for the patch Rafael! This indeed fixes the issue on my platform.

FWIW, Tested-By: Furquan Shaikh <furquan@google.com>

>
> This should allow the kernel to see the events generated before the GPEs are
> implicitly enabled, but it should clear them for the explicit users of acpi_enable_gpe().
>
> Mika, what do you think?
>
> ---
>  drivers/acpi/acpica/acevents.h |    3 ++-
>  drivers/acpi/acpica/evgpe.c    |    8 +++++++-
>  drivers/acpi/acpica/evgpeblk.c |    2 +-
>  drivers/acpi/acpica/evxface.c  |    2 +-
>  drivers/acpi/acpica/evxfgpe.c  |    2 +-
>  5 files changed, 12 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpica/acevents.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/acevents.h
> +++ linux-pm/drivers/acpi/acpica/acevents.h
> @@ -69,7 +69,8 @@ acpi_status
>  acpi_ev_mask_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 is_masked);
>
>  acpi_status
> -acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
> +acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info,
> +                         u8 clear_on_enable);
>
>  acpi_status
>  acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
> Index: linux-pm/drivers/acpi/acpica/evgpe.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evgpe.c
> +++ linux-pm/drivers/acpi/acpica/evgpe.c
> @@ -146,6 +146,7 @@ acpi_ev_mask_gpe(struct acpi_gpe_event_i
>   * FUNCTION:    acpi_ev_add_gpe_reference
>   *
>   * PARAMETERS:  gpe_event_info          - Add a reference to this GPE
> + *              clear_on_enable         - Clear GPE status before enabling it
>   *
>   * RETURN:      Status
>   *
> @@ -155,7 +156,8 @@ acpi_ev_mask_gpe(struct acpi_gpe_event_i
>   ******************************************************************************/
>
>  acpi_status
> -acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
> +acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info,
> +                         u8 clear_on_enable)
>  {
>         acpi_status status = AE_OK;
>
> @@ -170,6 +172,10 @@ acpi_ev_add_gpe_reference(struct acpi_gp
>
>                 /* Enable on first reference */
>
> +               if (clear_on_enable) {
> +                       (void)acpi_hw_clear_gpe(gpe_event_info);
> +               }
> +
>                 status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
>                 if (ACPI_SUCCESS(status)) {
>                         status = acpi_ev_enable_gpe(gpe_event_info);
> Index: linux-pm/drivers/acpi/acpica/evgpeblk.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evgpeblk.c
> +++ linux-pm/drivers/acpi/acpica/evgpeblk.c
> @@ -453,7 +453,7 @@ acpi_ev_initialize_gpe_block(struct acpi
>                                 continue;
>                         }
>
> -                       status = acpi_ev_add_gpe_reference(gpe_event_info);
> +                       status = acpi_ev_add_gpe_reference(gpe_event_info, FALSE);
>                         if (ACPI_FAILURE(status)) {
>                                 ACPI_EXCEPTION((AE_INFO, status,
>                                         "Could not enable GPE 0x%02X",
> Index: linux-pm/drivers/acpi/acpica/evxface.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evxface.c
> +++ linux-pm/drivers/acpi/acpica/evxface.c
> @@ -971,7 +971,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
>               ACPI_GPE_DISPATCH_METHOD) ||
>              (ACPI_GPE_DISPATCH_TYPE(handler->original_flags) ==
>               ACPI_GPE_DISPATCH_NOTIFY)) && handler->originally_enabled) {
> -               (void)acpi_ev_add_gpe_reference(gpe_event_info);
> +               (void)acpi_ev_add_gpe_reference(gpe_event_info, FALSE);
>                 if (ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
>
>                         /* Poll edge triggered GPEs to handle existing events */
> Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
> +++ linux-pm/drivers/acpi/acpica/evxfgpe.c
> @@ -108,7 +108,7 @@ acpi_status acpi_enable_gpe(acpi_handle
>         if (gpe_event_info) {
>                 if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
>                     ACPI_GPE_DISPATCH_NONE) {
> -                       status = acpi_ev_add_gpe_reference(gpe_event_info);
> +                       status = acpi_ev_add_gpe_reference(gpe_event_info, TRUE);
>                         if (ACPI_SUCCESS(status) &&
>                             ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
>
>
>
>
