Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92C2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfGOJow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:44:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41121 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfGOJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:44:51 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 82efc516f3121cff; Mon, 15 Jul 2019 11:44:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: linux-next: build failure after merge of the pm tree
Date:   Mon, 15 Jul 2019 11:44:48 +0200
Message-ID: <34005749.9vH1ANRJSZ@kreacher>
In-Reply-To: <20190715100236.1e019f2c@canb.auug.org.au>
References: <20190715100236.1e019f2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Monday, July 15, 2019 2:02:36 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/JvAwh/r3+t+V+F.+O2706e.
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from <command-line>:
> include/linux/intel_rapl.h:116:19: error: field 'pcap_rapl_online' has inco=
> mplete type
>   enum cpuhp_state pcap_rapl_online;
>                    ^~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   7ebf8eff63b4 ("intel_rapl: introduce struct rapl_if_private")
> 
> This was detected by the new test that attempts to build each include
> file standalone.
> 
> I have added the following fix patch for today:

I've applied this patch on top of the RAPL series and added it to my linux-next branch.

Thanks!

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 15 Jul 2019 09:56:30 +1000
> Subject: [PATCH] intel_rapl: need linux/cpuhotplug.h for enum cpuhp_state
> 
> Fixes: 7ebf8eff63b4 ("intel_rapl: introduce struct rapl_if_private")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/intel_rapl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 0c179d92d110..efb3ce892c20 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -12,6 +12,7 @@
> =20
>  #include <linux/types.h>
>  #include <linux/powercap.h>
> +#include <linux/cpuhotplug.h>
> =20
>  enum rapl_domain_type {
>  	RAPL_DOMAIN_PACKAGE,	/* entire package/socket */
> --=20
> 2.20.1
> 
> --=20
> Cheers,
> Stephen Rothwell
> 
> --Sig_/JvAwh/r3+t+V+F.+O2706e.
> Content-Type: application/pgp-signature
> Content-Description: OpenPGP digital signature
> 
> 
> --Sig_/JvAwh/r3+t+V+F.+O2706e.--
> 




