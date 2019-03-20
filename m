Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A667C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DD0218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553123502;
	bh=kIItjFpUBiWXnKhT03wNWRbqEQh7Ancu0BelUUI3jQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sijnz3YOjdh+SccevR0coLgk5Q/V0Ll9PS+P6OA0TqCYp1y5vkaAvLjZrbnanIDnp
	 OQML2q7XSfbP67iQI4M5v1Y3uIifXMWo/CjV0b+W6UIE6lE15cGL8fnLx0sBXH2/lE
	 BWdTHbE7tgLFDYMlIbErhBwQZVgfv6cGyyFy5ckU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCTXLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:11:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37254 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:11:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so3267899oif.4;
        Wed, 20 Mar 2019 16:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxuFz/8hZxDZcy/HDHdo+KdLu6FiusBXJmBPXmDCquo=;
        b=Z7N/Ta+qmPQe0pFmgBwSKF8T2zInsuk0isqDRPaD9gZiqkm4rg1n2ztT1jcoxxqU39
         Sk29FvMEzp2jrRwM8VQyi01oXCsCzQ0jKu4OLb3DokX5n8yefb8icLIS/VPSwPoUv6qt
         gFcQpXx+gftC6GcYHZPgzj4Ok8F3g5TDPCYKNqSwxcJYDRIWWuEu+FVIU0uCs3+3iXwy
         flj3gIg1SdkDOUZcdkR4onzA2I6Hen/2K4EKlJ6Bq1hcXAueLcRrW8JPmQ7TpGXhSNzk
         ogPN4C3w5BTuq6t0K5GKv/oKs846XZumCg3U9ecvAujP5qWpZXC8ZzvWkcdrCdT3PnRY
         IieQ==
X-Gm-Message-State: APjAAAU68m8X1fCrCCJkO9lA9qyAVdTpFvpLB4PLeGIoBBXq5AmWmUQf
        lbGMmCuekbn8YDj0YpH9ufc0fK+j4M6v7ckJX60=
X-Google-Smtp-Source: APXvYqxo6GTdqQrAYrjOkptAszHDve7g4P88EkY2z7EJcwZ2ynHSrXl6OxDQH48MZIhcoWdpxc7N3L5+q/+0nnrPHpY=
X-Received: by 2002:aca:eb93:: with SMTP id j141mr346148oih.178.1553123499152;
 Wed, 20 Mar 2019 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com>
In-Reply-To: <20190320222844.134765-1-furquan@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Mar 2019 00:11:28 +0100
Message-ID: <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
To:     Furquan Shaikh <furquan@google.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>, evgreen@google.com,
        dlaurie@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
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

What exactly is failing?

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

Well, this may cause events to be missed.

>
> +       /* Enable the requested GPE */
>         status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
>         return_ACPI_STATUS(status);
>  }
> --
> 2.21.0.225.g810b269d1ac-goog
>
