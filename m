Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E169C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518021881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567459935;
	bh=x77v7RfHxQP8XO6g/tjhFD4cAswr8tDwaEbOrs07xeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RuX6vrAgpbI2w2yKH1Iuhia448Fed3bRlNLw3v1E2AUElzuBcrfuKaaaZArIobXRq
	 tZ3jCMhYOWWNPIAnStKuRWhQpShhwBC+5QvEKoPOhLSENdTxTetK7akoTRdYUzosrf
	 jwetRyneqwdZuuYdPXd5mL6CooSvBe351yBfl00s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfIBVcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:32:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43090 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:32:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id 90so10830825otg.10;
        Mon, 02 Sep 2019 14:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRzaQ7RpTXTj09HDdlktAr/ebyQQrL0kch2BnxuHgVM=;
        b=GPqChi5ZEQEJ2d6snw08BqkZoUfTizyDuyx91exo8Ojx18+lgomU/WROvx1jQtPZ1o
         8rIghigt3pNT9eCnotG236Q9G+mbjSWGlK9a4bCfQeqHBrg1PIA+lcA4R+b919x6MGPF
         CfGbTH9T8aOFPb66/yGmcJfbCyJ4fsvS963PQkpjs7OWA9U9uqkK1T7OBXTP+PcUFvsP
         nM/0wpy5EE3gwtwxwvWftIb4RrBBIlzSVwI8lx0puDFK9h2lEJRgA+6iWCWfl46jQ+IK
         9TFr+lMe8ULfDO84JKlLNYCyQTjdb8phYQY+MTy2Vvck7zFv869tS/ajd41eYm6DD9oi
         lGzg==
X-Gm-Message-State: APjAAAWMn41siAlUT6+C55eDkyw3pfaGc1RjjOmJCWPszxsNe787fUpI
        Q6HGn1r6AtXlP9Ba9xW6h8NeGl1DxBf7dq9vSdxW0w==
X-Google-Smtp-Source: APXvYqxFaje6DHixq3AXTitOhl/CdjQent8WfatECLamdB5wUhfMK3ec5uVdGchXtjQ9kQC/iwqzzDSlffmJFXUHlug=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr5860561otk.118.1567459933133;
 Mon, 02 Sep 2019 14:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1567240295-44686-1-git-send-email-tiantao6@huawei.com>
In-Reply-To: <1567240295-44686-1-git-send-email-tiantao6@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:32:01 +0200
Message-ID: <CAJZ5v0huLagaNiK38JRaYY7=N38HSrHSqbw-HJiQDUmg_HTE2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Namespace: fix the no brace needed warning
To:     tiantao <tiantao6@huawei.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Len Brown <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 10:34 AM tiantao <tiantao6@huawei.com> wrote:
>
> for if else statements having single block no braces are needed fixed
> the following checkpatch warning
>
> WARNING: braces {} are not necessary for any arm of this statement
> +               if (!prev_node) {
> [...]
> +               } else {
> [...]
>
> Signed-off-by: tiantao <tiantao6@huawei.com>
> ---
>  drivers/acpi/acpica/nsaccess.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> index 2566e2d..7cef22a 100644
> --- a/drivers/acpi/acpica/nsaccess.c
> +++ b/drivers/acpi/acpica/nsaccess.c
> @@ -109,11 +109,10 @@ acpi_status acpi_ns_root_initialize(void)
>                 new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
>                 new_node->type = init_val->type;
>
> -               if (!prev_node) {
> +               if (!prev_node)
>                         acpi_gbl_root_node_struct.child = new_node;
> -               } else {
> +               else
>                         prev_node->peer = new_node;
> -               }
>
>                 new_node->parent = &acpi_gbl_root_node_struct;
>                 prev_node = new_node;
> --

The ACPICA code comes from an external project and the coding style in
it is different from the rest of the kernel, so the patch is not
applicable.

Thanks!
