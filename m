Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249C920830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfCYInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:43:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:40101 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbfCYInf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:43:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 01:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="137174998"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2019 01:43:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h8LCd-0002uA-PT; Mon, 25 Mar 2019 16:43:31 +0800
Date:   Mon, 25 Mar 2019 16:42:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kbuild-all@01.org, pakki001@umn.edu, kjlu@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: 8250: fix a missing check for pci_ioremap_bar
Message-ID: <201903251609.fCox8jWl%lkp@intel.com>
References: <20190324164139.23899-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324164139.23899-1-pakki001@umn.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v5.1-rc2 next-20190325]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aditya-Pakki/tty-8250-fix-a-missing-check-for-pci_ioremap_bar/20190325-151723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_lpss.c:207:26: sparse: incorrect type in argument 1 (different base types) @@    expected struct pci_dev *dev @@    got truct pci_dev *dev @@
   drivers/tty/serial/8250/8250_lpss.c:207:26:    expected struct pci_dev *dev
   drivers/tty/serial/8250/8250_lpss.c:207:26:    got struct device *dma_dev
>> drivers/tty/serial/8250/8250_lpss.c:207:52: sparse: cannot dereference this type
>> drivers/tty/serial/8250/8250_lpss.c:207:20: sparse: call with no type!

vim +207 drivers/tty/serial/8250/8250_lpss.c

   197	
   198	static void qrk_serial_exit_dma(struct lpss8250 *lpss)
   199	{
   200		struct dw_dma_slave *param = &lpss->dma_param;
   201	
   202		if (!param->dma_dev)
   203			return;
   204	
   205		dw_dma_remove(&lpss->dma_chip);
   206	
 > 207		pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
   208	}
   209	#else	/* CONFIG_SERIAL_8250_DMA */
   210	static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
   211	static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
   212	#endif	/* !CONFIG_SERIAL_8250_DMA */
   213	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
