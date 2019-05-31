Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D8AC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A0266AB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEaJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:24:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64225 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:24:00 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 519c7babe4363505; Fri, 31 May 2019 11:23:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org,
        Erik Schmauss <erik.schmauss@intel.com>, devel@acpica.org
Subject: Re: [PATCH] tools/power/acpi: exclude tools/* from .gitignore pattern
Date:   Fri, 31 May 2019 11:23:57 +0200
Message-ID: <7038880.DppijN9Y0u@kreacher>
In-Reply-To: <1556549106-16119-1-git-send-email-yamada.masahiro@socionext.com>
References: <1556549106-16119-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 29, 2019 4:45:06 PM CEST Masahiro Yamada wrote:
> tools/power/acpi/.gitignore has the following entries:
> 
>   acpidbg
>   acpidump
>   ec
> 
> They are intended to ignore the following build artifacts:
> 
>   tools/power/acpi/acpidbg
>   tools/power/acpi/acpidump
>   tools/power/acpi/ec
> 
> However, those .gitignore entries are effective not only for the
> current directory, but also for any sub-directories.
> 
> So, the following directories are also considered to be ignored:
> 
>   tools/power/acpi/tools/acpidbg
>   tools/power/acpi/tools/acpidump
>   tools/power/acpi/tools/ec
> 
> They are obviously version-controlled, so should be excluded from the
> .gitignore patterns.
> 
> You can fix it by prefixing the patterns with '/', which means they
> are only effective in the current directory.
> 
> I also prefixed the "include" consistently. IMHO, '/' prefixing is
> safer when you intend to ignore specific files or directories.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  tools/power/acpi/.gitignore | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
> index cba3d99..f698a0e 100644
> --- a/tools/power/acpi/.gitignore
> +++ b/tools/power/acpi/.gitignore
> @@ -1,4 +1,4 @@
> -acpidbg
> -acpidump
> -ec
> -include
> +/acpidbg
> +/acpidump
> +/ec
> +/include/
> 

Applied, thanks!




