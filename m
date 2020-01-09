Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F8C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B612072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAILjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:39:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:41673 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgAILje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:39:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 03:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="227225519"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Jan 2020 03:39:27 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 09 Jan 2020 13:39:26 +0200
Date:   Thu, 9 Jan 2020 13:39:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v2 14/36] platform/x86: intel_scu_ipc: Introduce new SCU
 IPC API
Message-ID: <20200109113926.GE2838@lahna.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-15-mika.westerberg@linux.intel.com>
 <20200109113015.GO32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109113015.GO32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:30:15PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 08, 2020 at 02:41:39PM +0300, Mika Westerberg wrote:
> > The current SCU IPC API has been operating on a single instance and
> > there has been no way to pin the providing module in place when the SCU
> > IPC is in use.
> > 
> > This implements a new API that takes the SCU IPC instance as first
> > parameter (NULL means the single instance is being used). The SCU IPC
> > instance can be retrieved by calling new function
> > intel_scu_ipc_dev_get() that take care of pinning the providing module
> > in place as long as intel_scu_ipc_dev_put() is not called.
> > 
> > The old API is left there to support existing users which cannot be
> > converted easily but it is put to a separate header that is subject to
> > be removed eventually. Subsequent patches will convert most of the users
> > to the new API.
> 
> Few minor comments below. After addressing them,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  arch/x86/include/asm/intel_scu_ipc.h        |  74 +++----
> >  arch/x86/include/asm/intel_scu_ipc_legacy.h |  76 +++++++
> >  drivers/platform/x86/intel_scu_ipc.c        | 228 +++++++++++++++-----
> >  drivers/platform/x86/intel_scu_pcidrv.c     |   7 +-
> >  4 files changed, 291 insertions(+), 94 deletions(-)
> >  create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
> > 
> > diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> > index 405c47bf0965..9895b60386c5 100644
> > --- a/arch/x86/include/asm/intel_scu_ipc.h
> > +++ b/arch/x86/include/asm/intel_scu_ipc.h
> > @@ -1,8 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #ifndef _ASM_X86_INTEL_SCU_IPC_H_
> > -#define  _ASM_X86_INTEL_SCU_IPC_H_
> > -
> > -#include <linux/notifier.h>
> > +#define _ASM_X86_INTEL_SCU_IPC_H_
> >  
> >  #define IPCMSG_INDIRECT_READ	0x02
> >  #define IPCMSG_INDIRECT_WRITE	0x05
> > @@ -20,6 +18,7 @@
> >  	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
> >  
> >  struct device;
> > +struct intel_scu_ipc_dev;
> >  
> >  /**
> >   * struct intel_scu_ipc_pdata - Platform data for SCU IPC
> > @@ -31,47 +30,38 @@ struct intel_scu_ipc_pdata {
> >  	int irq;
> >  };
> >  
> > -int intel_scu_ipc_probe(struct device *dev,
> > -			const struct intel_scu_ipc_pdata *pdata);
> > -
> > -/* Read single register */
> > -int intel_scu_ipc_ioread8(u16 addr, u8 *data);
> > -
> > -/* Read a vector */
> > -int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
> > -
> > -/* Write single register */
> > -int intel_scu_ipc_iowrite8(u16 addr, u8 data);
> > -
> > -/* Write a vector */
> > -int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
> > -
> > -/* Update single register based on the mask */
> > -int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
> > -
> > -/* Issue commands to the SCU with or without data */
> > -int intel_scu_ipc_simple_command(int cmd, int sub);
> > -int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
> > -			  u32 *out, int outlen);
> > -
> > -extern struct blocking_notifier_head intel_scu_notifier;
> > -
> > -static inline void intel_scu_notifier_add(struct notifier_block *nb)
> > -{
> > -	blocking_notifier_chain_register(&intel_scu_notifier, nb);
> > -}
> > -
> > -static inline void intel_scu_notifier_remove(struct notifier_block *nb)
> > -{
> > -	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
> > -}
> > -
> > -static inline int intel_scu_notifier_post(unsigned long v, void *p)
> > +struct intel_scu_ipc_dev *
> > +intel_scu_ipc_probe(struct device *dev, const struct intel_scu_ipc_pdata *pdata);
> > +
> > +struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
> > +void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
> > +struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev);
> > +
> > +int intel_scu_ipc_dev_ioread8(struct intel_scu_ipc_dev *scu, u16 addr,
> > +			      u8 *data);
> > +int intel_scu_ipc_dev_iowrite8(struct intel_scu_ipc_dev *scu, u16 addr,
> > +			       u8 data);
> > +int intel_scu_ipc_dev_readv(struct intel_scu_ipc_dev *scu, u16 *addr,
> > +			    u8 *data, size_t len);
> > +int intel_scu_ipc_dev_writev(struct intel_scu_ipc_dev *scu, u16 *addr,
> > +			     u8 *data, size_t len);
> 
> + blank line?

OK

> > +int intel_scu_ipc_dev_update(struct intel_scu_ipc_dev *scu, u16 addr, u8 data,
> > +			     u8 mask);
> 
> Perhaps move u8 data on the next line to be (slightly) consistent with above.

OK

> > +
> > +int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
> > +				     int sub);
> > +int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
> > +					int sub, const void *in, size_t inlen,
> > +					size_t size, void *out, size_t outlen);
> > +
> > +static inline int intel_scu_ipc_dev_command(struct intel_scu_ipc_dev *scu, int cmd,
> > +					    int sub, const void *in, size_t inlen,
> > +					    void *out, size_t outlen)
> >  {
> > -	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
> > +	return intel_scu_ipc_dev_command_with_size(scu, cmd, sub, in, inlen,
> > +						   inlen, out, outlen);
> >  }
> >  
> > -#define		SCU_AVAILABLE		1
> > -#define		SCU_DOWN		2
> > +#include <asm/intel_scu_ipc_legacy.h>
> >  
> >  #endif
> > diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
> > new file mode 100644
> > index 000000000000..3399ea8eea48
> > --- /dev/null
> > +++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
> > @@ -0,0 +1,76 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
> > +#define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
> > +
> > +#include <linux/notifier.h>
> > +
> > +/* Don't call these in new code - they will be removed eventually */
> > +
> > +/* Read single register */
> > +static inline int intel_scu_ipc_ioread8(u16 addr, u8 *data)
> > +{
> > +	return intel_scu_ipc_dev_ioread8(NULL, addr, data);
> > +}
> > +
> > +/* Read a vector */
> > +static inline int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
> > +{
> > +	return intel_scu_ipc_dev_readv(NULL, addr, data, len);
> > +}
> > +
> > +/* Write single register */
> > +static inline int intel_scu_ipc_iowrite8(u16 addr, u8 data)
> > +{
> > +	return intel_scu_ipc_dev_iowrite8(NULL, addr, data);
> > +}
> > +
> > +/* Write a vector */
> > +static inline int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
> > +{
> > +	return intel_scu_ipc_dev_writev(NULL, addr, data, len);
> > +}
> > +
> > +/* Update single register based on the mask */
> > +static inline int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask)
> > +{
> > +	return intel_scu_ipc_dev_update(NULL, addr, data, mask);
> > +}
> > +
> > +/* Issue commands to the SCU with or without data */
> > +static inline int intel_scu_ipc_simple_command(int cmd, int sub)
> > +{
> > +	return intel_scu_ipc_dev_simple_command(NULL, cmd, sub);
> > +}
> > +
> > +static inline int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
> > +					u32 *out, int outlen)
> > +{
> > +	/* New API takes both inlen and outlen as bytes so convert here */
> > +	size_t inbytes = inlen * sizeof(u32);
> > +	size_t outbytes = outlen * sizeof(u32);
> > +
> > +	return intel_scu_ipc_dev_command_with_size(NULL, cmd, sub, in, inbytes,
> > +						   inlen, out, outbytes);
> > +}
> > +
> > +extern struct blocking_notifier_head intel_scu_notifier;
> > +
> > +static inline void intel_scu_notifier_add(struct notifier_block *nb)
> > +{
> > +	blocking_notifier_chain_register(&intel_scu_notifier, nb);
> > +}
> > +
> > +static inline void intel_scu_notifier_remove(struct notifier_block *nb)
> > +{
> > +	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
> > +}
> > +
> > +static inline int intel_scu_notifier_post(unsigned long v, void *p)
> > +{
> > +	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
> > +}
> > +
> > +#define		SCU_AVAILABLE		1
> > +#define		SCU_DOWN		2
> > +
> > +#endif
> > diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> > index b1ac381bb7dd..cc29f504adcf 100644
> > --- a/drivers/platform/x86/intel_scu_ipc.c
> > +++ b/drivers/platform/x86/intel_scu_ipc.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/module.h>
> >  
> >  #include <asm/intel_scu_ipc.h>
> >  
> > @@ -77,6 +78,99 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
> >  
> >  static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
> >  
> > +/**
> > + * intel_scu_ipc_dev_get() - Get SCU IPC instance
> > + *
> > + * The recommended new API takes SCU IPC instance as parameter and this
> > + * function can be called by driver to get the instance. This also makes
> > + * sure the driver providing the IPC functionality cannot be unloaded
> > + * while the caller has the intance.
> > + *
> > + * Call intel_scu_ipc_dev_put() to release the instance.
> > + *
> > + * Returns %NULL if SCU IPC is not currently available.
> > + */
> > +struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
> > +{
> > +	struct intel_scu_ipc_dev *scu = &ipcdev;
> > +
> > +	mutex_lock(&ipclock);
> > +	if (!scu->dev)
> > +		goto err_unlock;
> > +	if (!try_module_get(scu->dev->driver->owner))
> > +		goto err_unlock;
> > +	mutex_unlock(&ipclock);
> > +	return scu;
> > +
> > +err_unlock:
> > +	mutex_unlock(&ipclock);
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_scu_ipc_dev_get);
> > +
> > +/**
> > + * intel_scu_ipc_dev_put() - Put SCU IPC instance
> > + * @scu: SCU IPC instance
> > + *
> > + * This function releases the SCU IPC instance retrieved from
> > + * intel_scu_ipc_dev_get() and allows the driver providing IPC to be
> > + * unloaded.
> > + */
> > +void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu)
> > +{
> > +	mutex_lock(&ipclock);
> > +	if (scu->dev)
> > +		module_put(scu->dev->driver->owner);
> > +	mutex_unlock(&ipclock);
> > +}
> > +EXPORT_SYMBOL_GPL(intel_scu_ipc_dev_put);
> > +
> > +struct intel_scu_ipc_devres {
> > +	struct intel_scu_ipc_dev *scu;
> > +};
> > +
> > +static void devm_intel_scu_ipc_dev_release(struct device *dev, void *res)
> > +{
> > +	struct intel_scu_ipc_devres *devres = res;
> > +	struct intel_scu_ipc_dev *scu = devres->scu;
> > +
> > +	intel_scu_ipc_dev_put(scu);
> > +}
> > +
> > +/**
> > + * devm_intel_scu_ipc_dev_get() - Allocate managed SCU IPC device
> > + * @dev: Device requesting the SCU IPC device
> > + *
> > + * The recommended new API takes SCU IPC instance as parameter and this
> > + * function can be called by driver to get the instance. This also makes
> > + * sure the driver providing the IPC functionality cannot be unloaded
> > + * while the caller has the intance.
> > + *
> > + * Returns %NULL if SCU IPC is not currently available.
> > + */
> > +struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev)
> > +{
> > +	struct intel_scu_ipc_devres *devres;
> > +	struct intel_scu_ipc_dev *scu;
> > +
> > +	devres = devres_alloc(devm_intel_scu_ipc_dev_release, sizeof(*devres),
> > +			      GFP_KERNEL);
> > +	if (!devres)
> > +		return NULL;
> > +
> > +	scu = intel_scu_ipc_dev_get();
> > +	if (!scu) {
> > +		devres_free(devres);
> > +		return NULL;
> > +	}
> > +
> > +	devres->scu = scu;
> > +	devres_add(dev, devres);
> > +
> > +	return scu;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_intel_scu_ipc_dev_get);
> > +
> >  /*
> >   * Send ipc command
> >   * Command Register (Write Only):
> > @@ -167,15 +261,18 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
> >  }
> >  
> >  /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
> > -static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
> > +static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
> > +			u32 count, u32 op, u32 id)
> >  {
> > -	struct intel_scu_ipc_dev *scu = &ipcdev;
> >  	int nc;
> >  	u32 offset = 0;
> >  	int err;
> >  	u8 cbuf[IPC_WWBUF_SIZE];
> >  	u32 *wbuf = (u32 *)&cbuf;
> >  
> > +	if (!scu)
> > +		scu = &ipcdev;
> > +
> >  	memset(cbuf, 0, sizeof(cbuf));
> >  
> >  	mutex_lock(&ipclock);
> > @@ -219,7 +316,8 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
> >  }
> >  
> >  /**
> > - * intel_scu_ipc_ioread8		-	read a word via the SCU
> > + * intel_scu_ipc_dev_ioread8() - Read a byte via the SCU
> > + * @scu: Optional SCU IPC instance
> >   * @addr: Register on SCU
> >   * @data: Return pointer for read byte
> >   *
> > @@ -228,14 +326,15 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
> >   *
> >   * This function may sleep.
> >   */
> > -int intel_scu_ipc_ioread8(u16 addr, u8 *data)
> > +int intel_scu_ipc_dev_ioread8(struct intel_scu_ipc_dev *scu, u16 addr, u8 *data)
> >  {
> > -	return pwr_reg_rdwr(&addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
> > +	return pwr_reg_rdwr(scu, &addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
> >  }
> > -EXPORT_SYMBOL(intel_scu_ipc_ioread8);
> > +EXPORT_SYMBOL(intel_scu_ipc_dev_ioread8);
> >  
> >  /**
> > - * intel_scu_ipc_iowrite8		-	write a byte via the SCU
> > + * intel_scu_ipc_dev_iowrite8() - Write a byte via the SCU
> > + * @scu: Optional SCU IPC instance
> >   * @addr: Register on SCU
> >   * @data: Byte to write
> >   *
> > @@ -244,14 +343,15 @@ EXPORT_SYMBOL(intel_scu_ipc_ioread8);
> >   *
> >   * This function may sleep.
> >   */
> > -int intel_scu_ipc_iowrite8(u16 addr, u8 data)
> > +int intel_scu_ipc_dev_iowrite8(struct intel_scu_ipc_dev *scu, u16 addr, u8 data)
> >  {
> > -	return pwr_reg_rdwr(&addr, &data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
> > +	return pwr_reg_rdwr(scu, &addr, &data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
> >  }
> > -EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
> > +EXPORT_SYMBOL(intel_scu_ipc_dev_iowrite8);
> >  
> >  /**
> > - * intel_scu_ipc_readvv		-	read a set of registers
> > + * intel_scu_ipc_dev_readv() - Read a set of registers
> > + * @scu: Optional SCU IPC instance
> >   * @addr: Register list
> >   * @data: Bytes to return
> >   * @len: Length of array
> > @@ -263,14 +363,16 @@ EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
> >   *
> >   * This function may sleep.
> >   */
> > -int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
> > +int intel_scu_ipc_dev_readv(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
> > +			    size_t len)
> >  {
> > -	return pwr_reg_rdwr(addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
> > +	return pwr_reg_rdwr(scu, addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
> >  }
> > -EXPORT_SYMBOL(intel_scu_ipc_readv);
> > +EXPORT_SYMBOL(intel_scu_ipc_dev_readv);
> >  
> >  /**
> > - * intel_scu_ipc_writev		-	write a set of registers
> > + * intel_scu_ipc_dev_writev() - Write a set of registers
> > + * @scu: Optional SCU IPC instance
> >   * @addr: Register list
> >   * @data: Bytes to write
> >   * @len: Length of array
> > @@ -282,14 +384,16 @@ EXPORT_SYMBOL(intel_scu_ipc_readv);
> >   *
> >   * This function may sleep.
> >   */
> > -int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
> > +int intel_scu_ipc_dev_writev(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
> > +			     size_t len)
> >  {
> > -	return pwr_reg_rdwr(addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
> > +	return pwr_reg_rdwr(scu, addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
> >  }
> > -EXPORT_SYMBOL(intel_scu_ipc_writev);
> > +EXPORT_SYMBOL(intel_scu_ipc_dev_writev);
> >  
> >  /**
> > - * intel_scu_ipc_update_register	-	r/m/w a register
> > + * intel_scu_ipc_dev_update() - Update a register
> > + * @scu: Optional SCU IPC instance
> >   * @addr: Register address
> >   * @bits: Bits to update
> >   * @mask: Mask of bits to update
> > @@ -302,15 +406,17 @@ EXPORT_SYMBOL(intel_scu_ipc_writev);
> >   * This function may sleep. Locking between SCU accesses is handled
> >   * for the caller.
> >   */
> > -int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
> 
> > +int intel_scu_ipc_dev_update(struct intel_scu_ipc_dev *scu, u16 addr, u8 bits,
> > +			     u8 mask)
> 
> In header you have 'u8 data'. Can we be consistent with a name?

Sure.

> >  {
> >  	u8 data[2] = { bits, mask };
> > -	return pwr_reg_rdwr(&addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_M);
> > +	return pwr_reg_rdwr(scu, &addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_M);
> >  }
> > -EXPORT_SYMBOL(intel_scu_ipc_update_register);
> > +EXPORT_SYMBOL(intel_scu_ipc_dev_update);
> >  
> >  /**
> > - * intel_scu_ipc_simple_command	-	send a simple command
> > + * intel_scu_ipc_dev_simple_command() - Send a simple command
> > + * @scu: Optional SCU IPC instance
> >   * @cmd: Command
> >   * @sub: Sub type
> >   *
> > @@ -321,11 +427,14 @@ EXPORT_SYMBOL(intel_scu_ipc_update_register);
> >   * This function may sleep. Locking for SCU accesses is handled for the
> >   * caller.
> >   */
> > -int intel_scu_ipc_simple_command(int cmd, int sub)
> > +int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
> > +				     int sub)
> >  {
> > -	struct intel_scu_ipc_dev *scu = &ipcdev;
> >  	int err;
> >  
> > +	if (!scu)
> > +		scu = &ipcdev;
> > +
> >  	mutex_lock(&ipclock);
> >  	if (scu->dev == NULL) {
> >  		mutex_unlock(&ipclock);
> > @@ -336,47 +445,65 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
> >  	mutex_unlock(&ipclock);
> >  	return err;
> >  }
> > -EXPORT_SYMBOL(intel_scu_ipc_simple_command);
> > +EXPORT_SYMBOL(intel_scu_ipc_dev_simple_command);
> >  
> >  /**
> > - * intel_scu_ipc_command	-	command with data
> > + * intel_scu_ipc_command_with_size() - Command with data
> > + * @scu: Optional SCU IPC instance
> >   * @cmd: Command
> >   * @sub: Sub type
> >   * @in: Input data
> > - * @inlen: Input length in dwords
> > + * @inlen: Input length in bytes
> > + * @size: Input size written to the IPC command register in whatever
> > + *	  units (dword, byte) the particular firmware requires. Normally
> > + *	  should be the same as @inlen.
> >   * @out: Output data
> > - * @outlen: Output length in dwords
> > + * @outlen: Output length in bytes
> >   *
> >   * Issue a command to the SCU which involves data transfers. Do the
> >   * data copies under the lock but leave it for the caller to interpret.
> >   */
> > -int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
> > -			  u32 *out, int outlen)
> > +int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
> > +					int sub, const void *in, size_t inlen,
> > +					size_t size, void *out, size_t outlen)
> >  {
> > -	struct intel_scu_ipc_dev *scu = &ipcdev;
> > +	size_t outbuflen = DIV_ROUND_UP(outlen, sizeof(u32));
> > +	size_t inbuflen = DIV_ROUND_UP(inlen, sizeof(u32));
> > +	u32 inbuf[4] = {};
> >  	int i, err;
> >  
> > +	if (inbuflen > 4 || outbuflen > 4)
> > +		return -EINVAL;
> > +
> > +	if (!scu)
> > +		scu = &ipcdev;
> > +
> >  	mutex_lock(&ipclock);
> >  	if (scu->dev == NULL) {
> >  		mutex_unlock(&ipclock);
> >  		return -ENODEV;
> >  	}
> >  
> > -	for (i = 0; i < inlen; i++)
> > -		ipc_data_writel(scu, *in++, 4 * i);
> > +	memcpy(inbuf, in, inlen);
> > +	for (i = 0; i < inbuflen; i++)
> > +		ipc_data_writel(scu, inbuf[i], 4 * i);
> >  
> > -	ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
> > +	ipc_command(scu, (size << 16) | (sub << 12) | cmd);
> >  	err = intel_scu_ipc_check_status(scu);
> >  
> > -	if (!err) {
> > -		for (i = 0; i < outlen; i++)
> > -			*out++ = ipc_data_readl(scu, 4 * i);
> 
> > +	if (!err && outlen) {
> 
> Do we need the 'outlen' test here? In any case if it's zero the following
> will be no-op.

Right, it is not needed. I'll remove the check.
