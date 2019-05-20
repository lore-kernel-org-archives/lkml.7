Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68628C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7B420863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ZDYqeYDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfETSGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:06:17 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:47715 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfETSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:06:16 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 14:06:15 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45763m0MdZz9t;
        Mon, 20 May 2019 19:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1558374886; bh=hXE7AHhk3hVcTSSePlYKB9Bnza+wPxYvgvUVa4FLAsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDYqeYDGoE2mL3x/+uC0/QalyZqGXXaVmCUQpPqRVyY4+7M0TsipHp97zwKXyKVIy
         GbYocBIkcKAONIMVifes8muu0oUVHPBtqkfkhX2a6oQ+DzJ+mN7UgB8hLy0Kdq5zKp
         MRJwLUWypLRdkoa61oo2R0OB9FI4eoR42+MLq5KOOAhj3bHYYBxJSWALmKUUqLAKqb
         jvdTEp1YKmsGAaw2IbVWqtQvUCTUO5qMndwhtXTVeHRnaz5tRIXIGufEBAXC17fZIF
         YKdv3eoHpCgLsvYhzvEbUFoO8tE2KTbKffBb+hTWdrOdIQVVjcOqjCKEpcfcskAERk
         5COH+wX22iT7g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Mon, 20 May 2019 19:55:55 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] misc: remove redundant 'default n' from Kconfig-s
Message-ID: <20190520175555.GA5429@qmqm.qmqm.pl>
References: <CGME20190520141047eucas1p2c6006d1ecfc3eb287b6b33d131f66180@eucas1p2.samsung.com>
 <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:10:46PM +0200, Bartlomiej Zolnierkiewicz wrote:
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
[...]
>  drivers/misc/cb710/Kconfig        |    1 -

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
