Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C39C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4372B21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGGOiAYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfGLDV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:21:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37043 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbfGLDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:21:27 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so17329488iog.4;
        Thu, 11 Jul 2019 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7LVm4En99ffCjdSQOlCLFmZyKo+5KgGT1Gs50j8hsM=;
        b=XGGOiAYWv7/LtWLb3fFHsucku023HvaBW9ern8zt9rFe1AyknFN0kxKFPziFQZPpU0
         mSUbPmiUxLZBClWysvQHFmJPzjerUGcZmDtQtON9UMZ2C4htBoznEEz2/vFFy/yVuJja
         T34RRf3SsfRNEsmhwekzCfWrfFfgARA567579Dr0mc521R6E52gp2ayCzNst2yQphWtb
         SAT8Oq/dYdNEQwYhy2DLsF34PcwbUmqh8/5rJ58NESmddmsnlgfyv8urPDxPtMjHgLqU
         fWnoeLnir4pIqAFryiTPsmzaD4bprxfXiinlG6R4m1tet7HqDGByU4JAdYYEUeQ+yvoL
         /dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7LVm4En99ffCjdSQOlCLFmZyKo+5KgGT1Gs50j8hsM=;
        b=ZhCnIr/Q7nDEWK8KIAfFSsiwrRSsYsyQPNu9MZO3imuX04BHYmjkRY8Sw9vL8R/WRH
         wZT4ZT2GaIGr/XvOiXDr2G7yBGejZF+Fh6thZcQgx6yrq+a3QwqgmOlFVPHl3+6rksfU
         OcPWAboKl56bAWTbtssKvk0slhRbLVtpYc1GX+gGSNOFJPoUYPJn0LhO0NHZoHPH0HtM
         YzOeCpJqhlxrq4zxGbiRm5rI04q0UL5MMwU/WndaNDrup/H6Td7HRMBDPHOmWE/YxX70
         iEa0O3FrsD5fb+LR+98LDv/TYaRqtix7/3TDBgYKhffZrsuqxDpMq1wP9NGGEKKkpcEv
         avHQ==
X-Gm-Message-State: APjAAAUBQbOmuk7yvAq3RegLmxGu53NUgIuamYQdIPXYXVb0uU+4j9BQ
        bCQxoXsxGDT3DzphAEkelL2IaiJR6QAxdl1tjHU=
X-Google-Smtp-Source: APXvYqyp5Ity6hBV3CWvEX0wudD0bshEvgzA9ul3uS1sRHoTyhwVoN3ni1XDKQh+sLTxNA7FAuOIv5IQ476yGT3CIBY=
X-Received: by 2002:a02:8814:: with SMTP id r20mr9020971jai.115.1562901686256;
 Thu, 11 Jul 2019 20:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190522013045.21678-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190522013045.21678-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 11 Jul 2019 20:21:14 -0700
Message-ID: <CAHQ1cqF+8i1RPi77pXhGv4GRMoWMC0PpvJcEWcKH1O+CKuGWpg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 6:31 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Due to:
>
>  * Current implementation of l2cap_config_rsp() dropping BT
>    connection if sender of configuration response replied with unknown
>    option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)
>
>  * Current implementation of l2cap_build_conf_req() adding
>    L2CAP_CONF_RFC(0x04) option to initial configure request sent by
>    the Linux host.
>
> devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> controllers, will get stuck in endless connect -> configure ->
> disconnect loop, never connect and be generaly unusable.
>
> To avoid this problem add code to do the following:
>
>  1. Parse the body of response L2CAP_CONF_UNKNOWN and, in case of
>     unsupported option being RFC, clear L2CAP_FEAT_ERTM and
>     L2CAP_FEAT_STREAMING from connection's feature mask (in order to
>     prevent RFC option from being added going forward)
>
>  2. Retry configuration step the same way it's done for
>     L2CAP_CONF_UNACCEPT
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Cc: Florian Dollinger <dollinger.florian@gmx.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>
> Changes since [v1]:
>
>    - Patch simplified to simply clear L2CAP_FEAT_ERTM |
>      L2CAP_FEAT_STREAMING from feat_mask when device flags RFC options
>      as unknown
>
> [v1] lore.kernel.org/r/20190208025828.30901-1-andrew.smirnov@gmail.com
>

Pinging the status of this. Marcel, do you have any feedback on v2?

Thanks,
Andrey Smirnov
