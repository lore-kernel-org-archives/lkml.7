Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F84208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sUORp49v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEMWsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:48:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59404 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfEMWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:48:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMdKBq023424;
        Mon, 13 May 2019 22:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=zjBscyYhoqo0ehvX4byH/+PaJKK4bIKyHqh+c/loXLg=;
 b=sUORp49vFnFduamm92UUhtOaP8jDK3gERbCayp7tqQrE68N7GLqJ352IgE9oTeoFMemj
 pDFIg1BbMuJADB+wXlZjKvuhZKZ+NakZu5xE4JFPeDd0yWinEmC90edSsy4IlmFvzMwk
 m6SNJmO2cVrNQ3JzL+bows/NDDhwxDIJ9yvtZN3bnFr+s/aaN6otYntIwIPq3/Vc5+WP
 hCqbhVHEEp8mHC0SS1QRB/jRRQP7nRB0Cfss7iJp922gT/0P4snFomaE5ge5Ew3qMfY7
 +J61hSbiwNZo/UdRb8/Bfoz07UxizliVfYuz3KtfPWEpVCtDhMOoCNrv6pskDEQhKrIm hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2sdkwdjcf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:48:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMiIu8033321;
        Mon, 13 May 2019 22:46:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sf3cmx4bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:46:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4DMk01X023981;
        Mon, 13 May 2019 22:46:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 15:46:00 -0700
To:     Ondrej Zary <linux@zary.sk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fdomain: Remove BIOS-related code from core
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190510212335.14728-1-linux@zary.sk>
Date:   Mon, 13 May 2019 18:45:58 -0400
In-Reply-To: <20190510212335.14728-1-linux@zary.sk> (Ondrej Zary's message of
        "Fri, 10 May 2019 23:23:34 +0200")
Message-ID: <yq1r292ezx5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=950
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130152
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ondrej,

> Move all BIOS signature and base handling to (currently not merged)
> ISA bus driver.

Please submit a complete (core/PCI/ISA) series with the kbuild warnings
addressed and Christoph's tags added.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
