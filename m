Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42AD208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF1J7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:59:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:63037 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfF1J7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:59:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 02:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="183657476"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Jun 2019 02:59:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Jun 2019 12:59:42 +0300
Date:   Fri, 28 Jun 2019 12:59:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
Subject: Re: [PATCH 2/2] drivers/usb/typec/tps6598x.c: fix 4CC cmd write
Message-ID: <20190628095942.GC21701@kuha.fi.intel.com>
References: <20190628083417.GA21701@kuha.fi.intel.com>
 <47a0d3b0b725c58bf7f422261a7c5d3accafea57.1561712364.git.nikolaus.voss@loewensteinmedical.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a0d3b0b725c58bf7f422261a7c5d3accafea57.1561712364.git.nikolaus.voss@loewensteinmedical.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:01:09AM +0200, Nikolaus Voss wrote:
> Writing 4CC commands with tps6598x_write_4cc() already has
> a pointer arg, don't reference it when using as arg to
> tps6598x_block_write(). Correcting this enforces the constness
> of the pointer to propagate to tps6598x_block_write(), so add
> the const qualifier there to avoid the warning.
> 
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tps6598x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index a170c49c2542..a38d1409f15b 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
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
