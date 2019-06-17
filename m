Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB204C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96112084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfFQKHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbfFQKHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:07:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3E31AF46;
        Mon, 17 Jun 2019 10:07:06 +0000 (UTC)
Subject: Re: [RFC PATCH 13/16] drivers/xen: gnttab, evtchn, xenbus API changes
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-14-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <2c025112-aaeb-0918-ff01-10842d285314@suse.com>
Date:   Mon, 17 Jun 2019 12:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Mechanical changes, now most of these calls take xenhost_t *
> as parameter.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   drivers/xen/cpu_hotplug.c     | 14 ++++++-------
>   drivers/xen/gntalloc.c        | 13 ++++++++----
>   drivers/xen/gntdev.c          | 16 +++++++++++----
>   drivers/xen/manage.c          | 37 ++++++++++++++++++-----------------
>   drivers/xen/platform-pci.c    | 12 +++++++-----
>   drivers/xen/sys-hypervisor.c  | 12 ++++++++----
>   drivers/xen/xen-balloon.c     | 10 +++++++---
>   drivers/xen/xenfs/xenstored.c |  7 ++++---
>   8 files changed, 73 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
> index afeb94446d34..4a05bc028956 100644
> --- a/drivers/xen/cpu_hotplug.c
> +++ b/drivers/xen/cpu_hotplug.c
> @@ -31,13 +31,13 @@ static void disable_hotplug_cpu(int cpu)
>   	unlock_device_hotplug();
>   }
>   
> -static int vcpu_online(unsigned int cpu)
> +static int vcpu_online(xenhost_t *xh, unsigned int cpu)

Do we really need xenhost for cpu on/offlinig?

> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index 9a69d955dd5c..1655d0a039fd 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -227,14 +227,14 @@ static void shutdown_handler(struct xenbus_watch *watch,
>   		return;
>   
>    again:
> -	err = xenbus_transaction_start(xh_default, &xbt);
> +	err = xenbus_transaction_start(watch->xh, &xbt);
>   	if (err)
>   		return;
>   
> -	str = (char *)xenbus_read(xh_default, xbt, "control", "shutdown", NULL);
> +	str = (char *)xenbus_read(watch->xh, xbt, "control", "shutdown", NULL);
>   	/* Ignore read errors and empty reads. */
>   	if (XENBUS_IS_ERR_READ(str)) {
> -		xenbus_transaction_end(xh_default, xbt, 1);
> +		xenbus_transaction_end(watch->xh, xbt, 1);
>   		return;
>   	}
>   
> @@ -245,9 +245,9 @@ static void shutdown_handler(struct xenbus_watch *watch,
>   
>   	/* Only acknowledge commands which we are prepared to handle. */
>   	if (idx < ARRAY_SIZE(shutdown_handlers))
> -		xenbus_write(xh_default, xbt, "control", "shutdown", "");
> +		xenbus_write(watch->xh, xbt, "control", "shutdown", "");
>   
> -	err = xenbus_transaction_end(xh_default, xbt, 0);
> +	err = xenbus_transaction_end(watch->xh, xbt, 0);
>   	if (err == -EAGAIN) {
>   		kfree(str);
>   		goto again;
> @@ -272,10 +272,10 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
>   	int err;
>   
>    again:
> -	err = xenbus_transaction_start(xh_default, &xbt);
> +	err = xenbus_transaction_start(watch->xh, &xbt);
>   	if (err)
>   		return;
> -	err = xenbus_scanf(xh_default, xbt, "control", "sysrq", "%c", &sysrq_key);
> +	err = xenbus_scanf(watch->xh, xbt, "control", "sysrq", "%c", &sysrq_key);
>   	if (err < 0) {
>   		/*
>   		 * The Xenstore watch fires directly after registering it and
> @@ -287,21 +287,21 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
>   		if (err != -ENOENT && err != -ERANGE)
>   			pr_err("Error %d reading sysrq code in control/sysrq\n",
>   			       err);
> -		xenbus_transaction_end(xh_default, xbt, 1);
> +		xenbus_transaction_end(watch->xh, xbt, 1);
>   		return;
>   	}
>   
>   	if (sysrq_key != '\0') {
> -		err = xenbus_printf(xh_default, xbt, "control", "sysrq", "%c", '\0');
> +		err = xenbus_printf(watch->xh, xbt, "control", "sysrq", "%c", '\0');
>   		if (err) {
>   			pr_err("%s: Error %d writing sysrq in control/sysrq\n",
>   			       __func__, err);
> -			xenbus_transaction_end(xh_default, xbt, 1);
> +			xenbus_transaction_end(watch->xh, xbt, 1);
>   			return;
>   		}
>   	}
>   
> -	err = xenbus_transaction_end(xh_default, xbt, 0);
> +	err = xenbus_transaction_end(watch->xh, xbt, 0);
>   	if (err == -EAGAIN)
>   		goto again;
>   
> @@ -324,14 +324,14 @@ static struct notifier_block xen_reboot_nb = {
>   	.notifier_call = poweroff_nb,
>   };
>   
> -static int setup_shutdown_watcher(void)
> +static int setup_shutdown_watcher(xenhost_t *xh)

I think shutdown is purely local, too.


Juergen
