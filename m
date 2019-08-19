Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523A4C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA5520851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfHSFBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:01:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:6236 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfHSFBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:01:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 22:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="378074312"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2019 22:01:02 -0700
Subject: Re: [RFC PATCH 11/15] drivers/acrn: add the support of handling
 emulated ioreq
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Yin FengWei <fengwei.yin@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-12-git-send-email-yakui.zhao@intel.com>
 <20190816133511.GC3632@kadam>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <0986d89b-c428-6e66-315c-dc2343ec4699@intel.com>
Date:   Mon, 19 Aug 2019 12:54:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190816133511.GC3632@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月16日 21:39, Dan Carpenter wrote:
> On Fri, Aug 16, 2019 at 10:25:52AM +0800, Zhao Yakui wrote:
>> +int acrn_ioreq_create_client(unsigned short vmid,
>> +			     ioreq_handler_t handler,
>> +			     void *client_priv,
>> +			     char *name)
>> +{
>> +	struct acrn_vm *vm;
>> +	struct ioreq_client *client;
>> +	int client_id;
>> +
>> +	might_sleep();
>> +
>> +	vm = find_get_vm(vmid);
>> +	if (unlikely(!vm || !vm->req_buf)) {
>> +		pr_err("acrn-ioreq: failed to find vm from vmid %d\n", vmid);
>> +		put_vm(vm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	client_id = alloc_client();
>> +	if (unlikely(client_id < 0)) {
>> +		pr_err("acrn-ioreq: vm[%d] failed to alloc ioreq client\n",
>> +		       vmid);
>> +		put_vm(vm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	client = acrn_ioreq_get_client(client_id);
>> +	if (unlikely(!client)) {
>> +		pr_err("failed to get the client.\n");
>> +		put_vm(vm);
>> +		return -EINVAL;
> 
> Do we need to clean up the alloc_client() allocation?

Thanks for the review.

The function of acrn_iocreq_get_client is used to return the client for 
the given client_id. (The ref_count of client is also added). If it is 
NULL, it indicates that it is already released in another place.

In the function of acrn_ioreq_create_client, we don't need to clean up 
the alloc_client as it always exists in course of creating_client.

> 
> regards,
> dan carpenter
> 
>> +	}
>> +
>> +	if (handler) {
>> +		client->handler = handler;
>> +		client->acrn_create_kthread = true;
>> +	}
>> +
>> +	client->ref_vm = vm;
>> +	client->vmid = vmid;
>> +	client->client_priv = client_priv;
>> +	if (name)
>> +		strncpy(client->name, name, sizeof(client->name) - 1);
>> +	rwlock_init(&client->range_lock);
>> +	INIT_LIST_HEAD(&client->range_list);
>> +	init_waitqueue_head(&client->wq);
>> +
>> +	/* When it is added to ioreq_client_list, the refcnt is increased */
>> +	spin_lock_bh(&vm->ioreq_client_lock);
>> +	list_add(&client->list, &vm->ioreq_client_list);
>> +	spin_unlock_bh(&vm->ioreq_client_lock);
>> +
>> +	pr_info("acrn-ioreq: created ioreq client %d\n", client_id);
>> +
>> +	return client_id;
>> +}
> 
