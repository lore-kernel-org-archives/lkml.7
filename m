Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB8C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFE421655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632815AbfIXTs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:48:56 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:23982 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbfIXTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:48:55 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OJfF6M013965;
        Tue, 24 Sep 2019 19:48:22 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v796vyvy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 19:48:22 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 620DA8D;
        Tue, 24 Sep 2019 19:48:21 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id EFC7346;
        Tue, 24 Sep 2019 19:48:19 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:48:19 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH v2 2/2] x86/boot/64: round memory hole size up to next
 PMD page.
Message-ID: <20190924194819.GB8138@swahl-linux>
References: <cover.1569004922.git.steve.wahl@hpe.com>
 <b0c6487fdd8ca33daa2ac1604b60fac8ed5b020f.1569004923.git.steve.wahl@hpe.com>
 <edd60d59-fdfc-2383-6cc8-e084e86e7a37@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd60d59-fdfc-2383-6cc8-e084e86e7a37@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_07:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=960 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 02:20:35PM -0700, Dave Hansen wrote:
> On 9/23/19 11:15 AM, Steve Wahl wrote:
> > The kernel image map is created using PMD pages, which can include
> > some extra space beyond what's actually needed.  Round the size of the
> > memory hole we search for up to the next PMD boundary, to be certain
> > all of the space to be mapped is usable RAM and includes no reserved
> > areas.
> 
> This looks good.  It also fully closes any possibility that anyone's
> future hardware will hit issues like this as long as they mark the
> memory reserved, right?

I believe that is true.  Thanks!

> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
