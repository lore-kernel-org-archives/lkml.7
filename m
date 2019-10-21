Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B97CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66B2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfJUFaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfJUFaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63AEBACB7;
        Mon, 21 Oct 2019 05:30:18 +0000 (UTC)
Subject: Re: [PATCH] xen/netback: cleanup init and deinit code
To:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20191021052747.31543-1-jgross@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <383da9a4-862f-f199-76d6-124711095de4@suse.com>
Date:   Mon, 21 Oct 2019 07:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021052747.31543-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.19 07:27, Juergen Gross wrote:
> Do some cleanup of the netback init and deinit code:
> 
> - add an omnipotent queue deinit function usable from
>    xenvif_disconnect_data() and the error path of xenvif_connect_data()
> - only install the irq handlers after initializing all relevant items
>    (especially the kthreads related to the queue)
> - there is no need to use get_task_struct() after creating a kthread
>    and using put_task_struct() again after having stopped it.
> - use kthread_run() instead of kthread_create() to spare the call of
>    wake_up_process().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sorry, forgot to add the "Reviewed-by:" of Paul. Will resend.


Juergen
