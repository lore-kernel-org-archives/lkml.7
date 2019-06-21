Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3ECC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FF8216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfFUNhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfFUNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:37:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LDba19099061
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:37:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8y882wrv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:37:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Jun 2019 14:37:17 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Jun 2019 14:37:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LDb4W738994388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 13:37:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B628DA405C;
        Fri, 21 Jun 2019 13:37:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 592A7A4054;
        Fri, 21 Jun 2019 13:37:12 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.137])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jun 2019 13:37:12 +0000 (GMT)
Date:   Fri, 21 Jun 2019 15:37:11 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
In-Reply-To: <20190621115604.0f3e3f69.cohuck@redhat.com>
References: <20190613110815.17251-1-cohuck@redhat.com>
        <20190621115604.0f3e3f69.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062113-0012-0000-0000-0000032B3A4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062113-0013-0000-0000-000021646468
Message-Id: <20190621153711.7d713c4d.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=894 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 11:56:04 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 13 Jun 2019 13:08:15 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Sometimes, we want to control which of the matching drivers
> > binds to a subchannel device (e.g. for subchannels we want to
> > handle via vfio-ccw).
> > 
> > For pci devices, a mechanism to do so has been introduced in
> > 782a985d7af2 ("PCI: Introduce new device binding path using
> > pci_dev.driver_override"). It makes sense to introduce the
> > driver_override attribute for subchannel devices as well, so
> > that we can easily extend the 'driverctl' tool (which makes
> > use of the driver_override attribute for pci).
> > 
> > Note that unlike pci we still require a driver override to
> > match the subchannel type; matching more than one subchannel
> > type is probably not useful anyway.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

I guess the '\n' handling is customary, and is what the same what
the pci counterpart (782a985d7af2) does anyway. It bothers
me a little that you don't necessarily get back from with show
what you stored. E.g. # echo -e "bug\nfree"
> /sys/bus/css/devices/0.0.0001/driver_override # echo $?
0
# cat /sys/bus/css/devices/0.0.0001/driver_override
bug
# echo $?
0
But given the previous art (782a985d7af2) I think it is the best way
to do it.

The rest is very straightforward.

> > ---
> > 
> > Lightly tested; did not yet attempt to adapt driverctl to actually
> > make use of it.
> 
> Friendly ping.
> 
> In the meanwhile, I figured out that you do not need to adapt driverctl
> at all, but just need to pass it '-b css' to work on the css bus; this
> seems to work just fine with this patch applied.
> 

Interesting. I hope to get around and have a closer look at it
eventually.

Regards,
Halil

