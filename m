Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD2C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0050A21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392840AbfIYUKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:10:14 -0400
Received: from mail5.windriver.com ([192.103.53.11]:56170 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbfIYUKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:10:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x8PK8Mci005202
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 25 Sep 2019 13:08:32 -0700
Received: from [192.168.10.15] (172.25.59.210) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.468.0; Wed, 25 Sep 2019
 13:08:12 -0700
Subject: Re: [PATCH v3 1/4] kgdb: Remove unused DCPU_SSTEP definition
To:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.1.I31ab239a765022d9402c38f8a12d9f7bae76b770@changeid>
From:   Jason Wessel <jason.wessel@windriver.com>
Message-ID: <9a8b84cb-938b-d468-335b-27bbd963c6d0@windriver.com>
Date:   Wed, 25 Sep 2019 15:08:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190925125811.v3.1.I31ab239a765022d9402c38f8a12d9f7bae76b770@changeid>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 3:02 PM, Douglas Anderson wrote:
>  From doing a 'git log --patch kernel/debug', it looks as if DCPU_SSTEP
> has never been used.  Presumably it used to be used back when kgdb was
> out of tree and nobody thought to delete the definition when the usage
> went away.  Delete.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

The history on this one is that it was part of the logic for the soft stepping on ARM v5 cores.   The code was never merged to the mainline for doing this, so the .h definition can certainly go.

Acked-by: Jason Wessel <jason.wessel@windriver.com>

> ---
> 
> Changes in v3:
> - Patch ("Remove unused DCPU_SSTEP definition") new for v3.
> 
> Changes in v2: None
> 
>   kernel/debug/debug_core.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
> index b4a7c326d546..804b0fe5a0ba 100644
> --- a/kernel/debug/debug_core.h
> +++ b/kernel/debug/debug_core.h
> @@ -33,7 +33,6 @@ struct kgdb_state {
>   #define DCPU_WANT_MASTER 0x1 /* Waiting to become a master kgdb cpu */
>   #define DCPU_NEXT_MASTER 0x2 /* Transition from one master cpu to another */
>   #define DCPU_IS_SLAVE    0x4 /* Slave cpu enter exception */
> -#define DCPU_SSTEP       0x8 /* CPU is single stepping */
>   
>   struct debuggerinfo_struct {
>   	void			*debuggerinfo;
> 

