Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D7B218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORLJ0Vg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCTWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:45:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38142 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfCTWpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:45:05 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so3643589ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pn/8P/PhErHRCIWKASPNB1+LPO19O+yI82+Xr6/z+BM=;
        b=ORLJ0Vg7Hu/oV6uzyAOhE6J9gbM9y7NrpZoX4bakOIXxECGyNue+IPGsgxKUHEdQrL
         oBfVOR+bK4nxSFpo+qRsiVmktDT6qP8PVDp0vO+HFP2t5VkuluxfdthY/Pax/eoYZI+m
         ZLIwTXRGZ3xziHOH2JbpUG677qM6KMnH6tH09YnSrQUcJxwaQ75ySJ2+Iv8cUqnZHK1y
         WSO3OHL9slLquaPSTSGTTvwPOb+Vox2ZLW14FvEfB2ZAMeb+2rFSItS+OBG3DIELMABs
         AqbbzVlABXB37iKzzD63sngPl4ePRyY+QsrQgquD4oPo4O+rO/B496rcVDKqHsL5Mh6C
         F/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn/8P/PhErHRCIWKASPNB1+LPO19O+yI82+Xr6/z+BM=;
        b=OGO60qnR+yNTHSQhgmJ7NVdQmF99uv6bQ8OAJshEPvCOstewKADperJZa+qOnpDyUK
         /x/FFII9xbgp0dJ1P1lb1YA87AHNS9LdKDqp8NDvRqySBjj1FB7f53skZ4FGe3VGq8w5
         CnStqjuPJprBTp8tbuGhQBPomhgONiW57TquzCpcrFgfbyG+zLPZClPHrstWmc91Mvy9
         WEYg0WwUlcNx/a8vlunQx6mik/Sa3shWIf4BxCDepXQlFG1ueqUsougLdVlITlEo6jLB
         XI2dawqXHSpyHHaOxGpWoHStIxeOqlm+h3UJE8OMQFYgvsarJvkujnF/0ZbisLB8oNOA
         hzTA==
X-Gm-Message-State: APjAAAWDbSocL7ArAQiQTLOCd1tmmLGv2375RyYsZ3HNHdQVbTExh4FR
        puKP4O6hQGRAWAb+XV9voZlCaEWY07jlNTHJNcOKbw==
X-Google-Smtp-Source: APXvYqxzXHcUzmAr+oZVnR+Q2MptMhvfvA/5nP35jFVLzlurRkS/ZygOTj+W9/murX8ECDAOXCE5EQDM52avJ1hMfXc=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr416094ios.269.1553121903765;
 Wed, 20 Mar 2019 15:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com>
In-Reply-To: <20190320222844.134765-1-furquan@google.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 20 Mar 2019 16:44:52 -0600
Message-ID: <CAEGmHFH3FBwXZEwF_rH69dBYFQegFJgcxt+5HPL_9sM_4pg+=A@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
To:     robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lv.zheng@intel.com, ericbakuladavis@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     Rajat Jain <rajatja@google.com>, Evan Green <evgreen@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding authors of the original commit whom I failed to copy in the
original patch.

On Wed, Mar 20, 2019 at 4:34 PM Furquan Shaikh <furquan@google.com> wrote:
>
> Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> clearing ACPI IRQs during suspend/resume") was added to stop clearing
> of event status bits unconditionally on suspend and resume paths. This
> was done because of an issue
> reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> lid status stays closed even on resume (which happens because event
> status bits are cleared unconditionally on resume). Though this change
> fixed the issue on suspend path, it introduced regressions on several
> resume paths.
>
> First regression was reported and fixed on S5 path by the following
> change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> entering S5"). Next regression was reported and fixed on all legacy
> sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> events when entering sleep states"). However, regression still exists
> on S0ix sleep path since it does not follow the legacy sleep path.
>
> In case of S0ix, events are enabled as part of device suspend path. If
> status bits for the events are set when they are enabled, it could
> result in premature wake from S0ix. This change ensures that status is
> cleared for any event that is being enabled so that any stale events
> are cleared out.
>
> Signed-off-by: Furquan Shaikh <furquan@google.com>
> ---
>  drivers/acpi/acpica/evgpe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> index 62d3aa74277b4..61455ab42fc87 100644
> --- a/drivers/acpi/acpica/evgpe.c
> +++ b/drivers/acpi/acpica/evgpe.c
> @@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
>
>         ACPI_FUNCTION_TRACE(ev_enable_gpe);
>
> -       /* Enable the requested GPE */
> +       /* Clear the GPE (of stale events) */
> +       status = acpi_hw_clear_gpe(gpe_event_info);
> +       if (ACPI_FAILURE(status))
> +               return_ACPI_STATUS(status);
>
> +       /* Enable the requested GPE */
>         status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
>         return_ACPI_STATUS(status);
>  }
> --
> 2.21.0.225.g810b269d1ac-goog
>
