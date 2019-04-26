Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1345BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB827212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NiRelQBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfDZElX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:41:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17040 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDZElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556253716; x=1587789716;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MpWvheFOejWRs2zd9Qglh5YkbiX057ZAvN5hIeqKvGg=;
  b=NiRelQBKakauQauElgyk8KQXFxtssVTsVlfTsxVB1MuTjX7WCuJtPxSJ
   KTpLm1lP+5qmx1h+A0z7laMzBqrKOzQAg7x7JOxXZQJnBgCkwi31gvYbV
   Hb1GyOcSy6qWY/CFEavecjqnwDSDKDEjmcI977M7DwVrveQ3qKLJeI+iI
   t1WeLOhl6paNZAfoWS2qzKtuyopx0wojNXYgxJ2ejxcatiOl/uiEc/sV7
   YxhAvOYeCag9URpX6gh7Wh+RMDaBlOlDYxBoc4CK7sbGgXBdwddL/ozu/
   TJue/T044qYcQr2Z1VwvwTUJfSR8XXfmMWIccHA6T6fi6uYxdtVjHe1zE
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,396,1549900800"; 
   d="scan'208";a="206023511"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2019 12:41:55 +0800
IronPort-SDR: z2K6iaIJlDslcti6kPdWyzkN4pri40PJhawW9UmjwZtOdL/pXPnOsjUi9GAoVOQvE4Ls8VZyDB
 zzOj19D86aveVnxGnShc9RTzEz3G+GO7ulEe+3/7E0IIJ+jhcVciqkYEVBM++hpz0la9q3/AVV
 +5vdtTI89QUPJ+1SSwaGGtJG0cNCymmNAaMmSwh4PURtTv9qh/Ty0PMyMnB6YYAWL5v7O7m1G4
 RiQp0qmfUGHOM5UrSkt7p3ez5RWUdnD3XKcV8DOZKsm9Q4L6WEyumQYKq36kRYb7YnkhACOZNl
 /Db1pg9qo8bfUmR9ochNUcEh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Apr 2019 21:20:00 -0700
IronPort-SDR: U3aV7ee0cykZHXpN0/znPIqgRaqQfDMLXGGa8LArrP7M+zdfNNiDSefYqC50qQqSyAnAfA2mtE
 T7qBObKPgcOlc/RzeNNWd4By+0xOsWJUVMH9+b9oq7x+523e7mezX+XfZMd1B02bYtz4G39DxP
 8te9T7QaBXt3D90DnF8wTlOwvXXwzzz5W3lJiy0ULk1RJXiHwgytRcjAxJ7aZF3/RT2DiO+lr+
 yFDWbVTblOwKmQ1BC90SdBhwCwECPdYRp6zZzcAkQJOD5lS/l6Iiaf9TrQdMfgv2jZ0hZTZgPB
 w2E=
Received: from usa001205.ad.shared (HELO [10.86.53.92]) ([10.86.53.92])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Apr 2019 21:41:23 -0700
Subject: Re: [PATCH] tty: Don't force RISCV SBI console as preferred console
To:     Anup Patel <Anup.Patel@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20190425133435.56065-1-anup.patel@wdc.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <9a8be7ef-e62e-2a93-9170-e3dc70dfb25f@wdc.com>
Date:   Thu, 25 Apr 2019 21:41:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425133435.56065-1-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 6:35 AM, Anup Patel wrote:
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

Do we even need HVC_SBI console to be enabled by default? Disabling 
CONFIG_HVC_RISCV_SBI seems to be fine while running in QEMU.

If we don't need it, I suggest we should remove the config option from 
defconfig in addition to this patch.

Regards,
Atish
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
>   drivers/tty/hvc/hvc_riscv_sbi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> index 75155bde2b88..31f53fa77e4a 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -53,7 +53,6 @@ device_initcall(hvc_sbi_init);
>   static int __init hvc_sbi_console_init(void)
>   {
>   	hvc_instantiate(0, 0, &hvc_sbi_ops);
> -	add_preferred_console("hvc", 0, NULL);
>   
>   	return 0;
>   }
> 

