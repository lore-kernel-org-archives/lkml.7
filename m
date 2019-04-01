Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD245C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB49A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554148492;
	bh=OOb/iIh1WevlZw+tSzoKk125izWcByw+Vj4BWbf0DJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=orwQyqNm99Uwr8u4vW87jSCqaL0zpy6dxfOYtD0Ac95PPhYgCswXmtc1A/Si+c8Rm
	 FlrS++Dg/2AyI/h/O1rvxx6bnP+woCJHpJMOzZs8bb+PX/iT+tQ3vJf+vfm3dwTPSz
	 2StjEmumuSsT1rXAo+2GDR5NpSRZEGJTrmHrqcUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDATyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:54:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37585 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDATyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:54:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id v84so8405679oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGDOzetaZYZ8LOd8b9oKz8TSRDQVr/+nYM3Gw/VJ2oQ=;
        b=UW9igYgiZXQEjeJW99iUJnbvEvPS5zVaLqiwO4Q9KbxJ/JiWNvvEpRKmaUb1bjNfgC
         AaYcSQw0YR8HWi0H3CP+jNzQZhxGmw0poyS4I0ObVXErYjyczzB25jPW/tEVScvpBvOu
         j0CAzg+CigipLzaH2KY6Kp+SwqqRGa4fanMQ22XEKFhrGx81bdALT6NA/HztsnavMgkb
         kt4/8zQeKt+3fAk+6baigvugYfIj7x+jZWUOhx+DdEzOOB6mAdNYz1fNprq6w6hcO4gS
         NIEvAn/YJqt+SpNpoipcBpqGWrZdxna8iJKpOJEK0XNvrDZB5LoFMJAoad8aaZxb5FrK
         hSsw==
X-Gm-Message-State: APjAAAXfOTrARnRZ5fl0EH3zlCIeDrjIJ3S/Jvvm9GkMmrGv3Y7paDoT
        zxboVu1wyQQz8cuNRLi4IN3nWQ==
X-Google-Smtp-Source: APXvYqwidRajxwEJg1PJz1CIw9bg3E5GYXIkKPzMuZ7My/eiMpcN+XgiAAX5i5VgLiysIN9RV4fVQw==
X-Received: by 2002:aca:355:: with SMTP id 82mr1877834oid.30.1554148489952;
        Mon, 01 Apr 2019 12:54:49 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id j18sm4483486otq.68.2019.04.01.12.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 12:54:48 -0700 (PDT)
Date:   Mon, 1 Apr 2019 12:54:47 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 01/17] fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register
 address.
Message-ID: <20190401195447.GA1910@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-2-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553483264-5379-2-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Mon, Mar 25, 2019 at 11:07:28AM +0800, Wu Hao wrote:
> FME_PR_INTFC_ID is used as compat_id for fpga manager and region,
> but high 64 bits and low 64 bits of the compat_id are swapped by
> mistake. This patch fixes this problem by fixing register address.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-fme-mgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index 76f3770..b3f7eee 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -30,8 +30,8 @@
>  #define FME_PR_STS		0x10
>  #define FME_PR_DATA		0x18
>  #define FME_PR_ERR		0x20
> -#define FME_PR_INTFC_ID_H	0xA8
> -#define FME_PR_INTFC_ID_L	0xB0
> +#define FME_PR_INTFC_ID_L	0xA8
> +#define FME_PR_INTFC_ID_H	0xB0

Does this handle endianess correct?
>  
>  /* FME PR Control Register Bitfield */
>  #define FME_PR_CTRL_PR_RST	BIT_ULL(0)  /* Reset PR engine */
> -- 
> 2.7.4
> 

Cheers,
Moritz
