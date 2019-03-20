Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F9C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029AC218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553106380;
	bh=5cG3/v+PJ0QS+PMPd/6BcA1NK+wQFhG2BEiTitNEmAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IjRRw3AguANwKumNvTiYWVGcUeb++0qNlfcYjROBTSvaqf/YPfMzuevPVaa9io0WA
	 R5mxcDKs5a+PxCRnHWrSJcFunVpI5uBXB/FBDOJE4JmdXdVn0EqG1+jTYaVJ9rwY8P
	 D3JOWI6N0whJzdwxyZbPNXEmqKf2kUs2F3Pymgxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCTS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfCTS0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:26:18 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377732184D;
        Wed, 20 Mar 2019 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553106377;
        bh=5cG3/v+PJ0QS+PMPd/6BcA1NK+wQFhG2BEiTitNEmAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxU9ecRJtcKAeBAocoJClsa/SRVd2y88VYI/Q39DacmcE3235iGmhW9ZJyNqDXRAk
         cG8hzgb/nHUf3Sa40Ir2PjzNEQzQtqJLvT3unzHRSeudP2qKJxuMM8ihKT134g7KNT
         cOHvRL0Yo/NxqjH8dArHaNHje2MxVJ40m+HWj/iE=
Date:   Wed, 20 Mar 2019 19:26:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        "Knut St . Osmundsen" <knut.osmundsen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: Implement passing requestor info to the host
 for VirtualBox 6.0.x
Message-ID: <20190320182614.GB3907@kroah.com>
References: <20190320093519.26029-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320093519.26029-1-hdegoede@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:35:19AM +0100, Hans de Goede wrote:
> diff --git a/drivers/virt/vboxguest/vboxguest_version.h b/drivers/virt/vboxguest/vboxguest_version.h
> index 77f0c8f8a231..84834dad38d5 100644
> --- a/drivers/virt/vboxguest/vboxguest_version.h
> +++ b/drivers/virt/vboxguest/vboxguest_version.h
> @@ -9,11 +9,10 @@
>  #ifndef __VBOX_VERSION_H__
>  #define __VBOX_VERSION_H__
>  
> -/* Last synced October 4th 2017 */

We don't care about the date sync anymore?

> -#define VBG_VERSION_MAJOR 5
> -#define VBG_VERSION_MINOR 2
> +#define VBG_VERSION_MAJOR 6
> +#define VBG_VERSION_MINOR 0
>  #define VBG_VERSION_BUILD 0
> -#define VBG_SVN_REV 68940
> -#define VBG_VERSION_STRING "5.2.0"
> +#define VBG_SVN_REV 127566
> +#define VBG_VERSION_STRING "6.0.0"

Do we really need to keep track of this?

>  
>  #endif
> diff --git a/drivers/virt/vboxguest/vmmdev.h b/drivers/virt/vboxguest/vmmdev.h
> index 5e2ae978935d..6337b8d75d96 100644
> --- a/drivers/virt/vboxguest/vmmdev.h
> +++ b/drivers/virt/vboxguest/vmmdev.h
> @@ -98,8 +98,8 @@ struct vmmdev_request_header {
>  	s32 rc;
>  	/** Reserved field no.1. MBZ. */
>  	u32 reserved1;
> -	/** Reserved field no.2. MBZ. */
> -	u32 reserved2;
> +	/** IN: Requestor information (VMMDEV_REQUESTOR_*) */
> +	u32 requestor;

They didn't use the first reserved field?  Oh well :(

> --- a/include/uapi/linux/vbox_vmmdev_types.h
> +++ b/include/uapi/linux/vbox_vmmdev_types.h
> @@ -102,6 +102,37 @@ enum vmmdev_request_type {
>  #define VMMDEVREQ_HGCM_CALL VMMDEVREQ_HGCM_CALL32
>  #endif
>  
> +/* vmmdev_request_header.requestor defines */
> +
> +/* Requestor user not given. */
> +#define VMMDEV_REQUESTOR_USR_NOT_GIVEN                      0x00000000
> +/* The kernel driver (VBoxGuest) is the requestor. */
> +#define VMMDEV_REQUESTOR_USR_DRV                            0x00000001
> +/* Some other kernel driver is the requestor. */
> +#define VMMDEV_REQUESTOR_USR_DRV_OTHER                      0x00000002
> +/* The root or a admin user is the requestor. */
> +#define VMMDEV_REQUESTOR_USR_ROOT                           0x00000003
> +/* Regular joe user is making the request. */
> +#define VMMDEV_REQUESTOR_USR_USER                           0x00000006
> +/* User classification mask. */
> +#define VMMDEV_REQUESTOR_USR_MASK                           0x00000007
> +/* Kernel mode request. */
> +#define VMMDEV_REQUESTOR_KERNEL                             0x00000000

Wait, isn't that the same as VMMDEV_REQUESTOR_USR_NOT_GIVEN?

> +/* User mode request. */
> +#define VMMDEV_REQUESTOR_USERMODE                           0x00000008
> +/* Don't know the physical console association of the requestor. */
> +#define VMMDEV_REQUESTOR_CON_DONT_KNOW                      0x00000000

And here, why is this number recycled?

> +/* Console classification mask. */
> +#define VMMDEV_REQUESTOR_CON_MASK                           0x00000040
> +/* Requestor is member of special VirtualBox user group. */
> +#define VMMDEV_REQUESTOR_GRP_VBOX                           0x00000080

Can you add a blank line here to make it more obvious it is "TRUST"
stuff here?

> +/* Requestor trust level: Unspecified */
> +#define VMMDEV_REQUESTOR_TRUST_NOT_GIVEN                    0x00000000
> +/* Requestor trust level mask */
> +#define VMMDEV_REQUESTOR_TRUST_MASK                         0x00007000

So those bits are the "trust" values?

that's odd, oh well, it's their api, not ours :(

> +/* Requestor is using the less trusted user device node (/dev/vboxuser) */
> +#define VMMDEV_REQUESTOR_USER_DEVICE                        0x00008000

Wait, what is this for?

So the dev node isn't as "trusted" as some other api?  Why not?

confused,

greg k-h
