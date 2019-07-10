Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC17C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE8120838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfGJSw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:52:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbfGJSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:52:26 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AIqNBg140775
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:52:25 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tnjdt0pcr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:52:24 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Wed, 10 Jul 2019 19:52:17 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Jul 2019 19:52:14 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6AIqD2M53084638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 18:52:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B5CB28058;
        Wed, 10 Jul 2019 18:52:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1FD82805A;
        Wed, 10 Jul 2019 18:52:11 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.176.217])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jul 2019 18:52:11 +0000 (GMT)
Subject: Re: [PATCH] Check sk before sendpage
From:   James Bottomley <jejb@linux.ibm.com>
To:     Lee Duncan <LDuncan@suse.com>, Yang Bin <yang.bin18@zte.com.cn>
Cc:     "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "cleech@redhat.com" <cleech@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "wang.liang82@zte.com.cn" <wang.liang82@zte.com.cn>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>
Date:   Wed, 10 Jul 2019 11:52:11 -0700
In-Reply-To: <1bc364ff-5bff-47ac-611a-f75c43f4bd1b@suse.com>
References: <1562743809-31133-1-git-send-email-yang.bin18@zte.com.cn>
         <1bc364ff-5bff-47ac-611a-f75c43f4bd1b@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071018-2213-0000-0000-000003AC1E9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011405; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230277; UDB=6.00647997; IPR=6.01011546;
 MB=3.00027669; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-10 18:52:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071018-2214-0000-0000-00005F2DE79F
Message-Id: <1562784731.3213.98.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-10 at 17:47 +0000, Lee Duncan wrote:
> On 7/10/19 12:30 AM, Yang Bin wrote:
> 
> > From: " Yang Bin "<yang.bin18@zte.com.cn>
> > 
> > Before xmit,iscsi may disconnect just now.
> > So must check connection sock NULL or not,or kernel will crash for
> > accessing NULL pointer.
> > 
> > Signed-off-by: Yang Bin <yang.bin18@zte.com.cn>
> > ---
> >  drivers/scsi/iscsi_tcp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> > index 7bedbe8..a59c49f 100644
> > --- a/drivers/scsi/iscsi_tcp.c
> > +++ b/drivers/scsi/iscsi_tcp.c
> > @@ -264,6 +264,9 @@ static int iscsi_sw_tcp_xmit_segment(struct
> > iscsi_tcp_conn *tcp_conn,
> >  	unsigned int copied = 0;
> >  	int r = 0;
> >  
> > +	if (!sk)
> > +		return -ENOTCONN;
> > +
> >  	while (!iscsi_tcp_segment_done(tcp_conn, segment, 0, r)) {
> >  		struct scatterlist *sg;
> >  		unsigned int offset, copy;
> > 
> 
> If the socket can be closed right before iscsi_sw_tcp_xmit_segment()
> is called, can it be called in the middle of sending segments? (In
> which case the check would have to be in the while loop.)

I think the important point is: is this an actual observed bug or just
a theoretical problem?

The reason for asking is this call is controlled directly by the
ISCSI_UEVENT_DESTROY_CONN event sent by the iscsi daemon.  Obviously if
the daemon goes haywire and doesn't shut down the connection before
sending the destroy event, we may get the crash, but I would be
inclined to say fix the daemon.

James

