Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512ADC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2089321871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWAdA8OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfDEMCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:02:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52106 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbfDEMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:02:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35BsOEq010011;
        Fri, 5 Apr 2019 12:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ER2504pxZ0CeDIABptkj4DnF+JKEaBXugV6iByeJ1F0=;
 b=eWAdA8OXha75II6Z0L3kh5vcP+qqO4CYdgWp8iaLlr7F0rg2nk++msPK7zQx/0ow56fB
 ujrfl5xfo9QzQQXwhwqSzyhm3Ox0fCsHb1KOfUv1NtqvuFZgOSaFkjEvSOLTqCOyk6Z0
 N1cCgp4zPGerDQgwgVjpRYUL2xe4S75dJT9q0IFtfdMFgY7IM/wYuB25TvcCC+0sjD3w
 R0xIML7E5tUBUmm6GdhLVB7MflP4zsYFRwvUMhKGi3+95Tjn5/b9DE923vfr9jXU7tTg
 1j/jJ6JbO1lcowFGLYfNey8YaA2M+rrU0PHZGHDQ2SsnqnCWCP4Io0qQRNdbeNNiJSeF AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2rhyvtmfsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 12:02:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35C1NmM012891;
        Fri, 5 Apr 2019 12:02:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rp34jasph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 12:02:30 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x35C2QKV021460;
        Fri, 5 Apr 2019 12:02:27 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 05:02:25 -0700
Date:   Fri, 5 Apr 2019 15:02:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        phil@raspberrypi.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] Revert "staging: vchiq_2835_arm: quit using custom
 down_interruptible()"
Message-ID: <20190405120217.GP32590@kadam>
References: <20190405113423.14495-1-nsaenzjulienne@suse.de>
 <20190405113423.14495-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405113423.14495-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=839 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:34:20PM +0200, Nicolas Saenz Julienne wrote:
> This reverts commit ff5979ad86368425b7da3a25f4e84650b51ff5fd.
> ---

Git kind of sets you up for failure with reverts...

Fix the subject, add a commit message and a Signed off by etc.  We need
all the regular stuff.  See commit 75ae193626de ("dm: revert
8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES *
PAGE_SIZE")") for an example of how to do it nicely.

regards,
dan carpenter

