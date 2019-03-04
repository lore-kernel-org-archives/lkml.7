Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2439AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BDA20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfCDIcC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35611 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfCDIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:52 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h0j0o-0007LH-Hf
        for linux-kernel@vger.kernel.org; Mon, 04 Mar 2019 08:31:50 +0000
Received: by mail-pg1-f198.google.com with SMTP id y8so4164037pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9zxCk3F/hzt9uJQkJnir+S4M3iM/AsEdGW2BV5LIU30=;
        b=McSkE8lhNGf4FZn5/nFYwDzjByCaIvWqusOKYC35gF9mxQAxj6VWUZ5E40ol4Y5vE7
         xJx1PgNFtA9FY0MGBxBg+Zt7gQSTjwxsMb6XcgY7nEfkfYbgKiDl11lrC78G0Cj4/fvV
         fjZ5i3C7Yf9vozeu1Qhe4rqXspVT3ZRKsdquFtoygzxGvYv93cXQJcU2Q/rpRVPonTg1
         zjCi4xYVTIrfu9MFq+j3mAORhAbyglR6g31syao3ayMkNrU4d3gvvDzZf/JxsZjUX4Sa
         vXWxIMq5SzB1ggKmNlCdCvoJT4MC6Lzy0UCF5BYNeyjLy+ULWXFk+C5gErdNfEjag9Ne
         l/og==
X-Gm-Message-State: AHQUAubBa1Jp5GA6GVBdr+uzePXx1edbk1RhbeytDwF7zXzfYDoDhgd0
        qKVjZDyf5nIuKKQawESxhZfMwtW1jO1WWOT/RTMrMdfSgoSn7PnhlviAniRATENGN7Vz4Quxenf
        W87lUuEgS8IgbU92gXV6s4QwloZDkipWNp6Fe4ZPg+A==
X-Received: by 2002:a62:e204:: with SMTP id a4mr18648080pfi.225.1551688308995;
        Mon, 04 Mar 2019 00:31:48 -0800 (PST)
X-Google-Smtp-Source: AHgI3IY22/0FIBT0Xk+NPd10aK1Z/JOpGCBG7pYkCuzKZcLNCG1xT7KfcGYvfgeJ7fIsOvhEB+c2ow==
X-Received: by 2002:a62:e204:: with SMTP id a4mr18648047pfi.225.1551688308594;
        Mon, 04 Mar 2019 00:31:48 -0800 (PST)
Received: from [10.101.46.46] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id b70sm8826916pfm.6.2019.03.04.00.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:31:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] igb: Fix WARN_ONCE on runtime suspend
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190302160115.GA6172@rani.riverdale.lan>
Date:   Mon, 4 Mar 2019 16:31:45 +0800
Cc:     intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E8841527-C294-4E2D-BB19-3C0B1F1EBBC7@canonical.com>
References: <20190302160115.GA6172@rani.riverdale.lan>
To:     Arvind Sankar <niveditas98@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 3, 2019, at 12:01 AM, Arvind Sankar <niveditas98@gmail.com> wrote:
> 
> The runtime_suspend device callbacks are not supposed to save
> configuration state or change the power state. Commit fb29f76cc566
> ("igb: Fix an issue that PME is not enabled during runtime suspend")
> changed the driver to not save configuration state during runtime
> suspend, however the driver callback still put the device into a
> low-power state. This causes a warning in the pci pm core and results in
> pci_pm_runtime_suspend not calling pci_save_state or pci_finish_runtime_suspend.
> 
> Fix this by not changing the power state either, leaving that to pci pm
> core, and make the same change for suspend callback as well.
> 
> Also move a couple of defines into the appropriate header file instead
> of inline in the .c file.

Header changes can be a separate patch, but that’s just a small nit.

> 
> Fixes: fb29f76cc566 ("igb: Fix an issue that PME is not enabled during runtime suspend")
> Signed-off-by: Arvind Sankar <niveditas98@gmail.com>

Reviewed-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> .../net/ethernet/intel/igb/e1000_defines.h    |  2 +
> drivers/net/ethernet/intel/igb/igb_main.c     | 57 +++----------------
> 2 files changed, 10 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
> index 8a28f3388f69..dca671591ef6 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
> @@ -194,6 +194,8 @@
> /* enable link status from external LINK_0 and LINK_1 pins */
> #define E1000_CTRL_SWDPIN0  0x00040000  /* SWDPIN 0 value */
> #define E1000_CTRL_SWDPIN1  0x00080000  /* SWDPIN 1 value */
> +#define E1000_CTRL_ADVD3WUC 0x00100000  /* D3 WUC */
> +#define E1000_CTRL_EN_PHY_PWR_MGMT 0x00200000 /* PHY PM enable */
> #define E1000_CTRL_SDP0_DIR 0x00400000  /* SDP0 Data direction */
> #define E1000_CTRL_SDP1_DIR 0x00800000  /* SDP1 Data direction */
> #define E1000_CTRL_RST      0x04000000  /* Global reset */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 93f150784cfc..c2b3a2ff1471 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8754,9 +8754,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	struct e1000_hw *hw = &adapter->hw;
> 	u32 ctrl, rctl, status;
> 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
> -#ifdef CONFIG_PM
> -	int retval = 0;
> -#endif
> +	bool wake;
> 
> 	rtnl_lock();
> 	netif_device_detach(netdev);
> @@ -8769,14 +8767,6 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	igb_clear_interrupt_scheme(adapter);
> 	rtnl_unlock();
> 
> -#ifdef CONFIG_PM
> -	if (!runtime) {
> -		retval = pci_save_state(pdev);
> -		if (retval)
> -			return retval;
> -	}
> -#endif
> -
> 	status = rd32(E1000_STATUS);
> 	if (status & E1000_STATUS_LU)
> 		wufc &= ~E1000_WUFC_LNKC;
> @@ -8793,10 +8783,6 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 		}
> 
> 		ctrl = rd32(E1000_CTRL);
> -		/* advertise wake from D3Cold */
> -		#define E1000_CTRL_ADVD3WUC 0x00100000
> -		/* phy power management enable */
> -		#define E1000_CTRL_EN_PHY_PWR_MGMT 0x00200000
> 		ctrl |= E1000_CTRL_ADVD3WUC;
> 		wr32(E1000_CTRL, ctrl);
> 
> @@ -8810,12 +8796,15 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 		wr32(E1000_WUFC, 0);
> 	}
> 
> -	*enable_wake = wufc || adapter->en_mng_pt;
> -	if (!*enable_wake)
> +	wake = wufc || adapter->en_mng_pt;
> +	if (!wake)
> 		igb_power_down_link(adapter);
> 	else
> 		igb_power_up_link(adapter);
> 
> +	if (enable_wake)
> +		*enable_wake = wake;
> +
> 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
> 	 * would have already happened in close and is redundant.
> 	 */
> @@ -8858,22 +8847,7 @@ static void igb_deliver_wake_packet(struct net_device *netdev)
> 
> static int __maybe_unused igb_suspend(struct device *dev)
> {
> -	int retval;
> -	bool wake;
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	retval = __igb_shutdown(pdev, &wake, 0);
> -	if (retval)
> -		return retval;
> -
> -	if (wake) {
> -		pci_prepare_to_sleep(pdev);
> -	} else {
> -		pci_wake_from_d3(pdev, false);
> -		pci_set_power_state(pdev, PCI_D3hot);
> -	}
> -
> -	return 0;
> +	return __igb_shutdown(to_pci_dev(dev), NULL, 0);
> }
> 
> static int __maybe_unused igb_resume(struct device *dev)
> @@ -8944,22 +8918,7 @@ static int __maybe_unused igb_runtime_idle(struct device *dev)
> 
> static int __maybe_unused igb_runtime_suspend(struct device *dev)
> {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int retval;
> -	bool wake;
> -
> -	retval = __igb_shutdown(pdev, &wake, 1);
> -	if (retval)
> -		return retval;
> -
> -	if (wake) {
> -		pci_prepare_to_sleep(pdev);
> -	} else {
> -		pci_wake_from_d3(pdev, false);
> -		pci_set_power_state(pdev, PCI_D3hot);
> -	}
> -
> -	return 0;
> +	return __igb_shutdown(to_pci_dev(dev), NULL, 1);
> }
> 
> static int __maybe_unused igb_runtime_resume(struct device *dev)
> -- 
> 2.19.2
> 

