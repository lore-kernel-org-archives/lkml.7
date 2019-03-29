Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28437218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="GpY1Hjj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfC2WN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:13:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43776 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2WNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:13:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id t81so2874711oig.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NtgwzGUDtHDVMA/Mj27wz+HRBAaxmKDNbLGra6YsPx0=;
        b=GpY1Hjj8VdxDbzo7LdIMblX2PlpMzdZd14xqIDCkILL4TFGI/Ra1A7u7jpPLcS3Ab5
         Aazh9ey5+6k/o+UmAp6hjB8m/ZdDQ4lIO94LR2xPCMm3U/UKOdb0SY6OCNPr0NtKS9X/
         YSok954V1sJSNpoTgKL9CQNPXLiFPR3qO7jfaj6soWY+Cg4tKbYQW0gLtcu2mdYcGo6e
         ert9yGTk4aLfkROxtCFYoCqcdRjnkmJRn9n8KiEl/x99zsOYubolJki10box/urHbXLd
         i1Yfx5+dvC76sc34QKk+5EXRXl/0c9kqMyWEOoEb9zwu8/+s0SVRDxNxeK5XzC7udRZ2
         R14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NtgwzGUDtHDVMA/Mj27wz+HRBAaxmKDNbLGra6YsPx0=;
        b=DZ34tIBsTvzfBrpne94hUQey+LHfocbdgQjt+Y3ZPX4jUVdywEZkgyxoeIp525L0uu
         8gcatOHHBWOxiNK3HyhbY688+bdVD0NPZB5TJh2QWlmIJZIActCvy7jMu2iV2wrUpLmp
         sdtxIqAZBGZQwzbLG6bWNvaCG7zRi3dwMVk9sZXkyJ3QDvUgrJ1yLrdV20ZcnY41uANc
         lBnNKcYJeeiO1JwqBGs1JkqHjaVZZydipXK9a2ia5NTgtpGzGPPsnjlnTZwU5DFJ4Yy0
         oFIpY1bSVDQeYYbzeQ6TvyA1giImKpfvZvfXNOAh/MQWQlTiGg+3iKFoU5+8YmbcdYVK
         Q6OA==
X-Gm-Message-State: APjAAAWixGqoJETJw4RTLE/W8dADWr/L+i7lLtedXy+Y+Hl7sFrIh//o
        O76aDb6FyZIynXU4eeTaL1er9do2sKc=
X-Google-Smtp-Source: APXvYqwaXALEsnKCz/huLaE8hiNzfLAXflvOdeiJ8032OqOXTAlQaPkkr3QharV268uAyEFVBZXbag==
X-Received: by 2002:aca:d4d8:: with SMTP id l207mr5325531oig.29.1553897632392;
        Fri, 29 Mar 2019 15:13:52 -0700 (PDT)
Received: from minyard.net (75-108-126-199.enidcmtk01.res.dyn.suddenlink.net. [75.108.126.199])
        by smtp.gmail.com with ESMTPSA id b23sm1230955otl.55.2019.03.29.15.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 15:13:51 -0700 (PDT)
Date:   Fri, 29 Mar 2019 17:13:49 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     minyard@acm.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Message-ID: <20190329221349.GG31733@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190305171231.22133-1-minyard@acm.org>
 <20190327154439.GA18500@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327154439.GA18500@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:44:39AM +0900, Greg Kroah-Hartman wrote:
> On Tue, Mar 05, 2019 at 11:12:31AM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > This creates simulated serial ports, both as echo devices and pipe
> > devices.  The driver reasonably approximates the serial port speed
> > and simulates some modem control lines.  It allows error injection
> > and direct control of modem control lines.
> 
> I like this, thanks for doing it!

Hopefully this is useful for others.  I guess you could test the
kernel serial code with it, too.

> 
> Minor nits below:

Deleted and made the changes I agreed with or understood.  Other
comment below...

> > +
> > +#define circ_sbuf_space(buf) CIRC_SPACE((buf)->head, (buf)->tail, \
> > +					SERIALSIM_XBUFSIZE)
> > +#define circ_sbuf_empty(buf) ((buf)->head == (buf)->tail)
> > +#define circ_sbuf_next(idx) (((idx) + 1) % SERIALSIM_XBUFSIZE)
> 
> Don't we have a ring buffer (or 3) structure already?  Did you create
> another one?

I'm using circ_buf, same as the main serial code, these are just helpers.
Is there something else I can use?  The only ring buffer I saw that was
named that was for tracing, and that really wouldn't work.

> 
> > +static void serialsim_thread_delay(void)
> > +{
> > +#ifdef CONFIG_HIGH_RES_TIMERS
> > +	ktime_t timeout;
> > +
> > +	timeout = ns_to_ktime(1000000000 / SERIALSIM_WAKES_PER_SEC);
> > +	set_current_state(TASK_INTERRUPTIBLE);
> > +	schedule_hrtimeout(&timeout, HRTIMER_MODE_REL);
> > +#else
> > +	schedule_timeout_interruptible(1);
> > +#endif
> > +}
> 
> Why do you care about hires timers here?  Why not always just sleep to
> slow things down?

It makes things smoother, otherwise you get no data for a while then
big bursts of data at higher speeds.

> 
> > +
> > +static int serialsim_thread(void *data)
> > +{
> > +	struct serialsim_intf *intf = data;
> > +	struct serialsim_intf *ointf = intf->ointf;
> > +	struct uart_port *port = &intf->port;
> > +	struct uart_port *oport = &ointf->port;
> > +	struct circ_buf *tbuf = &intf->buf;
> > +	unsigned int residual = 0;
> > +
> > +	while (!kthread_should_stop()) {
> 
> Aren't we trying to get away from creating new kthreads?
> 
> Can you just use a workqueue entry?

The purpose of this is to wait short periods of time and copy characters
from one serial port to the other.  I'm not sure how a work queue would
do that.  I could drive it from timers, would that be better?  I don't
need something that runs in thread context.

Either way, it's not a terribly efficient mechanism, but that wasn't
a big concern for this, I don't think.

> 
> > +static unsigned int nr_echo_ports = 4;
> > +module_param(nr_echo_ports, uint, 0444);
> > +MODULE_PARM_DESC(nr_echo_ports,
> > +		 "The number of echo ports to create.  Defaults to 4");
> > +
> > +static unsigned int nr_pipe_ports = 4;
> > +module_param(nr_pipe_ports, uint, 0444);
> > +MODULE_PARM_DESC(nr_pipe_ports,
> > +		 "The number of pipe ports to create.  Defaults to 4");
> 
> No way to just do this with configfs and not worry about module params?

I'll look.  Module parameters seem a lot simpler, though.  I could also
just make it not configurable.

> 
> > +static char *gettok(char **s)
> > +{
> > +	char *t = skip_spaces(*s);
> > +	char *p = t;
> > +
> > +	while (*p && !isspace(*p))
> > +		p++;
> > +	if (*p)
> > +		*p++ = '\0';
> > +	*s = p;
> > +
> > +	return t;
> > +}
> 
> We don't have this already in the tree?

There is strsep(), but there's no way to do isspace() on it.  I don't
see a set of space characters anyplace.

> 
> > +static bool tokeq(const char *t, const char *m)
> > +{
> > +	return strcmp(t, m) == 0;
> > +}
> 
> same here.

There is sysfs_streq(), but it's not quite the same.  I didn't see
anything else.

> 
> > +
> > +static unsigned int parse_modem_line(char op, unsigned int flag,
> > +				     unsigned int *mctrl)
> > +{
> > +	if (op == '+')
> > +		*mctrl |= flag;
> > +	else
> > +		*mctrl &= ~flag;
> > +	return flag;
> > +}
> > +
> > +static void serialsim_ctrl_append(char **val, int *left, char *n, bool enabled)
> > +{
> > +	int count;
> > +
> > +	count = snprintf(*val, *left, " %c%s", enabled ? '+' : '-', n);
> > +	*left -= count;
> > +	*val += count;
> > +}
> 
> sysfs files really should only be "one value per file", so this api is
> troubling :(

Yeah, it is.  I wanted something that was easy for scripts to parse.
More on this below...

> 
> This worries me, parsing sysfs files is ripe for problems.  configfs
> might be better here.

Maybe so, but wouldn't you still have to do parsing?

I could separate these out into individual items (dtr, dsr, etc.).  You
wouldn't be able to get an atomic view of the modem lines, though.

On the whole sysfs thing, I'm not currently using the sysfs interface
for my testing, but I thought I would use it from scripts.  It would
still be better for scripts, but perhaps it's better to just pull the
whole sysfs part.

> 
> > +
> > +static DEVICE_ATTR(ctrl, 0660, serialsim_ctrl_read, serialsim_ctrl_write);
> 
> DEVICE_ATTR_RW()?

Doesn't take show or store functions.

> > +
> > +#define TIOCSERSREMNULLMODEM	0x54e4
> > +#define TIOCSERSREMMCTRL	0x54e5
> > +#define TIOCSERSREMERR		0x54e6
> > +#ifdef TCGETS2
> > +#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios2)
> > +#else
> > +#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios)
> > +#endif
> > +#define TIOCSERGREMNULLMODEM	_IOR('T', 0xe8, int)
> > +#define TIOCSERGREMMCTRL	_IOR('T', 0xe9, unsigned int)
> > +#define TIOCSERGREMERR		_IOR('T', 0xea, unsigned int)
> > +#define TIOCSERGREMRS485	_IOR('T', 0xeb, struct serial_rs485)
> 
> Wait, don't we have ioctls for these things in the tty layer already?
> WHy add new ones?

These are for getting and setting the remote end's modem control 
lines.  I'm not sure how I could do that with the same ioctls.

-corey
