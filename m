Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F43FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415257;
	bh=gr0yb3CUeTYAG6UBVtLxpDL4nMwzH49UBBB5Tvv0D54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oGxNrPo/yE7wsoNqKWu5lCycd1fx7rPLnXAwsY3RhvCxiQI3nU1RyK7Yb5toGg7Dv
	 CiWkmEp388y8LEh8PDmX1wMsh/UxogyacNC3e1aWnzPLYP2P8EFODv6JDA/4batPpS
	 mZKOTYFWJsp0cPVaOx/84FDH5Q36sG+LDpqQnScM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfDPLrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDPLre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE8420868;
        Tue, 16 Apr 2019 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415253;
        bh=gr0yb3CUeTYAG6UBVtLxpDL4nMwzH49UBBB5Tvv0D54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x76TAv51/R7wB4O8ZUrCbr1pBhzgnQ1DCsubV4IOABAEcucQNGf/Fs7PW7T/PT6Ql
         VCvYVFW7xu+b4+WbYKJf6JKWzKzK/UAQ+MjWluHvWqC4z8O6uDIPDpi+MEr/fQ3bob
         GK6NlgseQlkxo6eVMTmONxJIiOBFVZu2VUbJbPQk=
Date:   Tue, 16 Apr 2019 13:13:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v10 1/7] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190416111310.GA27812@kroah.com>
References: <20190409144250.7237-1-TheSven73@gmail.com>
 <20190409144250.7237-2-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409144250.7237-2-TheSven73@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:42:44AM -0400, Sven Van Asbroeck wrote:
> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> 
> They are typically used when a Linux device wants to expose itself
> as an actuator, motor, console light, switch, etc. over the fieldbus.
> 
> This framework is designed to provide a generic interface to Fieldbus
> Devices from both the Linux Kernel and the userspace.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  Documentation/ABI/testing/fieldbus-dev-cdev   |  31 ++
>  .../ABI/testing/sysfs-class-fieldbus-dev      |  62 ++++
>  Documentation/fieldbus_dev/fieldbus_dev.txt   |  66 ++++
>  drivers/staging/Kconfig                       |   2 +
>  drivers/staging/Makefile                      |   1 +
>  drivers/staging/fieldbus/Kconfig              |  19 +
>  drivers/staging/fieldbus/Makefile             |   9 +
>  drivers/staging/fieldbus/dev_core.c           | 349 ++++++++++++++++++
>  include/linux/fieldbus_dev.h                  | 106 ++++++

Please keep all staging code self-contained within your drivers/staging/
directory.

For the dt stuff, as that has been acked, it can go into the "real"
locations.  But for the include and sysfs documentation stuff, that all
needs to stay within your directory.

Can you respin this series based on that and resend?

thanks,

greg k-h
