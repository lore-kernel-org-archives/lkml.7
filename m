Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5EEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D4B20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576496802;
	bh=IkB1UlUGa4MRznOMVCadSRq4wUiE+s9J7we9zna8NZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S7XVMhbyztBdB2KTwgy34AMxnwalaJwsW3Y2Iqi8c29l6igSu/LUfvLM+vzAOhZJU
	 q8RThY88RVcfOXHEsSj5tr5ZDQS4ZOEzv3T9TZw/GUGjwowHFJr2bxnCRw95sB2GDw
	 AGkRGMA25F7riJDWx931uVEJ+ACwpCAedrJUb05g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLPLql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfLPLqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:46:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFEF206EC;
        Mon, 16 Dec 2019 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576496799;
        bh=IkB1UlUGa4MRznOMVCadSRq4wUiE+s9J7we9zna8NZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgVZo4zd46lPDBUJGrJPNUNoZCnIQmKicaHa26FrkrwfgJ5XahM39Yp+QdzPjm1PU
         9Np4q105OcIPlHK8+RiU/Gd+Bk4hOTaXWfYBCl24ZICBwVMF2aVFmrl3RjVO0Fz3hF
         Vh1XfOYut2WS+xurB9FM/KWMKHPG9+2SVUFdTkOI=
Date:   Mon, 16 Dec 2019 12:46:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191216114636.GB1515069@kroah.com>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:59:55PM +0900, Tetsuo Handa wrote:
> While syzkaller is finding many bugs, sometimes syzkaller examines
> stupid operations. But disabling operations using kernel config option
> is problematic because "kernel config option excludes whole module when
> there is still room for examining all but specific operation" and
> "the list of kernel config options becomes too complicated to maintain
> because such list changes over time". Thus, this patch introduces a
> kernel config option which allows disabling only specific operations.
> This kernel config option should be enabled only when building kernels
> for fuzz testing.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  drivers/char/mem.c                  |  6 +++---
>  drivers/tty/serial/8250/8250_port.c |  7 +++++--
>  drivers/tty/vt/keyboard.c           |  3 +++
>  fs/ioctl.c                          |  5 +++++
>  include/linux/uaccess.h             | 12 ++++++++++++
>  kernel/printk/printk.c              |  8 ++++++++
>  lib/Kconfig.debug                   | 10 ++++++++++
>  lib/usercopy.c                      | 27 +++++++++++++++++++++++++++
>  8 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 43dd0891ca1e..63aff3ae7c2b 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -246,7 +246,7 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
>  				return -EFAULT;
>  			}
>  
> -			copied = copy_from_user(ptr, buf, sz);
> +			copied = copy_from_user_to_any(ptr, buf, sz);

That name gives no context at all what is happening here.

And for the record, I really do not like this.

Why isn't it the job of the fuzzers to keep a blacklist of things they
should not do without expecting the system to crash?  Why is it up to
the kernel to do that work for them?


>  			unxlate_dev_mem_ptr(p, ptr);
>  			if (copied) {
>  				written += sz - copied;
> @@ -550,7 +550,7 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
>  		if (!virt_addr_valid(ptr))
>  			return -ENXIO;
>  
> -		copied = copy_from_user(ptr, buf, sz);
> +		copied = copy_from_user_to_any(ptr, buf, sz);
>  		if (copied) {
>  			written += sz - copied;
>  			if (written)
> @@ -604,7 +604,7 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
>  				err = -ENXIO;
>  				break;
>  			}
> -			n = copy_from_user(kbuf, buf, sz);
> +			n = copy_from_user_to_any(kbuf, buf, sz);
>  			if (n) {
>  				err = -EFAULT;
>  				break;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 90655910b0c7..367b92ad598b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -519,11 +519,14 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
>  	case UPIO_MEM32:
>  	case UPIO_MEM32BE:
>  	case UPIO_AU:
> -		p->serial_out(p, offset, value);
> +		/* Writing to random kernel address causes crash. */
> +		if (!IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
> +			p->serial_out(p, offset, value);
>  		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
>  		break;
>  	default:
> -		p->serial_out(p, offset, value);
> +		if (!IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
> +			p->serial_out(p, offset, value);
>  	}
>  }
>  
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 15d33fa0c925..367820b8ff59 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -633,6 +633,9 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
>  	     kbd->kbdmode == VC_OFF) &&
>  	     value != KVAL(K_SAK))
>  		return;		/* SAK is allowed even in raw mode */
> +	/* Repeating SysRq-t forever causes RCU stalls. */
> +	if (IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
> +		return;

That does not make sense.  What does this comment mean?



>  	fn_handler[value](vc);
>  }
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 2f5e4e5b97e1..f879aa94b118 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -601,6 +601,11 @@ static int ioctl_fsfreeze(struct file *filp)
>  	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
>  		return -EOPNOTSUPP;
>  
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +	/* Freezing filesystems causes hung tasks. */
> +	return -EBUSY;
> +#endif

ick ick ick.

> +
>  	/* Freeze */
>  	if (sb->s_op->freeze_super)
>  		return sb->s_op->freeze_super(sb);
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67f016010aad..6e5ddd0fdcce 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -387,4 +387,16 @@ void __noreturn usercopy_abort(const char *name, const char *detail,
>  			       unsigned long len);
>  #endif
>  
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +unsigned long __must_check copy_from_user_to_any(void *to,
> +						 const void __user *from,
> +						 unsigned long n);
> +#else
> +static __always_inline unsigned long __must_check
> +copy_from_user_to_any(void *to, const void __user *from, unsigned long n)

Again, this name does not make any sense to me.
You provide no documentation for when this should, or should not, be
used instead of the "normal" copy_from_user() call.

Again, not that I think this is ok at all.

> +{
> +	return copy_from_user(to, from, n);
> +}
> +#endif
> +
>  #endif		/* __LINUX_UACCESS_H__ */
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1ef6f75d92f1..9a2f95a78fef 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1198,6 +1198,14 @@ MODULE_PARM_DESC(ignore_loglevel,
>  
>  static bool suppress_message_printing(int level)
>  {
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +	/*
> +	 * Changing console_loglevel causes "no output". But ignoring
> +	 * console_loglevel is easier than preventing change of
> +	 * console_loglevel.
> +	 */
> +	return (level >= CONSOLE_LOGLEVEL_DEFAULT && !ignore_loglevel);
> +#endif

I don't understand the need for this change at all.

>  	return (level >= console_loglevel && !ignore_loglevel);
>  }
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d1842fe756d5..f9836cc23942 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2184,4 +2184,14 @@ config HYPERV_TESTING
>  	help
>  	  Select this option to enable Hyper-V vmbus testing.
>  
> +config KERNEL_BUILT_FOR_FUZZ_TESTING
> +       bool "Build kernel for fuzz testing"
> +       default n

That is always the default, no need to list it.

> +       help
> +	 Say N unless you are building kernels for fuzz testing.
> +	 Saying Y here disables several things that legitimately cause
> +	 damage under a fuzzer workload (e.g. copying to arbitrary
> +	 user-specified kernel address, changing console loglevel,
> +	 freezing filesystems).
> +
>  endmenu # Kernel hacking
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index cbb4d9ec00f2..f7d5d243a63d 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -86,3 +86,30 @@ int check_zeroed_user(const void __user *from, size_t size)
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL(check_zeroed_user);
> +
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +/*
> + * Since copying to arbitrary user-specified kernel address will crash
> + * the kernel trivially, do not copy to user-specified kernel address
> + * if the kernel was build for fuzz testing.
> + */
> +unsigned long __must_check copy_from_user_to_any(void *to,
> +						 const void __user *from,
> +						 unsigned long n)
> +{
> +	static char dummybuf[PAGE_SIZE];
> +	unsigned long ret = 0;
> +
> +	while (n) {
> +		unsigned long size = min(n, sizeof(dummybuf));
> +
> +		ret = copy_from_user(dummybuf, from, size);
> +		if (ret)
> +			break;
> +		from += size;
> +		n -= size;

Why???  What does this "exercise" any different from a stubbed out call
to copy_from_user()?

greg k-h
