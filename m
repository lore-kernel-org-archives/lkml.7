Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A13C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E5620733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576589770;
	bh=0GcJLxA7OSgngk5Cbf7gZ164cpouoGCQ7wXshqh7xP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sw2tMnOY7iB4MucOGv67t4zcBCmtvu7nP44hL5YywDo1n0MvimDzLpy83qXAUJxgL
	 U9naDDpdAvWLGETqcXARr+MQa7IXc53AjzcKGGtQQOytZKy49zYQnWCrLgZfTqUnZ9
	 iJ4zXwuNjJCGrDIPEYXUkpyz2rKkDUN9boHtvHkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfLQNgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:36:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B9320733;
        Tue, 17 Dec 2019 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576589767;
        bh=0GcJLxA7OSgngk5Cbf7gZ164cpouoGCQ7wXshqh7xP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO7sYP9hzJ2LKFUjWYMr8cKQRSxT34uYSPAm9E/Ynn6jHkHN7qs+n58IU5Pq5mMJX
         z8As6iSwaa4HYA7zrZ/1VAByV6uIXw4sihKKWn/HxO+ihsUjgLgfbM6rztO94oQHTP
         6KDwwBh4NboagV0PZHwAnG1Zgwa/GJv0gnSlTtmo=
Date:   Tue, 17 Dec 2019 14:36:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Kim <david.kim@ncipher.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Tim Magee <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191217133605.GC3362771@kroah.com>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217132244.14768-2-david.kim@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:22:44PM +0000, Dave Kim wrote:
> --- /dev/null
> +++ b/include/uapi/linux/nshield_solo.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + *
> + * nshield_solo.h: UAPI header for driving the nCipher PCI HSMs using the
> + * nshield_solo module
> + *
> + */
> +#ifndef _UAPI_NSHIELD_SOLO_H_
> +#define _UAPI_NSHIELD_SOLO_H_
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +/* Device ioctl struct definitions */
> +
> +/* Result of the ENQUIRY ioctl. */
> +struct nfdev_enquiry_str {
> +	__u32 busno; /**< Which bus is the PCI device on. */
> +	__u8 slotno; /**< Which slot is the PCI device in. */
> +	__u8 reserved[3]; /**< for consistent struct alignment */

What is this crazy /**< text?

Please use correct kerneldoc formatting to help document things.

> +};
> +
> +/* Result of the STATS ioctl. */
> +struct nfdev_stats_str {
> +	__u32 isr; /**< Count interrupts. */
> +	__u32 isr_read; /**< Count read interrupts. */
> +	__u32 isr_write; /**< Count write interrupts. */
> +	__u32 write_fail; /**< Count write failures. */
> +	__u32 write_block; /**< Count blocks written. */
> +	__u32 write_byte; /**< Count bytes written. */
> +	__u32 read_fail; /**< Count read failures. */
> +	__u32 read_block; /**< Count blocks read. */
> +	__u32 read_byte; /**< Count bytes read. */
> +	__u32 ensure_fail; /**< Count read request failures. */
> +	__u32 ensure; /**< Count read requests. */
> +};
> +
> +/* Result of the STATUS ioctl. */
> +struct nfdev_status_str {
> +	__u32 status; /**< Status flags. */
> +	char error[8]; /**< Error string. */
> +};
> +
> +/* Input to the CONTROL ioctl. */
> +struct nfdev_control_str {
> +	__u32 control; /**< Control flags. */
> +};
> +
> +/** Index of control bits indicating desired mode
> + *
> + * Desired mode follows the M_ModuleMode enumeration.
> + */
> +#define NFDEV_CONTROL_MODE_SHIFT       1
> +
> +/** Detect a backwards-compatible control value
> + *
> + * Returns true if the request control value "makes no difference", i.e.
> + * and the failure of an attempt to set it is therefore uninteresting.
> + */
> +#define NFDEV_CONTROL_HARMLESS(c) ((c) <= 1)

Why does userspace need this?


> +
> +/** Monitor firmware supports MOI control and error reporting
> + */

Correct kerneldoc format everywhere please.

> +#define NFDEV_STATUS_MONITOR_MOI       0x0001
> +
> +/** Application firmware supports MOI control and error reporting
> + */
> +#define NFDEV_STATUS_APPLICATION_MOI   0x0002
> +
> +/** Application firmware running and supports error reporting
> + */
> +#define NFDEV_STATUS_APPLICATION_RUNNING 0x0004
> +
> +/** HSM failed
> + *
> + * Consult error[] for additional information.
> + */
> +#define NFDEV_STATUS_FAILED            0x0008
> +
> +/** Standard PCI interface. */
> +#define NFDEV_IF_STANDARD	       0x01
> +
> +/** PCI interface with read replies pushed from device
> + *  via DMA.
> + */
> +#define NFDEV_IF_PCI_PUSH	       0x02
> +
> +/** PCI interface with read replies pushed from device
> + *  and write requests pulled from host via DMA.
> + */
> +#define NFDEV_IF_PCI_PULL 0x03
> +
> +/** Maximum PCI interface. */
> +#define NFDEV_IF_MAX_VERS              NFDEV_IF_PCI_PUSH_PULL
> +
> +/* platform independent base ioctl numbers */
> +
> +enum {
> +	/** Enquiry ioctl.
> +	 *  \return nfdev_enquiry_str describing the attached device.
> +	 */
> +	NFDEV_IOCTL_NUM_ENQUIRY = 1,
> +
> +	/** Channel Update ioctl.
> +	 *  \deprecated
> +	 */
> +	NFDEV_IOCTL_NUM_CHUPDATE,

You have to explicitly set your enums if you want them to work properly
in an ioctl.  As it is, this will fail in nasty ways you can never debug
:(

> +
> +	/** Ensure Reading ioctl.
> +	 *  Signal a read request to the device.
> +	 *  \param (unsigned int) Length of data to be read.
> +	 */

Again, kerneldoc please.

> +	NFDEV_IOCTL_NUM_ENSUREREADING,
> +
> +	/** Device Count ioctl.
> +	 *  Not implemented for on all platforms.
> +	 *  \return (int) the number of attached devices.
> +	 */
> +	NFDEV_IOCTL_NUM_DEVCOUNT,
> +
> +	/** Internal Debug ioctl.
> +	 *  Not implemented in release drivers.
> +	 */
> +	NFDEV_IOCTL_NUM_DEBUG,
> +
> +	/** PCI Interface Version ioctl.
> +	 *  \param (int) Maximum PCI interface version
> +	 *   supported by the user of the device.
> +	 */
> +	NFDEV_IOCTL_NUM_PCI_IFVERS,
> +
> +	/** Statistics ioctl.
> +	 *  \return nfdev_enquiry_str describing the attached device.
> +	 */
> +	NFDEV_IOCTL_NUM_STATS,
> +
> +	/** Module control ioctl
> +	 * \param (nfdev_control_str) Value to write to HSM
> +	 * control register
> +	 */
> +	NFDEV_IOCTL_NUM_CONTROL,
> +
> +	/** Module state ioctl
> +	 * \return (nfdev_status_str) Values read from HSM
> +	 * status/error registers
> +	 */
> +	NFDEV_IOCTL_NUM_STATUS,
> +};
> +
> +#define NFDEV_IOCTL_TYPE 0x10
> +
> +#define NFDEV_IOCTL_CHUPDATE                                                   \
> +	_IO(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_CHUPDATE)
> +
> +#define NFDEV_IOCTL_ENQUIRY                                                    \
> +	_IOR(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_ENQUIRY,                        \
> +	     struct nfdev_enquiry_str)
> +
> +#define NFDEV_IOCTL_ENSUREREADING                                              \
> +	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_ENSUREREADING, int)
> +
> +#define NFDEV_IOCTL_ENSUREREADING_BUG3349                                      \
> +	_IO(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_ENSUREREADING)
> +
> +#define NFDEV_IOCTL_DEBUG                                                      \
> +	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_DEBUG, int)

Why do you care about debugging to userspace through an ioctl?  Just use
debugfs and be done with it, that's what it is there for.  Also you can
use dynamic debugging (hopefully you already are) and use that
kernel-wide api/interface.

Individual drivers should NEVER have custom debugging controls and
macros.

> +
> +#define NFDEV_IOCTL_PCI_IFVERS                                                 \
> +	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_PCI_IFVERS, int)

Can't you get this from the pci device information?

thanks,

greg k-h
