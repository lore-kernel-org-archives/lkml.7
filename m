Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E36521479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ri3WBhI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfGARg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:36:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfGARg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:36:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61HYLaG025278;
        Mon, 1 Jul 2019 17:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=E5p4klyouXJMnCEoFf9ReMs3WMufrbsMVLNSYgho534=;
 b=Ri3WBhI56N9U6Zk0mVeiPpP9TWTK+h9+/JiVOreIgmAr0tJ2LtK4mlNy6piune6DfOJW
 jHdy4z7WknciOrgQbAUUTqVemF0zEu5NDHloQbMUKkI/JeRWhuWne5SmrEXZKbuwXdXE
 u4IALDH8CztPgYVZP2yFllgIDKOFOYkh4DcI8wDf0ZFdSi7pi6+6vDlaBdv9fs4xdpkI
 bip/d9v86za4iOg2sDDsISjbcjNkjDRm5tu1ojgkwaFebUZp7P3mgosgN30GO4wHehwp
 ooOSjgj9aBtk4/jplDSOtfe+TFcuwh7lamgpm4abJyvVows1jbCIt/qF0qngjqUVYbss zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2te61dy0w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:36:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61HXFQ6130155;
        Mon, 1 Jul 2019 17:36:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tebbjabtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:36:32 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61HaS8e029744;
        Mon, 1 Jul 2019 17:36:28 GMT
Received: from [10.11.38.58] (/10.11.38.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:36:28 -0700
Subject: Re: [PATCH] soc: ti: fix irq-ti-sci link error
To:     Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190617130149.1782930-1-arnd@arndb.de>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <7a96a4d2-25e7-f9cf-1109-23c5495325a8@oracle.com>
Date:   Mon, 1 Jul 2019 10:36:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190617130149.1782930-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 6:01 AM, Arnd Bergmann wrote:
> The irqchip driver depends on the SoC specific driver, but we want
> to be able to compile-test it elsewhere:
> 
> WARNING: unmet direct dependencies detected for TI_SCI_INTA_MSI_DOMAIN
>    Depends on [n]: SOC_TI [=n]
>    Selected by [y]:
>    - TI_SCI_INTA_IRQCHIP [=y] && TI_SCI_PROTOCOL [=y]
> 
> drivers/irqchip/irq-ti-sci-inta.o: In function `ti_sci_inta_irq_domain_probe':
> irq-ti-sci-inta.c:(.text+0x204): undefined reference to `ti_sci_inta_msi_create_irq_domain'
> 
> Rearrange the Kconfig and Makefile so we build the soc driver whenever
> its users are there, regardless of the SOC_TI option.
> 
> Fixes: 49b323157bf1 ("soc: ti: Add MSI domain bus support for Interrupt Aggregator")
> Fixes: f011df6179bd ("irqchip/ti-sci-inta: Add msi domain support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Thanks Arnd. Will you be able to add it to your fixes queue.

FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernle.org>
