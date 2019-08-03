Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B45C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E2D206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfHCOOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:14:03 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:33509 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfHCOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:14:03 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 93E09300000AD;
        Sat,  3 Aug 2019 16:14:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 62A5226343; Sat,  3 Aug 2019 16:14:01 +0200 (CEST)
Date:   Sat, 3 Aug 2019 16:14:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 4/8] thunderbolt: Do not fail adding switch if some port
 is not implemented
Message-ID: <20190803141401.bmjo7u723p4wxtqb@wunner.de>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-5-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095800.43534-5-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 12:57:56PM +0300, Mika Westerberg wrote:
> There are two ways to mark a port as unimplemented. Typical way is to
> return port type as TB_TYPE_INACTIVE when its config space is read.
> Alternatively if the port is not physically present (such as ports 10
> and 11 in ICL) reading from port config space returns
> TB_CFG_ERROR_INVALID_CONFIG_SPACE instead. Currently the driver bails
> out from adding the switch if it receives any error during port
> inititialization which is wrong.
> 
> Handle this properly and just leave the port as TB_TYPE_INACTIVE before
> continuing to the next port.

Your patch may also cause this snippet in eeprom.c to become obsolete:

		/* Port 5 is inaccessible on this gen 1 controller */
		if (sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE)
			sw->ports[5].disabled = true;

To verify this hypothesis, one needs to comment out the call to
tb_drom_copy_efi() as well as the above-quoted snippet and boot
on a Mac with Light Ridge.  The driver should hit an error without
your patch and it may work correctly with your patch.

Thanks,

Lukas
