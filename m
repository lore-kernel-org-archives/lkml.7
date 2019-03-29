Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C313C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E612075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WP8mhl40";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hKI0yevD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfC2Emz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:42:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfC2Emy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:42:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2AF41608A5; Fri, 29 Mar 2019 04:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553834573;
        bh=EO1BL6ln/S6bcOvV6oxejZkWs1L6tAo8dcEYqgszbks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WP8mhl403o8n7A+QvdxPBp+KYpOghkGvsgf9T6Dq8kjeYZM1xs/5qhjqg4GIMIgYM
         p5WyZeGB03+sScQpVNs4nTMKyEtwmVRTzGdW7PlM5XO+Pq4CWLorYgEpRwH6gEYNBS
         MCpAAr8YLV0cDHgRPyOQoD6NwkET0+GNTUVGtwKA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 273436063A;
        Fri, 29 Mar 2019 04:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553834571;
        bh=EO1BL6ln/S6bcOvV6oxejZkWs1L6tAo8dcEYqgszbks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hKI0yevDujRFztuIza6695xoF87tFvAKR+wLqzV5e5Hccq3O/KLqDTPbe/ra96CVY
         LWvs0AXZHuVqpMUcX2oupWgLOJ1qbdj2UuDuazangLeEvcBOFPVAdYQXLTIztdtQk8
         ylYOtE7JNhfGZsaR0zpKAk52JIKNXxK6UDp0jW4Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Mar 2019 10:12:51 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] Bluetooth: hci_qca: Added support for WCN3998
In-Reply-To: <20190328212320.GF112750@google.com>
References: <1553689723-21017-2-git-send-email-c-hbandi@codeaurora.org>
 <201903290535.u5TF12SC%lkp@intel.com> <20190328212320.GF112750@google.com>
Message-ID: <a75d686f28a2c73562e9bbf5b601d37c@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-29 02:53, Matthias Kaehlcke wrote:
> On Fri, Mar 29, 2019 at 05:05:49AM +0800, kbuild test robot wrote:
>> Hi Harish,
>> 
>> Thank you for the patch! Perhaps something to improve:
>> 
>> [auto build test WARNING on bluetooth-next/master]
>> [also build test WARNING on next-20190328]
>> [cannot apply to v5.1-rc2]
>> [if your patch is applied to the wrong git tree, please drop us a note 
>> to help improve the system]
>> 
>> url:    
>> https://github.com/0day-ci/linux/commits/Harish-Bandi/Bluetooth-hci_qca-Added-support-for-WCN3998/20190328-213357
>> base:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git 
>> master
>> config: riscv-allmodconfig (attached as .config)
>> compiler: riscv64-linux-gcc (GCC) 8.1.0
>> reproduce:
>>         wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=8.1.0 make.cross ARCH=riscv
>> 
>> Note: it may well be a FALSE warning. FWIW you are at least aware of 
>> it now.
>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>> 
>> All warnings (new ones prefixed by >>):
>> 
>>    drivers/bluetooth/btqca.c: In function 'qca_uart_setup':
>> >> drivers/bluetooth/btqca.c:369:3: warning: 'rom_ver' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>       snprintf(config.fwname, sizeof(config.fwname),
>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>         "qca/crnv%02x.bin", rom_ver);
>>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> vim +/rom_ver +369 drivers/bluetooth/btqca.c
>> 
>> 83e81961 Ben Young Tae Kim      2015-08-10  333
>> aadebac4 Balakrishna Godavarthi 2018-08-03  334  int 
>> qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>> aadebac4 Balakrishna Godavarthi 2018-08-03  335  		   enum 
>> qca_btsoc_type soc_type, u32 soc_ver)
>> 83e81961 Ben Young Tae Kim      2015-08-10  336  {
>> 83e81961 Ben Young Tae Kim      2015-08-10  337  	struct rome_config 
>> config;
>> 83e81961 Ben Young Tae Kim      2015-08-10  338  	int err;
>> 4219d468 Balakrishna Godavarthi 2018-08-03  339  	u8 rom_ver;
> 
> With the use of qca_is_wcn399x() the compiler can't determine anymore
> that rom_ver is only read for WCN399x, in which case it is also
> initialized. Just initialize rom_ver with 0 to keep the compiler happy.
> 
[Harish] - sure, will wait for few more comments and address all 
comments in new patch version.

>> 83e81961 Ben Young Tae Kim      2015-08-10  340
>> ba493d4f Balakrishna Godavarthi 2018-08-03  341  	bt_dev_dbg(hdev, 
>> "QCA setup on UART");
>> 83e81961 Ben Young Tae Kim      2015-08-10  342
>> 83e81961 Ben Young Tae Kim      2015-08-10  343  
>> 	config.user_baud_rate = baudrate;
>> 83e81961 Ben Young Tae Kim      2015-08-10  344
>> 83e81961 Ben Young Tae Kim      2015-08-10  345  	/* Download rampatch 
>> file */
>> 83e81961 Ben Young Tae Kim      2015-08-10  346  	config.type = 
>> TLV_TYPE_PATCH;
>> cc8a70bd Harish Bandi           2019-03-27  347  	if 
>> (qca_is_wcn399x(soc_type)) {
>> 4219d468 Balakrishna Godavarthi 2018-08-03  348  		/* Firmware files 
>> to download are based on ROM version.
>> 4219d468 Balakrishna Godavarthi 2018-08-03  349  		 * ROM version is 
>> derived from last two bytes of soc_ver.
>> 4219d468 Balakrishna Godavarthi 2018-08-03  350  		 */
>> 4219d468 Balakrishna Godavarthi 2018-08-03  351  		rom_ver = ((soc_ver 
>> & 0x00000f00) >> 0x04) |
>> 4219d468 Balakrishna Godavarthi 2018-08-03  352  			    (soc_ver & 
>> 0x0000000f);
>> 4219d468 Balakrishna Godavarthi 2018-08-03  353  
>> 		snprintf(config.fwname, sizeof(config.fwname),
>> 4219d468 Balakrishna Godavarthi 2018-08-03  354  			 
>> "qca/crbtfw%02x.tlv", rom_ver);
>> 4219d468 Balakrishna Godavarthi 2018-08-03  355  	} else {
>> 4219d468 Balakrishna Godavarthi 2018-08-03  356  
>> 		snprintf(config.fwname, sizeof(config.fwname),
>> 4219d468 Balakrishna Godavarthi 2018-08-03  357  			 
>> "qca/rampatch_%08x.bin", soc_ver);
>> 4219d468 Balakrishna Godavarthi 2018-08-03  358  	}
>> 4219d468 Balakrishna Godavarthi 2018-08-03  359
>> ba493d4f Balakrishna Godavarthi 2018-08-03  360  	err = 
>> qca_download_firmware(hdev, &config);
>> 83e81961 Ben Young Tae Kim      2015-08-10  361  	if (err < 0) {
>> ba493d4f Balakrishna Godavarthi 2018-08-03  362  		bt_dev_err(hdev, 
>> "QCA Failed to download patch (%d)", err);
>> 83e81961 Ben Young Tae Kim      2015-08-10  363  		return err;
>> 83e81961 Ben Young Tae Kim      2015-08-10  364  	}
>> 83e81961 Ben Young Tae Kim      2015-08-10  365
>> 83e81961 Ben Young Tae Kim      2015-08-10  366  	/* Download NVM 
>> configuration */
>> 83e81961 Ben Young Tae Kim      2015-08-10  367  	config.type = 
>> TLV_TYPE_NVM;
>> cc8a70bd Harish Bandi           2019-03-27  368  	if 
>> (qca_is_wcn399x(soc_type))
>> 4219d468 Balakrishna Godavarthi 2018-08-03 @369  
>> 		snprintf(config.fwname, sizeof(config.fwname),
>> 4219d468 Balakrishna Godavarthi 2018-08-03  370  			 
>> "qca/crnv%02x.bin", rom_ver);
>> 4219d468 Balakrishna Godavarthi 2018-08-03  371  	else
>> 4219d468 Balakrishna Godavarthi 2018-08-03  372  
>> 		snprintf(config.fwname, sizeof(config.fwname),
>> 4219d468 Balakrishna Godavarthi 2018-08-03  373  			 
>> "qca/nvm_%08x.bin", soc_ver);
>> 4219d468 Balakrishna Godavarthi 2018-08-03  374
>> ba493d4f Balakrishna Godavarthi 2018-08-03  375  	err = 
>> qca_download_firmware(hdev, &config);
>> 83e81961 Ben Young Tae Kim      2015-08-10  376  	if (err < 0) {
>> ba493d4f Balakrishna Godavarthi 2018-08-03  377  		bt_dev_err(hdev, 
>> "QCA Failed to download NVM (%d)", err);
>> 83e81961 Ben Young Tae Kim      2015-08-10  378  		return err;
>> 83e81961 Ben Young Tae Kim      2015-08-10  379  	}
>> 83e81961 Ben Young Tae Kim      2015-08-10  380
>> 83e81961 Ben Young Tae Kim      2015-08-10  381  	/* Perform HCI reset 
>> */
>> ba493d4f Balakrishna Godavarthi 2018-08-03  382  	err = 
>> qca_send_reset(hdev);
>> 83e81961 Ben Young Tae Kim      2015-08-10  383  	if (err < 0) {
>> ba493d4f Balakrishna Godavarthi 2018-08-03  384  		bt_dev_err(hdev, 
>> "QCA Failed to run HCI_RESET (%d)", err);
>> 83e81961 Ben Young Tae Kim      2015-08-10  385  		return err;
>> 83e81961 Ben Young Tae Kim      2015-08-10  386  	}
>> 83e81961 Ben Young Tae Kim      2015-08-10  387
>> ba493d4f Balakrishna Godavarthi 2018-08-03  388  	bt_dev_info(hdev, 
>> "QCA setup on UART is completed");
>> 83e81961 Ben Young Tae Kim      2015-08-10  389
>> 83e81961 Ben Young Tae Kim      2015-08-10  390  	return 0;
>> 83e81961 Ben Young Tae Kim      2015-08-10  391  }
>> ba493d4f Balakrishna Godavarthi 2018-08-03  392  
>> EXPORT_SYMBOL_GPL(qca_uart_setup);
>> 83e81961 Ben Young Tae Kim      2015-08-10  393
>> 
>> :::::: The code at line 369 was first introduced by commit
>> :::::: 4219d4686875fdd83df3da00fda5ff0551e0a2d7 Bluetooth: btqca: Add 
>> wcn3990 firmware download support.
>> 
>> :::::: TO: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> :::::: CC: Marcel Holtmann <marcel@holtmann.org>
>> 
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology 
>> Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel 
>> Corporation

Thanks,
Harish
