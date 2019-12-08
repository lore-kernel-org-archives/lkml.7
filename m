Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91FC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101AA206F4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 08:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pb1+GSeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLHIm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 03:42:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHIm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 03:42:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB88dbPB120569;
        Sun, 8 Dec 2019 08:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=C632cShNDIwgKGlrI0ZhQmp/hjWxtmU9sMgd8cCzF00=;
 b=Pb1+GSeW7Z1mjQjxsDH3fHxDcn7hRUruK8pPCTga4CWQXVPnkmw7u4peV+WcTjlSlxIg
 CgTEfznEXrPd0eQJs08yoLvBzLJ2gHHf9nA1Dk6msmnntmceN4MAeyXuywvcgWmDpUNJ
 B0ALJYW7Xz4v6wrok4fpDScGmjBaqK3bo4u26p4RDFBuPx+JjTKdyZEWmYVFtTaLJ7fC
 P6zGVKHHuTwt5ZwpdZ1kaYtEhQo8lUoNoHnbWO2cOizWzhYBFLwsJ+vbZALJunpvq20L
 c5uGthSNxwk/jo/dIFpsuo/nUm4s5sZ717leg3VPhKy6J4ZcXlL5JvLDyDS+9MQdbyXI Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wr4qr34s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Dec 2019 08:42:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB88cpIj090795;
        Sun, 8 Dec 2019 08:40:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wrp83p0yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Dec 2019 08:40:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB88eitp011949;
        Sun, 8 Dec 2019 08:40:45 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Dec 2019 00:40:44 -0800
Date:   Sun, 8 Dec 2019 11:40:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: sound/firewire/motu/motu-pcm.c:191 pcm_open() error: double unlocked
 'motu->mutex' (orig line 179)
Message-ID: <20191208084034.GU1787@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9464 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912080078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9464 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912080078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94e89b40235476a83a53a47b9ffb0cb91a4c335e
commit: 3fd80b2003882b6a328caff9e6b3a14bed61f27c ALSA: firewire-motu: use the same size of period for PCM substream in AMDTP streams

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/firewire/motu/motu-pcm.c:191 pcm_open() error: double unlocked 'motu->mutex' (orig line 179)

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fd80b2003882b6a328caff9e6b3a14bed61f27c
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 3fd80b2003882b6a328caff9e6b3a14bed61f27c
vim +191 sound/firewire/motu/motu-pcm.c

dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  133  static int pcm_open(struct snd_pcm_substream *substream)
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  134  {
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  135  	struct snd_motu *motu = substream->private_data;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  136  	const struct snd_motu_protocol *const protocol = motu->spec->protocol;
3fd80b2003882b Takashi Sakamoto 2019-10-07  137  	struct amdtp_domain *d = &motu->domain;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  138  	enum snd_motu_clock_source src;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  139  	int err;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  140  
71c3797779d3cd Takashi Sakamoto 2017-03-22  141  	err = snd_motu_stream_lock_try(motu);
71c3797779d3cd Takashi Sakamoto 2017-03-22  142  	if (err < 0)
71c3797779d3cd Takashi Sakamoto 2017-03-22  143  		return err;
71c3797779d3cd Takashi Sakamoto 2017-03-22  144  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  145  	mutex_lock(&motu->mutex);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  146  
8b460c76bd1712 Takashi Sakamoto 2017-08-20  147  	err = snd_motu_stream_cache_packet_formats(motu);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  148  	if (err < 0)
71c3797779d3cd Takashi Sakamoto 2017-03-22  149  		goto err_locked;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  150  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  151  	err = init_hw_info(motu, substream);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  152  	if (err < 0)
71c3797779d3cd Takashi Sakamoto 2017-03-22  153  		goto err_locked;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  154  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  155  	err = protocol->get_clock_source(motu, &src);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  156  	if (err < 0)
71c3797779d3cd Takashi Sakamoto 2017-03-22  157  		goto err_locked;
3fd80b2003882b Takashi Sakamoto 2019-10-07  158  
3fd80b2003882b Takashi Sakamoto 2019-10-07  159  	// When source of clock is not internal or any stream is reserved for
3fd80b2003882b Takashi Sakamoto 2019-10-07  160  	// transmission of PCM frames, the available sampling rate is limited
3fd80b2003882b Takashi Sakamoto 2019-10-07  161  	// at current one.
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  162  	if (src != SND_MOTU_CLOCK_SOURCE_INTERNAL ||
3fd80b2003882b Takashi Sakamoto 2019-10-07  163  	    (motu->substreams_counter > 0 && d->events_per_period > 0)) {
3fd80b2003882b Takashi Sakamoto 2019-10-07  164  		unsigned int frames_per_period = d->events_per_period;
3fd80b2003882b Takashi Sakamoto 2019-10-07  165  		unsigned int rate;
3fd80b2003882b Takashi Sakamoto 2019-10-07  166  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  167  		err = protocol->get_clock_rate(motu, &rate);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  168  		if (err < 0)
71c3797779d3cd Takashi Sakamoto 2017-03-22  169  			goto err_locked;
3fd80b2003882b Takashi Sakamoto 2019-10-07  170  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  171  		substream->runtime->hw.rate_min = rate;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  172  		substream->runtime->hw.rate_max = rate;
3fd80b2003882b Takashi Sakamoto 2019-10-07  173  
3fd80b2003882b Takashi Sakamoto 2019-10-07  174  		if (frames_per_period > 0) {
3fd80b2003882b Takashi Sakamoto 2019-10-07  175  			err = snd_pcm_hw_constraint_minmax(substream->runtime,
3fd80b2003882b Takashi Sakamoto 2019-10-07  176  					SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
3fd80b2003882b Takashi Sakamoto 2019-10-07  177  					frames_per_period, frames_per_period);
3fd80b2003882b Takashi Sakamoto 2019-10-07  178  			if (err < 0) {
3fd80b2003882b Takashi Sakamoto 2019-10-07 @179  				mutex_unlock(&motu->mutex);
                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^
Delete this.

3fd80b2003882b Takashi Sakamoto 2019-10-07  180  				goto err_locked;
3fd80b2003882b Takashi Sakamoto 2019-10-07  181  			}
3fd80b2003882b Takashi Sakamoto 2019-10-07  182  		}
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  183  	}
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  184  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  185  	snd_pcm_set_sync(substream);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  186  
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  187  	mutex_unlock(&motu->mutex);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  188  
3fd80b2003882b Takashi Sakamoto 2019-10-07  189  	return 0;
71c3797779d3cd Takashi Sakamoto 2017-03-22  190  err_locked:
71c3797779d3cd Takashi Sakamoto 2017-03-22 @191  	mutex_unlock(&motu->mutex);
71c3797779d3cd Takashi Sakamoto 2017-03-22  192  	snd_motu_stream_lock_release(motu);
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  193  	return err;
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  194  }
dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  195  

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
