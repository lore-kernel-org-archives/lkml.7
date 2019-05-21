Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A92C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE012173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfEULtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:49:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfEULto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:49:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457Yw527Kzz9s7h;
        Tue, 21 May 2019 21:49:40 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?utf-8?Q?Micha=C5=82_Miros?= =?utf-8?Q?=C5=82aw?= 
        <mirq-linux@rere.qmqm.pl>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] misc: remove redundant 'default n' from Kconfig-s
In-Reply-To: <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
References: <CGME20190520141047eucas1p2c6006d1ecfc3eb287b6b33d131f66180@eucas1p2.samsung.com> <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
Date:   Tue, 21 May 2019 21:49:38 +1000
Message-ID: <87pnoc6n8t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
>
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
>
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
...
> Index: b/drivers/misc/ocxl/Kconfig
> ===================================================================
> --- a/drivers/misc/ocxl/Kconfig
> +++ b/drivers/misc/ocxl/Kconfig
> @@ -4,7 +4,6 @@
>  
>  config OCXL_BASE
>  	bool
> -	default n
>  	select PPC_COPRO_BASE
>  
>  config OCXL

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (ocxl)

cheers
