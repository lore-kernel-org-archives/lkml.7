Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F783C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63532089F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTO2aEfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfGAGAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:00:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39612 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfGAGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:00:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so6741203pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sg6AW5CSqanpjYZH3U5Z/ukrtDxL0FdU1gA0efXYK0A=;
        b=QTO2aEfzi+A3HebhY7g/ZgvkJUcXa3vAiESzBq8/GpxefC8hHHKW1weAYnL9RurIRC
         eB4mQaIkZN8U+uCAHQ0gxKhc71mpoGo7tG9c5Z7UGTR76/w98eZqSjCsGP/qLMbt/pLp
         JO93Yul0TEW/VhJv3oJSloY/mML5blyvDQ5XfXM/eXwXAlkhs6rGvdOtYJnsPpYQiOLE
         zBT+aUk2/QPUk10GQs5Tea+BytLTgdOCje/6qslcdWzm4PJ4CBe/3qxU471pKpnjzQr4
         yKUBfu2t50wT03EYggRyqXAmichUFKS97Yb67hprGOfAoJXSJ3uI5mbHn+yleb8Lttay
         fgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sg6AW5CSqanpjYZH3U5Z/ukrtDxL0FdU1gA0efXYK0A=;
        b=jONfqDLXbVEmm3urdkU6MUZHcuFzuCry6mOc8LqgipK5kFuGWb35vW8py+keakQpmS
         TM+Tspi1zT4NYWQAY/s5qCgawTVJW/F4Qll4TbecGb4QPl8KaMTEWacQ4WPZoZ8hgwvR
         84iQozg2i45+oyJSmme548G3zvdf4BX/dQw74dopSY/MHqZbun3cr2caL18HFY/CVmrN
         hdS6dlvCXs35IBlYbwCIUPynwmrjDrb2I3lGj37M7qw5ylcXlDaB4rP92/YXXcUwscS2
         HbfyNr6hKGRxaHlYwr4ydNE1bNiZSs73FO1B8e1QZBGuXzTig4EO9tBBFmqNzKLzk7o8
         y00g==
X-Gm-Message-State: APjAAAWsHzfzUiWSf0fgDffhUl1XzYFc46jw9udXdjLknKvBvDaq95w8
        4T7vgS/H+n9nhAw3OSKg4oNnkg==
X-Google-Smtp-Source: APXvYqxxnVbUx2Y7NhWR1fhPFR5nH7JgIMmZ37hT57LCoxkhPrg7BsR5QVJt+o8s1K3nGQKhB7uWUA==
X-Received: by 2002:a17:902:246:: with SMTP id 64mr26301451plc.311.1561960842206;
        Sun, 30 Jun 2019 23:00:42 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f14sm9253392pfn.53.2019.06.30.23.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 23:00:41 -0700 (PDT)
Date:   Sun, 30 Jun 2019 23:00:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH v2 2/2] tty: add rpmsg driver
Message-ID: <20190701060039.GD1263@builder>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
 <1557500577-22366-3-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557500577-22366-3-git-send-email-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 May 08:02 PDT 2019, Arnaud Pouliquen wrote:

> This driver exposes a standard tty interface on top of the rpmsg
> framework through the "rpmsg-tty-channel" rpmsg service.
> 
> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> per rpmsg endpoint.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  Documentation/serial/tty_rpmsg.txt |  38 +++
>  drivers/tty/Kconfig                |   9 +
>  drivers/tty/Makefile               |   1 +
>  drivers/tty/rpmsg_tty.c            | 479 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 527 insertions(+)
>  create mode 100644 Documentation/serial/tty_rpmsg.txt
>  create mode 100644 drivers/tty/rpmsg_tty.c
> 
> diff --git a/Documentation/serial/tty_rpmsg.txt b/Documentation/serial/tty_rpmsg.txt
> new file mode 100644
> index 000000000000..e069ed268a2b
> --- /dev/null
> +++ b/Documentation/serial/tty_rpmsg.txt
> @@ -0,0 +1,38 @@
> +
> +			The rpmsg TTY
> +
> +The rpmsg tty driver implements a serial communication on the rpmsg bus,
> +to communicate with a remote processor devices in asymmetric multiprocessing
> +(AMP) configurations.
> +
> +The remote processor can instantiate a new tty by requesting a new "rpmsg-tty-channel" RPMsg service. Information related to the RPMsg and
> +associated tty device is available in /sys/bus/rpmsg/devices/virtio0.rpmsg-tty-channel.-1.<X>, with
> +<X> corresponding to the ttyRPMSG instance.
> +
> +RPMsg data/control structure
> +----------------------------
> +
> +The RPMsg is used to send data or control messages. Differentiation between the
> +stream and the control messages is done thanks to the first byte of the
> +RPMsg payload:
> +
> +
> +RPMSG_DATA	- rest of messages contains data
> +
> +RPMSG_CTRL 	- message contains control.
> +
> +
> +To be compliant with this driver, the remote firmware has to respect this RPMsg
> +payload structure. At least the RPMSG_DATA type has to be supported. The
> +RPMSG_CTRL is optional.
> +

This scheme prevents us from using this driver to expose any existing
tty-like channels without having to modify such firmware.

> +Flow control type
> +-----------------
> +
> +A minimum flow control can be implemented to allow/block communication with the remote processor.
> +
> +DATA_TERM_READY	-	one parameter:
> +			- u8 state
> +				Set to indicate to remote side that terminal is
> +				ready for communication.
> +				Reset to block communication with remote side.

And as shown in discussions following Qualcomm's proposed flow-control
addition to the rpmsg API the need for flow control is not limited to
this custom tty like interface. 


So I really would like to see an implementation of a side-band flow
control mechanism in the virtio rpmsg bus.

> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index e0a04bfc873e..d7b426939f69 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -442,6 +442,15 @@ config VCC
>  	help
>  	  Support for Sun logical domain consoles.
>  
> +config RPMSG_TTY
> +	tristate "RPMSG tty driver"
> +	depends on RPMSG
> +	help
> +	  Say y here to export rpmsg endpoints as tty devices, usually found
> +	  in /dev/ttyRPMSGx.
> +	  This makes it possible for user-space programs to send and receive
> +	  rpmsg messages as a standard tty protocol.
> +
>  config LDISC_AUTOLOAD
>  	bool "Automatically load TTY Line Disciplines"
>  	default y
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index c72cafdf32b4..90a98a20714d 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -33,5 +33,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>  obj-$(CONFIG_VCC)		+= vcc.o
> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>  
>  obj-y += ipwireless/
> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
[..]
> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
> +	{ .name	= "rpmsg-tty-channel" },

I really would like a mechanism that does not depend on a fixed channel
name, as this required that firmware is written specifically for being
paired with this driver.

In other words this is exactly the same problem that we worked around in
rpmsg_char.

Regards,
Bjorn
