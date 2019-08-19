Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA70EC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHSFGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:06:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:17236 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHSFGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:06:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 22:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="378076155"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2019 22:06:29 -0700
Subject: Re: [RFC PATCH 10/15] drivers/acrn: add interrupt injection support
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Mingqiang Chi <mingqiang.chi@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-11-git-send-email-yakui.zhao@intel.com>
 <20190816131203.GB3632@kadam>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <5347e652-9bc1-c465-bc20-488cf0159249@intel.com>
Date:   Mon, 19 Aug 2019 12:59:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190816131203.GB3632@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月16日 21:12, Dan Carpenter wrote:
> On Fri, Aug 16, 2019 at 10:25:51AM +0800, Zhao Yakui wrote:
>> +	case IC_VM_INTR_MONITOR: {
>> +		struct page *page;
>> +
>> +		ret = get_user_pages_fast(ioctl_param, 1, 1, &page);
>> +		if (unlikely(ret != 1) || !page) {
>                                         ^^^^^^^^
> Not required.

Do you mean that it is enough to check the condition of "ret != 1"?
OK. It will be removed.


> 
>> +			pr_err("acrn-dev: failed to pin intr hdr buffer!\n");
>> +			return -ENOMEM;
>> +		}
>> +
>> +		ret = hcall_vm_intr_monitor(vm->vmid, page_to_phys(page));
>> +		if (ret < 0) {
>> +			pr_err("acrn-dev: monitor intr data err=%ld\n", ret);
>> +			return -EFAULT;
>> +		}
>> +		break;
>> +	}
>> +
> 
> regards,
> dan carpenter
> 
