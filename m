Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA5220692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgAHQl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:41:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:3334 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgAHQl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:41:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:41:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="303603172"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 08:41:53 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEP3-0005U0-FY; Wed, 08 Jan 2020 18:41:53 +0200
Date:   Wed, 8 Jan 2020 18:41:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/36] platform/x86: intel_scu_ipc: Drop
 intel_scu_ipc_io[read|write][8|16]()
Message-ID: <20200108164153.GC32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-11-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-11-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:35PM +0300, Mika Westerberg wrote:
> There are no users for these so we can remove them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_scu_ipc.h | 12 -----
>  drivers/platform/x86/intel_scu_ipc.c | 68 ----------------------------
>  2 files changed, 80 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> index b2dde96e0611..b59afa59a4cb 100644
> --- a/arch/x86/include/asm/intel_scu_ipc.h
> +++ b/arch/x86/include/asm/intel_scu_ipc.h
> @@ -22,24 +22,12 @@
>  /* Read single register */
>  int intel_scu_ipc_ioread8(u16 addr, u8 *data);
>  
> -/* Read two sequential registers */
> -int intel_scu_ipc_ioread16(u16 addr, u16 *data);
> -
> -/* Read four sequential registers */
> -int intel_scu_ipc_ioread32(u16 addr, u32 *data);
> -
>  /* Read a vector */
>  int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
>  
>  /* Write single register */
>  int intel_scu_ipc_iowrite8(u16 addr, u8 data);
>  
> -/* Write two sequential registers */
> -int intel_scu_ipc_iowrite16(u16 addr, u16 data);
> -
> -/* Write four sequential registers */
> -int intel_scu_ipc_iowrite32(u16 addr, u32 data);
> -
>  /* Write a vector */
>  int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
>  
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 997fdac920c6..ba857e54800b 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -237,40 +237,6 @@ int intel_scu_ipc_ioread8(u16 addr, u8 *data)
>  }
>  EXPORT_SYMBOL(intel_scu_ipc_ioread8);
>  
> -/**
> - *	intel_scu_ipc_ioread16		-	read a word via the SCU
> - *	@addr: register on SCU
> - *	@data: return pointer for read word
> - *
> - *	Read a register pair. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> - *
> - *	This function may sleep.
> - */
> -int intel_scu_ipc_ioread16(u16 addr, u16 *data)
> -{
> -	u16 x[2] = {addr, addr + 1};
> -	return pwr_reg_rdwr(x, (u8 *)data, 2, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
> -}
> -EXPORT_SYMBOL(intel_scu_ipc_ioread16);
> -
> -/**
> - *	intel_scu_ipc_ioread32		-	read a dword via the SCU
> - *	@addr: register on SCU
> - *	@data: return pointer for read dword
> - *
> - *	Read four registers. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> - *
> - *	This function may sleep.
> - */
> -int intel_scu_ipc_ioread32(u16 addr, u32 *data)
> -{
> -	u16 x[4] = {addr, addr + 1, addr + 2, addr + 3};
> -	return pwr_reg_rdwr(x, (u8 *)data, 4, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
> -}
> -EXPORT_SYMBOL(intel_scu_ipc_ioread32);
> -
>  /**
>   *	intel_scu_ipc_iowrite8		-	write a byte via the SCU
>   *	@addr: register on SCU
> @@ -287,40 +253,6 @@ int intel_scu_ipc_iowrite8(u16 addr, u8 data)
>  }
>  EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
>  
> -/**
> - *	intel_scu_ipc_iowrite16		-	write a word via the SCU
> - *	@addr: register on SCU
> - *	@data: word to write
> - *
> - *	Write two registers. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> - *
> - *	This function may sleep.
> - */
> -int intel_scu_ipc_iowrite16(u16 addr, u16 data)
> -{
> -	u16 x[2] = {addr, addr + 1};
> -	return pwr_reg_rdwr(x, (u8 *)&data, 2, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
> -}
> -EXPORT_SYMBOL(intel_scu_ipc_iowrite16);
> -
> -/**
> - *	intel_scu_ipc_iowrite32		-	write a dword via the SCU
> - *	@addr: register on SCU
> - *	@data: dword to write
> - *
> - *	Write four registers. Returns 0 on success or an error code. All
> - *	locking between SCU accesses is handled for the caller.
> - *
> - *	This function may sleep.
> - */
> -int intel_scu_ipc_iowrite32(u16 addr, u32 data)
> -{
> -	u16 x[4] = {addr, addr + 1, addr + 2, addr + 3};
> -	return pwr_reg_rdwr(x, (u8 *)&data, 4, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
> -}
> -EXPORT_SYMBOL(intel_scu_ipc_iowrite32);
> -
>  /**
>   *	intel_scu_ipc_readvv		-	read a set of registers
>   *	@addr: register list
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


