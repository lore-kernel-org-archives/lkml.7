Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62398C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2462077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WvTI0PsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCNU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:26:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfCNU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:26:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EKIvGm101964;
        Thu, 14 Mar 2019 20:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=0MnBDGPgz9vC3/2m+t5FiE97iY9+rd0eyr2X/THTWCU=;
 b=WvTI0PsXF4pULFJO5AY+OrP4f7TWyMnozUbMBxSfn6wfEWfF6wEqMQcqlL6c463M/0i9
 a2oY4r4pgF125PMmmlYfCXVRqvV2n5qWJGbuPkI+KekW5jfqrn2+MlnrruNQt3BkmPaV
 Zn4ZPJh0zdhuUnmG/i+c+BWOO3r81X5UpAhfRfA3qvLvslvwmyvvoYQX/0QHB7hnn256
 moME0tX1Rmh0fnJyqTXdjG9UpF1+x9r2PddyLbTsR/MXhoud9d66SsJ/MOlvJbNfmI36
 ZkdJ9MdXp82PlvkwgllK5JH0Ym+XB3IDSXpoNELeqkTy/+omWXJ4iJaPPkDcCW/3YKGZ Ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2r430f3sm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 20:25:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2EKPeKs006903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 20:25:40 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2EKPb9Z032336;
        Thu, 14 Mar 2019 20:25:37 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 20:25:37 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190314133038.GJ16658@quack2.suse.cz>
Date:   Thu, 14 Mar 2019 14:25:35 -0600
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christopher Lameter <cl@linux.com>,
        Jerome Glisse <jglisse@redhat.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Transfer-Encoding: 7bit
Message-Id: <3AF66C8F-F4BC-4413-A01C-3C90A3C27B28@oracle.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
 <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
 <20190314090345.GB16658@quack2.suse.cz> <20190314125718.GO20037@ziepe.ca>
 <20190314133038.GJ16658@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=629 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 14, 2019, at 7:30 AM, Jan Kara <jack@suse.cz> wrote:
> 
> Well I have some crash reports couple years old and they are not from QA
> departments. So I'm pretty confident there are real users that use this in
> production... and just reboot their machine in case it crashes.

Do you know what the use case in those crashes actually was?

I'm curious to know they were actually cases of say DMA from a video
capture card or if the uses posited to date are simply theoretical.

It's always good to know who might be doing this and why if for no other
reason than as something to keep in mind when designing future interfaces.

