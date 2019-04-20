Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EF9C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00342147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ezfDVrRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfDTTuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:50:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55070 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfDTTuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:50:52 -0400
Received: from zn.tnic (p200300EC2F112E00E1C548496DF7C17A.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:e1c5:4849:6df7:c17a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3840E1EC04B9;
        Sat, 20 Apr 2019 21:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555789850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WR/dlNg+bH8kUbTku1663JwbgJdziNqTJgguDqgAyFU=;
        b=ezfDVrRr96rYtlNgE2SOPEEnVfHDPYJ0nSQyKPvzxBIwpixnByRLb5KHrx58OQXf5HEhwI
        MemwOit/DgRLUmWFNCUQRtM7KguJ+JrfgsyC4/biqQCaKH9PDkOS6e5QVIsDeGW9LUzyyk
        lhRFvED0zg+jYu/F27KeOmzwSmInVGQ=
Date:   Sat, 20 Apr 2019 21:50:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190420195045.GG29704@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418220229.32133-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:02:29PM -0700, Tony Luck wrote:
> Useful when running error injection tests that want to
> see all of the MCi_(STATUS|ADDR|MISC) data via /dev/mcelog.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/ras/cec.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index 2d9ec378a8bc..a2ceedcd8516 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -123,6 +123,9 @@ static u64 dfs_pfn;
>  /* Amount of errors after which we offline */
>  static unsigned int count_threshold = COUNT_MASK;
>  
> +/* debugfs switch to enable/disable CEC */
> +static u64 cec_enabled = 1;
> +
>  /*
>   * The timer "decays" element count each timer_interval which is 24hrs by
>   * default.
> @@ -400,6 +403,14 @@ static int count_threshold_set(void *data, u64 val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, u64_get, count_threshold_set, "%lld\n");
>  
> +static int enable_set(void *data, u64 val)
> +{
> +	ce_arr.disabled = !val;

Btw, regardless of what we end up doing wrt hiding this switch under
RAS_CEC_DEBUG or exposing it, that ce_arr.disabled flag is not
needed anymore and you can remove it along with the flags union in
ce_array with the next version of this. Because one of the cec_enabled
or ce_arr.disabled is now redundant and I think you want to have
cec_enabled. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
