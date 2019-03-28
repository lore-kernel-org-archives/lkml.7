Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B221850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUPkJWfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfC1VXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:23:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39627 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfC1VXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:23:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so11943339pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqKQkLHcoVleSZJDXxp+ounSCzDz/LbWKI0lwF2jm6c=;
        b=QUPkJWfGhP/P4G6u66lFUUK66uTOJj/SzBgpzr+fe5I+o2rjOLo4TvTmvXW2I883+M
         tFQAP+Wj3zH+Zt1m1GwLBGIM/0gltRbUYO0WruX0EruFPkfKbyudWFDVKJ1T0kKals+M
         mKkAEdE39DGjsBwA7Ee2zohT5/8R9zOSfugPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqKQkLHcoVleSZJDXxp+ounSCzDz/LbWKI0lwF2jm6c=;
        b=bocsIb9ScOO9OCnr3aIAjq7arECosQxgpFIQyzdMlU0mi2kCQdY2pzg777SgPRFnlR
         XBaQCLs+cczwagoRuj2vAJVRl33J7vPL754WVcJeN/YDo1Xs4Mc09JvpLFiUEYtZ3cBS
         gk2+tCJCtrjaLt4dVSfImBJ9x+RaPY6IcbOWCWfwAIb1W2w4j960UmZkFCyRRiOXtwb0
         a221XXE+1Pdt4GcIEiLiS3CbuJIk52E3Rb6MRiAX6FFDWVSw3w1IkbtDr/xWVR/A66Ce
         ycOjsp3pRe3c1cL58eQ/eQ2MA0bySFgPlfUpol4x5YSWC+ccjAYKpqgzUbDqAXjmqnou
         QFmg==
X-Gm-Message-State: APjAAAV40JBAfCQ06Uf894DsTnGuGoMd8kigTXVMiCYnReDOTqcjXwhA
        tjJJjWJ60KNoNKdhwMMJuoQhaw==
X-Google-Smtp-Source: APXvYqySSQ/zRn33VwWBuvvqbRXZmv5DVQ0kz5eUnyhCBC0r3S2rYkuLQmslk4OhOPP33NkRyV4EiQ==
X-Received: by 2002:a62:12c8:: with SMTP id 69mr44143842pfs.184.1553808201725;
        Thu, 28 Mar 2019 14:23:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m5sm133593pff.187.2019.03.28.14.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 14:23:21 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:23:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Harish Bandi <c-hbandi@codeaurora.org>, kbuild-all@01.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] Bluetooth: hci_qca: Added support for WCN3998
Message-ID: <20190328212320.GF112750@google.com>
References: <1553689723-21017-2-git-send-email-c-hbandi@codeaurora.org>
 <201903290535.u5TF12SC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201903290535.u5TF12SC%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 05:05:49AM +0800, kbuild test robot wrote:
> Hi Harish,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on bluetooth-next/master]
> [also build test WARNING on next-20190328]
> [cannot apply to v5.1-rc2]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Harish-Bandi/Bluetooth-hci_qca-Added-support-for-WCN3998/20190328-213357
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> config: riscv-allmodconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=riscv 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/bluetooth/btqca.c: In function 'qca_uart_setup':
> >> drivers/bluetooth/btqca.c:369:3: warning: 'rom_ver' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       snprintf(config.fwname, sizeof(config.fwname),
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         "qca/crnv%02x.bin", rom_ver);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> vim +/rom_ver +369 drivers/bluetooth/btqca.c
> 
> 83e81961 Ben Young Tae Kim      2015-08-10  333  
> aadebac4 Balakrishna Godavarthi 2018-08-03  334  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> aadebac4 Balakrishna Godavarthi 2018-08-03  335  		   enum qca_btsoc_type soc_type, u32 soc_ver)
> 83e81961 Ben Young Tae Kim      2015-08-10  336  {
> 83e81961 Ben Young Tae Kim      2015-08-10  337  	struct rome_config config;
> 83e81961 Ben Young Tae Kim      2015-08-10  338  	int err;
> 4219d468 Balakrishna Godavarthi 2018-08-03  339  	u8 rom_ver;

With the use of qca_is_wcn399x() the compiler can't determine anymore
that rom_ver is only read for WCN399x, in which case it is also
initialized. Just initialize rom_ver with 0 to keep the compiler happy.

> 83e81961 Ben Young Tae Kim      2015-08-10  340  
> ba493d4f Balakrishna Godavarthi 2018-08-03  341  	bt_dev_dbg(hdev, "QCA setup on UART");
> 83e81961 Ben Young Tae Kim      2015-08-10  342  
> 83e81961 Ben Young Tae Kim      2015-08-10  343  	config.user_baud_rate = baudrate;
> 83e81961 Ben Young Tae Kim      2015-08-10  344  
> 83e81961 Ben Young Tae Kim      2015-08-10  345  	/* Download rampatch file */
> 83e81961 Ben Young Tae Kim      2015-08-10  346  	config.type = TLV_TYPE_PATCH;
> cc8a70bd Harish Bandi           2019-03-27  347  	if (qca_is_wcn399x(soc_type)) {
> 4219d468 Balakrishna Godavarthi 2018-08-03  348  		/* Firmware files to download are based on ROM version.
> 4219d468 Balakrishna Godavarthi 2018-08-03  349  		 * ROM version is derived from last two bytes of soc_ver.
> 4219d468 Balakrishna Godavarthi 2018-08-03  350  		 */
> 4219d468 Balakrishna Godavarthi 2018-08-03  351  		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
> 4219d468 Balakrishna Godavarthi 2018-08-03  352  			    (soc_ver & 0x0000000f);
> 4219d468 Balakrishna Godavarthi 2018-08-03  353  		snprintf(config.fwname, sizeof(config.fwname),
> 4219d468 Balakrishna Godavarthi 2018-08-03  354  			 "qca/crbtfw%02x.tlv", rom_ver);
> 4219d468 Balakrishna Godavarthi 2018-08-03  355  	} else {
> 4219d468 Balakrishna Godavarthi 2018-08-03  356  		snprintf(config.fwname, sizeof(config.fwname),
> 4219d468 Balakrishna Godavarthi 2018-08-03  357  			 "qca/rampatch_%08x.bin", soc_ver);
> 4219d468 Balakrishna Godavarthi 2018-08-03  358  	}
> 4219d468 Balakrishna Godavarthi 2018-08-03  359  
> ba493d4f Balakrishna Godavarthi 2018-08-03  360  	err = qca_download_firmware(hdev, &config);
> 83e81961 Ben Young Tae Kim      2015-08-10  361  	if (err < 0) {
> ba493d4f Balakrishna Godavarthi 2018-08-03  362  		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> 83e81961 Ben Young Tae Kim      2015-08-10  363  		return err;
> 83e81961 Ben Young Tae Kim      2015-08-10  364  	}
> 83e81961 Ben Young Tae Kim      2015-08-10  365  
> 83e81961 Ben Young Tae Kim      2015-08-10  366  	/* Download NVM configuration */
> 83e81961 Ben Young Tae Kim      2015-08-10  367  	config.type = TLV_TYPE_NVM;
> cc8a70bd Harish Bandi           2019-03-27  368  	if (qca_is_wcn399x(soc_type))
> 4219d468 Balakrishna Godavarthi 2018-08-03 @369  		snprintf(config.fwname, sizeof(config.fwname),
> 4219d468 Balakrishna Godavarthi 2018-08-03  370  			 "qca/crnv%02x.bin", rom_ver);
> 4219d468 Balakrishna Godavarthi 2018-08-03  371  	else
> 4219d468 Balakrishna Godavarthi 2018-08-03  372  		snprintf(config.fwname, sizeof(config.fwname),
> 4219d468 Balakrishna Godavarthi 2018-08-03  373  			 "qca/nvm_%08x.bin", soc_ver);
> 4219d468 Balakrishna Godavarthi 2018-08-03  374  
> ba493d4f Balakrishna Godavarthi 2018-08-03  375  	err = qca_download_firmware(hdev, &config);
> 83e81961 Ben Young Tae Kim      2015-08-10  376  	if (err < 0) {
> ba493d4f Balakrishna Godavarthi 2018-08-03  377  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> 83e81961 Ben Young Tae Kim      2015-08-10  378  		return err;
> 83e81961 Ben Young Tae Kim      2015-08-10  379  	}
> 83e81961 Ben Young Tae Kim      2015-08-10  380  
> 83e81961 Ben Young Tae Kim      2015-08-10  381  	/* Perform HCI reset */
> ba493d4f Balakrishna Godavarthi 2018-08-03  382  	err = qca_send_reset(hdev);
> 83e81961 Ben Young Tae Kim      2015-08-10  383  	if (err < 0) {
> ba493d4f Balakrishna Godavarthi 2018-08-03  384  		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
> 83e81961 Ben Young Tae Kim      2015-08-10  385  		return err;
> 83e81961 Ben Young Tae Kim      2015-08-10  386  	}
> 83e81961 Ben Young Tae Kim      2015-08-10  387  
> ba493d4f Balakrishna Godavarthi 2018-08-03  388  	bt_dev_info(hdev, "QCA setup on UART is completed");
> 83e81961 Ben Young Tae Kim      2015-08-10  389  
> 83e81961 Ben Young Tae Kim      2015-08-10  390  	return 0;
> 83e81961 Ben Young Tae Kim      2015-08-10  391  }
> ba493d4f Balakrishna Godavarthi 2018-08-03  392  EXPORT_SYMBOL_GPL(qca_uart_setup);
> 83e81961 Ben Young Tae Kim      2015-08-10  393  
> 
> :::::: The code at line 369 was first introduced by commit
> :::::: 4219d4686875fdd83df3da00fda5ff0551e0a2d7 Bluetooth: btqca: Add wcn3990 firmware download support.
> 
> :::::: TO: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> :::::: CC: Marcel Holtmann <marcel@holtmann.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


