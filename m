Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E4C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0056624649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgADNXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 08:23:21 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10826 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgADNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 08:23:21 -0500
X-IronPort-AV: E=Sophos;i="5.69,394,1571695200"; 
   d="scan'208";a="429875740"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2020 14:23:14 +0100
Date:   Sat, 4 Jan 2020 14:23:14 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Olga Kornievskaia <kolga@netapp.com>
cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: fs/nfs/nfs4file.c:167:7-14: ERROR: reference preceded by free on
 line 167 (fwd)
Message-ID: <alpine.DEB.2.21.2001041421570.6944@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know if the test on line 150 is guaranteed to be true on a retry.
If that is not the case, the it may be useful to set cn_reso to NULL after
the kfree.

julia

---------- Forwarded message ----------
Date: Sat, 4 Jan 2020 19:20:21 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: fs/nfs/nfs4file.c:167:7-14: ERROR: reference preceded by free on line
    167


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a562aee727a7bfbb3a37b1aa934118397dad701
commit: 0e65a32c8a569db363048e17a708b1a0913adbef NFS: handle source server reboot
date:   3 months ago
:::::: branch date: 15 hours ago
:::::: commit date: 3 months ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> fs/nfs/nfs4file.c:167:7-14: ERROR: reference preceded by free on line 167

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e65a32c8a569db363048e17a708b1a0913adbef
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 0e65a32c8a569db363048e17a708b1a0913adbef
vim +167 fs/nfs/nfs4file.c

5445b1fbd12342 Trond Myklebust   2015-09-05  131
1c6dcbe5ceff81 Anna Schumaker    2014-09-26  132  #ifdef CONFIG_NFS_V4_2
64bf5ff58dff75 Dave Chinner      2019-06-05  133  static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
2e72448b07dc3f Anna Schumaker    2013-05-21  134  				      struct file *file_out, loff_t pos_out,
2e72448b07dc3f Anna Schumaker    2013-05-21  135  				      size_t count, unsigned int flags)
2e72448b07dc3f Anna Schumaker    2013-05-21  136  {
0491567b51efec Olga Kornievskaia 2019-06-04  137  	struct nfs42_copy_notify_res *cn_resp = NULL;
1d38f3f0d70008 Olga Kornievskaia 2019-06-04  138  	struct nl4_server *nss = NULL;
1d38f3f0d70008 Olga Kornievskaia 2019-06-04  139  	nfs4_stateid *cnrs = NULL;
0491567b51efec Olga Kornievskaia 2019-06-04  140  	ssize_t ret;
0491567b51efec Olga Kornievskaia 2019-06-04  141
5dae222a5ff0c2 Amir Goldstein    2019-06-05  142  	/* Only offload copy if superblock is the same */
5dae222a5ff0c2 Amir Goldstein    2019-06-05  143  	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
5dae222a5ff0c2 Amir Goldstein    2019-06-05  144  		return -EXDEV;
0769663b4f5805 Olga Kornievskaia 2019-04-11  145  	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
0769663b4f5805 Olga Kornievskaia 2019-04-11  146  		return -EOPNOTSUPP;
837bb1d752d92e Trond Myklebust   2016-06-25  147  	if (file_inode(file_in) == file_inode(file_out))
0769663b4f5805 Olga Kornievskaia 2019-04-11  148  		return -EOPNOTSUPP;
0e65a32c8a569d Olga Kornievskaia 2019-06-14  149  retry:
0491567b51efec Olga Kornievskaia 2019-06-04  150  	if (!nfs42_files_from_same_server(file_in, file_out)) {
0491567b51efec Olga Kornievskaia 2019-06-04  151  		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
0491567b51efec Olga Kornievskaia 2019-06-04  152  				GFP_NOFS);
0491567b51efec Olga Kornievskaia 2019-06-04  153  		if (unlikely(cn_resp == NULL))
0491567b51efec Olga Kornievskaia 2019-06-04  154  			return -ENOMEM;
0491567b51efec Olga Kornievskaia 2019-06-04  155
0491567b51efec Olga Kornievskaia 2019-06-04  156  		ret = nfs42_proc_copy_notify(file_in, file_out, cn_resp);
0491567b51efec Olga Kornievskaia 2019-06-04  157  		if (ret) {
0491567b51efec Olga Kornievskaia 2019-06-04  158  			ret = -EOPNOTSUPP;
0491567b51efec Olga Kornievskaia 2019-06-04  159  			goto out;
0491567b51efec Olga Kornievskaia 2019-06-04  160  		}
1d38f3f0d70008 Olga Kornievskaia 2019-06-04  161  		nss = &cn_resp->cnr_src;
1d38f3f0d70008 Olga Kornievskaia 2019-06-04  162  		cnrs = &cn_resp->cnr_stateid;
0491567b51efec Olga Kornievskaia 2019-06-04  163  	}
1d38f3f0d70008 Olga Kornievskaia 2019-06-04  164  	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
1d38f3f0d70008 Olga Kornievskaia 2019-06-04  165  				nss, cnrs);
0491567b51efec Olga Kornievskaia 2019-06-04  166  out:
0491567b51efec Olga Kornievskaia 2019-06-04 @167  	kfree(cn_resp);
0e65a32c8a569d Olga Kornievskaia 2019-06-14  168  	if (ret == -EAGAIN)
0e65a32c8a569d Olga Kornievskaia 2019-06-14  169  		goto retry;
0491567b51efec Olga Kornievskaia 2019-06-04  170  	return ret;
2e72448b07dc3f Anna Schumaker    2013-05-21  171  }
2e72448b07dc3f Anna Schumaker    2013-05-21  172

:::::: The code at line 167 was first introduced by commit
:::::: 0491567b51efeca807da1125a1a0d5193875e286 NFS: add COPY_NOTIFY operation

:::::: TO: Olga Kornievskaia <kolga@netapp.com>
:::::: CC: Olga Kornievskaia <olga.kornievskaia@gmail.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
