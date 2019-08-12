Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84021C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6023F2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfHLGSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:18:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725822AbfHLGSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:18:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C66nrR038018
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:18:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ub283rwtv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:18:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 12 Aug 2019 07:18:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 07:17:59 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7C6HxiO38011134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 06:17:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF31FAE051;
        Mon, 12 Aug 2019 06:17:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D106AE056;
        Mon, 12 Aug 2019 06:17:58 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Aug 2019 06:17:58 +0000 (GMT)
Date:   Mon, 12 Aug 2019 09:17:56 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
References: <20190808154240.9384-1-hch@lst.de>
 <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
 <20190808215632.GA12773@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808215632.GA12773@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19081206-0020-0000-0000-0000035EB031
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081206-0021-0000-0000-000021B3BDAF
Message-Id: <20190812061756.GA28471@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:56:32PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 08, 2019 at 10:50:37AM -0700, Linus Torvalds wrote:
> > > Note that both Thomas and Steven have series touching this area pending,
> > > and there are a couple consumer in flux too - the hmm tree already
> > > conflicts with this series, and I have potential dma changes on top of
> > > the consumers in Thomas and Steven's series, so we'll probably need a
> > > git tree similar to the hmm one to synchronize these updates.
> > 
> > I'd be willing to just merge this now, if that helps. The conversion
> > is mechanical, and my only slight worry would be that at least for my
> > original patch I didn't build-test the (few) non-x86
> > architecture-specific cases. But I did end up looking at them fairly
> > closely  (basically using some grep/sed scripts to see that the
> > conversions I did matched the same patterns). And your changes look
> > like obvious improvements too where any mistake would have been caught
> > by the compiler.
> 
> I did cross compile the s390 and powerpc bits, but I do not have an
> openrisc compiler.

The openrisc defconfig builds fine.
 
> > So I'm not all that worried from a functionality standpoint, and if
> > this will help the next merge window, I'll happily pull now.
> 
> That would help with this series vs the others, but not with the other
> series vs each other.
> 

-- 
Sincerely yours,
Mike.

