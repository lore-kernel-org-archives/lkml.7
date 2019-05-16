Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA59BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C421620657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfEPRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:21:19 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:42792 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfEPRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:21:19 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x4GHKxbf002968;
        Thu, 16 May 2019 18:20:59 +0100
Date:   Thu, 16 May 2019 18:20:58 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH v2 2/2] tty: add rpmsg driver
Message-ID: <20190516182058.2a565748@alans-desktop>
In-Reply-To: <1557500577-22366-3-git-send-email-arnaud.pouliquen@st.com>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
        <1557500577-22366-3-git-send-email-arnaud.pouliquen@st.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int rpmsg_tty_data_handler(struct rpmsg_device *rpdev, void *data,
> +				  int len, void *priv, u32 src)
> +{
> +	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
> +	u8 *cbuf;
> +	int space;
> +
> +	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
> +
> +	if (!len)
> +		return 0;
> +
> +	dev_dbg(&rpdev->dev, "space available: %d\n",
> +		tty_buffer_space_avail(&cport->port));
> +
> +	space = tty_prepare_flip_string(&cport->port, &cbuf, len);
> +	if (space <= 0) {
> +		dev_err(&rpdev->dev, "No memory for tty_prepare_flip_string\n");
> +		return -ENOMEM;
> +	}

Really bad idea.

1. It's not an 'error'. It's normal that in the case the consumer is
blocked you can run out of processing space

2. You will trigger this when being hit by a very large fast flow of data
so responding by burning CPU spewing messages (possibly even out of this
tty) is bad.

It's not a bug - just keep statistics and throw it away. If anyone cares
they will do flow control.


> +
> +static int rpmsg_tty_write_control(struct tty_struct *tty, u8 ctrl, u8 *values,
> +				   unsigned int n_value)
> +{
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +	struct rpmsg_tty_payload *msg;
> +	struct rpmsg_tty_ctrl *m_ctrl;
> +	struct rpmsg_device *rpdev;
> +	unsigned int msg_size;
> +	int ret;
> +
> +	if (!cport) {
> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}
> +
> +	rpdev = cport->rpdev;
> +
> +	msg_size = sizeof(*msg) + sizeof(*m_ctrl) + n_value;
> +	msg = kzalloc(msg_size, GFP_KERNEL);


Out of memory check ?

> +static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int len)
> +{
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +	struct rpmsg_device *rpdev;
> +	int msg_size, msg_max_size, ret = 0;
> +	int cmd_sz = sizeof(struct rpmsg_tty_payload);
> +	u8 *tmpbuf;
> +
> +	if (!cport) {
> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}
> +
> +	/* If cts not set, the message is not sent*/
> +	if (!cport->cts)
> +		return 0;
> +
> +	rpdev = cport->rpdev;
> +
> +	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
> +		__func__, tty->index, len);
> +	if (!buf) {
> +		dev_err(&rpdev->dev, "buf shouldn't be null.\n");
> +		return -ENOMEM;
> +	}
> +
> +	msg_max_size = rpmsg_get_buf_payload_size(rpdev->ept);
> +	if (msg_max_size < 0)
> +		return msg_max_size;
> +
> +	msg_size = min(len + cmd_sz, msg_max_size);
> +	tmpbuf = kzalloc(msg_size, GFP_KERNEL);

Allocation failure check ?

