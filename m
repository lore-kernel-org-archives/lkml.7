Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A73BC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A3C20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Le822Kkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfCDOxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:53:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:53:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x24EmaQa064733;
        Mon, 4 Mar 2019 14:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=QWzn0brrdacKiPSX5gaFWa9xmn8x0VHRVQu35wOA19A=;
 b=Le822KknRNBk1if3l6w+HjQOMg6LBMz0odljIcfWCgjDnKKiLHHytT5XpuWmjbPPBls0
 pAsXVnf17Nzi9inyl3cIMvmebsR0kNY626vn8fLAqoJfFisuKGMGfxaK2kDSPIvqdOyd
 MQ6jyQU8etgtnQHzvSjHF1AQVcbIz5anixeDOIgROtseGzNKlRPkNU2giDWVBNjnrdnY
 mH+USFIlHFqZUqAPXsYR75pgJ8HsRdHGNRav6PIvnCSY/Fm7q5LhXKpINF02dUyCOmP9
 EntkQ00u72LavtARPTd+CLkm9YE2d5DxQXwa1DIIMWY9Xp/bHInFfdj8+0uDSNgHWiRW 1Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qyh8ty9j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Mar 2019 14:53:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x24ErIRe010799
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 14:53:18 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x24ErFiv020046;
        Mon, 4 Mar 2019 14:53:15 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 06:53:14 -0800
Date:   Mon, 4 Mar 2019 17:53:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, justinpopo6@gmail.com
Cc:     kbuild-all@01.org, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads7950: add GPIO support
Message-ID: <20190304145303.GA13452@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551392209-20004-3-git-send-email-justinpopo6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9184 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903040109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

url:    https://github.com/0day-ci/linux/commits/justinpopo6-gmail-com/iio-adc-ads7950-add-gpio-support/20190301-201828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

smatch warnings:
drivers/iio/adc/ti-ads7950.c:530 ti_ads7950_init_hw() error: double unlock 'mutex:&st->slock'

# https://github.com/0day-ci/linux/commit/5290a7752b734ae0b2f5b343bd761366decdbbeb
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 5290a7752b734ae0b2f5b343bd761366decdbbeb
vim +530 drivers/iio/adc/ti-ads7950.c

5290a775 Justin Chen 2019-02-28  506  
5290a775 Justin Chen 2019-02-28  507  static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
5290a775 Justin Chen 2019-02-28  508  {
5290a775 Justin Chen 2019-02-28  509  	int ret = 0;
5290a775 Justin Chen 2019-02-28  510  
5290a775 Justin Chen 2019-02-28  511  	mutex_lock(&st->slock);
5290a775 Justin Chen 2019-02-28  512  
5290a775 Justin Chen 2019-02-28  513  	/* Settings for Manual/Auto1/Auto2 commands */
5290a775 Justin Chen 2019-02-28  514  	/* Default to 5v ref */
5290a775 Justin Chen 2019-02-28  515  	st->cmd_settings_bitmask = TI_ADS7950_CR_RANGE_5V;
5290a775 Justin Chen 2019-02-28  516  	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
5290a775 Justin Chen 2019-02-28  517  	ret = spi_sync(st->spi, &st->scan_single_msg);
5290a775 Justin Chen 2019-02-28  518  	if (ret)
5290a775 Justin Chen 2019-02-28  519  		goto out;
5290a775 Justin Chen 2019-02-28  520  
5290a775 Justin Chen 2019-02-28  521  	/* Settings for GPIO command */
5290a775 Justin Chen 2019-02-28  522  	st->gpio_cmd_settings_bitmask = 0x0;
5290a775 Justin Chen 2019-02-28  523  	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
5290a775 Justin Chen 2019-02-28  524  	ret = spi_sync(st->spi, &st->scan_single_msg);
5290a775 Justin Chen 2019-02-28  525  	mutex_unlock(&st->slock);
                                        ^^^^^^^^^^^^^^^^^^^^^^^^

5290a775 Justin Chen 2019-02-28  526  	if (ret)
5290a775 Justin Chen 2019-02-28  527  		goto out;
5290a775 Justin Chen 2019-02-28  528  
5290a775 Justin Chen 2019-02-28  529  out:
5290a775 Justin Chen 2019-02-28 @530  	mutex_unlock(&st->slock);
                                        ^^^^^^^^^^^^^^^^^^^^^^^^

It's a bit disappointing that mutex_unlock() doesn't generate a warning
at runtime...  :(

5290a775 Justin Chen 2019-02-28  531  
5290a775 Justin Chen 2019-02-28  532  	return ret;
5290a775 Justin Chen 2019-02-28  533  }
5290a775 Justin Chen 2019-02-28  534  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
