Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5888520825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfIEKYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:24:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730973AbfIEKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:24:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85AOGd5099859
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 06:24:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uu0k2g01v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:24:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 5 Sep 2019 11:24:14 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 11:24:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x85ANjFO29426076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 10:23:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284064C046;
        Thu,  5 Sep 2019 10:24:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6F724C040;
        Thu,  5 Sep 2019 10:24:08 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.123])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 10:24:08 +0000 (GMT)
Date:   Thu, 5 Sep 2019 12:24:07 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, freude@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, frankja@linux.ibm.com,
        jjherne@linux.ibm.com
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
In-Reply-To: <f3e8d65e-bad4-c639-c53e-57585b90986d@de.ibm.com>
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
        <20190830180250.79804f76.pasic@linux.ibm.com>
        <f3e8d65e-bad4-c639-c53e-57585b90986d@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090510-4275-0000-0000-0000036175CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090510-4276-0000-0000-00003873BDAE
Message-Id: <20190905122407.5fa02121.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 09:35:47 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Halil,
> 
> can you also send this patch as a separate mail. This also requires a much better
> patch description about the why and it certainly should also have an agreement from
> Anthony.
> 


IMHO this patch only makes sense when the objective of Tony's patch is
accomplished. We do have to wait when we need to give up resources or do
stuff like subsystem reset. But I don't think we should introduce
artificial waits when interpreting AQIC: it should be up to the guest to
handle this stuff, as it is in LPAR.

Sure I can send a separate patch and state in the cover lette that it
builds on top of 'vfio-ap: remove unnecessary calls to disable queue
interrupts'.

And yes the commit message is sloppy. Was not meant to end up in the
changelog. Just a quick and dirty explanation.

> On 30.08.19 18:02, Halil Pasic wrote:
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Fri, 30 Aug 2019 17:39:47 +0200
> > Subject: [PATCH 2/2] s390: vfio-ap: don't wait after AQIC interpretation
> > 
> > Waiting for the asynchronous part of AQIC to complete as a part
> > AQIC implementation is unnecessary and silly.

s/implementation/interpretation/

Regards,
Halil

> > 
> > Let's get rid of vfio_ap_wait_for_irqclear().
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  drivers/s390/crypto/vfio_ap_ops.c | 50 ++-------------------------------------
> >  1 file changed, 2 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> > index dd07ebf..8d098f0 100644
> > --- a/drivers/s390/crypto/vfio_ap_ops.c
> > +++ b/drivers/s390/crypto/vfio_ap_ops.c
> > @@ -68,47 +68,6 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
> >  }
> >  
> >  /**
> > - * vfio_ap_wait_for_irqclear
> > - * @apqn: The AP Queue number
> > - *
> > - * Checks the IRQ bit for the status of this APQN using ap_tapq.
> > - * Returns if the ap_tapq function succeeded and the bit is clear.
> > - * Returns if ap_tapq function failed with invalid, deconfigured or
> > - * checkstopped AP.
> > - * Otherwise retries up to 5 times after waiting 20ms.
> > - *
> > - */
> > -static void vfio_ap_wait_for_irqclear(int apqn)
> > -{
> > -	struct ap_queue_status status;
> > -	int retry = 5;
> > -
> > -	do {
> > -		status = ap_tapq(apqn, NULL);
> > -		switch (status.response_code) {
> > -		case AP_RESPONSE_NORMAL:
> > -		case AP_RESPONSE_RESET_IN_PROGRESS:
> > -			if (!status.irq_enabled)
> > -				return;
> > -			/* Fall through */
> > -		case AP_RESPONSE_BUSY:
> > -			msleep(20);
> > -			break;
> > -		case AP_RESPONSE_Q_NOT_AVAIL:
> > -		case AP_RESPONSE_DECONFIGURED:
> > -		case AP_RESPONSE_CHECKSTOPPED:
> > -		default:
> > -			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
> > -				  status.response_code, apqn);
> > -			return;
> > -		}
> > -	} while (--retry);
> > -
> > -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> > -		  __func__, status.response_code, apqn);
> > -}
> > -
> > -/**
> >   * vfio_ap_free_aqic_resources
> >   * @q: The vfio_ap_queue
> >   *
> > @@ -133,14 +92,10 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
> >   * @q: The vfio_ap_queue
> >   *
> >   * Uses ap_aqic to disable the interruption and in case of success, reset
> > - * in progress or IRQ disable command already proceeded: calls
> > - * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
> > - * and calls vfio_ap_free_aqic_resources() to free the resources associated
> > + * in progress or IRQ disable command already proceeded :calls
> > + * vfio_ap_free_aqic_resources() to free the resources associated
> >   * with the AP interrupt handling.
> >   *
> > - * In the case the AP is busy, or a reset is in progress,
> > - * retries after 20ms, up to 5 times.
> > - *
> >   * Returns if ap_aqic function failed with invalid, deconfigured or
> >   * checkstopped AP.
> >   */
> > @@ -155,7 +110,6 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
> >  		switch (status.response_code) {
> >  		case AP_RESPONSE_OTHERWISE_CHANGED:
> >  		case AP_RESPONSE_NORMAL:
> > -			vfio_ap_wait_for_irqclear(q->apqn);
> >  			goto end_free;
> >  		case AP_RESPONSE_RESET_IN_PROGRESS:
> >  		case AP_RESPONSE_BUSY:
> > -- 2.5.5

