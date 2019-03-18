Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B779C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4ED20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:22:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfCRPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:22:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24201C057F41;
        Mon, 18 Mar 2019 15:22:37 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA7319C71;
        Mon, 18 Mar 2019 15:22:36 +0000 (UTC)
Message-ID: <3b2542225e519a8cf8e329745b0ee2e2464787c7.camel@redhat.com>
Subject: Re: [BUG] scsi: ses: out of bound accessing in
 ses_enclosure_data_process
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     jejb@linux.ibm.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, diego.gonzalez@oracle.com
Date:   Mon, 18 Mar 2019 11:22:35 -0400
In-Reply-To: <yq1k1gwkc6x.fsf@oracle.com>
References: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
         <yq1k1gwkc6x.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 18 Mar 2019 15:22:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 01:01 -0400, Martin K. Petersen wrote:
> Jianchao,
> 
> > When our customer probe the lpfc devices, they encountered odd memory
> > corruption issues, and we get 'out of bound' access warning at
> > following position after open KASAN
> 
> Please provide the output of:
> 
> # sg_ses -p 1 /dev/sgN
> # sg_ses -p 7 /dev/sgN
> 
> for the enclosure device in question.
> 

The ses driver is allocating kernel buffers based upon the size
reported by RECEIVE DIAGNOSTIC commands, and is iterating through
them based on sizes in the individual descriptors.  It appears to
be vulnerable to incorrect data from the device causing out-of-bounds
memory access, because the for() test does not prevent the use of
the pointer in subsequent code, e.g.:

        for (i = 0; i < num_enclosures && type_ptr < buf + len; i++) {
                types += type_ptr[2];
                type_ptr += type_ptr[3] + 4;
        }

        ses_dev->page1_types = type_ptr;
        ses_dev->page1_num_types = types;

Whether or not this is the current problem, it's wrong.

-Ewan

