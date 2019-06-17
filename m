Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A63C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E7B21726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfFQJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:50:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfFQJu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:50:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B387AF99;
        Mon, 17 Jun 2019 09:50:27 +0000 (UTC)
Subject: Re: [RFC PATCH 12/16] xen/xenbus: support xenbus frontend/backend
 with xenhost_t
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-13-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <af5e0319-b850-b263-2ce1-7719b66194e4@suse.com>
Date:   Mon, 17 Jun 2019 11:50:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-13-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> As part of xenbus init, both frontend, backend interfaces need to talk
> on the correct xenbus. This might be a local xenstore (backend) or might
> be a XS_PV/XS_HVM interface (frontend) which needs to talk over xenbus
> with the remote xenstored. We bootstrap all of these with evtchn/gfn
> parameters from (*setup_xs)().
> 
> Given this we can do appropriate device discovery (in case of frontend)
> and device connectivity for the backend.
> Once done, we stash the xenhost_t * in xen_bus_type, xenbus_device or
> xenbus_watch and then the frontend and backend devices implicitly use
> the correct interface.
> 
> The rest of patch is just changing the interfaces where needed.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   drivers/block/xen-blkback/blkback.c        |  10 +-
>   drivers/net/xen-netfront.c                 |  14 +-
>   drivers/pci/xen-pcifront.c                 |   4 +-
>   drivers/xen/cpu_hotplug.c                  |   4 +-
>   drivers/xen/manage.c                       |  28 +--
>   drivers/xen/xen-balloon.c                  |   8 +-
>   drivers/xen/xenbus/xenbus.h                |  45 ++--
>   drivers/xen/xenbus/xenbus_client.c         |  32 +--
>   drivers/xen/xenbus/xenbus_comms.c          | 121 +++++-----
>   drivers/xen/xenbus/xenbus_dev_backend.c    |  30 ++-
>   drivers/xen/xenbus/xenbus_dev_frontend.c   |  22 +-
>   drivers/xen/xenbus/xenbus_probe.c          | 246 +++++++++++++--------
>   drivers/xen/xenbus/xenbus_probe_backend.c  |  19 +-
>   drivers/xen/xenbus/xenbus_probe_frontend.c |  65 +++---
>   drivers/xen/xenbus/xenbus_xs.c             | 188 +++++++++-------
>   include/xen/xen-ops.h                      |   3 +
>   include/xen/xenbus.h                       |  54 +++--
>   include/xen/xenhost.h                      |  20 ++
>   18 files changed, 536 insertions(+), 377 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
> index c3e201025ef0..d6e0c397c6a0 100644
> --- a/drivers/xen/xenbus/xenbus_dev_frontend.c
> +++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
> @@ -58,10 +58,14 @@
>   
>   #include <xen/xenbus.h>
>   #include <xen/xen.h>
> +#include <xen/interface/xen.h>
> +#include <xen/xenhost.h>
>   #include <asm/xen/hypervisor.h>
>   
>   #include "xenbus.h"
>   
> +static xenhost_t *xh;
> +
>   /*
>    * An element of a list of outstanding transactions, for which we're
>    * still waiting a reply.
> @@ -312,13 +316,13 @@ static void xenbus_file_free(struct kref *kref)
>   	 */
>   
>   	list_for_each_entry_safe(trans, tmp, &u->transactions, list) {
> -		xenbus_transaction_end(trans->handle, 1);
> +		xenbus_transaction_end(xh, trans->handle, 1);
>   		list_del(&trans->list);
>   		kfree(trans);
>   	}
>   
>   	list_for_each_entry_safe(watch, tmp_watch, &u->watches, list) {
> -		unregister_xenbus_watch(&watch->watch);
> +		unregister_xenbus_watch(xh, &watch->watch);
>   		list_del(&watch->list);
>   		free_watch_adapter(watch);
>   	}
> @@ -450,7 +454,7 @@ static int xenbus_write_transaction(unsigned msg_type,
>   		   (!strcmp(msg->body, "T") || !strcmp(msg->body, "F"))))
>   		return xenbus_command_reply(u, XS_ERROR, "EINVAL");
>   
> -	rc = xenbus_dev_request_and_reply(&msg->hdr, u);
> +	rc = xenbus_dev_request_and_reply(xh, &msg->hdr, u);
>   	if (rc && trans) {
>   		list_del(&trans->list);
>   		kfree(trans);
> @@ -489,7 +493,7 @@ static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
>   		watch->watch.callback = watch_fired;
>   		watch->dev_data = u;
>   
> -		err = register_xenbus_watch(&watch->watch);
> +		err = register_xenbus_watch(xh, &watch->watch);
>   		if (err) {
>   			free_watch_adapter(watch);
>   			rc = err;
> @@ -500,7 +504,7 @@ static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
>   		list_for_each_entry(watch, &u->watches, list) {
>   			if (!strcmp(watch->token, token) &&
>   			    !strcmp(watch->watch.node, path)) {
> -				unregister_xenbus_watch(&watch->watch);
> +				unregister_xenbus_watch(xh, &watch->watch);
>   				list_del(&watch->list);
>   				free_watch_adapter(watch);
>   				break;
> @@ -618,8 +622,9 @@ static ssize_t xenbus_file_write(struct file *filp,
>   static int xenbus_file_open(struct inode *inode, struct file *filp)
>   {
>   	struct xenbus_file_priv *u;
> +	struct xenstore_private *xs = xs_priv(xh);
>   
> -	if (xen_store_evtchn == 0)
> +	if (xs->store_evtchn == 0)
>   		return -ENOENT;
>   
>   	nonseekable_open(inode, filp);
> @@ -687,6 +692,11 @@ static int __init xenbus_init(void)
>   	if (!xen_domain())
>   		return -ENODEV;
>   
> +	if (xen_driver_domain() && xen_nested())
> +		xh = xh_remote;
> +	else
> +		xh = xh_default;

This precludes any mixed use of L0 and L1 frontends. With this move you
make it impossible to e.g. use a driver domain for networking in L1 with
a L1-local PV disk, or pygrub in L1 dom0.


Juergen
