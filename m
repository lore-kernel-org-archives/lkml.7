Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BTC_ID,PDS_BTC_MSGID,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F59AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1288120640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5QhZaAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCIjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:39:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37562 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:39:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB38YSen157021;
        Tue, 3 Dec 2019 08:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=FCwj1DoJeqTiclkRS/wd5nQuyjQcZ7lmVtMLn5nqA88=;
 b=I5QhZaArgx8w/0ql+cN+aSda5lNlKUfEU4Wsud2rP8guuuM1tZm4KIlKoRj7A5dfeXUM
 zKqmiRZPK1proWf2H0iQ866oI9Z79dOAbFPiE66UZSYfsgIPzhv9MWOExK4hQeEbAKqQ
 QTzeEqVpBLJrGWnjuDPizJV1PtRUXFuOIu8bTuetmfFpqg13IyfYolA/wtI6WBcCHq8+
 FHi3zRR2iyYZvdBglEWjgdVWlLyd7lkf2RXvKMgKtk84WAHq0Wc26yurhDNyI0QvY4xC
 Vt2gFxINRTiD3r+PJMHMW7dL99eOn0y71SKg6sjWbtjfk5zuLGk7ASdmVzA3BOZWwv/j dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wkh2r5sve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 08:39:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB38YMws010558;
        Tue, 3 Dec 2019 08:39:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wn7ppjsj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 08:39:04 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB38d207016891;
        Tue, 3 Dec 2019 08:39:02 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 00:39:01 -0800
Date:   Tue, 3 Dec 2019 11:38:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH next 2/3] debugfs: introduce debugfs_create_single[,_data]
Message-ID: <20191203083847.GC1787@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129092752.169902-3-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ How do I fetch 0day git branchs?
  git fetch https://github.com/0day-ci/linux/commits/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
  doesn't work. - dan ]

Hi Kefeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20191128]
[cannot apply to v5.4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
base:    d26b0e226f222c22c3b7e9d16e5b886e7c51057a


If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/debugfs/file.c:1193 debugfs_create_single_data() warn: overwrite may leak 'entry'

Old smatch warnings:
include/linux/compiler.h:247 __write_once_size() warn: potential memory corrupting cast 8 vs 4 bytes

# https://github.com/0day-ci/linux/commit/198a4ea9768d6790a169e8b802e702c208aafbd1
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 198a4ea9768d6790a169e8b802e702c208aafbd1
vim +/entry +1193 fs/debugfs/file.c

198a4ea9768d67 Kefeng Wang      2019-11-29  1179  struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
198a4ea9768d67 Kefeng Wang      2019-11-29  1180  					  struct dentry *parent, void *data,
198a4ea9768d67 Kefeng Wang      2019-11-29  1181  					  int (*read_fn)(struct seq_file *s,
198a4ea9768d67 Kefeng Wang      2019-11-29  1182  							 void *data))
198a4ea9768d67 Kefeng Wang      2019-11-29  1183  {
198a4ea9768d67 Kefeng Wang      2019-11-29  1184  	struct debugfs_entry *entry;
198a4ea9768d67 Kefeng Wang      2019-11-29  1185  
198a4ea9768d67 Kefeng Wang      2019-11-29  1186  	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
198a4ea9768d67 Kefeng Wang      2019-11-29  1187  	if (!entry)
198a4ea9768d67 Kefeng Wang      2019-11-29  1188  		return ERR_PTR(-ENOMEM);
198a4ea9768d67 Kefeng Wang      2019-11-29  1189  
198a4ea9768d67 Kefeng Wang      2019-11-29  1190  	entry->read = read_fn;
198a4ea9768d67 Kefeng Wang      2019-11-29  1191  	entry->data = data;
198a4ea9768d67 Kefeng Wang      2019-11-29  1192  
198a4ea9768d67 Kefeng Wang      2019-11-29 @1193  	entry = debugfs_set_lowest_bit(entry);
                                                        ^^^^^^^^
I haven't looked at the surrounding code but how would we free "entry"
when we write over it here?

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
