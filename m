Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE32C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC496214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfDWG6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:58:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:32978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWG6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:58:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 23:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="164180183"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2019 23:58:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIpNn-0005Gv-71; Tue, 23 Apr 2019 14:58:23 +0800
Date:   Tue, 23 Apr 2019 14:57:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/chemical/sps30.c:122:30: sparse: sparse: cast truncates
 bits from constant value (8004 becomes 4)
Message-ID: <201904231456.G27oroy1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7142eaa58b49d9de492ccc16d48df7c488a5fbb6
commit: 62129a0849d27cc94ced832bcf9dcde283dcbe08 iio: chemical: sps30: allow changing self cleaning period
date:   3 months ago
reproduce:
        # apt-get install sparse
        git checkout 62129a0849d27cc94ced832bcf9dcde283dcbe08
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

>> drivers/iio/chemical/sps30.c:122:30: sparse: sparse: cast truncates bits from constant value (8004 becomes 4)

vim +122 drivers/iio/chemical/sps30.c

    91	
    92	static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
    93	{
    94		/*
    95		 * Internally sensor stores measurements in a following manner:
    96		 *
    97		 * PM1: upper two bytes, crc8, lower two bytes, crc8
    98		 * PM2P5: upper two bytes, crc8, lower two bytes, crc8
    99		 * PM4: upper two bytes, crc8, lower two bytes, crc8
   100		 * PM10: upper two bytes, crc8, lower two bytes, crc8
   101		 *
   102		 * What follows next are number concentration measurements and
   103		 * typical particle size measurement which we omit.
   104		 */
   105		u8 buf[SPS30_MAX_READ_SIZE] = { cmd >> 8, cmd };
   106		int i, ret = 0;
   107	
   108		switch (cmd) {
   109		case SPS30_START_MEAS:
   110			buf[2] = 0x03;
   111			buf[3] = 0x00;
   112			buf[4] = crc8(sps30_crc8_table, &buf[2], 2, CRC8_INIT_VALUE);
   113			ret = sps30_write_then_read(state, buf, 5, NULL, 0);
   114			break;
   115		case SPS30_STOP_MEAS:
   116		case SPS30_RESET:
   117		case SPS30_START_FAN_CLEANING:
   118			ret = sps30_write_then_read(state, buf, 2, NULL, 0);
   119			break;
   120		case SPS30_READ_AUTO_CLEANING_PERIOD:
   121			buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
 > 122			buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
   123		case SPS30_READ_DATA_READY_FLAG:
   124		case SPS30_READ_DATA:
   125		case SPS30_READ_SERIAL:
   126			/* every two data bytes are checksummed */
   127			size += size / 2;
   128			ret = sps30_write_then_read(state, buf, 2, buf, size);
   129			break;
   130		case SPS30_AUTO_CLEANING_PERIOD:
   131			buf[2] = data[0];
   132			buf[3] = data[1];
   133			buf[4] = crc8(sps30_crc8_table, &buf[2], 2, CRC8_INIT_VALUE);
   134			buf[5] = data[2];
   135			buf[6] = data[3];
   136			buf[7] = crc8(sps30_crc8_table, &buf[5], 2, CRC8_INIT_VALUE);
   137			ret = sps30_write_then_read(state, buf, 8, NULL, 0);
   138			break;
   139		}
   140	
   141		if (ret)
   142			return ret;
   143	
   144		/* validate received data and strip off crc bytes */
   145		for (i = 0; i < size; i += 3) {
   146			u8 crc = crc8(sps30_crc8_table, &buf[i], 2, CRC8_INIT_VALUE);
   147	
   148			if (crc != buf[i + 2]) {
   149				dev_err(&state->client->dev,
   150					"data integrity check failed\n");
   151				return -EIO;
   152			}
   153	
   154			*data++ = buf[i];
   155			*data++ = buf[i + 1];
   156		}
   157	
   158		return 0;
   159	}
   160	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
