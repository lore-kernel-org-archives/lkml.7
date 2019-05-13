Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4959C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0E7208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfEMBwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 21:52:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfEMBwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 21:52:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F08D13082132;
        Mon, 13 May 2019 01:52:48 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFAF05D9D2;
        Mon, 13 May 2019 01:52:44 +0000 (UTC)
Date:   Mon, 13 May 2019 09:52:41 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
Message-ID: <20190513015241.GA8515@dhcp-128-65.nay.redhat.com>
References: <20190510102051.25647-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510102051.25647-1-kasong@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 13 May 2019 01:52:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/19 at 06:20pm, Kairui Song wrote:
> Device dump allow drivers to add device related dump data to vmcore as
> they want. This have a potential issue, the data is stored in memory,
> drivers may append too much data and use too much memory. The vmcore is
> typically used in a kdump kernel which runs in a pre-reserved small
> chunk of memory. So as a result it will make kdump unusable at all due
> to OOM issues.
> 
> So introduce new device_dump_limit= kernel parameter, and set the
> default limit to 0, so device dump is not enabled unless user specify
> the accetable maxiam memory usage for device dump data. In this way user
> will also have the chance to adjust the kdump reserved memory
> accordingly.

The device dump is only affective in kdump 2nd kernel, so add the
limitation seems not useful.  One is hard to know the correct size
unless one does some crash test.  If one did the test and want to eanble
the device dump he needs increase crashkernel= size in 1st kernel and
add the limit param in 2nd kernel.

So a global on/off param sounds easier and better, something like
vmcore_device_dump=on  (default is off) 

> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  fs/proc/vmcore.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3fe90443c1bb..e28695ef2439 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
>  /* Device Dump list and mutex to synchronize access to list */
>  static LIST_HEAD(vmcoredd_list);
>  static DEFINE_MUTEX(vmcoredd_mutex);
> +
> +/* Device Dump Limit */
> +static size_t vmcoredd_limit;
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  
>  /* Device Dump Size */
> @@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
>  			    PAGE_SIZE);
>  
> +	if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
>  	/* Allocate buffer for driver's to write their dumps */
>  	buf = vmcore_alloc_buf(data_size);
>  	if (!buf) {
> @@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return ret;
>  }
>  EXPORT_SYMBOL(vmcore_add_device_dump);
> +
> +static int __init parse_vmcoredd_limit(char *arg)
> +{
> +	char *end;
> +
> +	if (!arg)
> +		return -EINVAL;
> +	vmcoredd_limit = memparse(arg, &end);
> +	return end > arg ? 0 : -EINVAL;
> +
> +}
> +__setup("device_dump_limit=", parse_vmcoredd_limit);
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  
>  /* Free all dumps in vmcore device dump list */
> -- 
> 2.20.1
> 

Thanks
Dave
