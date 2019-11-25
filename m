Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A1C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B3320815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PuYswLWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYG3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:29:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56784 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYG3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:29:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP6E6hP171857;
        Mon, 25 Nov 2019 06:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=PfguRXmDia+jKGs0Xz4/qLTSqwtTEXOdAS/FPkFOlwc=;
 b=PuYswLWHhcyvt7fZUsa/ccdNCIgqqyTv7BKHS5UspVi/Re7TM16Ib8yj+cvSGNj+GaqY
 sPVaVUNGNkj8cKyLglSs0YtO2okaYLR+0VUnDWAlqa6Z+BG5djNeyUMi81Zi8cm3QteT
 WIsDPf5oqtQi2UDCypqJ//NdG76QYRj+eq+A+eGBNykZpYuiFslo3TgTfYjx28h4gO7h
 FDk3QG/yNq+g1vYDqx4yd48uoyAgjg4TW1PTvV9ZNczRXbmL/ZS7Bq5ySF0HM6GOFKBN
 GOiR+TQp0UQ9tstvltDuJX6sMJYRnKqF+5phFTFT8hiMFwxkF0iSGbDcTaM3/sZhIme4 PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdqwba3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 06:27:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP6CqPE043092;
        Mon, 25 Nov 2019 06:27:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wfe7ycxjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 06:27:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAP6RURD005747;
        Mon, 25 Nov 2019 06:27:30 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Nov 2019 22:27:30 -0800
Date:   Mon, 25 Nov 2019 09:27:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 2/2] tty: add retry to tty_init_dev() to workaround a
 race condition
Message-ID: <20191125062722.GD1749@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120151709.14148-2-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

[auto build test WARNING on v5.4-rc8]
[cannot apply to tty/tty-testing next-20191122]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Sudip-Mukherjee/tty-remove-unused-argument-from-tty_open_by_driver/20191123-164153
base:    af42d3466bdc8f39806b26f593604fdc54140bcb

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/tty/tty_io.c:1360 tty_init_dev() error: we previously assumed 'tty->port' could be null (see line 1348)

# https://github.com/0day-ci/linux/commit/8de47da07f8c6fe6f631965cafb384cd0d72ce40
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 8de47da07f8c6fe6f631965cafb384cd0d72ce40
vim +1360 drivers/tty/tty_io.c

8de47da07f8c6f drivers/tty/tty_io.c  Sudip Mukherjee     2019-11-20  1318  struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
8de47da07f8c6f drivers/tty/tty_io.c  Sudip Mukherjee     2019-11-20  1319  				int retry)
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1320  {
bf970ee46e0fb3 drivers/char/tty_io.c Alan Cox            2008-10-13  1321  	struct tty_struct *tty;
73ec06fc5f5c8e drivers/char/tty_io.c Alan Cox            2008-10-13  1322  	int retval;
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1323  
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1324  	/*
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1325  	 * First time open is complex, especially for PTY devices.
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1326  	 * This code guarantees that either everything succeeds and the
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1327  	 * TTY is ready for operation, or else the table slots are vacated
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1328  	 * and the allocated memory released.  (Except that the termios
16b00ae82dce0e drivers/tty/tty_io.c  Johan Hovold        2017-03-30  1329  	 * may be retained.)
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1330  	 */
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1331  
73ec06fc5f5c8e drivers/char/tty_io.c Alan Cox            2008-10-13  1332  	if (!try_module_get(driver->owner))
73ec06fc5f5c8e drivers/char/tty_io.c Alan Cox            2008-10-13  1333  		return ERR_PTR(-ENODEV);
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1334  
2c964a2f4191f2 drivers/tty/tty_io.c  Rasmus Villemoes    2014-07-10  1335  	tty = alloc_tty_struct(driver, idx);
d5543503753983 drivers/tty/tty_io.c  Jiri Slaby          2011-03-23  1336  	if (!tty) {
d5543503753983 drivers/tty/tty_io.c  Jiri Slaby          2011-03-23  1337  		retval = -ENOMEM;
d5543503753983 drivers/tty/tty_io.c  Jiri Slaby          2011-03-23  1338  		goto err_module_put;
d5543503753983 drivers/tty/tty_io.c  Jiri Slaby          2011-03-23  1339  	}
^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds      2005-04-16  1340  
89c8d91e31f267 drivers/tty/tty_io.c  Alan Cox            2012-08-08  1341  	tty_lock(tty);
73ec06fc5f5c8e drivers/char/tty_io.c Alan Cox            2008-10-13  1342  	retval = tty_driver_install_tty(driver, tty);
d5543503753983 drivers/tty/tty_io.c  Jiri Slaby          2011-03-23  1343  	if (retval < 0)
c8b710b3e43481 drivers/tty/tty_io.c  Peter Hurley        2016-01-09  1344  		goto err_free_tty;
8b0a88d5912ab5 drivers/char/tty_io.c Alan Cox            2008-10-13  1345  
04831dc154df9b drivers/tty/tty_io.c  Jiri Slaby          2012-06-04  1346  	if (!tty->port)
04831dc154df9b drivers/tty/tty_io.c  Jiri Slaby          2012-06-04  1347  		tty->port = driver->ports[idx];
8de47da07f8c6f drivers/tty/tty_io.c  Sudip Mukherjee     2019-11-20 @1348  	if (!tty->port && retry) {
                                                                                    ^^^^^^^^^^
Check

8de47da07f8c6f drivers/tty/tty_io.c  Sudip Mukherjee     2019-11-20  1349  		retval = -EAGAIN;
8de47da07f8c6f drivers/tty/tty_io.c  Sudip Mukherjee     2019-11-20  1350  		goto err_release_driver;
8de47da07f8c6f drivers/tty/tty_io.c  Sudip Mukherjee     2019-11-20  1351  	}
04831dc154df9b drivers/tty/tty_io.c  Jiri Slaby          2012-06-04  1352  
5d4121c04b3577 drivers/tty/tty_io.c  Jiri Slaby          2012-08-17  1353  	WARN_RATELIMIT(!tty->port,
5d4121c04b3577 drivers/tty/tty_io.c  Jiri Slaby          2012-08-17  1354  			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
5d4121c04b3577 drivers/tty/tty_io.c  Jiri Slaby          2012-08-17  1355  			__func__, tty->driver->name);
5d4121c04b3577 drivers/tty/tty_io.c  Jiri Slaby          2012-08-17  1356  
b027e2298bd588 drivers/tty/tty_io.c  Gaurav Kohli        2018-01-23  1357  	retval = tty_ldisc_lock(tty, 5 * HZ);
b027e2298bd588 drivers/tty/tty_io.c  Gaurav Kohli        2018-01-23  1358  	if (retval)
b027e2298bd588 drivers/tty/tty_io.c  Gaurav Kohli        2018-01-23  1359  		goto err_release_lock;
967fab6916681e drivers/tty/tty_io.c  Jiri Slaby          2012-10-18 @1360  	tty->port->itty = tty;
                                                                                ^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

967fab6916681e drivers/tty/tty_io.c  Jiri Slaby          2012-10-18  1361  

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
