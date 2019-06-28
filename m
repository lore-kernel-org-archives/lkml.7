Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6CDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E70120644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF1IeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:34:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:10390 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfF1IeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:34:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 01:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="183642900"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Jun 2019 01:34:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Jun 2019 11:34:17 +0300
Date:   Fri, 28 Jun 2019 11:34:17 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
Subject: Re: [PATCH] drivers/usb/typec/tps6598x.c: fix two bugs
Message-ID: <20190628083417.GA21701@kuha.fi.intel.com>
References: <20190628081235.19205-1-nikolaus.voss@loewensteinmedical.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628081235.19205-1-nikolaus.voss@loewensteinmedical.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:12:35AM +0200, Nikolaus Voss wrote:
> 1. Portinfo bit field is 3 bits wide, not 2 bits. This led to
>    a wrong driver configuration for some tps6598x configurations.
> 
> 2. Writing 4CC commands with tps6598x_write_4cc() already has
>    a pointer arg, don't reference it when using as arg to
>    tps6598x_block_write(). Correcting this enforces the constness
>    of the pointer to propagate to tps6598x_block_write(), so add
>    the const qualifier there to avoid the warning.

Like Greg said, if please supply separate patches. Also, if these are
fixes, then please mark them as such with appropriate tags:

        Fixes: ....
        Cc: stable@...


> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/usb/typec/tps6598x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c674abe3cf99..a38d1409f15b 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -41,7 +41,7 @@
>  #define TPS_STATUS_VCONN(s)		(!!((s) & BIT(7)))
>  
>  /* TPS_REG_SYSTEM_CONF bits */
> -#define TPS_SYSCONF_PORTINFO(c)		((c) & 3)
> +#define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
>  
>  enum {
>  	TPS_PORTINFO_SINK,
> @@ -127,7 +127,7 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  }
>  
>  static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> -				void *val, size_t len)
> +				const void *val, size_t len)
>  {
>  	u8 data[TPS_MAX_LEN + 1];
>  
> @@ -173,7 +173,7 @@ static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
>  static inline int
>  tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
>  {
> -	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
> +	return tps6598x_block_write(tps, reg, val, 4);
>  }
>  
>  static int tps6598x_read_partner_identity(struct tps6598x *tps)
> -- 
> 2.17.1

thanks,

-- 
heikki
