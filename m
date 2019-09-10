Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D45C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63578208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568104527;
	bh=gq1oX7g1Y9V/FS/nFdeM7t2rYXKR9a9D5gFA8dwOc7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pAUiIcNejKRF1hk2O8avk5nr21xhrMUklOnDsa//SMiCtGZ+LP/lnNYKxrjDRnJUN
	 vAoxTA+KUObGsidIpAz8QF/tcYSFnFpn0qhIcr8/sgNaOfNGaZn1Yi5QmV+n2rRVw7
	 nm1PJlaFW6Qto7/WJYWEH9rMK7gHhmp791PvwLUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfIJIf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfIJIfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:35:25 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED08921019;
        Tue, 10 Sep 2019 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568104525;
        bh=gq1oX7g1Y9V/FS/nFdeM7t2rYXKR9a9D5gFA8dwOc7c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O7smnQIORSuxuPKvFJpJUe//i2lOfceQe7N3hhf5xTY9yHVaxdShNo9wHJdTFNtNl
         /nfGiifZpyibgn6qZ8CX7RX/WZmnu4Ck7cViVgFp6sFKR5EK7bHdBhDQW8LxgzXitk
         FcltKK4nepEug6Rkbm36cUuXtq/n/XJpwEwZAnxk=
Received: by mail-qk1-f179.google.com with SMTP id 4so16118285qki.6;
        Tue, 10 Sep 2019 01:35:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWAZiw5+GRQvi7sOMjR6RXpBcDrpA8WHBvsEPp62Wl6VylMtqrO
        aEWLA1pre42ysKAXbbOaiCSXVU5bJpZCJlmm1A==
X-Google-Smtp-Source: APXvYqysvUoiPfGBRFjZLFOYp9C9TcbYqjBxw2q/vgsg/gQhKtd+x15xoz9tpQGtV7MQ1YR1webjN1s1m2b7apiT7bA=
X-Received: by 2002:a37:682:: with SMTP id 124mr27525298qkg.393.1568104524187;
 Tue, 10 Sep 2019 01:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062103.39641-1-philippe.schenker@toradex.com> <20190910062103.39641-4-philippe.schenker@toradex.com>
In-Reply-To: <20190910062103.39641-4-philippe.schenker@toradex.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 10 Sep 2019 09:35:13 +0100
X-Gmail-Original-Message-ID: <CAL_JsqKF9+mz+B=kPs9tnuRDB7+o7T8BSjKxzCRkvg7PYwGwWA@mail.gmail.com>
Message-ID: <CAL_JsqKF9+mz+B=kPs9tnuRDB7+o7T8BSjKxzCRkvg7PYwGwWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: regulator: add regulator-fixed-clock binding
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 7:21 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> This adds the documentation to the compatible regulator-fixed-clock.
> This binding is a special binding of regulator-fixed and adds the
> ability to add a clock to regulator-fixed, so the regulator can be
> enabled and disabled with that clock. If the special compatible
> regulator-fixed-clock is used it is mandatory to supply a clock.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>
> ---
>
> Changes in v2:
> - Change select: to if:
> - Change items: to enum:
> - Defined how many clocks should be given
>
>  .../bindings/regulator/fixed-regulator.yaml   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
