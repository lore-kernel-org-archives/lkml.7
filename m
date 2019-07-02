Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C0C0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C0A216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHuaCxD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBBcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:32:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGBBcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:32:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x621IeTc170139;
        Tue, 2 Jul 2019 01:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CTmK2bG4LfuAj+OGk5lCbn5r1g3VskoESmcpOd+WCVk=;
 b=PHuaCxD02WjFRnUJ0yL8NVZgO4T7q7BEmHAMOV5o9R9/JS8Q+ePLiaUb2NCNYvk/mUMC
 pQnfRR5Ko7UcMlbnXNbAe2rjXBr62NZHhOpAD5k1aT5bWjazZtUvKheBop1Y/eOMozHO
 Ub5k3EToCB2v6o4SkEc+JRpDkEUmpW+UEnZoDoqzNyN6oiEQJTD0oGxWUpy7ACDzEk93
 RkIuy4JL8XIXg6EnfgwGnMa9pxdbyl9yomSdTjoulOmiNs6WTxPf/0AAsDQwa1SlwWCN
 +9APY4EzjyIUIXo9sumxogh/scE9JS597BkUUtLMOClQsEY2tCVyovnNMCBRFbRfJ3l3 vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61prhk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 01:32:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x621N30L022377;
        Tue, 2 Jul 2019 01:30:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tebqg7pkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 01:30:14 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x621UAkk007677;
        Tue, 2 Jul 2019 01:30:11 GMT
Received: from [10.159.132.152] (/10.159.132.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 18:30:10 -0700
Subject: Re: [PATCH] soc: ti: fix irq-ti-sci link error
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20190617130149.1782930-1-arnd@arndb.de>
 <7a96a4d2-25e7-f9cf-1109-23c5495325a8@oracle.com>
 <CAOesGMi5urJPF3cKfF+UB_KrK50_VQw+MMS5w_UqKzEMYKeXFA@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <f767335b-eed9-13fd-3a85-774bde43eba4@oracle.com>
Date:   Mon, 1 Jul 2019 18:30:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMi5urJPF3cKfF+UB_KrK50_VQw+MMS5w_UqKzEMYKeXFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 3:24 PM, Olof Johansson wrote:
> On Mon, Jul 1, 2019 at 10:36 AM <santosh.shilimkar@oracle.com> wrote:
>>
>> On 6/17/19 6:01 AM, Arnd Bergmann wrote:
>>> The irqchip driver depends on the SoC specific driver, but we want
>>> to be able to compile-test it elsewhere:
>>>
>>> WARNING: unmet direct dependencies detected for TI_SCI_INTA_MSI_DOMAIN
>>>     Depends on [n]: SOC_TI [=n]
>>>     Selected by [y]:
>>>     - TI_SCI_INTA_IRQCHIP [=y] && TI_SCI_PROTOCOL [=y]
>>>
>>> drivers/irqchip/irq-ti-sci-inta.o: In function `ti_sci_inta_irq_domain_probe':
>>> irq-ti-sci-inta.c:(.text+0x204): undefined reference to `ti_sci_inta_msi_create_irq_domain'
>>>
>>> Rearrange the Kconfig and Makefile so we build the soc driver whenever
>>> its users are there, regardless of the SOC_TI option.
>>>
>>> Fixes: 49b323157bf1 ("soc: ti: Add MSI domain bus support for Interrupt Aggregator")
>>> Fixes: f011df6179bd ("irqchip/ti-sci-inta: Add msi domain support")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>> Thanks Arnd. Will you be able to add it to your fixes queue.
>>
>> FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernle.org>
> 
> Cc:ing to arm@kernel.org is the best way to make sure it surfaces.
> 
> Also, please do Acked-by on separate line so the tools catch it next
Will do..

> time (also, check for typos. :)
> 
:- )

> Applying to fixes.
Thanks for picking it up.
