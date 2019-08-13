Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0CE20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565710039;
	bh=HKhJdQ9xC644Yyxr4Mc48vaFAU0qEox8cqu8XFFdUAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MB5eEB4MQOyRRYW9p7woFf0X+R6SeDcx9RpLYVIG6zEnrCysJnEm2nwsJ94sp4K8F
	 edDiobKFmthgvgIqqZHTQ7wMBi9OZlQKDsGikLPJP+uO9e+iX7ZZBYC9SbrsHppLh5
	 ps6t3hR6OnxFzr9xUlKr8LfD9Gxarsj44N/OB4JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfHMP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfHMP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:27:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A59920663;
        Tue, 13 Aug 2019 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565710036;
        bh=HKhJdQ9xC644Yyxr4Mc48vaFAU0qEox8cqu8XFFdUAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9wRRvwg4CR0ZqATaS40VxceJXh+XAOEDYDVGMbuXihVxvIUQkOS08JVRAP6YHPxs
         A60yBGejcNuFmn8CkV42ZGdG1mqrkf0dRFpXdsxC/TzSQwKAYgmXAuzsoA8n9D7t+N
         9OZC8T3G5xnbzlqoLfgZRrVbg+EbQJmI3PlIRXe8=
Date:   Tue, 13 Aug 2019 17:27:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org,
        hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 04/10] modpost: add support for symbol namespaces
Message-ID: <20190813152714.GC26138@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-5-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-5-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:17:01PM +0100, Matthias Maennich wrote:
> Add support for symbols that are exported into namespaces. For that,
> extract any namespace suffix from the symbol name. In addition, emit a
> warning whenever a module refers to an exported symbol without
> explicitly importing the namespace that it is defined in. This patch
> consistently adds the namespace suffix to symbol names exported into
> Module.symvers.
> 
> Example warning emitted by modpost in case of the above violation:
> 
>  WARNING: module ums-usbat uses symbol usb_stor_resume from namespace
>  USB_STORAGE, but does not import it.
> 
> Co-developed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  scripts/mod/modpost.c | 91 +++++++++++++++++++++++++++++++++++++------
>  scripts/mod/modpost.h |  7 ++++
>  2 files changed, 87 insertions(+), 11 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
