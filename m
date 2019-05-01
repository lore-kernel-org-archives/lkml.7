Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F63C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53F32087B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UUni8NCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEAAZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:25:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34728 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfEAAZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:25:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so6648965pgt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wBeD3b909RdFy58d+At4l9FRNp3CkcTVG43WCw6PgfM=;
        b=UUni8NCNKRgcDZzt09yN4ZkOr5ERYa3/18JrLfu+88GoJq2NgUzSWFDuNo3aIITt5B
         7KFuK+CMHO34y/h5iL2aMmZtXpCYA0mD+NfxYTyILksuHQX6Ykv2lAwzVR7AZqTYqWWp
         jI0aMrTW8MlK+JseDslpMnsuiWE06HVnLD4SCPqLey3xPhGIo6o5CKF5CwyX8z029DGm
         hSa5klySuszuKwEvbbWmOfM2cuNb+dvbwKKjQ5dTdfPbfkFMJnJnGyj3pdn6sSaofMHd
         gDVyaVUfegBgzNhjFnAtt9hI9PQyc8tEo6xjLWeLXLeqKpzSIbFL4rzL58F3axMmnOFk
         UWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wBeD3b909RdFy58d+At4l9FRNp3CkcTVG43WCw6PgfM=;
        b=Hfr227/Nz7i100Go+b+6O0Lkt4yi5K+q0EnAkQYOgWtUf3x0Hedt41d2VLsTudizQA
         hbjoW7D6I2oQTRjjSaFq5QHXCUTLQo9E2ThuYkj55Mch/IL7nIQGkpd2qJYKvCTbIcsd
         L6bSyEXWcUXc83IMzjMofvRWO/W7SnUdE+OG3crCJEQFpQ71MQlhcoAhHCsuIBC0bpQH
         ATUQH8liD3SrlzrXh/DK02/eynWOBAyIKA4OxNx3cgBuX4lPaIkHXRIfqY+mpwdPYTyb
         d54annDkpsFY72nrRFviuvPYz7XlAqZ/bRNukuQum5UhN3hvzPvVtzZt4xcYqZTCsLK6
         W0kQ==
X-Gm-Message-State: APjAAAUPJHLB5UEstPnQXcFPiiy1mbL7SsT0mOQxc0JOhF5lurcxGbP2
        CwyYwVHPpXNBALT/FkSHKSuUHA==
X-Google-Smtp-Source: APXvYqyrq84qFMlrdBzc+89KzXCioB8oGv3uwDjU+AogH+K1vFy/FQY/zljc4Y4fjJgLjtya4EJv8Q==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr35960225pfo.90.1556670304608;
        Tue, 30 Apr 2019 17:25:04 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x128sm63049012pfx.103.2019.04.30.17.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 17:25:03 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:25:03 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Apr 2019 17:24:03 PDT (-0700)
Subject:     Re: [PATCH] tty: Don't force RISCV SBI console as preferred console
In-Reply-To: <20190425133435.56065-1-anup.patel@wdc.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-955c86e5-6dfb-4554-a435-49cfefad6185@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 06:35:06 PDT (-0700), Anup Patel wrote:
> The Linux kernel will auto-disables all boot consoles whenever it
> gets a preferred real console.
> 
> Currently on RISC-V systems, if we have a real console which is not
> RISCV SBI console then boot consoles (such as earlycon=sbi) are not
> auto-disabled when a real console (ttyS0 or ttySIF0) is available.
> This results in duplicate prints at boot-time after kernel starts
> using real console (i.e. ttyS0 or ttySIF0) if "earlycon=" kernel
> parameter was passed by bootloader.
> 
> The reason for above issue is that RISCV SBI console always adds
> itself as preferred console which is causing other real consoles
> to be not used as preferred console.
> 
> Ideally "console=" kernel parameter passed by bootloaders should
> be the one selecting a preferred real console.
> 
> This patch fixes above issue by not forcing RISCV SBI console as
> preferred console.
> 
> Fixes: afa6b1ccfad5 ("tty: New RISC-V SBI console driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/tty/hvc/hvc_riscv_sbi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> index 75155bde2b88..31f53fa77e4a 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -53,7 +53,6 @@ device_initcall(hvc_sbi_init);
>  static int __init hvc_sbi_console_init(void)
>  {
>  	hvc_instantiate(0, 0, &hvc_sbi_ops);
> -	add_preferred_console("hvc", 0, NULL);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 

I merged this.  Also, it looks like Exchange is doing something to your patches
that makes them a bit difficult to merge.  If you don't have a way of fixing
that, can you include a pointer to a git tree with a signed commit/tag?
