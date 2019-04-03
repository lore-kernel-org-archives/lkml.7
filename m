Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80511C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463D720830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554301225;
	bh=YpJBBoYpoUjmlc3F7RcbH+BUTGifKEeDm1kgn4IpXPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2LX8gN9GIpqkdXK8SE26pCwS+VPjZUhz7mT2Sw7Sl7uzjjFoTVYQ5kVtJ2whLajGc
	 Da8UR38VhVsSJNnVYGV2oepzOTaxoNoS1q7aKb61b+9MEomPOY4VivmcxOHUP95Y45
	 RP5ICY6wDEbzwf9LfoIAOG5dfC7oR94lf6ke1sjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDCOUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:20:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43894 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:20:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id t81so13681656oig.10;
        Wed, 03 Apr 2019 07:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vB/OBQax5R4rjNTU0F5RxkuYfIFOtn/+V3lPfgLchV4=;
        b=lkcKaD3tj2OVbLfhZfQKZ5dmum2/oB+NSO6Ra40bafzGJyEo4LahiVtTWzYXZCcw+i
         SaoTSyAttQnVH/l0Ggh869OrPyfdMTDzgYo3XQScg7hhNGTw+SI3onCiU+dxVMnPeiJA
         /Io0sQIZlPwelar9b97rTzF6ateokoJelaQBL4v/YK7dEMmnJ7iXCpPccQHvlIP/5PCe
         i6iE+I6KCMPplHIseeDj+mlK+KJ8zWKU16BxAUYHSeWSZqbvE6p75HQDBaET7hy+bh+N
         QRHsmkJXlZDD8DzQE9ivwsTqq1plHAJK+AqGNrWFAlaWS4dzpvcsIuNXMqo9e3t6AjMm
         ZT7Q==
X-Gm-Message-State: APjAAAX92huyyOWMEfHnQHLz7s99pZ4+91kdYGjtxmZSOa30LLdS8b4k
        DEsth3RGZTmu+G31562q2Ok=
X-Google-Smtp-Source: APXvYqzmJphmqgl+5isEouBPtPvvu6olFc0Gj2NyusYlgqRo0bbrVSBbslHTVF9x8/wz0XqffajJ5w==
X-Received: by 2002:aca:4b03:: with SMTP id y3mr404842oia.21.1554301223123;
        Wed, 03 Apr 2019 07:20:23 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id q23sm6951753oic.45.2019.04.03.07.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:20:22 -0700 (PDT)
Date:   Wed, 3 Apr 2019 07:20:22 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Message-ID: <20190403142022.GB5752@archbook>
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a log for user to know FPGA configuration is successful
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/fpga-mgr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c386681..559e046 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
>  	}
>  	mgr->state = FPGA_MGR_STATE_OPERATING;
>  
> +	dev_info(&mgr->dev, "Successfully programming FPGA\n");

That info is available in FPGA manager's sysfs status entry, if at all
I'd make this a dev_dbg().

From my end I don't see how we need this really.

Thanks,
Moritz
