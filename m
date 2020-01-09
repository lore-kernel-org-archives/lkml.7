Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81990C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A5F206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhAriIhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgAIXxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:53:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgAIXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MlF5dQoK0dle1ZtWDZdBf2+ZpHH+83Dr5WwoqzcG/Ug=; b=jhAriIhFGALIxRRRCqZHcRAxO
        bf4QTy+4gxMC39a/tlgJyZemUmAPzGWDjdYo3FHiNCnYh8JuaJUOUAqTcnkrixja9wAfclkGZmZtZ
        OiGYE3YLWVzXSN7R3Vf+GYLfFMDkJgubsYVgRPn1DL9zPq2/5vdltjhWxA0qgJ6h0DLzBaHWqmeWI
        HOIXJlomwE073znZL/WcTeVayoFFFIjuYZfMH/47g17s7JvjFwiHqnoOefTdRbJjnANQOgy68NXNA
        CBi9tnvH+bvoAl54/o9oGGG/HslohH6KEl7s/DCI+6/8jUsdX9veYo9gyCunxXFQ5VPrcsWtaI4wO
        C5UPITnAQ==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iphc3-0000H5-40; Thu, 09 Jan 2020 23:53:15 +0000
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e622d11-0eb7-274e-8f0a-132d296420fe@infradead.org>
Date:   Thu, 9 Jan 2020 15:53:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200109215444.95995-4-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/9/20 1:54 PM, Dmitry Safonov wrote:
> 
> Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++++++----
>  include/linux/serial_core.h      |  2 +-
>  lib/Kconfig.debug                |  8 +++++
>  3 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6ac9dfed3423..f70eba032d0b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
>  }
>  EXPORT_SYMBOL_GPL(uart_insert_char);
>  
> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
> +
> +static void uart_sysrq_on(struct work_struct *w)
> +{
> +	sysrq_toggle_support(1);
> +	pr_info("SysRq is enabled by magic sequience on serial\n");

typo:	                                   sequence

> +}
> +static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);



-- 
~Randy

