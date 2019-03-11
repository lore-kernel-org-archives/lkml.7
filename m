Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BB2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCKNdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:33:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbfCKNdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C4F3AEA2;
        Mon, 11 Mar 2019 13:33:42 +0000 (UTC)
Date:   Mon, 11 Mar 2019 14:33:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Message-ID: <20190311133341.vqcagdo4e4vy6dfu@pathway.suse.cz>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-01 16:48:19, Calvin Owens wrote:
> This patch embeds a device struct in the console struct, and registers
> them on a "console" bus so we can expose attributes in sysfs.
> 
> Currently, most drivers declare static console structs, and that is
> incompatible with the dev refcount model. So we end up needing to patch
> all of the console drivers to:
> 
> 	1. Dynamically allocate the console struct using a new helper
> 	2. Handle the allocation in (1) possibly failing
> 	3. Dispose of (1) with put_device()
> 
> Early console structures must still be static, since they're required
> before we're able to allocate memory. The least ugly way I can come up
> with to handle this is an "is_static" flag in the structure which makes
> the gets and puts NOPs, and is checked in ->release() to catch mistakes.
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index 5c8d780637bd..e09cb192a469 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -857,12 +857,12 @@ static void lp_console_write(struct console *co, const char *s,
>  	parport_release(dev);
>  }
>  
> -static struct console lpcons = {
> -	.name		= "lp",
> +static const struct console_operations lp_cons_ops = {
>  	.write		= lp_console_write,
> -	.flags		= CON_PRINTBUFFER,
>  };
>  
> +static struct console *lpcons;

I have got the following compilation error (see below):

  CC      drivers/char/lp.o
drivers/char/lp.c: In function ‘lp_register’:
drivers/char/lp.c:925:2: error: ‘lpcons’ undeclared (first use in this function)
  lpcons = allocate_console_dfl(&lp_cons_ops, "lp", NULL);
  ^
drivers/char/lp.c:925:2: note: each undeclared identifier is reported only once for each function it appears in
In file included from drivers/char/lp.c:125:0:
drivers/char/lp.c:925:33: error: ‘lp_cons_ops’ undeclared (first use in this function)


>  #endif /* console on line printer */
>  
>  /* --- initialisation code ------------------------------------- */
> @@ -921,6 +921,11 @@ static int lp_register(int nr, struct parport *port)
>  						      &ppdev_cb, nr);
>  	if (lp_table[nr].dev == NULL)
>  		return 1;
> +
> +	lpcons = allocate_console_dfl(&lp_cons_ops, "lp", NULL);
> +	if (!lpcons)
> +		return -ENOMEM;

This should be done inside #ifdef CONFIG_LP_CONSOLE
to avoid the above compilation error.

> +
>  	lp_table[nr].flags |= LP_EXIST;
>  
>  	if (reset)

[...]
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 3c27a4a29b8c..382591683033 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -142,20 +143,28 @@ static inline int con_debug_leave(void)
>  #define CON_BRL		(32) /* Used for a braille device */
>  #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
>  
> -struct console {
> -	char	name[16];
> +struct console;
> +
> +struct console_operations {
>  	void	(*write)(struct console *, const char *, unsigned);
>  	int	(*read)(struct console *, char *, unsigned);
>  	struct tty_driver *(*device)(struct console *, int *);
>  	void	(*unblank)(void);
>  	int	(*setup)(struct console *, char *);
>  	int	(*match)(struct console *, char *name, int idx, char *options);
> +};
> +
> +struct console {
> +	char	name[16];
>  	short	flags;
>  	short	index;
>  	int	cflag;
>  	void	*data;
>  	struct	 console *next;
>  	int	level;
> +	const struct console_operations *ops;
> +	struct device dev;
> +	int is_static;
>  };
>  
>  /*
> @@ -167,6 +176,29 @@ struct console {
>  extern int console_set_on_cmdline;
>  extern struct console *early_console;
>  
> +extern struct console *allocate_console(const struct console_operations *ops,
> +					const char *name, short flags,
> +					short index, void *data);
> +
> +#define allocate_console_dfl(ops, name, data) \
> +	allocate_console(ops, name, CON_PRINTBUFFER, -1, data)
> +
> +/*
> + * Helpers for get/put that do the right thing for static early consoles.
> + */
> +
> +#define get_console(con) \
> +do { \
> +	if (!con->is_static) \
> +		get_device(&(con)->dev); \
> +} while (0)
> +
> +#define put_console(con) \
> +do { \
> +	if (con && !con->is_static) \
> +		put_device(&((struct console *)con)->dev); \
> +} while (0)
> +
>  extern int add_preferred_console(char *name, int idx, char *options);
>  extern void register_console(struct console *);
>  extern int unregister_console(struct console *);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 5fe2b037e833..29b43c4df3d6 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -426,6 +426,25 @@ int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
>  int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
>  int uart_match_port(struct uart_port *port1, struct uart_port *port2);
>  
> +/*
> + * This ugliness removes the need for #ifdef boilerplate in UART drivers which
> + * allow their console functionality to be disabled via Kconfig.
> + */
> +#define uart_allocate_console(drv, ops, name, flags, idx, kcfg)		    \
> +({									    \
> +	int __retval = 0;						    \
> +	if (IS_ENABLED(CONFIG_##kcfg)) {				    \

I wonder if it is worth it. I do not see much existing #ifdef's
removed by this patch. I would expect that the code is never
called when the driver is disabled in Kconfig.

IMHO, such a trick hidden in a macro could cause more confusion
than good.


> +		(drv)->cons = allocate_console(ops, name, flags, idx, drv); \
> +		__retval = (drv)->cons ? 0 : -ENOMEM;			    \
> +	}								    \
> +	__retval;							    \
> +})
> +
> +#define uart_allocate_console_dfl(drv, ops, name, kcfg) \
> +	uart_allocate_console(drv, ops, name, CON_PRINTBUFFER, -1, kcfg)
> +
> +#define uart_put_console(drv) put_console((drv)->cons)
> +
>  /*
>   * Power Management
>   */
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2e0eb89f046c..67e1e993ab80 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -108,6 +108,8 @@ enum devkmsg_log_masks {
>  
>  static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
>  
> +static int printk_late_done;
> +
>  static int __control_devkmsg(char *str)
>  {
>  	if (!str)
> @@ -1731,7 +1733,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>  			continue;
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
> -		if (!con->write)
> +		if (!con->ops->write)
>  			continue;
>  		if (!cpu_online(smp_processor_id()) &&
>  		    !(con->flags & CON_ANYTIME))
> @@ -1739,9 +1741,9 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>  		if (suppress_message_printing(level, con))
>  			continue;
>  		if (con->flags & CON_EXTENDED)
> -			con->write(con, ext_text, ext_len);
> +			con->ops->write(con, ext_text, ext_len);
>  		else
> -			con->write(con, text, len);
> +			con->ops->write(con, text, len);
>  	}
>  }
>  
> @@ -2052,7 +2054,7 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
>  	n = vscnprintf(buf, sizeof(buf), fmt, ap);
>  	va_end(ap);
>  
> -	early_console->write(early_console, buf, n);
> +	early_console->ops->write(early_console, buf, n);
>  }
>  #endif
>  
> @@ -2481,8 +2483,8 @@ void console_unblank(void)
>  	console_locked = 1;
>  	console_may_schedule = 0;
>  	for_each_console(c)
> -		if ((c->flags & CON_ENABLED) && c->unblank)
> -			c->unblank();
> +		if ((c->flags & CON_ENABLED) && c->ops->unblank)
> +			c->ops->unblank();
>  	console_unlock();
>  }
>  
> @@ -2515,9 +2517,9 @@ struct tty_driver *console_device(int *index)
>  
>  	console_lock();
>  	for_each_console(c) {
> -		if (!c->device)
> +		if (!c->ops->device)
>  			continue;
> -		driver = c->device(c, index);
> +		driver = c->ops->device(c, index);
>  		if (driver)
>  			break;
>  	}
> @@ -2558,6 +2560,68 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  
> +static struct bus_type console_subsys = {
> +	.name = "console",
> +};
> +
> +static void console_release(struct device *dev)
> +{
> +	struct console *con = container_of(dev, struct console, dev);
> +
> +	if (WARN(con->is_static, "Freeing static early console!\n"))
> +		return;
> +
> +	if (WARN(con->flags & CON_ENABLED, "Freeing running console!\n"))
> +		return;
> +
> +	pr_info("Freeing console %s\n", con->name);
> +	kfree(con);
> +}
> +
> +static void console_init_device(struct console *con)
> +{
> +	device_initialize(&con->dev);
> +	dev_set_name(&con->dev, "%s", con->name);
> +	con->dev.release = console_release;
> +}
> +
> +static void console_register_device(struct console *new)
> +{
> +	/*
> +	 * We might be called very early from register_console(): in that case,
> +	 * printk_late_init() will take care of this later.
> +	 */
> +	if (!printk_late_done)
> +		return;
> +
> +	if (new->is_static)
> +		console_init_device(new);
> +
> +	new->dev.bus = &console_subsys;
> +	WARN_ON(device_add(&new->dev));
> +}
> +
> +struct console *allocate_console(const struct console_operations *ops,
> +				 const char *name, short flags, short index,
> +				 void *data)
> +{
> +	struct console *new;
> +
> +	new = kzalloc(sizeof(*new), GFP_KERNEL);

I have just realized that page_alloc_init() is called before
parse_early_param(). Therefore we should be able to use
memblock_alloc() for early consoles and reduce problems
with static structures.


> +	if (!new)
> +		return NULL;
> +
> +	new->ops = ops;
> +	strscpy(new->name, name, sizeof(new->name));
> +	new->flags = flags;
> +	new->index = index;
> +	new->data = data;
> +
> +	console_init_device(new);

This is a side effect that I would not expect from a function called
alloc*(). I would rename:

s/allocate_console/create_console/  or
s/allocate_console/init_console/


> +	return new;
> +}
> +EXPORT_SYMBOL_GPL(allocate_console);
> +
>  /*
>   * The console driver calls this routine during kernel initialization
>   * to register the console printing procedure with printk() and to
> @@ -2622,10 +2686,10 @@ void register_console(struct console *newcon)
>  	if (!has_preferred) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
> -		if (newcon->setup == NULL ||
> -		    newcon->setup(newcon, NULL) == 0) {
> +		if (newcon->ops->setup == NULL ||
> +		    newcon->ops->setup(newcon, NULL) == 0) {
>  			newcon->flags |= CON_ENABLED;
> -			if (newcon->device) {
> +			if (newcon->ops->device) {

There might be confusion why we need two devices (con->dev
and con->ops->device).

I would rename con->ops->device to con->ops->tty_dev.


>  				newcon->flags |= CON_CONSDEV;
>  				has_preferred = true;
>  			}
> @@ -2639,8 +2703,8 @@ void register_console(struct console *newcon)
>  	for (i = 0, c = console_cmdline;
>  	     i < MAX_CMDLINECONSOLES && c->name[0];
>  	     i++, c++) {
> -		if (!newcon->match ||
> -		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
> +		if (!newcon->ops->match ||
> +		    newcon->ops->match(newcon, c->name, c->index, c->options) != 0) {
>  			/* default matching */
>  			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
>  			if (strcmp(c->name, newcon->name) != 0)
> @@ -2660,8 +2724,8 @@ void register_console(struct console *newcon)
>  			if (_braille_register_console(newcon, c))
>  				return;
>  
> -			if (newcon->setup &&
> -			    newcon->setup(newcon, c->options) != 0)
> +			if (newcon->ops->setup &&
> +			    newcon->ops->setup(newcon, c->options) != 0)
>  				break;
>  		}
>  
> @@ -2706,6 +2770,8 @@ void register_console(struct console *newcon)
>  		console_drivers->next = newcon;
>  	}
>  
> +	get_console(newcon);
> +
>  	if (newcon->flags & CON_EXTENDED)
>  		nr_ext_console_drivers++;
>  
> @@ -2730,6 +2796,7 @@ void register_console(struct console *newcon)
>  		exclusive_console_stop_seq = console_seq;
>  		logbuf_unlock_irqrestore(flags);
>  	}
> +	console_register_device(newcon);

This calls console_init_device() for the statically defined
early consoles. I guess that it would invalidate the above
get_console().

Also it is not symmetric with unregister_console(). We add it
to the console_subsys here and did not remove it when
the console is unregistered.

IMHO, this might be done already in allocate_console().
And eventually in printk_late_init() for consoles that
are allocated earlier.

I am not familiar with the device-related sysfs API.
But I see that device_initialize() and device_add()
can be done by device_register(). The separate
calls are needed only when a special reference
handling is needed. Are we special?

Anyway, please, try to describe the expected workflow
in the commit description:

    + where the structure should get allocated
    + when it is added to the sysfs hierarchy
    + what happens when the console gets registered
      and unregistered
    + when it is removed from the sysfs hierarchy
    + when the structure is released/freed

    + What is needed to get the console registered
      and unregistered repeatedly on a running system

Finally, we might want to show state of the CON_ENABLED flag
in sysfs to distinguish the currently used consoles.


>  	console_unlock();
>  	console_sysfs_notify();

Thanks a lot for working on this. I know that it is not easy.
But it is really appreciated.

Best Regards,
Petr
