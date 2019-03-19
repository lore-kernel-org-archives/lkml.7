Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF17E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552987416;
	bh=0d3F1lEaIVNUwHo9E0LOPr2LOXSklUe7KHejJ9H77TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C1AG3O/Oh44cPRmYcKdNeziRNIEy6Sc23luKqwaDczwKvICGjMyqc3AuPJoTPlh8i
	 sl8Z8ZPyIMtEfsAYgB1PEaGePe/uKXx+Tjn3sTWumpALl7zK7Et3ASz1wXenr5sTMu
	 Tg3WVfWQM6Muk6UCboe8S12H5o3F/UGwlNfgsSWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfCSJXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfCSJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:23:34 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3907220857;
        Tue, 19 Mar 2019 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552987413;
        bh=0d3F1lEaIVNUwHo9E0LOPr2LOXSklUe7KHejJ9H77TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6XZbxPQQ+ytlg9F+qW299agTzTey988XUHrjTP8KO3cK5A1a8t+SvHGvX3Li3qwl
         +/d8xENPUD4VkzowvLOjy2MxrJZB3mds8UjUHhBcOtDARa6XYSm4+izjpvb1FfM1A1
         ajf7ojwU7rg0V8T/hT3HPTMsPohbTDFyaW2A3sh8=
Date:   Tue, 19 Mar 2019 10:23:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Ian King <colin.king@canonical.com>,
        Matteo Croce <mcroce@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] usb: introduce usb_ep_type_string() function
Message-ID: <20190319092331.GA21652@kroah.com>
References: <28a8e9f1518e47c35e4563706cbe592b972a7f9d.1552977710.git.chunfeng.yun@mediatek.com>
 <1552982059.10179.143.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552982059.10179.143.camel@mhfsdcap03>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:54:19PM +0800, Chunfeng Yun wrote:
> 
> Hi Felipe & Mathias,
> 
> Could you please comment this patch, if there is some-effect on dwc3 and
> xhci, I'll remove its change.

To be specific, you are changing the string values for things that might
care about it and are seen by userspace.

Please be explicit about this, as it could cause problems.

greg k-h
