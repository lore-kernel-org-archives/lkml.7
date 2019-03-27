Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F752070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711278;
	bh=xiE+2H7Wy2ixicBKtqd+tRt4Uq+rva1soguQRU7bBso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z0XBZ0/+0dxoaCukUuG8Ju5E6yKETDcK5bKsruy6kWIz+k5QZTg6JuOdIyL+XK415
	 reZ8KAgFTFItQXLt3eI37GupBgRfSE47y48YbPadLre20ORWarEMQcVl1D0P94p8NW
	 l6s7/5XYL6rddmGUqV6FKqP7NIt2yd5vRx1Yv1j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbfC0S14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387513AbfC0S1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:27:54 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5634B20449;
        Wed, 27 Mar 2019 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711272;
        bh=xiE+2H7Wy2ixicBKtqd+tRt4Uq+rva1soguQRU7bBso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REJs4LyVTCgtCXSNCKRL1GWH35n7hX8fVR51elsBk9pjUlvOdQBBJR9yehNpQlnfK
         nmvTR9HLMgzo5Kit12YVXpdc4gEPwsWo0yOmJyUPjKiRa0hc5Z2nBoQA31Ij3kSMR7
         AOCYYIUwTeOO1cWtg49K38wjjkc+0eUfCYZ37D0A=
Date:   Thu, 28 Mar 2019 00:44:39 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     minyard@acm.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Message-ID: <20190327154439.GA18500@kroah.com>
References: <20190305171231.22133-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305171231.22133-1-minyard@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:12:31AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This creates simulated serial ports, both as echo devices and pipe
> devices.  The driver reasonably approximates the serial port speed
> and simulates some modem control lines.  It allows error injection
> and direct control of modem control lines.

I like this, thanks for doing it!

Minor nits below:

> +You can modify null modem and control the lines individually
> +through an interface in /sys/class/tty/ttyECHO<n>/ctrl,
> +/sys/class/tty/ttyPipeA<n>/ctrl, and
> +/sys/class/tty/ttyPipeB<n>/ctrl.  The following may be written to
> +those files:
> +
> +[+-]nullmodem
> +    enable/disable null modem
> +
> +[+-]cd
> +    enable/disable Carrier Detect (no effect if +nullmodem)
> +
> +[+-]dsr
> +    enable/disable Data Set Ready (no effect if +nullmodem)
> +
> +[+-]cts
> +    enable/disable Clear To Send (no effect if +nullmodem)
> +
> +[+-]ring
> +    enable/disable Ring
> +
> +frame
> +    inject a frame error on the next byte
> +
> +parity
> +    inject a parity error on the next byte
> +
> +overrun
> +    inject an overrun error on the next byte
> +
> +The contents of the above files has the following format:
> +
> +tty[Echo|PipeA|PipeB]<n>
> +    <mctrl values>
> +
> +where <mctrl values> is the modem control values above (not frame,
> +parity, or overrun) with the following added:
> +
> +[+-]dtr
> +    value of the Data Terminal Ready
> +
> +[+-]rts
> +    value of the Request To Send
> +
> +The above values are not settable through this interface, they are
> +set through the serial port interface itself.
> +
> +So, for instance, ttyEcho0 comes up in the following state::
> +
> +   # cat /sys/class/tty/ttyEcho0/ctrl
> +   ttyEcho0: +nullmodem -cd -dsr -cts -ring -dtr -rts
> +
> +If something connects, it will become::
> +
> +   ttyEcho0: +nullmodem +cd +dsr +cts -ring +dtr +rts
> +
> +To enable ring::
> +
> +   # echo "+ring" >/sys/class/tty/ttyEcho0/ctrl
> +   # cat /sys/class/tty/ttyEcho0/ctrl
> +   ttyEcho0: +nullmodem +cd +dsr +cts +ring +dtr +rts
> +
> +Now disable NULL modem and the CD line::
> +
> +   # echo "-nullmodem -cd" >/sys/class/tty/ttyEcho0/ctrl
> +   # cat /sys/class/tty/ttyEcho0/ctrl
> +   ttyEcho0: -nullmodem -cd -dsr -cts +ring -dtr -rts
> +
> +Note that these settings are for the side you are modifying.  So if
> +you set nullmodem on ttyPipeA0, that controls whether the DTR/RTS
> +lines from ttyPipeB0 affect ttyPipeA0.  It doesn't affect ttyPipeB's
> +modem control lines.

All of the sysfs stuff needs to also go in Documentation/ABI to describe
your new files.

> +config SERIAL_SIMULATOR
> +	tristate "Serial port simulator"
> +	default n

n is the default, no need to say it again here.

> --- /dev/null
> +++ b/drivers/tty/serial/serialsim.c
> @@ -0,0 +1,1101 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * serialsim - Emulate a serial device in a loopback and/or pipe
> + *
> + * See the docs for this for more details.

Pointer to the docs?

And no copyright notice?  I don't object to it, but it is usually nice
to see.

> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/serial.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/device.h>
> +#include <linux/serial_core.h>
> +#include <linux/kthread.h>
> +#include <linux/hrtimer.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/ctype.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/serialsim.h>
> +
> +#define PORT_SERIALECHO 72549
> +#define PORT_SERIALPIPEA 72550
> +#define PORT_SERIALPIPEB 72551

tabs?

> +
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +#define SERIALSIM_WAKES_PER_SEC	1000
> +#else
> +#define SERIALSIM_WAKES_PER_SEC	HZ
> +#endif
> +
> +#define SERIALSIM_XBUFSIZE	32
> +
> +/* For things to send on the line, in flags field. */
> +#define DO_FRAME_ERR		(1 << TTY_FRAME)
> +#define DO_PARITY_ERR		(1 << TTY_PARITY)
> +#define DO_OVERRUN_ERR		(1 << TTY_OVERRUN)
> +#define DO_BREAK		(1 << TTY_BREAK)
> +#define FLAGS_MASK (DO_FRAME_ERR | DO_PARITY_ERR | DO_OVERRUN_ERR | DO_BREAK)
> +
> +struct serialsim_intf {
> +	struct uart_port port;
> +
> +	/*
> +	 * This is my transmit buffer, my thread picks this up and
> +	 * injects them into the other port's uart.
> +	 */
> +	unsigned char xmitbuf[SERIALSIM_XBUFSIZE];
> +	struct circ_buf buf;
> +
> +	/* Error flags to send. */
> +	bool break_reported;
> +	unsigned int flags;
> +
> +	/* Modem state. */
> +	unsigned int mctrl;
> +	bool do_null_modem;
> +	spinlock_t mctrl_lock;
> +	struct tasklet_struct mctrl_tasklet;
> +
> +	/* My transmitter is enabled. */
> +	bool tx_enabled;
> +
> +	/* I can receive characters. */
> +	bool rx_enabled;
> +
> +	/* Is the port registered with the uart driver? */
> +	bool registered;
> +
> +	/*
> +	 * The serial echo port on the other side of this pipe (or points
> +	 * to myself in loopback mode.
> +	 */
> +	struct serialsim_intf *ointf;
> +
> +	unsigned int div;
> +	unsigned int bytes_per_interval;
> +	unsigned int per_interval_residual;
> +
> +	struct ktermios termios;
> +
> +	const char *threadname;
> +	struct task_struct *thread;
> +
> +	struct serial_rs485 rs485;
> +};
> +
> +#define circ_sbuf_space(buf) CIRC_SPACE((buf)->head, (buf)->tail, \
> +					SERIALSIM_XBUFSIZE)
> +#define circ_sbuf_empty(buf) ((buf)->head == (buf)->tail)
> +#define circ_sbuf_next(idx) (((idx) + 1) % SERIALSIM_XBUFSIZE)

Don't we have a ring buffer (or 3) structure already?  Did you create
another one?

> +static void serialsim_thread_delay(void)
> +{
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	ktime_t timeout;
> +
> +	timeout = ns_to_ktime(1000000000 / SERIALSIM_WAKES_PER_SEC);
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	schedule_hrtimeout(&timeout, HRTIMER_MODE_REL);
> +#else
> +	schedule_timeout_interruptible(1);
> +#endif
> +}

Why do you care about hires timers here?  Why not always just sleep to
slow things down?

> +
> +static int serialsim_thread(void *data)
> +{
> +	struct serialsim_intf *intf = data;
> +	struct serialsim_intf *ointf = intf->ointf;
> +	struct uart_port *port = &intf->port;
> +	struct uart_port *oport = &ointf->port;
> +	struct circ_buf *tbuf = &intf->buf;
> +	unsigned int residual = 0;
> +
> +	while (!kthread_should_stop()) {

Aren't we trying to get away from creating new kthreads?

Can you just use a workqueue entry?

> +static unsigned int nr_echo_ports = 4;
> +module_param(nr_echo_ports, uint, 0444);
> +MODULE_PARM_DESC(nr_echo_ports,
> +		 "The number of echo ports to create.  Defaults to 4");
> +
> +static unsigned int nr_pipe_ports = 4;
> +module_param(nr_pipe_ports, uint, 0444);
> +MODULE_PARM_DESC(nr_pipe_ports,
> +		 "The number of pipe ports to create.  Defaults to 4");

No way to just do this with configfs and not worry about module params?

> +static char *gettok(char **s)
> +{
> +	char *t = skip_spaces(*s);
> +	char *p = t;
> +
> +	while (*p && !isspace(*p))
> +		p++;
> +	if (*p)
> +		*p++ = '\0';
> +	*s = p;
> +
> +	return t;
> +}

We don't have this already in the tree?

> +static bool tokeq(const char *t, const char *m)
> +{
> +	return strcmp(t, m) == 0;
> +}

same here.

> +
> +static unsigned int parse_modem_line(char op, unsigned int flag,
> +				     unsigned int *mctrl)
> +{
> +	if (op == '+')
> +		*mctrl |= flag;
> +	else
> +		*mctrl &= ~flag;
> +	return flag;
> +}
> +
> +static void serialsim_ctrl_append(char **val, int *left, char *n, bool enabled)
> +{
> +	int count;
> +
> +	count = snprintf(*val, *left, " %c%s", enabled ? '+' : '-', n);
> +	*left -= count;
> +	*val += count;
> +}

sysfs files really should only be "one value per file", so this api is
troubling :(

> +static ssize_t serialsim_ctrl_read(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct tty_port *tport = dev_get_drvdata(dev);
> +	struct uart_state *state = container_of(tport, struct uart_state, port);
> +	struct uart_port *port = state->uart_port;
> +	struct serialsim_intf *intf = serialsim_port_to_intf(port);
> +	unsigned int mctrl = intf->mctrl;
> +	char *val = buf;
> +	int left = PAGE_SIZE;
> +	int count;
> +
> +	count = snprintf(val, left, "%s:", dev->kobj.name);

dev_name()?

And is it really needed?  It's already known as this is the sysfs file
for that device.  Don't make userspace parse it away.

> +	val += count;
> +	left -= count;
> +	serialsim_ctrl_append(&val, &left, "nullmodem", intf->do_null_modem);
> +	serialsim_ctrl_append(&val, &left, "cd", mctrl & TIOCM_CAR);
> +	serialsim_ctrl_append(&val, &left, "dsr", mctrl & TIOCM_DSR);
> +	serialsim_ctrl_append(&val, &left, "cts", mctrl & TIOCM_CTS);
> +	serialsim_ctrl_append(&val, &left, "ring", mctrl & TIOCM_RNG);
> +	serialsim_ctrl_append(&val, &left, "dtr", mctrl & TIOCM_DTR);
> +	serialsim_ctrl_append(&val, &left, "rts", mctrl & TIOCM_RTS);
> +	*val++ = '\n';
> +
> +	return val - buf;
> +}
> +
> +static ssize_t serialsim_ctrl_write(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *val, size_t count)
> +{
> +	struct tty_port *tport = dev_get_drvdata(dev);
> +	struct uart_state *state = container_of(tport, struct uart_state, port);
> +	struct uart_port *port = state->uart_port;
> +	struct serialsim_intf *intf = serialsim_port_to_intf(port);
> +	char *str = kstrndup(val, count, GFP_KERNEL);
> +	char *p, *s = str;
> +	int rv = count;
> +	unsigned int flags = 0;
> +	unsigned int nullmodem = 0;
> +	unsigned int mctrl_mask = 0, mctrl = 0;
> +
> +	if (!str)
> +		return -ENOMEM;
> +
> +	p = gettok(&s);
> +	while (*p) {
> +		char op = '\0';
> +		int err = 0;
> +
> +		switch (*p) {
> +		case '+':
> +		case '-':
> +			op = *p++;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (tokeq(p, "frame"))
> +			flags |= DO_FRAME_ERR;
> +		else if (tokeq(p, "parity"))
> +			flags |= DO_PARITY_ERR;
> +		else if (tokeq(p, "overrun"))
> +			flags |= DO_OVERRUN_ERR;
> +		else if (tokeq(p, "nullmodem"))
> +			nullmodem = op;
> +		else if (tokeq(p, "dsr"))
> +			mctrl_mask |= parse_modem_line(op, TIOCM_DSR, &mctrl);
> +		else if (tokeq(p, "cts"))
> +			mctrl_mask |= parse_modem_line(op, TIOCM_CTS, &mctrl);
> +		else if (tokeq(p, "cd"))
> +			mctrl_mask |= parse_modem_line(op, TIOCM_CAR, &mctrl);
> +		else if (tokeq(p, "ring"))
> +			mctrl_mask |= parse_modem_line(op, TIOCM_RNG, &mctrl);
> +		else
> +			err = -EINVAL;
> +
> +		if (err) {
> +			rv = err;
> +			goto out;
> +		}
> +		p = gettok(&s);
> +	}
> +
> +	if (flags)
> +		serialsim_set_flags(intf, flags);
> +	if (nullmodem)
> +		serialsim_set_null_modem(intf, nullmodem == '+');
> +	if (mctrl_mask)
> +		serialsim_set_modem_lines(intf, mctrl_mask, mctrl);
> +
> +out:
> +	kfree(str);
> +
> +	return rv;
> +}

This worries me, parsing sysfs files is ripe for problems.  configfs
might be better here.

> +
> +static DEVICE_ATTR(ctrl, 0660, serialsim_ctrl_read, serialsim_ctrl_write);

DEVICE_ATTR_RW()?

> +
> +static struct attribute *serialsim_dev_attrs[] = {
> +	&dev_attr_ctrl.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group serialsim_dev_attr_group = {
> +	.attrs = serialsim_dev_attrs,
> +};

ATTRIBUTE_GROUPS()?

> +static int __init serialsim_init(void)
> +{
> +	unsigned int i;
> +	int rv;
> +
> +	serialecho_ports = kcalloc(nr_echo_ports,
> +				   sizeof(*serialecho_ports),
> +				   GFP_KERNEL);
> +	if (!serialecho_ports) {
> +		pr_err("serialsim: Unable to allocate echo ports.\n");

No need to print error for memory failure.

> +		rv = ENOMEM;

-ENOMEM?

> +		goto out;
> +	}
> +
> +	serialpipe_ports = kcalloc(nr_pipe_ports * 2,
> +				   sizeof(*serialpipe_ports),
> +				   GFP_KERNEL);
> +	if (!serialpipe_ports) {
> +		kfree(serialecho_ports);
> +		pr_err("serialsim: Unable to allocate pipe ports.\n");

Same here.

> +		rv = ENOMEM;

-ENOMEM?

> +		goto out;

Shouldn't out clean up stuff?

> +	}
> +
> +	serialecho_driver.nr = nr_echo_ports;
> +	rv = uart_register_driver(&serialecho_driver);
> +	if (rv) {
> +		kfree(serialecho_ports);
> +		kfree(serialpipe_ports);
> +		pr_err("serialsim: Unable to register driver.\n");
> +		goto out;

Again, out should clean up stuff for an error.  Will make the code below
simpler.

> +	}
> +
> +	serialpipea_driver.nr = nr_pipe_ports;
> +	rv = uart_register_driver(&serialpipea_driver);
> +	if (rv) {
> +		uart_unregister_driver(&serialecho_driver);
> +		kfree(serialecho_ports);
> +		kfree(serialpipe_ports);
> +		pr_err("serialsim: Unable to register driver.\n");
> +		goto out;
> +	}
> +
> +	serialpipeb_driver.nr = nr_pipe_ports;
> +	rv = uart_register_driver(&serialpipeb_driver);
> +	if (rv) {
> +		uart_unregister_driver(&serialpipea_driver);
> +		uart_unregister_driver(&serialecho_driver);
> +		kfree(serialecho_ports);
> +		kfree(serialpipe_ports);
> +		pr_err("serialsim: Unable to register driver.\n");
> +		goto out;
> +	}
> +
> +	for (i = 0; i < nr_echo_ports; i++) {
> +		struct serialsim_intf *intf = &serialecho_ports[i];
> +		struct uart_port *port = &intf->port;
> +
> +		intf->buf.buf = intf->xmitbuf;
> +		intf->ointf = intf;
> +		intf->threadname = "serialecho";
> +		intf->do_null_modem = true;
> +		spin_lock_init(&intf->mctrl_lock);
> +		tasklet_init(&intf->mctrl_tasklet, mctrl_tasklet, (long) intf);
> +		/* Won't configure without some I/O or mem address set. */
> +		port->iobase = 1;
> +		port->line = i;
> +		port->flags = UPF_BOOT_AUTOCONF;
> +		port->ops = &serialecho_ops;
> +		spin_lock_init(&port->lock);
> +		port->attr_group = &serialsim_dev_attr_group;
> +		rv = uart_add_one_port(&serialecho_driver, port);
> +		if (rv)
> +			pr_err("serialsim: Unable to add uart port %d: %d\n",
> +			       i, rv);
> +		else
> +			intf->registered = true;
> +	}
> +
> +	for (i = 0; i < nr_pipe_ports * 2; i += 2) {
> +		struct serialsim_intf *intfa = &serialpipe_ports[i];
> +		struct serialsim_intf *intfb = &serialpipe_ports[i + 1];
> +		struct uart_port *porta = &intfa->port;
> +		struct uart_port *portb = &intfb->port;
> +
> +		intfa->buf.buf = intfa->xmitbuf;
> +		intfb->buf.buf = intfb->xmitbuf;
> +		intfa->ointf = intfb;
> +		intfb->ointf = intfa;
> +		intfa->threadname = "serialpipea";
> +		intfb->threadname = "serialpipeb";
> +		spin_lock_init(&intfa->mctrl_lock);
> +		spin_lock_init(&intfb->mctrl_lock);
> +		tasklet_init(&intfa->mctrl_tasklet, mctrl_tasklet,
> +			     (long) intfa);
> +		tasklet_init(&intfb->mctrl_tasklet, mctrl_tasklet,
> +			     (long) intfb);
> +
> +		/* Won't configure without some I/O or mem address set. */
> +		porta->iobase = 1;
> +		porta->line = i / 2;
> +		porta->flags = UPF_BOOT_AUTOCONF;
> +		porta->ops = &serialpipea_ops;
> +		spin_lock_init(&porta->lock);
> +		porta->attr_group = &serialsim_dev_attr_group;
> +		porta->rs485_config = serialsim_rs485;
> +
> +		/*
> +		 * uart_add_one_port() does an mctrl operation, which will
> +		 * claim the other port's lock.  So everything needs to be
> +		 * full initialized, and we need null modem off until we
> +		 * get things added.
> +		 */
> +		portb->iobase = 1;
> +		portb->line = i / 2;
> +		portb->flags = UPF_BOOT_AUTOCONF;
> +		portb->ops = &serialpipeb_ops;
> +		portb->attr_group = &serialsim_dev_attr_group;
> +		spin_lock_init(&portb->lock);
> +		portb->rs485_config = serialsim_rs485;
> +
> +		rv = uart_add_one_port(&serialpipea_driver, porta);
> +		if (rv) {
> +			pr_err("serialsim: Unable to add uart pipe a port %d: %d\n",
> +			       i, rv);
> +			continue;
> +		} else {
> +			intfa->registered = true;
> +		}
> +
> +		rv = uart_add_one_port(&serialpipeb_driver, portb);
> +		if (rv) {
> +			pr_err("serialsim: Unable to add uart pipe b port %d: %d\n",
> +			       i, rv);
> +			intfa->registered = false;
> +			uart_remove_one_port(&serialpipea_driver, porta);
> +		} else {
> +			intfb->registered = true;
> +		}
> +
> +		if (intfa->registered && intfb->registered) {
> +			serialsim_set_null_modem(intfa, true);
> +			serialsim_set_null_modem(intfb, true);
> +		}
> +	}
> +	rv = 0;
> +
> +	pr_info("serialsim ready\n");

Don't be noisy for when all is good.  Drivers should be quiet.

> --- /dev/null
> +++ b/include/uapi/linux/serialsim.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +
> +/*
> + * serialsim - Emulate a serial device in a loopback and/or pipe
> + */
> +
> +/*
> + * TTY IOCTLs for controlling the modem control and for error injection.
> + * See drivers/tty/serial/serialsim.c and Documentation/serial/serialsim.rst
> + * for details.
> + */
> +
> +#ifndef LINUX_SERIALSIM_H
> +#define LINUX_SERIALSIM_H
> +
> +#include <linux/ioctl.h>
> +#include <asm/termbits.h>
> +
> +#define TIOCSERSREMNULLMODEM	0x54e4
> +#define TIOCSERSREMMCTRL	0x54e5
> +#define TIOCSERSREMERR		0x54e6
> +#ifdef TCGETS2
> +#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios2)
> +#else
> +#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios)
> +#endif
> +#define TIOCSERGREMNULLMODEM	_IOR('T', 0xe8, int)
> +#define TIOCSERGREMMCTRL	_IOR('T', 0xe9, unsigned int)
> +#define TIOCSERGREMERR		_IOR('T', 0xea, unsigned int)
> +#define TIOCSERGREMRS485	_IOR('T', 0xeb, struct serial_rs485)

Wait, don't we have ioctls for these things in the tty layer already?
WHy add new ones?

thanks,

greg k-h
