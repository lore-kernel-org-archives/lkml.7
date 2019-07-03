Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE47C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0BC218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGCPKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:10:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbfGCPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:10:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63F1PRc133395
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jul 2019 11:10:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgxn10ag5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:10:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 3 Jul 2019 16:09:58 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 16:09:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63F9sFN16187652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 15:09:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9307B11C04C;
        Wed,  3 Jul 2019 15:09:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AC6411C04A;
        Wed,  3 Jul 2019 15:09:54 +0000 (GMT)
Received: from localhost (unknown [9.152.212.151])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  3 Jul 2019 15:09:54 +0000 (GMT)
Date:   Wed, 3 Jul 2019 17:09:53 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
References: <20190613110815.17251-1-cohuck@redhat.com>
 <alpine.LFD.2.21.1906211817010.2388@schleppi>
 <20190624091740.1d9c6c1d.cohuck@redhat.com>
 <20190703165506.53d3911c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703165506.53d3911c.cohuck@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19070315-0008-0000-0000-000002F97B99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070315-0009-0000-0000-00002266CA70
Message-Id: <your-ad-here.call-01562166593-ext-0522@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=908 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 04:55:06PM +0200, Cornelia Huck wrote:
> On Mon, 24 Jun 2019 09:17:40 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 21 Jun 2019 18:19:36 +0200 (CEST)
> > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > 
> > > On Thu, 13 Jun 2019, Cornelia Huck wrote:  
> > > > Sometimes, we want to control which of the matching drivers
> > > > binds to a subchannel device (e.g. for subchannels we want to
> > > > handle via vfio-ccw).
> > > > 
> > > > For pci devices, a mechanism to do so has been introduced in
> > > > 782a985d7af2 ("PCI: Introduce new device binding path using
> > > > pci_dev.driver_override"). It makes sense to introduce the
> > > > driver_override attribute for subchannel devices as well, so
> > > > that we can easily extend the 'driverctl' tool (which makes
> > > > use of the driver_override attribute for pci).
> > > > 
> > > > Note that unlike pci we still require a driver override to
> > > > match the subchannel type; matching more than one subchannel
> > > > type is probably not useful anyway.
> > > > 
> > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>    
> > > 
> > > Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> > > 
> > > Should I take that via our git tree or do you have other patches depending 
> > > on this one?
> > >   
> > 
> > No, this patch is stand-alone; everything else is happening in user
> > space, so taking it via your tree would be great. Thanks!
> 
> Friendly ping (I don't see it on s390/features yet; or is this going
> via some other path?)
> 

It is there now. Just waited until latest ci results to push the branch.
Sorry for delay.

