Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1702175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yuy2FPOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfCTI7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:59:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39508 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:59:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2K8sLHn149988;
        Wed, 20 Mar 2019 08:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Mq3oeKvwEtgfjFSKPpK1HBygoHwQWpAO8dOx1N18U1s=;
 b=Yuy2FPOtlegvvJIcWXGkEJyBlj8fylOF7oJqPBDI4H+Mchy+YFzYN0CuoAO4P+OWNsSq
 NIh8NS2570kECwTxWbVZITQ46wIw7fGc+RRXfnw3gE8XGt0X8GPxVq+lhTfmPfkUekpj
 o9zeShwC21X0DBwSZUNSetKMRaPfoTbUOsykB6FzplKbfJSUHo00z/CiMTBOQVJNrEQ0
 o3e8c8/thpn8rSqdCsWZJ6dznJjis10/rSCKeCEy15AXIfZnvYGK3Cl4KURqudrMPMk2
 YRr+i3g8uARvuG6vk6f6ZpMx1pSCoXHf5JyqQYjE5jjjCr9SWdXmbMLwb0VXglqizKft +Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssrhc88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 08:59:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2K8x2vH011728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 08:59:02 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2K8x1n6001887;
        Wed, 20 Mar 2019 08:59:01 GMT
Received: from kadam (/10.175.25.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 01:59:01 -0700
Date:   Wed, 20 Mar 2019 11:58:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: static analysis bug report: staging r8712u memcpy of
 uninitialized variable
Message-ID: <20190320085858.GF2202@kadam>
References: <2b54dc2d-7509-dc76-b730-4c8d66f81226@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b54dc2d-7509-dc76-b730-4c8d66f81226@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:20:51AM +0000, Colin Ian King wrote:
> Hi,
> 
> Static analysis with cppcheck found a couple of interesting issues with
> memcpy'ing of an uninitialized variable. Two occurrences of the same
> issue are found in drivers/staging/rtl8712/rtl8712_cmd.c in functions
> read_bbreg_hdl and read_rfreg_hdl.
> 
> For example:
> 
> static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
> {
>         u32 val;
>         void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj
> *pcmd);
>         struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
> 
>         if (pcmd->rsp && pcmd->rspsz > 0)
>                 memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> 
> 	....
> 
> }
> 
> I don't understand why the contents of val is being memcpy'd to
> pcmd->rsp, especially when val is uninitialized and hence contains
> garbage. Any ideas?
> 

The concern would be that it's reading a user specified amount of
stack memory to pcmd->rsp and that sounds like an information leak.

The pcmd_callback function pointer is always r8712_getbbrfreg_cmdrsp_callback()
which frees pcmd->parmbuf and pcmd but leaks pcmd->rsp.  I don't see
a way for anyone to access the ->rsp memory so probably there aren't any
security implications.

Anyway, let me send a patch.

regards,
dan carpenter

