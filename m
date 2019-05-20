Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8D21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbfETPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:47:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387881AbfETPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:47:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KFloPT085754
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:47:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2skxfq28jj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:47:51 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Mon, 20 May 2019 16:46:57 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 16:46:55 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4KFksim30605346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:46:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21120B2067;
        Mon, 20 May 2019 15:46:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F07EB2065;
        Mon, 20 May 2019 15:46:53 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.204.144])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 15:46:53 +0000 (GMT)
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in
 ses_enclosure_data_process()
From:   James Bottomley <jejb@linux.ibm.com>
To:     Waiman Long <longman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 May 2019 08:46:52 -0700
In-Reply-To: <3385cf54-7b6c-3f28-e037-f0d4037368eb@redhat.com>
References: <20190501180535.26718-1-longman@redhat.com>
         <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
         <1558363938.3742.1.camel@linux.ibm.com>
         <3385cf54-7b6c-3f28-e037-f0d4037368eb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052015-0064-0000-0000-000003E19301
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011131; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206089; UDB=6.00633293; IPR=6.00987048;
 MB=3.00026973; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-20 15:46:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052015-0065-0000-0000-00003D8A0973
Message-Id: <1558367212.3742.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 11:24 -0400, Waiman Long wrote:
> On 5/20/19 10:52 AM, James Bottomley wrote:
> > On Mon, 2019-05-20 at 10:41 -0400, Waiman Long wrote:
> > [...]
> > > > --- a/drivers/scsi/ses.c
> > > > +++ b/drivers/scsi/ses.c
> > > > @@ -605,9 +605,14 @@ static void
> > > > ses_enclosure_data_process(struct
> > > > enclosure_device *edev,
> > > >  			     /* these elements are optional */
> > > >  			     type_ptr[0] ==
> > > > ENCLOSURE_COMPONENT_SCSI_TARGET_PORT ||
> > > >  			     type_ptr[0] ==
> > > > ENCLOSURE_COMPONENT_SCSI_INITIATOR_PORT ||
> > > > -			     type_ptr[0] ==
> > > > ENCLOSURE_COMPONENT_CONTROLLER_ELECTRONICS))
> > > > +			     type_ptr[0] ==
> > > > ENCLOSURE_COMPONENT_CONTROLLER_ELECTRONICS)) {
> > > >  				addl_desc_ptr +=
> > > > addl_desc_ptr[1]
> > > > + 2;
> > > >  
> > > > +				/* Ensure no out-of-bounds
> > > > memory
> > > > access */
> > > > +				if (addl_desc_ptr >= ses_dev-
> > > > > page10 +
> > > > 
> > > > +						     ses_dev-
> > > > > page10_len)
> > > > 
> > > > +					addl_desc_ptr = NULL;
> > > > +			}
> > > >  		}
> > > >  	}
> > > >  	kfree(buf);
> > > 
> > > Ping! Any comment on this patch.
> > 
> > The update looks fine to me:
> > 
> > Reviewed-by: James E.J. Bottomley <jejb@linux.ibm.com>
> > 
> > It might also be interesting to find out how the proliant is
> > structuring this descriptor array to precipitate the out of bounds:
> > Is it just an off by one or something more serious?
> 
> I didn't look into the detail the enclosure message returned by the
> hardware, but I believe it may have more description entries (page7)
> than extended description entries (page10).
> 
> I can try to reserve the system and find out what exactly is wrong
> with that system if you really want to find that out.

Please.  What I'm interested in is whether this is simply a bug in the
array firmware, in which case the fix is sufficient, or whether there's
some problem with the parser, like mismatched expectations over added
trailing nulls or something.

James

