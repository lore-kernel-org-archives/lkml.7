Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2174AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2320842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfCEM3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:29:15 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:34068 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbfCEM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:29:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.413613-0.0952049-0.491183;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.E4NsxYY_1551788947;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E4NsxYY_1551788947)
          by smtp.aliyun-inc.com(10.147.41.120);
          Tue, 05 Mar 2019 20:29:08 +0800
Subject: Re: [PATCH v12 1/4] pstore/blk: new support logger for block devices
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190305071242.GF13452@kadam>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <d3d8621b-9d12-d03a-5f2a-76c0d8c464db@allwinnertech.com>
Date:   Tue, 5 Mar 2019 20:29:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190305071242.GF13452@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Dan Carpenter,

On 2019/03/05 15:12, Dan Carpenter wrote:
> Hi liaoweixiong,
> 
> url:    https://github.com/0day-ci/linux/commits/liaoweixiong/pstore-block-new-support-logger-for-block-devices/20190303-142003
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
> 
> smatch warnings:
> fs/pstore/blkzone.c:180 blkz_zone_write() error: we previously assumed 'zone->buffer' could be null (see line 167)
> 
> # https://github.com/0day-ci/linux/commit/113727d0f1946ad094dbc6531d653a88c7a221bf
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 113727d0f1946ad094dbc6531d653a88c7a221bf
> vim +180 fs/pstore/blkzone.c
> 
> 113727d0 liaoweixiong 2019-02-28  153  
> 113727d0 liaoweixiong 2019-02-28  154  static int blkz_zone_write(struct blkz_zone *zone,
> 113727d0 liaoweixiong 2019-02-28  155  		enum blkz_flush_mode flush_mode, const char *buf,
> 113727d0 liaoweixiong 2019-02-28  156  		size_t len, unsigned long off)
> 113727d0 liaoweixiong 2019-02-28  157  {
> 113727d0 liaoweixiong 2019-02-28  158  	struct blkz_info *info = blkz_cxt.bzinfo;
> 113727d0 liaoweixiong 2019-02-28  159  	ssize_t wcnt;
> 113727d0 liaoweixiong 2019-02-28  160  	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
> 113727d0 liaoweixiong 2019-02-28  161  	size_t wlen;
> 113727d0 liaoweixiong 2019-02-28  162  
> 113727d0 liaoweixiong 2019-02-28  163  	if (off > zone->buffer_size)
> 113727d0 liaoweixiong 2019-02-28  164  		return -EINVAL;
> 113727d0 liaoweixiong 2019-02-28  165  	wlen = min_t(size_t, len, zone->buffer_size - off);
> 113727d0 liaoweixiong 2019-02-28  166  	if (flush_mode != FLUSH_META && flush_mode != FLUSH_NONE) {
> 113727d0 liaoweixiong 2019-02-28 @167  		if (buf && zone->buffer)
>                                                            ^^^^^^^^^^^^
> Check.
> 

zone->buffer should not be checked whether null as it will never be null
here. I will fix it on next version.
zone->buffer was allocated when the zone was initialized (see line 995).
Pstore/blk will not go on if allocates buffer for zone->buffer failed.

> 113727d0 liaoweixiong 2019-02-28  168  			memcpy(zone->buffer->data + off, buf, wlen);
> 113727d0 liaoweixiong 2019-02-28  169  		atomic_set(&zone->buffer->datalen, wlen + off);
> 113727d0 liaoweixiong 2019-02-28  170  	}
> 113727d0 liaoweixiong 2019-02-28  171  
> 113727d0 liaoweixiong 2019-02-28  172  	writeop = is_on_panic() ? info->panic_write : info->write;
> 113727d0 liaoweixiong 2019-02-28  173  	if (!writeop)
> 113727d0 liaoweixiong 2019-02-28  174  		return -EINVAL;
> 113727d0 liaoweixiong 2019-02-28  175  
> 113727d0 liaoweixiong 2019-02-28  176  	switch (flush_mode) {
> 113727d0 liaoweixiong 2019-02-28  177  	case FLUSH_NONE:
> 113727d0 liaoweixiong 2019-02-28  178  		return 0;
> 113727d0 liaoweixiong 2019-02-28  179  	case FLUSH_PART:
> 113727d0 liaoweixiong 2019-02-28 @180  		wcnt = writeop((const char *)zone->buffer->data + off, wlen,
>                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Unchecked.
> 
> 113727d0 liaoweixiong 2019-02-28  181  				zone->off + sizeof(*zone->buffer) + off);
>                                                                                     ^^^^^^^^^^^^
> This is weird.  I can't fetch for-next/pstore so I don't know what
> type "buffer" is.  It's vague.  We also have ->buffer_size which seems
> like a more expected way to describe the size.
> 

The type of buffer is struct blkz_buffer (see line 98). struct
blkz_buffer is a header of data, who's member data[0] point to real
data. The codes "sizeof(*zone->buffer)" just to get size of header.
There is a size recorder for blkz_buffer->data on struct blkz_zone. It
is no need to write to block device, that's why it do not live in struct
blkz_buffer.

> 113727d0 liaoweixiong 2019-02-28  182  		if (wcnt != wlen)
> 113727d0 liaoweixiong 2019-02-28  183  			goto set_dirty;
> 113727d0 liaoweixiong 2019-02-28  184  	case FLUSH_META:
> 113727d0 liaoweixiong 2019-02-28  185  		wlen = sizeof(struct blkz_buffer);
> 113727d0 liaoweixiong 2019-02-28  186  		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
> 113727d0 liaoweixiong 2019-02-28  187  		if (wcnt != wlen)
> 113727d0 liaoweixiong 2019-02-28  188  			goto set_dirty;
> 113727d0 liaoweixiong 2019-02-28  189  		break;
> 113727d0 liaoweixiong 2019-02-28  190  	case FLUSH_ALL:
> 113727d0 liaoweixiong 2019-02-28  191  		wlen = buffer_datalen(zone) + sizeof(*zone->buffer);
> 113727d0 liaoweixiong 2019-02-28  192  		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
> 113727d0 liaoweixiong 2019-02-28  193  		if (wcnt != wlen)
> 113727d0 liaoweixiong 2019-02-28  194  			goto set_dirty;
> 113727d0 liaoweixiong 2019-02-28  195  		break;
> 113727d0 liaoweixiong 2019-02-28  196  	}
> 113727d0 liaoweixiong 2019-02-28  197  
> 113727d0 liaoweixiong 2019-02-28  198  	return 0;
> 113727d0 liaoweixiong 2019-02-28  199  set_dirty:
> 113727d0 liaoweixiong 2019-02-28  200  	pr_err("write failed with %zd returned, set dirty\n", wcnt);
> 113727d0 liaoweixiong 2019-02-28  201  	atomic_set(&zone->dirty, true);
> 113727d0 liaoweixiong 2019-02-28  202  	return -EBUSY;
> 113727d0 liaoweixiong 2019-02-28  203  }
> 113727d0 liaoweixiong 2019-02-28  204  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
liaoweixiong
