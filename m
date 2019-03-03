Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4F1C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DE620863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCCTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 14:33:50 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29337
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbfCCTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 14:33:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,437,1544482800"; 
   d="scan'208";a="297933716"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 20:33:43 +0100
Date:   Sun, 3 Mar 2019 20:33:43 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Andreas Klinger <ak@it-klinger.de>
cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        kbuild-all@01.org, jic23@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, arnd@arndb.de,
        davem@davemloft.net, gregkh@linuxfoundation.org, johan@kernel.org,
        khilman@baylibre.com, knaack.h@gmx.de, lars@metafoo.de,
        linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com,
        mchehab+samsung@kernel.org, m.othacehe@gmail.com,
        nicolas.ferre@microchip.com, pmeerw@pmeerw.net, robh@kernel.org,
        songqiang1304521@gmail.com, treding@nvidia.com,
        techsupport@maxbotix.com
Subject: Re: [PATCH v2 3/4] mb12x2.c: add distance iio sensor with i2c
 (fwd)
Message-ID: <alpine.DEB.2.21.1903032032330.2540@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It looks like an unlock is missing before line 110.

julia

---------- Forwarded message ----------
Date: Mon, 4 Mar 2019 03:30:02 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 3/4] mb12x2.c: add distance iio sensor with i2c

Hi Andreas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v5.0-rc8 next-20190301]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andreas-Klinger/add-MaxBotix-I2CXL-ultrasonic-iio-driver/20190304-001520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/iio/proximity/mb12x2.c:110:2-8: preceding lock on line 70

# https://github.com/0day-ci/linux/commit/a931c13b9c38d77e8dbf0b8aa64288a4bfcc789c
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout a931c13b9c38d77e8dbf0b8aa64288a4bfcc789c
vim +110 drivers/iio/proximity/mb12x2.c

a931c13b Andreas Klinger 2019-03-01   62
a931c13b Andreas Klinger 2019-03-01   63  static s16 mb12x2_read_distance(struct mb12x2_data *data)
a931c13b Andreas Klinger 2019-03-01   64  {
a931c13b Andreas Klinger 2019-03-01   65  	struct i2c_client *client = data->client;
a931c13b Andreas Klinger 2019-03-01   66  	int ret;
a931c13b Andreas Klinger 2019-03-01   67  	s16 distance;
a931c13b Andreas Klinger 2019-03-01   68  	__be16 buf;
a931c13b Andreas Klinger 2019-03-01   69
a931c13b Andreas Klinger 2019-03-01  @70  	mutex_lock(&data->lock);
a931c13b Andreas Klinger 2019-03-01   71
a931c13b Andreas Klinger 2019-03-01   72  	reinit_completion(&data->ranging);
a931c13b Andreas Klinger 2019-03-01   73
a931c13b Andreas Klinger 2019-03-01   74  	ret = i2c_smbus_write_byte(client, MB12X2_RANGE_COMMAND);
a931c13b Andreas Klinger 2019-03-01   75  	if (ret < 0) {
a931c13b Andreas Klinger 2019-03-01   76  		dev_err(&client->dev, "write command - err: %d\n", ret);
a931c13b Andreas Klinger 2019-03-01   77  		mutex_unlock(&data->lock);
a931c13b Andreas Klinger 2019-03-01   78  		return ret;
a931c13b Andreas Klinger 2019-03-01   79  	}
a931c13b Andreas Klinger 2019-03-01   80
a931c13b Andreas Klinger 2019-03-01   81  	if (data->gpiod_status) {
a931c13b Andreas Klinger 2019-03-01   82  		/* it cannot take more than 100 ms */
a931c13b Andreas Klinger 2019-03-01   83  		ret = wait_for_completion_killable_timeout(&data->ranging,
a931c13b Andreas Klinger 2019-03-01   84  									HZ/10);
a931c13b Andreas Klinger 2019-03-01   85  		if (ret < 0) {
a931c13b Andreas Klinger 2019-03-01   86  			mutex_unlock(&data->lock);
a931c13b Andreas Klinger 2019-03-01   87  			return ret;
a931c13b Andreas Klinger 2019-03-01   88  		} else if (ret == 0) {
a931c13b Andreas Klinger 2019-03-01   89  			mutex_unlock(&data->lock);
a931c13b Andreas Klinger 2019-03-01   90  			return -ETIMEDOUT;
a931c13b Andreas Klinger 2019-03-01   91  		}
a931c13b Andreas Klinger 2019-03-01   92  	} else {
a931c13b Andreas Klinger 2019-03-01   93  		/*
a931c13b Andreas Klinger 2019-03-01   94  		 * use simple sleep if gpio announce pin is not connected
a931c13b Andreas Klinger 2019-03-01   95  		 */
a931c13b Andreas Klinger 2019-03-01   96  		msleep(15);
a931c13b Andreas Klinger 2019-03-01   97  	}
a931c13b Andreas Klinger 2019-03-01   98
a931c13b Andreas Klinger 2019-03-01   99  	ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
a931c13b Andreas Klinger 2019-03-01  100  	if (ret < 0) {
a931c13b Andreas Klinger 2019-03-01  101  		dev_err(&client->dev, "i2c_master_recv: ret=%d\n", ret);
a931c13b Andreas Klinger 2019-03-01  102  		mutex_unlock(&data->lock);
a931c13b Andreas Klinger 2019-03-01  103  		return ret;
a931c13b Andreas Klinger 2019-03-01  104  	}
a931c13b Andreas Klinger 2019-03-01  105
a931c13b Andreas Klinger 2019-03-01  106  	distance = __be16_to_cpu(buf);
a931c13b Andreas Klinger 2019-03-01  107  	/* check for not returning misleading error codes */
a931c13b Andreas Klinger 2019-03-01  108  	if (distance < 0) {
a931c13b Andreas Klinger 2019-03-01  109  		dev_err(&client->dev, "distance=%d\n", distance);
a931c13b Andreas Klinger 2019-03-01 @110  		return -EINVAL;
a931c13b Andreas Klinger 2019-03-01  111  	}
a931c13b Andreas Klinger 2019-03-01  112
a931c13b Andreas Klinger 2019-03-01  113  	mutex_unlock(&data->lock);
a931c13b Andreas Klinger 2019-03-01  114
a931c13b Andreas Klinger 2019-03-01  115  	return distance;
a931c13b Andreas Klinger 2019-03-01  116  }
a931c13b Andreas Klinger 2019-03-01  117

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
