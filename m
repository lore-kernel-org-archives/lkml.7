Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B95FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC3920679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfGaOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:24:44 -0400
Received: from goliath.siemens.de ([192.35.17.28]:43945 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfGaOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:24:44 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x6VEOTva024755
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 16:24:30 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x6VEOTdf027880;
        Wed, 31 Jul 2019 16:24:29 +0200
Subject: Re: [PATCH] scripts/gdb: Handle split debug
To:     Douglas Anderson <dianders@chromium.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20190730234052.148744-1-dianders@chromium.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <34bbd6b5-2e37-159a-b75b-36a6be11c506@siemens.com>
Date:   Wed, 31 Jul 2019 16:24:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190730234052.148744-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.19 01:40, Douglas Anderson wrote:
> Some systems (like Chrome OS) may use "split debug" for kernel
> modules.  That means that the debug symbols are in a different file
> than the main elf file.  Let's handle that by also searching for debug
> symbols that end in ".ko.debug".

Is this split-up depending on additional kernel patches, is this already
possible with mainline, or is this purely a packaging topic? Wondering because
of testability in case it's downstream-only.

Jan

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  scripts/gdb/linux/symbols.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 2f5b95f09fa0..34e40e96dee2 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -77,12 +77,12 @@ lx-symbols command."""
>              gdb.write("scanning for modules in {0}\n".format(path))
>              for root, dirs, files in os.walk(path):
>                  for name in files:
> -                    if name.endswith(".ko"):
> +                    if name.endswith(".ko") or name.endswith(".ko.debug"):
>                          self.module_files.append(root + "/" + name)
>          self.module_files_updated = True
>  
>      def _get_module_file(self, module_name):
> -        module_pattern = ".*/{0}\.ko$".format(
> +        module_pattern = ".*/{0}\.ko(?:.debug)?$".format(
>              module_name.replace("_", r"[_\-]"))
>          for name in self.module_files:
>              if re.match(module_pattern, name) and os.path.exists(name):
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
