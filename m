Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766522087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEGNM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEGNM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:12:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 782942C9710;
        Tue,  7 May 2019 13:12:27 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C111148CFC;
        Tue,  7 May 2019 13:12:26 +0000 (UTC)
Subject: Re: [PATCH] livepatch: Remove stale kobj_added entries from
 kernel-doc descriptions
To:     Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        jpoimboe@redhat.com, pmladek@suse.com
Cc:     kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190507130815.17685-1-mbenes@suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <0d62c598-1f59-c931-c2bd-2600683c57f6@redhat.com>
Date:   Tue, 7 May 2019 09:12:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507130815.17685-1-mbenes@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 07 May 2019 13:12:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 9:08 AM, Miroslav Benes wrote:
> Commit 4d141ab3416d ("livepatch: Remove custom kobject state handling")
> removed kobj_added members of klp_func, klp_object and klp_patch
> structures. kernel-doc descriptions were omitted by accident. Remove
> them.
> 
> Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>   include/linux/livepatch.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index a14bab1a0a3e..955d46f37b72 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -47,7 +47,6 @@
>    * @stack_node:	list node for klp_ops func_stack list
>    * @old_size:	size of the old function
>    * @new_size:	size of the new function
> - * @kobj_added: @kobj has been added and needs freeing
>    * @nop:        temporary patch to use the original code again; dyn. allocated
>    * @patched:	the func has been added to the klp_ops list
>    * @transition:	the func is currently being applied or reverted
> @@ -125,7 +124,6 @@ struct klp_callbacks {
>    * @node:	list node for klp_patch obj_list
>    * @mod:	kernel module associated with the patched object
>    *		(NULL for vmlinux)
> - * @kobj_added: @kobj has been added and needs freeing
>    * @dynamic:    temporary object for nop functions; dynamically allocated
>    * @patched:	the object's funcs have been added to the klp_ops list
>    */
> @@ -152,7 +150,6 @@ struct klp_object {
>    * @list:	list node for global list of actively used patches
>    * @kobj:	kobject for sysfs resources
>    * @obj_list:	dynamic list of the object entries
> - * @kobj_added: @kobj has been added and needs freeing
>    * @enabled:	the patch is enabled (but operation may be incomplete)
>    * @forced:	was involved in a forced transition
>    * @free_work:	patch cleanup from workqueue-context
> 

D'oh, missed that in the review.  Good eye, Kamalesh.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
