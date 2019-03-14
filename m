Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843E820854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNKLJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:11:09 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:43273 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:11:09 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 06:11:07 EDT
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id x2EA0dv9009635
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Mar 2019 11:00:39 +0100
Date:   Thu, 14 Mar 2019 11:00:38 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] firewire: mark expected switch fall-throughs
Message-ID: <20190314110038.7ef825de@kant>
In-Reply-To: <20190211180356.GA27613@embeddedor>
References: <20190211180356.GA27613@embeddedor>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added Cc: Mathieu Malaterre, who sent a patch which is a subset of this)

On Feb 11 Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/firewire/core-device.c: In function ‘set_broadcast_channel’:
> drivers/firewire/core-device.c:969:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (data & cpu_to_be32(1 << 31)) {
>        ^
> drivers/firewire/core-device.c:974:3: note: here
>    case RCODE_ADDRESS_ERROR:
>    ^~~~
> drivers/firewire/core-iso.c: In function ‘manage_channel’:
> drivers/firewire/core-iso.c:308:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if ((data[0] & bit) == (data[1] & bit))
>        ^
> drivers/firewire/core-iso.c:312:3: note: here
>    default:
>    ^~~~~~~
> drivers/firewire/core-topology.c: In function ‘count_ports’:
> drivers/firewire/core-topology.c:69:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     (*child_port_count)++;
>     ~~~~~~~~~~~~~~~~~~~^~
> drivers/firewire/core-topology.c:70:3: note: here
>    case SELFID_PORT_PARENT:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that in some cases, the code comment is modified in
> accordance with what GCC is expecting to find.

OK, I looked up
https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Warning-Options.html#index-Wimplicit-fallthrough
now.  I am loudly sighing and rolling my eyes...  Anyway; the last regex
listed at the Wimplicit-fallthrough=3 bullet point is obviously the one
you are wanting to match.

> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/firewire/core-device.c   | 2 +-
>  drivers/firewire/core-iso.c      | 2 +-
>  drivers/firewire/core-topology.c | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
> index 7c2eed76011e..0c86548fa4a7 100644
> --- a/drivers/firewire/core-device.c
> +++ b/drivers/firewire/core-device.c
> @@ -970,7 +970,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
>  				device->bc_implemented = BC_IMPLEMENTED;
>  				break;
>  			}
> -			/* else fall through to case address error */
> +			/* else, fall through - to case address error */
>  		case RCODE_ADDRESS_ERROR:
>  			device->bc_implemented = BC_UNIMPLEMENTED;
>  		}
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784cffc23..7e5c98840b80 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -308,7 +308,7 @@ static int manage_channel(struct fw_card *card, int irm_id, int generation,
>  			if ((data[0] & bit) == (data[1] & bit))
>  				continue;
>  
> -			/* 1394-1995 IRM, fall through to retry. */
> +			/* fall through - to retry for 1394-1995 IRM */

If you don't mind, I will apply your patch with a different wording of this
comment:

			/* fall through - It's an 1394-1995 IRM, retry. */

I'll mark my modification to your patch in the signed-off-by-tag.

>  		default:
>  			if (retry) {
>  				retry--;
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index 7db234d3fbdd..82c67e900aad 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -67,6 +67,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
>  		switch (port_type) {
>  		case SELFID_PORT_CHILD:
>  			(*child_port_count)++;
> +			/* fall through */
>  		case SELFID_PORT_PARENT:
>  		case SELFID_PORT_NCONN:
>  			(*total_port_count)++;

-- 
Stefan Richter
-======---== --== -===-
http://arcgraph.de/sr/
