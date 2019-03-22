Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873C42083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sya9Ren5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCVPZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:25:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36005 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCVPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:25:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so2018427edi.3;
        Fri, 22 Mar 2019 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAZbCRBsttGYt0IyRTrNeLBRUrUFUGOU9JHaNLTD4Pw=;
        b=Sya9Ren5v5le1ppuKQ70ppCAcHLY6hgh5RpdNStWMO3AgAQS9kI93EVlCd1qlU5Tbp
         TzutdtGPulfxyeeSh28TTVisHqfL6KQUVCiz/jB7mDy8uR1s79yXML+GBLoXwZlFAo2H
         GHsZbF6DgDc/to8f1FoYBY7Z3wmvaDl/yZW9dt8TAejkFM0Sq2RVgGHu9bKB9+1qBA8Q
         05YQxqFWpJ5Abm5hIfcFw9M3DdfE5bUvfPLeH/z6gxPbBrzimKbGfksEsMXJfOytSMRM
         6UQOeVFMKRvkyeT+8H1p5afYXVx9Q3tcK8YM+DfPjCLMenNWuZV4cbm2uE5xgHNFQKQQ
         NZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAZbCRBsttGYt0IyRTrNeLBRUrUFUGOU9JHaNLTD4Pw=;
        b=C1CEmYcNEsN/VgURjI9RFUWN5v7z80kLZB8W++5IIzpXiokpjV4ptoT561ukOOYa1d
         7WMIm6ETrgQlLEhcXBtHMfg+ttsLgT7mYN72Xb2DHRILbppixQCXLynNfmMCxD2sgEHQ
         D5JkUmv1jZpU1DOxVh9LNMlEZmKchch8mvmK18AoXp7uRfWFWrK6VVdK+ymTJXkFCWr3
         GgmFof0uZW5b8Wk8fw4Wu3Y3VBnCkk8xXxYe61Q39RdKlcpcETrvAhd4N3p1zXEiV3W4
         S6nj62HmsZhqxaG77b7/7i8fOiG2tWDjQL7dTDXWJIMpNCMo5b8mvTVYmnaYJlp3pOWX
         C40A==
X-Gm-Message-State: APjAAAVtqBLV3acmyrzMJ6KqWb1QLGsnaecRbMsKBRSVNI1OTi7KsUiA
        OGEpsxk+4vfpitj1TyzviYc=
X-Google-Smtp-Source: APXvYqyxA5tAtinDswRrueJLCotsRTfTNLiDoyWm7VLvqMdl3XQpO4uvB2jp6RQmPmJqF3ndC+z+sA==
X-Received: by 2002:a17:906:28c9:: with SMTP id p9mr5819478ejd.43.1553268307559;
        Fri, 22 Mar 2019 08:25:07 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id i2sm1752872ejc.1.2019.03.22.08.25.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:25:06 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:25:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla4xxx: avoid freeing unallocated dma memory
Message-ID: <20190322152504.GA21978@archlinux-ryzen>
References: <20190322142530.904080-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322142530.904080-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:25:03PM +0100, Arnd Bergmann wrote:
> Clang -Wuninitialized notices that on is_qla40XX we never allocate
> any DMA memory in get_fw_boot_info() but attempt to free it anyway:
> 
> drivers/scsi/qla4xxx/ql4_os.c:5915:7: error: variable 'buf_dma' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>                 if (!(val & 0x07)) {
>                     ^~~~~~~~~~~~~
> drivers/scsi/qla4xxx/ql4_os.c:5985:47: note: uninitialized use occurs here
>         dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
>                                                      ^~~~~~~
> drivers/scsi/qla4xxx/ql4_os.c:5915:3: note: remove the 'if' if its condition is always true
>                 if (!(val & 0x07)) {
>                 ^~~~~~~~~~~~~~~~~~~
> drivers/scsi/qla4xxx/ql4_os.c:5885:20: note: initialize the variable 'buf_dma' to silence this warning
>         dma_addr_t buf_dma;
>                           ^
>                            = 0
> 
> Skip the call to dma_free_coherent() here.
> 
> Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is what I initially had but I guess I cared too much about that
debug print firing properly :) I like this better personally.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 16a18d5d856f..daa884fa43f4 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -5928,7 +5928,7 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
>  		val = rd_nvram_byte(ha, sec_addr);
>  		if (val & BIT_7)
>  			ddb_index[1] = (val & 0x7f);
> -
> +		goto exit_boot_info;
>  	} else if (is_qla80XX(ha)) {
>  		buf = dma_alloc_coherent(&ha->pdev->dev, size,
>  					 &buf_dma, GFP_KERNEL);
> -- 
> 2.20.0
> 
