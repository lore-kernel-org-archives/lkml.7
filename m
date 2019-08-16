Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF7FC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B0121721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKhRz9KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfHPNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:42:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfHPNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:42:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GDcrU3047809;
        Fri, 16 Aug 2019 13:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YfWGic/dAg3fOFFkayje3xp6vGSyQHJYYgKCOSMt1R4=;
 b=oKhRz9KXJQZeZWP9mAN3VtbPF7T3KnlqEnIKrl+aCmMOpyrCyb+zDRFQ3a0pACv1spsG
 dDTPTOWCte/DyLfDi6TiugGyErSA9NUhUeCdiF3JvxRMEIKzZZT3WywsdELCoUu2ya9c
 LWcUIN5m8pHmZAx7fYe3NCs8kdbLVedhMZ0s53M4KisgQoIu1O2pSnISSzLjXgepRfIi
 5VHf80LZFNttco54XcJqi+zKmrUR5OAdgKIALjj/2H5hSripyi9SrBLUg30mDBi2DqTp
 lfUv11Kw/SRwpTtZp7BkonOq84I3Q54iomoOxHNCzuQpsHQehW2fnmxi66Fz/qooCQ2B nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u9nvprp7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 13:42:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GDcshr092763;
        Fri, 16 Aug 2019 13:40:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2udgr2w4m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 13:40:06 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7GDe4fJ032639;
        Fri, 16 Aug 2019 13:40:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 06:40:04 -0700
Date:   Fri, 16 Aug 2019 16:39:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Yin FengWei <fengwei.yin@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
Subject: Re: [RFC PATCH 11/15] drivers/acrn: add the support of handling
 emulated ioreq
Message-ID: <20190816133511.GC3632@kadam>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-12-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565922356-4488-12-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:52AM +0800, Zhao Yakui wrote:
> +int acrn_ioreq_create_client(unsigned short vmid,
> +			     ioreq_handler_t handler,
> +			     void *client_priv,
> +			     char *name)
> +{
> +	struct acrn_vm *vm;
> +	struct ioreq_client *client;
> +	int client_id;
> +
> +	might_sleep();
> +
> +	vm = find_get_vm(vmid);
> +	if (unlikely(!vm || !vm->req_buf)) {
> +		pr_err("acrn-ioreq: failed to find vm from vmid %d\n", vmid);
> +		put_vm(vm);
> +		return -EINVAL;
> +	}
> +
> +	client_id = alloc_client();
> +	if (unlikely(client_id < 0)) {
> +		pr_err("acrn-ioreq: vm[%d] failed to alloc ioreq client\n",
> +		       vmid);
> +		put_vm(vm);
> +		return -EINVAL;
> +	}
> +
> +	client = acrn_ioreq_get_client(client_id);
> +	if (unlikely(!client)) {
> +		pr_err("failed to get the client.\n");
> +		put_vm(vm);
> +		return -EINVAL;

Do we need to clean up the alloc_client() allocation?

regards,
dan carpenter

> +	}
> +
> +	if (handler) {
> +		client->handler = handler;
> +		client->acrn_create_kthread = true;
> +	}
> +
> +	client->ref_vm = vm;
> +	client->vmid = vmid;
> +	client->client_priv = client_priv;
> +	if (name)
> +		strncpy(client->name, name, sizeof(client->name) - 1);
> +	rwlock_init(&client->range_lock);
> +	INIT_LIST_HEAD(&client->range_list);
> +	init_waitqueue_head(&client->wq);
> +
> +	/* When it is added to ioreq_client_list, the refcnt is increased */
> +	spin_lock_bh(&vm->ioreq_client_lock);
> +	list_add(&client->list, &vm->ioreq_client_list);
> +	spin_unlock_bh(&vm->ioreq_client_lock);
> +
> +	pr_info("acrn-ioreq: created ioreq client %d\n", client_id);
> +
> +	return client_id;
> +}

