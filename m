Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F4C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D3921473
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfE1KmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:42:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:52031 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfE1KmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:42:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 03:42:12 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 May 2019 03:42:09 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 May 2019 13:42:08 +0300
Date:   Tue, 28 May 2019 13:42:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: Re: [net-next,v3 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Message-ID: <20190528104208.GE2781@lahna.fi.intel.com>
References: <20190528032213.19839-1-ruslan@babayev.com>
 <20190528032213.19839-3-ruslan@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528032213.19839-3-ruslan@babayev.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 08:22:13PM -0700, Ruslan Babayev wrote:
> +	} else if (ACPI_COMPANION(&pdev->dev)) {

You can also use has_acpi_companion() here.

> +		struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +		struct fwnode_handle *fw = acpi_fwnode_handle(adev);
> +		struct fwnode_reference_args args;
> +		struct acpi_handle *acpi_handle;
> +		int ret;
> +
> +		ret = acpi_node_get_property_reference(fw, "i2c-bus", 0, &args);
> +		if (ACPI_FAILURE(ret) || !is_acpi_device_node(args.fwnode)) {
> +			dev_err(&pdev->dev, "missing 'i2c-bus' property\n");
> +			return -ENODEV;
>  		}
> +
> +		acpi_handle = ACPI_HANDLE_FWNODE(args.fwnode);
> +		i2c = i2c_acpi_find_adapter_by_handle(acpi_handle);
> +	}
> +
> +	if (!i2c)
> +		return -EPROBE_DEFER;
> +
> +	err = sfp_i2c_configure(sfp, i2c);
> +	if (err < 0) {
> +		i2c_put_adapter(i2c);
> +		return err;

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
