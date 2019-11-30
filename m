Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AFEC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E224649
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfK3BSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 20:18:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:64009 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfK3BSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:18:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 17:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,259,1571727600"; 
   d="gz'50?scan'50,208,50";a="261643047"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Nov 2019 17:18:30 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iarP4-000D99-12; Sat, 30 Nov 2019 09:18:30 +0800
Date:   Sat, 30 Nov 2019 09:17:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: fs/io_uring.c:1632:21: error: implicit declaration of function
 'kmap'; did you mean 'vmap'?
Message-ID: <201911300932.MIXukaXa%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="526vcb4jq5ul4al3"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--526vcb4jq5ul4al3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81b6b96475ac7a4ebfceae9f16fb3758327adbfe
commit: 311ae9e159d81a1ec1cf645daf40b39ae5a0bd84 io_uring: fix dead-hung for non-iter fixed rw
date:   4 days ago
config: h8300-h8300h-sim_defconfig (attached as .config)
compiler: h8300-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 311ae9e159d81a1ec1cf645daf40b39ae5a0bd84
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/io_uring.c: In function 'loop_rw_iter':
>> fs/io_uring.c:1632:21: error: implicit declaration of function 'kmap'; did you mean 'vmap'? [-Werror=implicit-function-declaration]
       iovec.iov_base = kmap(iter->bvec->bv_page)
                        ^~~~
                        vmap
   fs/io_uring.c:1632:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       iovec.iov_base = kmap(iter->bvec->bv_page)
                      ^
>> fs/io_uring.c:1647:4: error: implicit declaration of function 'kunmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
       kunmap(iter->bvec->bv_page);
       ^~~~~~
       vunmap
   cc1: some warnings being treated as errors

vim +1632 fs/io_uring.c

  1604	
  1605	/*
  1606	 * For files that don't have ->read_iter() and ->write_iter(), handle them
  1607	 * by looping over ->read() or ->write() manually.
  1608	 */
  1609	static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
  1610				   struct iov_iter *iter)
  1611	{
  1612		ssize_t ret = 0;
  1613	
  1614		/*
  1615		 * Don't support polled IO through this interface, and we can't
  1616		 * support non-blocking either. For the latter, this just causes
  1617		 * the kiocb to be handled from an async context.
  1618		 */
  1619		if (kiocb->ki_flags & IOCB_HIPRI)
  1620			return -EOPNOTSUPP;
  1621		if (kiocb->ki_flags & IOCB_NOWAIT)
  1622			return -EAGAIN;
  1623	
  1624		while (iov_iter_count(iter)) {
  1625			struct iovec iovec;
  1626			ssize_t nr;
  1627	
  1628			if (!iov_iter_is_bvec(iter)) {
  1629				iovec = iov_iter_iovec(iter);
  1630			} else {
  1631				/* fixed buffers import bvec */
> 1632				iovec.iov_base = kmap(iter->bvec->bv_page)
  1633							+ iter->iov_offset;
  1634				iovec.iov_len = min(iter->count,
  1635						iter->bvec->bv_len - iter->iov_offset);
  1636			}
  1637	
  1638			if (rw == READ) {
  1639				nr = file->f_op->read(file, iovec.iov_base,
  1640						      iovec.iov_len, &kiocb->ki_pos);
  1641			} else {
  1642				nr = file->f_op->write(file, iovec.iov_base,
  1643						       iovec.iov_len, &kiocb->ki_pos);
  1644			}
  1645	
  1646			if (iov_iter_is_bvec(iter))
> 1647				kunmap(iter->bvec->bv_page);
  1648	
  1649			if (nr < 0) {
  1650				if (!ret)
  1651					ret = nr;
  1652				break;
  1653			}
  1654			ret += nr;
  1655			if (nr != iovec.iov_len)
  1656				break;
  1657			iov_iter_advance(iter, nr);
  1658		}
  1659	
  1660		return ret;
  1661	}
  1662	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--526vcb4jq5ul4al3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--526vcb4jq5ul4al3--
