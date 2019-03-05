Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A055C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFA920848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JE7X3Xql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCEHNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:13:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42096 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:13:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2574HGO052297;
        Tue, 5 Mar 2019 07:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=DwMrWW13R97QKkCvcoBfMSTbzIahT4nyU9ajZ4Nvks8=;
 b=JE7X3XqloNto1yYDy/ck/ZlXn6pbXpNq3DA8NefpnsPDyZlAJ+m5leiMowKkSsb2UAjU
 KORaqeNloxOLyJbvRyHqamgiSJEdo/AUkb3NfYD8Rx1FgzLRQPeC88XUwnJxy/GuofId
 r0pmNIdXAwwJmUsgFnVytUT6S7nguS0O9/qaFiLvPTWxACA6hbZRnJXPchJR4PE9iS29
 01W7ZIcCb0h5KhvnodvUULk1lLBzI7QmW6PCRL+oy2/kscQE6dPnNOy1UiMiRvAMyREJ
 ltvr0asrBC+6uAkpoaMVAQZXx3dh/W99vqhuhERgPxNKp3UtX84cH78ZBGx6afEqHFFs xg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qyfbe3sbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 07:13:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x257D0XE003975
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 07:13:00 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x257CtJZ023915;
        Tue, 5 Mar 2019 07:12:55 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 23:12:54 -0800
Date:   Tue, 5 Mar 2019 10:12:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     kbuild-all@01.org, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: Re: [PATCH v12 1/4] pstore/blk: new support logger for block devices
Message-ID: <20190305071242.GF13452@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551337948-16451-2-git-send-email-liaoweixiong@allwinnertech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi liaoweixiong,

url:    https://github.com/0day-ci/linux/commits/liaoweixiong/pstore-block-new-support-logger-for-block-devices/20190303-142003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore

smatch warnings:
fs/pstore/blkzone.c:180 blkz_zone_write() error: we previously assumed 'zone->buffer' could be null (see line 167)

# https://github.com/0day-ci/linux/commit/113727d0f1946ad094dbc6531d653a88c7a221bf
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 113727d0f1946ad094dbc6531d653a88c7a221bf
vim +180 fs/pstore/blkzone.c

113727d0 liaoweixiong 2019-02-28  153  
113727d0 liaoweixiong 2019-02-28  154  static int blkz_zone_write(struct blkz_zone *zone,
113727d0 liaoweixiong 2019-02-28  155  		enum blkz_flush_mode flush_mode, const char *buf,
113727d0 liaoweixiong 2019-02-28  156  		size_t len, unsigned long off)
113727d0 liaoweixiong 2019-02-28  157  {
113727d0 liaoweixiong 2019-02-28  158  	struct blkz_info *info = blkz_cxt.bzinfo;
113727d0 liaoweixiong 2019-02-28  159  	ssize_t wcnt;
113727d0 liaoweixiong 2019-02-28  160  	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
113727d0 liaoweixiong 2019-02-28  161  	size_t wlen;
113727d0 liaoweixiong 2019-02-28  162  
113727d0 liaoweixiong 2019-02-28  163  	if (off > zone->buffer_size)
113727d0 liaoweixiong 2019-02-28  164  		return -EINVAL;
113727d0 liaoweixiong 2019-02-28  165  	wlen = min_t(size_t, len, zone->buffer_size - off);
113727d0 liaoweixiong 2019-02-28  166  	if (flush_mode != FLUSH_META && flush_mode != FLUSH_NONE) {
113727d0 liaoweixiong 2019-02-28 @167  		if (buf && zone->buffer)
                                                           ^^^^^^^^^^^^
Check.

113727d0 liaoweixiong 2019-02-28  168  			memcpy(zone->buffer->data + off, buf, wlen);
113727d0 liaoweixiong 2019-02-28  169  		atomic_set(&zone->buffer->datalen, wlen + off);
113727d0 liaoweixiong 2019-02-28  170  	}
113727d0 liaoweixiong 2019-02-28  171  
113727d0 liaoweixiong 2019-02-28  172  	writeop = is_on_panic() ? info->panic_write : info->write;
113727d0 liaoweixiong 2019-02-28  173  	if (!writeop)
113727d0 liaoweixiong 2019-02-28  174  		return -EINVAL;
113727d0 liaoweixiong 2019-02-28  175  
113727d0 liaoweixiong 2019-02-28  176  	switch (flush_mode) {
113727d0 liaoweixiong 2019-02-28  177  	case FLUSH_NONE:
113727d0 liaoweixiong 2019-02-28  178  		return 0;
113727d0 liaoweixiong 2019-02-28  179  	case FLUSH_PART:
113727d0 liaoweixiong 2019-02-28 @180  		wcnt = writeop((const char *)zone->buffer->data + off, wlen,
                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked.

113727d0 liaoweixiong 2019-02-28  181  				zone->off + sizeof(*zone->buffer) + off);
                                                                                    ^^^^^^^^^^^^
This is weird.  I can't fetch for-next/pstore so I don't know what
type "buffer" is.  It's vague.  We also have ->buffer_size which seems
like a more expected way to describe the size.

113727d0 liaoweixiong 2019-02-28  182  		if (wcnt != wlen)
113727d0 liaoweixiong 2019-02-28  183  			goto set_dirty;
113727d0 liaoweixiong 2019-02-28  184  	case FLUSH_META:
113727d0 liaoweixiong 2019-02-28  185  		wlen = sizeof(struct blkz_buffer);
113727d0 liaoweixiong 2019-02-28  186  		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
113727d0 liaoweixiong 2019-02-28  187  		if (wcnt != wlen)
113727d0 liaoweixiong 2019-02-28  188  			goto set_dirty;
113727d0 liaoweixiong 2019-02-28  189  		break;
113727d0 liaoweixiong 2019-02-28  190  	case FLUSH_ALL:
113727d0 liaoweixiong 2019-02-28  191  		wlen = buffer_datalen(zone) + sizeof(*zone->buffer);
113727d0 liaoweixiong 2019-02-28  192  		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
113727d0 liaoweixiong 2019-02-28  193  		if (wcnt != wlen)
113727d0 liaoweixiong 2019-02-28  194  			goto set_dirty;
113727d0 liaoweixiong 2019-02-28  195  		break;
113727d0 liaoweixiong 2019-02-28  196  	}
113727d0 liaoweixiong 2019-02-28  197  
113727d0 liaoweixiong 2019-02-28  198  	return 0;
113727d0 liaoweixiong 2019-02-28  199  set_dirty:
113727d0 liaoweixiong 2019-02-28  200  	pr_err("write failed with %zd returned, set dirty\n", wcnt);
113727d0 liaoweixiong 2019-02-28  201  	atomic_set(&zone->dirty, true);
113727d0 liaoweixiong 2019-02-28  202  	return -EBUSY;
113727d0 liaoweixiong 2019-02-28  203  }
113727d0 liaoweixiong 2019-02-28  204  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
